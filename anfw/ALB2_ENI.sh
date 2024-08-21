#!/bin/bash

# ALB 이름 설정
ALB_NAME="ALB-VPC02"

# ENI ID 가져오기
ENI_ID=$(aws ec2 describe-network-interfaces --filters "Name=description,Values=*${ALB_NAME}*" --query "NetworkInterfaces[*].NetworkInterfaceId" --output text)

# ENI ID가 유효한지 확인
if [ -z "$ENI_ID" ]; then
  echo "Error: ENI ID를 찾을 수 없습니다. ALB 이름을 확인하세요."
  exit 1
fi

# ENI에 연결된 IP 주소 가져오기
ENI_IP=$(aws ec2 describe-network-interfaces --network-interface-ids $ENI_ID --query "NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress" --output text)

# IP 주소 출력
if [ -z "$ENI_IP" ]; then
  echo "Error: ENI IP 주소를 찾을 수 없습니다."
else
  echo "ALB(${ALB_NAME})의 ENI IP 주소: $ENI_IP"
fi
