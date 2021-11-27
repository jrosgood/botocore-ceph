#!/bin/bash
# https://github.com/ceph/ceph/tree/master/examples/boto3

# uncomment to echo commands to terminal so we can see what's happening at each step
# set -ex

boto3_aws_path=~/.aws/models/s3/2006-03-01/
ext_filename=service-2.sdk-extras.json
remote_file_location="https://raw.githubusercontent.com/ceph/ceph/master/examples/boto3/"

function print_help() {
    echo "Usage: boto3_ceph_ext [options...]"
    echo " -o, --overwrite          Overwrite $boto3_aws_path$ext_filename if it exists"
    echo " -h, --help <category>    Get help for commands"
    echo ""
    echo "This script will retrieve/store the SDF to add Ceph extensions to the AWS SDK"
}

function has_param() {
    local terms="$1"
    shift

    for term in $terms; do
        for arg; do
            if [[ $arg == "$term" ]]; then
                echo "param_exists"
            fi
        done
    done
}

if [[ -n $(has_param "-h --help" "$@") ]]; then
    print_help
    exit 0
fi

if [ -f $boto3_aws_path$ext_filename ] ; then
    if [[ -z $(has_param "-o --overwrite" "$@") ]]; then
        echo "$ext_filename already exists in $boto3_aws_path, use the -o flag to overwrite" && exit 1
    else
        echo "$ext_filename already exists in $boto3_aws_path and will be overwritten"
    fi
fi

if [ ! -d $boto3_aws_path ] ; then
    mkdir $boto3_aws_path || echo "$boto3_aws_path could not be created, exiting" ; exit 1
fi

cd $boto3_aws_path

curl $remote_file_location$ext_filename -o $ext_filename || echo "$ext_filename could not be downloaded from $remote_file_location" ; exit 1

if [ -f $boto3_aws_path$ext_filename ] ; then
    echo "$ext_filename has been added to $boto3_aws_path" || echo "$echo_filename could not be downloaded to $boto3_aws_path"
fi
