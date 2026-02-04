#!/bin/bash
#
# Import either 01_Basic.conf or 01_Homedir.conf
source 01_Basic.conf
# If no start-argument has been provided to the bash script then ...
if [ -z "$1" ]; then
  # print error message and exit script
  printf "%s\n" \
    "Error: Provide at least 1 argument:" \
    "(1): create container, (2): remove container" \
    "Exit script."
  exit 1
fi


case $1 in
1)
  # if docker file does not exist ..
  if [ ! -f "$file" ]; then
    # print error message and exit script
    echo "Error: Dockerfile $file not found!"
    exit 1
  fi
  
  # Build a dockerfile with tag -t
  printf "Start building %s ..." ${file}
  docker build -t "$image" -f "$file" .
  echo "\nDone."
  
  # List images
  echo "\nListing Docker images:"
  docker image ls
  echo ""
  
  # Run container based on its image
  docker run -itd --rm --name "$container" "$image"
  # Start bash-shell in container
  docker exec -it "$container" bash
  ;;

2)
  # stop container
  docker stop "$container"
  # remove image
  docker rmi "$image"
  # Check if the image still exists by filtering all
  # existing images with removed image. When output is empty then
  # image has been successfully removed.
  docker images | grep "$image"
  ;;
*)
  echo "Incorrect choice entered!"
  ;;
esac

