#!/bin/bash

# Variables
ALB_NAME="ALB-VPC01"
VPC_NAME="ANFW-N2SVPC"
SUBNET_A_NAME="ANFW-N2SVPC-Public-Subnet-A"
SUBNET_B_NAME="ANFW-N2SVPC-Public-Subnet-B"
SECURITY_GROUP_NAME="ALBSecurityGroup"
TARGET_GROUP_NAME="ANFW-VPC01-TG"
TAG_KEY="Name"
TAG_VALUE="ALB-VPC01"

# Get VPC ID
VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=$VPC_NAME" --query "Vpcs[0].VpcId" --output text)
echo "VPC ID: $VPC_ID"

# Get Subnet IDs
SUBNET_A_ID=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=$SUBNET_A_NAME" --query "Subnets[0].SubnetId" --output text)
SUBNET_B_ID=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=$SUBNET_B_NAME" --query "Subnets[0].SubnetId" --output text)
echo "Subnet A ID: $SUBNET_A_ID"
echo "Subnet B ID: $SUBNET_B_ID"

# Get Security Group ID(s) that contain 'ALBSecurityGroup'
SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=*$SECURITY_GROUP_NAME*" --query "SecurityGroups[0].GroupId" --output text)
echo "Security Group ID: $SECURITY_GROUP_ID"

# Create ALB
ALB_VPC01_ARN=$(aws elbv2 create-load-balancer \
    --name $ALB_NAME \
    --subnets $SUBNET_A_ID $SUBNET_B_ID \
    --security-groups $SECURITY_GROUP_ID \
    --scheme internet-facing \
    --type application \
    --ip-address-type ipv4 \
    --tags Key=$TAG_KEY,Value=$TAG_VALUE \
    --query "LoadBalancers[0].LoadBalancerArn" --output text)
echo "ALB ARN: $ALB_VPC01_ARN"

# Get Target Group ARN
TARGET_GROUP01_ARN=$(aws elbv2 describe-target-groups --names $TARGET_GROUP_NAME --query "TargetGroups[0].TargetGroupArn" --output text)
echo "Target Group ARN: $TARGET_GROUP01_ARN"

# Create Listener
aws elbv2 create-listener \
    --load-balancer-arn $ALB_VPC01_ARN \
    --protocol HTTP \
    --port 80 \
    --default-actions Type=forward,TargetGroupArn=$TARGET_GROUP01_ARN

echo "ALB '$ALB_NAME' has been created with the specified configuration."
