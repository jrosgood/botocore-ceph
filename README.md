# Ceph Extension to Boto3
The intent of this entirely over-engineered script is to make the process of adding Ceph extensions to boto3 very simple.

To use this script, simply execute it as-is, or use the -o option if you want to overwrite any existing 'extras' definition that's already in the path.  

##### Ok, but what does it do?
It creates the `~/.aws/models/s3/2006-03-01/` directory if it doesn't already exist, moves to that directory, and uses `cURL` to download the extensions file from `https://raw.githubusercontent.com/ceph/ceph/master/examples/boto3/`.  Simple, for sure, but it beats typing all that out a bunch of times if you're adding this functionality in multiple places.
