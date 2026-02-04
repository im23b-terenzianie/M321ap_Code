#!/bin/bash
#
LIB='../../bin/aws.conf'
if [ ! -f "$LIB" ]; then
  echo "Error: Configuration file $LIB not found!"
  exit 1
fi
source $LIB

# Set variable for target directory where the app should be stored
DIR="~/m347_exercises"

# remove (with ssh) target directory for the app
echo "Remove directory ${DIR} on ${DEST}"
ssh -i "$KEY" "$DEST" "rm -rf ${DIR}"
echo "Create directory ${DIR} on ${DEST}"
# create (with ssh) target directory for the app
ssh -i "$KEY" "$DEST" "mkdir -p ${DIR}"
# copy (with scp) all relevant bash script & Dockerfiles to destination
scp -i "$KEY" 05_run.sh 01_Basic.conf 02_Homedir.conf Dockerfile1 Dockerfile2 "${DEST}:${DIR}/"
echo "Files copied successfully to ${DEST}:${DIR}/"