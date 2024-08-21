#!/bin/bash

# ALB 이름 설정
ALB_NAME="ALB-VPC02"

# ALB의 ARN 가져오기
ALB_ARN=$(aws elbv2 describe-load-balancers --names $ALB_NAME --query "LoadBalancers[0].LoadBalancerArn" --output text)

# ALB에 연결된 ENI 목록 가져오기
ALB_VPC02_ENI_IDS=$(aws elbv2 describe-load-balancers --load-balancer-arns $ALB_ARN --query "LoadBalancers[0].AvailabilityZones[].LoadBalancerAddresses[].NetworkInterfaceId" --output text)

# ENI IP 주소 가져오기
for ENI_ID in $ALB_VPC02_ENI_IDS; do
  aws ec2 describe-network-interfaces --network-interface-ids $ENI_ID --query "NetworkInterfaces[0].PrivateIpAddresses[].PrivateIpAddress" --output text
done
