APP_NAME="petclinic"
APP_REPO_NAME="cloudandcloud-repo/microservice-app-prod"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export AWS_REGION="us-east-1"
ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo 'Packaging the App into Jars with Maven'
. ./.devops/jenkins/pipeline-dev-package-with-maven-container.sh
echo 'Preparing QA Tags for Docker Images'
. ./.devops/jenkins/2nd-pipeline-prod-ecr-tag-for-docker-images.sh
echo 'Building App QA Images'
. ./.devops/jenkins/2nd-pipeline-prod-build-tagged-docker-images-for-ecr.sh
echo "Pushing App QA Images to ECR Repo"
. ./.devops/jenkins/2nd-pipeline-prod-push-docker-images-to-ecr.sh
echo 'Deploying App on Kubernetes Cluster'
. ./.devops/jenkins/2nd-pipeline-prod-deploy-app-on-EKS.sh
echo 'Deleting all local images'
docker image prune -af
