#!/bin/bash
#Adding files to containers

#Function to order files from shortest to longest
ShortestFirst()
{
    #Creating a variable to keep files stored in order
    count=0

    #Creates Docker$i directory
    docker exec container$i mkdir Docker$i/
    
    #Prints contents of Docker$i directory in size order and copies them to Docker$i directory within container
    ls -Sr ./Docker$i/ | while read file; do
        #echo "$file"
        docker cp ./Docker$i/$file container$i:/Docker$i/$count
        ((count+=1))
    done   
}

FSFS()
{
    #Creating a variable to keep files stored in order
    count=0
    
    #Creates Docker$i directory
    docker exec container$i mkdir Docker$i/
    
    #Prints contents of Docker$i directory in size order and copies them to Docker$i directory within container
    ls ./Docker$i/ | while read file; do
        #echo "$file"
        docker cp ./Docker$i/$file container$i:/Docker$i/$count
        ((count+=1))
    done   
}

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
        else
            #Runs the shortes first function
            ShortestFirst "$i"
        fi
    done
}


#Runs function
ContainerFiles

#Runs the next script
./gameofdockers.sh