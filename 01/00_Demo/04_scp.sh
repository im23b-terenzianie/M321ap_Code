#!/bin/bash
#
# Pre requisit: scp (secure copy) must be installed on your notebook
# Check it with: scp /?
#
# Set variable for target node (your AWS EC2 instance)
DEST="ubuntu@ec2-xx-xxx-xxx-xx.compute.amazonaws.com"
# Set private key
KEY="~/.ssh/your-key.pem"
# check if private key is set
if [ ! -f "$KEY" ]; then
    echo "Private key not found: $KEY"
    exit 1
fi
# Set variable for target directory where the app should be stored
DIR="~/m347_demo"

# remove (with ssh) target directory for the app
echo "Remove directory ${DIR} on ${DEST}"
ssh -i "$KEY" "$DEST" "rm -rf ${DIR}"
echo "Create directory ${DIR} on ${DEST}"
# create (with ssh) target directory for the app
ssh -i "$KEY" "$DEST" "mkdir -p ${DIR}"
# copy (with scp) all relevant bash script & Dockerfiles to destination
scp -i "$KEY" 05_run.sh Dockerfile1 Dockerfile2 "${DEST}:${DIR}/"
echo "Files copied successfully to ${DEST}:${DIR}/"