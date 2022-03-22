#!/usr/bin/env zsh

function _stskeygen_helper {
    stskeygen --account $1 --profile $1 --admin --duration 43200
}

function aws-planning {
    _stskeygen_helper logisticsquotingplanning
}

function aws-praguematic {
    _stskeygen_helper praguematic
}

function aws-sapidus {
    _stskeygen_helper sapidus
}

AWS_PROFILE=logisticsquotingplanning

function bastion_key {
    SSH_KEY_FILE=~/.ssh/bastion_connect
    rm $SSH_KEY_FILE*
    ssh-keygen -t rsa -b 2048 -f $SSH_KEY_FILE -q -N ""
    instance_id=`aws ec2 describe-instances --filter Name=tag:Name,Values=Bastion Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].{Instance:InstanceId}' --output text`
    echo $instance_id
    aws ec2-instance-connect send-ssh-public-key --region eu-west-1 --instance-os-user ec2-user --ssh-public-key file://$SSH_KEY_FILE.pub --availability-zone eu-west-1a --instance-id $instance_id
}
