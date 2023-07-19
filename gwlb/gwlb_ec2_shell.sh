#!/bin/bash
# command ./gwlb_ec2_shell.sh

aws ec2 describe-instances --filters 'Name=tag:Name,Values=GWLBVPC-Appliance-10.254.11.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=GWLBVPC-Appliance-10.254.11.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=GWLBVPC-Appliance-10.254.12.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=GWLBVPC-Appliance-10.254.12.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
export Appliance_11_101=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=GWLBVPC-Appliance-10.254.11.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export Appliance_11_102=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=GWLBVPC-Appliance-10.254.11.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export Appliance_12_101=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=GWLBVPC-Appliance-10.254.12.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export Appliance_12_102=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=GWLBVPC-Appliance-10.254.12.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
echo "export Appliance_11_101=${Appliance_11_101}"| tee -a ~/.bash_profile
echo "export Appliance_11_102=${Appliance_11_102}"| tee -a ~/.bash_profile
echo "export Appliance_12_101=${Appliance_12_101}"| tee -a ~/.bash_profile
echo "export Appliance_12_102=${Appliance_12_102}"| tee -a ~/.bash_profile

aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC01-Private-A-10.1.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC01-Private-A-10.1.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC01-Private-B-10.1.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC01-Private-B-10.1.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
export VPC01_21_101=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC01-Private-A-10.1.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export VPC01_21_102=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC01-Private-A-10.1.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export VPC01_22_101=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC01-Private-B-10.1.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export VPC01_22_102=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC01-Private-B-10.1.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
echo "export VPC01_21_101=${VPC01_21_101}"| tee -a ~/.bash_profile
echo "export VPC01_21_102=${VPC01_21_102}"| tee -a ~/.bash_profile
echo "export VPC01_22_101=${VPC01_22_101}"| tee -a ~/.bash_profile
echo "export VPC01_22_102=${VPC01_22_102}"| tee -a ~/.bash_profile

aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC02-Private-A-10.2.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC02-Private-A-10.2.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC02-Private-B-10.2.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC02-Private-B-10.2.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
export VPC02_21_101=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC02-Private-A-10.2.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export VPC02_21_102=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC02-Private-A-10.2.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export VPC02_22_101=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC02-Private-B-10.2.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export VPC02_22_102=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=VPC02-Private-B-10.2.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
echo "export VPC02_21_101=${VPC02_21_101}"| tee -a ~/.bash_profile
echo "export VPC02_21_102=${VPC02_21_102}"| tee -a ~/.bash_profile
echo "export VPC02_22_101=${VPC02_22_101}"| tee -a ~/.bash_profile
echo "export VPC02_22_102=${VPC02_22_102}"| tee -a ~/.bash_profile

aws ec2 describe-instances --filters 'Name=tag:Name,Values=N2SVPC-Private-A-10.11.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=N2SVPC-Private-A-10.11.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=N2SVPC-Private-B-10.11.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --filters 'Name=tag:Name,Values=N2SVPC-Private-B-10.11.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId'
export N2SVPC_21_101=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=N2SVPC-Private-A-10.11.21.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export N2SVPC_21_102=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=N2SVPC-Private-A-10.11.21.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export N2SVPC_22_101=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=N2SVPC-Private-B-10.11.22.101' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
export N2SVPC_22_102=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=N2SVPC-Private-B-10.11.22.102' 'Name=instance-state-name,Values=running' | jq -r '.Reservations[].Instances[].InstanceId')
echo "export N2SVPC_21_101=${N2SVPC_21_101}"| tee -a ~/.bash_profile
echo "export N2SVPC_21_102=${N2SVPC_21_102}"| tee -a ~/.bash_profile
echo "export N2SVPC_22_101=${N2SVPC_22_101}"| tee -a ~/.bash_profile
echo "export N2SVPC_22_102=${N2SVPC_22_102}"| tee -a ~/.bash_profile