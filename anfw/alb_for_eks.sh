#!/bin/bash
#create-load0-balancer
echo "-------------"
echo "Create - environment variable"
echo "-------------"
export ANFW_N2SVPC_NAME=ANFW-N2SVPC
export ANFW_N2SVPC_PublicSubnet01_NAME=ANFW-N2SVPC-Public-Subnet-A
export ANFW_N2SVPC_PublicSubnet02_NAME=ANFW-N2SVPC-Public-Subnet-B
export ANFW_N2SVPC_ALBSG_NAME=ANFW-N2SVPC-ALBSecurityGroup
export ALB_FOR_EKS_NAME=ALB-FOR-EKS
export ALB_FOR_EKS_TG=EKS-TG
export NLB_PRIVATE_A_IP=10.1.21.201
export NLB_PRIVATE_B_IP=10.1.22.201
echo "export ANFW_N2SVPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=$ANFW_N2SVPC_NAME" | jq -r '.Vpcs[].VpcId')" | tee -a ~/.bash_profile
echo "export ANFW_N2SVPC_PublicSubnet01=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=${ANFW_N2SVPC_PublicSubnet01_NAME}" | jq -r '.Subnets[].SubnetId')" | tee -a ~/.bash_profile
echo "export ANFW_N2SVPC_PublicSubnet02=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=${ANFW_N2SVPC_PublicSubnet02_NAME}" | jq -r '.Subnets[].SubnetId')" | tee -a ~/.bash_profile
echo "export ANFW_N2SVPC_ALBSG=$(aws ec2 describe-security-groups --filters "Name=tag:Name,Values=${ANFW_N2SVPC_ALBSG_NAME}" | jq -r '.SecurityGroups[].GroupId')" | tee -a ~/.bash_profile

echo "-------------"
echo "Create - ALB for EKS Workload"
echo "-------------"
aws elbv2 create-load-balancer --name ${ALB_FOR_EKS_NAME} \
--subnets ${ANFW_N2SVPC_PublicSubnet01} ${ANFW_N2SVPC_PublicSubnet02} \
--security-groups ${ANFW_N2SVPC_ALBSG}


echo "-------------"
echo "Status check - ALB for EKS Workload"
echo "-------------"
aws elbv2 describe-load-balancers  --name ${ALB_FOR_EKS_NAME}  | jq -r '.LoadBalancers[].State'
echo "export ALB_FOR_EKS_ARN=$(aws elbv2 describe-load-balancers  --name ${ALB_FOR_EKS_NAME} | jq -r '.LoadBalancers[].LoadBalancerArn')" | tee -a ~/.bash_profile
source ~/.bash_profile

echo "-------------"
echo "create-target-group - ALB for EKS Workload"
echo "-------------"
aws elbv2 create-target-group --name ${ALB_FOR_EKS_TG} \
--protocol HTTP --port 80 \
--target-type ip \
--vpc-id ${ANFW_N2SVPC_ID}


echo "export ALB_FOR_EKS_TG_ARN=$(aws elbv2 describe-target-groups --name ${ALB_FOR_EKS_TG} | jq -r '.TargetGroups[].TargetGroupArn')" | tee -a ~/.bash_profile
source ~/.bash_profile

echo "-------------"
echo "register-targets - ALB for EKS Workload"
echo "-------------"
aws elbv2 register-targets \
    --target-group-arn ${ALB_FOR_EKS_TG_ARN} \
    --targets Id=${NLB_PRIVATE_A_IP},AvailabilityZone=all Id=${NLB_PRIVATE_B_IP},AvailabilityZone=all

echo "-------------"
echo "create-listener - ALB for EKS Workload"
echo "-------------"
aws elbv2 create-listener --load-balancer-arn $ALB_FOR_EKS_ARN  --protocol HTTP --port 80  \
--default-actions Type=forward,TargetGroupArn=${ALB_FOR_EKS_TG_ARN}
echo "export ALB_FOR_EKS_LISTENER_ARN=$(aws elbv2 describe-listeners --load-balancer-arn $ALB_FOR_EKS_ARN | jq -r '.Listeners[].ListenerArn')" | tee -a ~/.bash_profile
source ~/.bash_profile

echo "-------------"
echo "EKS-Sample-APP-URL ADDRESS"
echo "-------------"
echo "export EKS_Sample_APP_URL=$(aws elbv2 describe-load-balancers  --name ${ALB_FOR_EKS_NAME} | jq -r '.LoadBalancers[].DNSName')" | tee -a ~/.bash_profile
source ~/.bash_profile

echo "EKS-Sample-APP-URL = http://$(aws elbv2 describe-load-balancers  --name ${ALB_FOR_EKS_NAME} | jq -r '.LoadBalancers[].DNSName')"

###How to delete elbv2###
#aws elbv2 delete-listener --listener-arn $ALB_FOR_EKS_LISTENER_ARN
#aws elbv2 delete-target-group --target-group-arn $ALB_FOR_EKS_TG_ARN
#aws elbv2 delete-load-balancer --load-balancer-arn $ALB_FOR_EKS_ARN