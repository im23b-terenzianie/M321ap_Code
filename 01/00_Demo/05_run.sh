#!/bin/bash
#
# set docker file name
DOCKERFILE="Dockerfile1"
# set image name
IMAGE="m347_i1"
# set container name
CONTAINER="m347_c1"

# if docker file does not exist ..
if [ ! -f "$DOCKERFILE" ]; then
  # print error message and exit script
  echo "Error: Dockerfile $DOCKERFILE not found!"
  exit 1
fi

# 1. Build a dockerfile with tag -t
echo "Building Docker image..."
docker build -t "$IMAGE" -f "$DOCKERFILE" .

# 2. List images
echo "\nListing Docker images:"
docker image ls

echo "\n"
# 3. Run image with and name it m347_c1
echo "Running container..."
docker run -itd --rm --name "$CONTAINER" "$IMAGE"
# 4. Start bash-shell in container
echo "Accessing container shell..."
docker exec -it "$CONTAINER" bash
