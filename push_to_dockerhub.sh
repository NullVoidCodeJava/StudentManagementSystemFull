# Make sure to replace YOUR_DOCKERHUB_USERNAME with your actual Docker Hub username.

# To use this script:
# 1.
# Save it in your project root.
# 2.
# Make it executable: chmod +x push_to_dockerhub.sh
# 3.
# Run it: ./push_to_dockerhub.sh

#!/bin/bash

# Set your Docker Hub username
DOCKERHUB_USERNAME="YOUR_DOCKERHUB_USERNAME"

# Login to Docker Hub
echo "Logging in to Docker Hub..."
docker login

# Tag and push backend image
echo "Tagging and pushing backend image..."
docker tag studentsystembackend $DOCKERHUB_USERNAME/studentsystembackend:latest
docker push $DOCKERHUB_USERNAME/studentsystembackend:latest

# Tag and push frontend image
echo "Tagging and pushing frontend image..."
docker tag studentsystemfrontend $DOCKERHUB_USERNAME/studentsystemfrontend:latest
docker push $DOCKERHUB_USERNAME/studentsystemfrontend:latest

echo "Push to Docker Hub complete!"


