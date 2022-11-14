#!/bin/bash
#Adding files to containers

#Function to order files from shortest to longest
ShortestFirst()
{
    #Creating a variable to keep files stored in order
    count=0

    #Copies relevant docker file into container
    docker cp ./Docker\ Files/Docker$i/ container$i:/Docker$i/

    #Outputs contents of Docker$i directory in size order
    docker exec container$i ls -Sr ./Docker$i/ | while read file; do
        #Replaces the unsorted files with the sorted files in the Docker$i directory
        docker exec container$i mv ./Docker$i/$file /Docker$i/$count
        #Increments count variable
        ((count+=1))
    done   
}

#Function to order files in order of first come first serve
FSFS()
{
    #Creating a variable to keep files stored in order
    count=0
    
    #Creates Docker$i directory
    docker exec container$i mkdir Docker$i/
    
    #Prints contents of Docker$i directory in size order and copies them to Docker$i directory within container
    ls ./Docker$i/ | while read file; do
        #echo "$file"
        docker cp ./Docker\ Files/Docker$i/$file container$i:/Docker$i/$count
        #Increments count variable 
        ((count+=1))
    done   
}

#Function to add files to containers
ContainerFiles()
{
    #Loop to add files to containers
    for ((i = 1; i < 4; i++)); do
        echo "Loading files to Docker $i..."
        #Adds the files to container 1 in a first come first served order
        if [ $i -eq 1 ]; then
            FSFS "$i"
        #Adds the files to container 2 in order of shortest file first
        elif [ $i -eq 2 ]; then
            #Runs the shortest first function
            ShortestFirst "$i"
        #Adds the files to container 3 in order of shortest file first
        else
            #Runs the shortest first function
            ShortestFirst "$i"
        fi
    done
}


#Runs function
ContainerFiles

#Runs the next script
./gameofdockers.sh