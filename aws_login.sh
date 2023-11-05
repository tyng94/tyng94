#!/bin/bash

# usage source ./aws_login.sh [profile_name]
profile=${1:-taywenyang94}

aws sso login --profile $profile
export AWS_PROFILE=$profile
eval "$(aws configure export-credentials --profile taywenyang94 --format env)"
