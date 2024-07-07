#!/bin/bash

echo "Starting OpenShift deployment..."

# Login to OpenShift
oc login --token=<your_token> --server=<your_server>

# Create a new project
oc new-project my-project

# Deploy an application from a Docker image
oc new-app --name=my-app --docker-image=my-docker-image

# Expose the application to create a route
oc expose svc/my-app

echo "OpenShift deployment completed."
