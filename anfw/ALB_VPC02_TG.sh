#!/bin/bash

# Variables
TARGET_GROUP_NAME="ANFW-VPC02-TG"
VPC_NAME="ANFW-N2SVPC"
PROTOCOL="HTTP"
PORT=80
HEALTH_CHECK_PROTOCOL="HTTP"
HEALTH_CHECK_PATH="/ec2meta-webpage/index.php"
TARGET_TYPE="ip"
TARGET_IPS=("10.2.21.101" "10.2.21.102" "10.2.22.101" "10.2.22.102")
PROTOCOL_VERSION="HTTP1"

# Get VPC ID
VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=$VPC_NAME" --query "Vpcs[0].VpcId" --output text)

if [ -z "$VPC_ID" ] || [ "$VPC_ID" == "None" ]; then
  echo "Error: VPC with name '$VPC_NAME' not found."
  exit 1
fi

# Create target group
aws elbv2 create-target-group \
    --name $TARGET_GROUP_NAME \
    --protocol $PROTOCOL \
    --port $PORT \
    --vpc-id $VPC_ID \
    --target-type $TARGET_TYPE \
    --health-check-protocol $HEALTH_CHECK_PROTOCOL \
    --health-check-path $HEALTH_CHECK_PATH \
    --protocol-version $PROTOCOL_VERSION

# Get Target Group ARN
TARGET_GROUP_ARN=$(aws elbv2 describe-target-groups --names $TARGET_GROUP_NAME --query "TargetGroups[0].TargetGroupArn" --output text)

# Register IP addresses as targets
for IP in "${TARGET_IPS[@]}"; do
    aws elbv2 register-targets \
        --target-group-arn $TARGET_GROUP_ARN \
        --targets Id=$IP,AvailabilityZone=all
done

echo "ALB Target Group '$TARGET_GROUP_NAME' has been created and targets have been registered."
