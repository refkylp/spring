APP_REPO_NAME="cloudandcloud-repo/microservice-app-prod"
AWS_REGION="us-east-1"

aws ecr describe-repositories --region ${AWS_REGION} --repository-name ${APP_REPO_NAME} || \
aws ecr create-repository \
 --repository-name ${APP_REPO_NAME} \
 --image-scanning-configuration scanOnPush=false \
 --image-tag-mutability MUTABLE \
 --region ${AWS_REGION}
