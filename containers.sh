#!/bin/bash
#OS CW to create docker containers

#Creating docker containers
CreateDockerContainers()
{
    echo "Creating Docker Containers..."

    #Pulling docker image
    docker pull alpine:latest &> /dev/null

    #Loop to create 3 containers
    for ((i = 1; i < 4; i++)); do
        #Creates container and runs it in background
        docker run -d -it --name container$i alpine:latest &> /dev/null
        echo "Docker $i created..."
    done
}

#Runs function
CreateDockerContainers

#Calls the next script
./files.sh