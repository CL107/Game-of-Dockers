#!/bin/bash
#OS CW to create docker containers

#Pulling docker image
#echo "Pulling alpine:latest"
docker pull alpine:latest &> /dev/null

#Creating docker containers
CreateDockerContainers()
{
    echo "Creating Docker Containers..."

    #Loop to create 3 containers
    for ((i = 1; i < 4; i++)); do
        docker run -d -it --name container$i alpine:latest &> /dev/null
        echo "Docker $i created..."
    done
}

#Runs function
CreateDockerContainers

#Calls the next script
./files.sh
