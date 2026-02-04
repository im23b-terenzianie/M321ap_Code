#!/bin/bash
#
# Pre requisit: scp (secure copy) must be installed on your notebook
# Check it with: scp /?
#
# Set variable for target node (your AWS EC2 instance)
DEST="ubuntu@ec2-54-163-208-242.compute-1.amazonaws.com" #??
# Set private key
PRIVATE_KEY="$HOME/.ssh/M321_key.pem" #??
# check if private key is set
if [ ! -f ${PRIVATE_KEY} ]; then #??
    echo ${PRIVATE_KEY} does not exist! #??
    exit 1 #??
fi #??
# Set variable for target directory where the app should be stored
DIR="~/01" #??

# remove (with ssh) target directory for the app
echo "Remove directory ${DIR} on ${DEST}"
ssh -i ${PRIVATE_KEY} ${DEST} "rm -rf ${DIR}" #??
echo "Create directory ${DIR} on ${DEST}"
# create (with ssh) target directory for the app
ssh -i ${PRIVATE_KEY} ${DEST} "mkdir ${DIR}" #??
# copy (with scp) all relevant bash script & Dockerfiles to destination
scp -i ${PRIVATE_KEY}  05*.sh ${DEST}:${DIR} #??
scp -i ${PRIVATE_KEY}  Dockerfile* ${DEST}:${DIR} #??