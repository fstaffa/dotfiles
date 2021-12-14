# old stskeygen
# alias aws-key='/usr/local/bin/stskeygen --profile-name sapidus --username fstaffa@cimpress.com  --connection cimpresscom-waad --admin --admin_keys'
alias aws-sapidus='stskeygen --account sapidus --admin --profile sapidus --duration 43200'

alias aws-planning='stskeygen --account logisticsquotingplanning --admin --profile logisticsquotingplanning --duration 43200'
alias aws-praguematic='stskeygen --account praguematic --profile praguematic --admin  --duration 43200'

set -gx AWS_PROFILE logisticsquotingplanning

alias doinst-sapidus='docker build --build-arg ctArtifactoryUrl=$CT_ARTIFACTORY_URL --build-arg ctArtifactoryUser=$CT_ARTIFACTORY_USER --build-arg ctArtifactoryApiKey=$CT_ARTIFACTORY_API_KEY'
alias doinst-other='docker build --build-arg ctArtifactoryUrl=$CT_ARTIFACTORY_URL --build-arg ctArtifactoryUser=$ARTIFACTORY_USER --build-arg ctArtifactoryApiKey=$ARTIFACTORY_PASS'

alias do-ccm='docker build --build-arg ctArtifactoryUrl=$CT_ARTIFACTORY_URL --build-arg ctArtifactoryUser=$ARTIFACTORY_USER --build-arg CT_ARTIFACTORY_API_KEY=$ARTIFACTORY_PASS'

function bastion_key
    set SSH_KEY_FILE ~/.ssh/bastion_connect
    rm $SSH_KEY_FILE*
    ssh-keygen -t rsa -b 2048 -f $SSH_KEY_FILE -q -N ""
    set instance_id (aws ec2 describe-instances --filter Name=tag:Name,Values=Bastion Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].{Instance:InstanceId}' --output text)
    aws ec2-instance-connect send-ssh-public-key --region eu-west-1 --instance-os-user ec2-user --ssh-public-key file://$SSH_KEY_FILE.pub --availability-zone eu-west-1a --instance-id $instance_id
end

function ccurl
    curl -H "Authorization: Bearer $CIMPRESS_AUTH" $argv
end

function bastion_key_planning
    set SSH_KEY_FILE ~/.ssh/bastion_connect
    rm $SSH_KEY_FILE*
    ssh-keygen -t rsa -b 2048 -f $SSH_KEY_FILE -q -N ""
    set instance_id (aws ec2 describe-instances --filter Name=tag:Name,Values='Vltava bastion host' Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].{Instance:InstanceId}' --output text --region eu-west-1)
    aws ec2-instance-connect send-ssh-public-key --region eu-west-1 --instance-os-user ec2-user --ssh-public-key file://$SSH_KEY_FILE.pub --availability-zone eu-west-1b --instance-id $instance_id
end

function gitlab_runner_key_planning
    set SSH_KEY_FILE ~/.ssh/bastion_connect
    rm $SSH_KEY_FILE*
    ssh-keygen -t rsa -b 2048 -f $SSH_KEY_FILE -q -N ""
    set instance_id (aws ec2 describe-instances --filter Name=tag:Name,Values='Vltava bastion host' Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].{Instance:InstanceId}' --output text --region eu-west-1)
    aws ec2-instance-connect send-ssh-public-key --region eu-west-1 --instance-os-user ec2-user --ssh-public-key file://$SSH_KEY_FILE.pub --availability-zone eu-west-1b --instance-id $instance_id
    set instance_id (aws ec2 describe-instances --filter Name=tag:Name,Values='Gitlab Runner for dockerized builds' Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].{Instance:InstanceId}' --output text --region eu-west-1)
    aws ec2-instance-connect send-ssh-public-key --region eu-west-1 --instance-os-user ec2-user --ssh-public-key file://$SSH_KEY_FILE.pub --availability-zone eu-west-1b --instance-id $instance_id
end

function bastion_key_praguematic
    set SSH_KEY_FILE ~/.ssh/bastion_connect
    rm $SSH_KEY_FILE*
    ssh-keygen -t rsa -b 2048 -f $SSH_KEY_FILE -q -N ""
    set instance_id i-08c5581e55a5d35c2
    aws ec2-instance-connect send-ssh-public-key --region eu-west-1 --instance-os-user ec2-user --ssh-public-key file://$SSH_KEY_FILE.pub --availability-zone eu-west-1a --instance-id $instance_id
end

set -gx ASPNETCORE_ENVIRONMENT Development

function rds_connect
    bastion_key_planning
    ssh rds
end
