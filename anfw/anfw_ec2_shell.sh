#!/bin/bash
# command ./anfw_ec2_shell.sh
echo "--------------------------"
echo "VPC01 instance list"
echo "--------------------------"
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC01-Private-A-10.1.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC01-Private-A-10.1.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC01-Private-B-10.1.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC01-Private-B-10.1.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
export ANFW_VPC01_21_101=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC01-Private-A-10.1.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export ANFW_VPC01_21_102=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC01-Private-A-10.1.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export ANFW_VPC01_22_101=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC01-Private-B-10.1.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export ANFW_VPC01_22_102=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC01-Private-B-10.1.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
echo "export ANFW_VPC01_21_101=${ANFW_VPC01_21_101}"| tee -a ~/.bash_profile
echo "export ANFW_VPC01_21_102=${ANFW_VPC01_21_102}"| tee -a ~/.bash_profile
echo "export ANFW_VPC01_22_101=${ANFW_VPC01_22_101}"| tee -a ~/.bash_profile
echo "export ANFW_VPC01_22_102=${ANFW_VPC01_22_102}"| tee -a ~/.bash_profile
echo "-------------------------"
echo "VPC02 instance list"
echo "--------------------------"
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC02-Private-A-10.2.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC02-Private-A-10.2.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC02-Private-B-10.2.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC02-Private-B-10.2.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
export ANFW_VPC02_21_101=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC02-Private-A-10.2.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export ANFW_VPC02_21_102=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC02-Private-A-10.2.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export ANFW_VPC02_22_101=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC02-Private-B-10.2.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export ANFW_VPC02_22_102=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-VPC02-Private-B-10.2.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
echo "export ANFW_VPC02_21_101=${ANFW_VPC02_21_101}"| tee -a ~/.bash_profile
echo "export ANFW_VPC02_21_102=${ANFW_VPC02_21_102}"| tee -a ~/.bash_profile
echo "export ANFW_VPC02_22_101=${ANFW_VPC02_22_101}"| tee -a ~/.bash_profile
echo "export ANFW_VPC02_22_102=${ANFW_VPC02_22_102}"| tee -a ~/.bash_profile
echo "-------------------------"
echo "N2SVPC instance list"
echo "--------------------------"
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-N2SVPC-Private-A-10.11.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-N2SVPC-Private-A-10.11.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-N2SVPC-Private-B-10.11.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-N2SVPC-Private-B-10.11.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
export ANFW_N2SVPC_21_101=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-N2SVPC-Private-A-10.11.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export ANFW_N2SVPC_21_102=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-N2SVPC-Private-A-10.11.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export ANFW_N2SVPC_22_101=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-N2SVPC-Private-B-10.11.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export ANFW_N2SVPC_22_102=$(aws ec2 describe-instances --region ${AWS_REGION} --filters 'Name=tag:Name,Values=ANFW-N2SVPC-Private-B-10.11.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
echo "export N2SVPC_21_101=${ANFW_N2SVPC_21_101}"| tee -a ~/.bash_profile
echo "export N2SVPC_21_102=${ANFW_N2SVPC_21_102}"| tee -a ~/.bash_profile
echo "export N2SVPC_22_101=${ANFW_N2SVPC_22_101}"| tee -a ~/.bash_profile
echo "export N2SVPC_22_102=${ANFW_N2SVPC_22_102}"| tee -a ~/.bash_profile
echo "-------------------------"
