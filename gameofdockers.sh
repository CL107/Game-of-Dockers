#!/bin/bash

#Function to write files to GAME_OF_DOCKERS txt file, 2 files per container at a time
WriteFiles()
{
    echo "Beginning text creation GAME_OF_DOCKERS.txt…"

    #Creates a variable to keep track of the number of files written
    count=0
    #Creates a temporary variable to act as a boolean for a loop
    x=true
    #Loop to increment writing files to GAME_OF_DOCKERS.txt by 2 each time until all lines written
    while $x; do

        #Loop to write files to GAME_OF_DOCKERS.txt
        for ((i = 1; i < 4; i++)); do
            #Writes the first file to GAME_OF_DOCKERS.txt
            if docker exec container$i cat Docker$i/$count &> /dev/null >> ./GAME_OF_DOCKERS.txt; then
                #Writes a new line to GAME_OF_DOCKERS.txt 
                echo >> ./GAME_OF_DOCKERS.txt
                ((count+=1))
            #If there is no file, exit the loop
            else
                x=false
            fi

            #Writes the second file to GAME_OF_DOCKERS.txt
            if docker exec container$i cat Docker$i/$count &> /dev/null >> ./GAME_OF_DOCKERS.txt; then
                #Writes a new line to GAME_OF_DOCKERS.txt
                echo >> ./GAME_OF_DOCKERS.txt
                ((count-=1))
            #If there is no file, exit the loop
            else
                x=false
            fi
        done
        #Increments count by 2
        ((count+=2))
    done
}

#Function to remove text from GAME_OF_DOCKERS.txt
RemoveText()
{
    #Prompts user to enter a phrase to remove from GAME_OF_DOCKERS.txt
    echo "Enter the full path of the .txt you would like to remove from GAME_OF_DOCKERS.txt: "
    read text

    #Removes the specified .txt file from GAME_OF_DOCKERS.txt
    sed -i "/$(cat $text)/d" ./GAME_OF_DOCKERS.txt
}

#Function to add text to GAME_OF_DOCKERS.txt
AddText()
{
    #Asks user for input
    echo "Please enter text to add to GAME_OF_DOCKERS.txt: "
    read text
    #Adds the text to GAME_OF_DOCKERS.txt
    echo $text >> ./GAME_OF_DOCKERS.txt
}

#Function to provide user with options based on GAME_OF_DOCKERS.txt
Inputs()
{
    #Asks user for input
    echo "Would you like to read Game of Dockers chapter? Yes/No: "
    read choice

    #If user inputs yes, run the function
    if [ $choice == "Yes" ] || [ $choice == "yes" ]; then
        #Prints the contents of GAME_OF_DOCKERS.txt
        cat ./GAME_OF_DOCKERS.txt
        echo
    #If user inputs no, move on
    elif [ $choice == "No" ] || [ $choice == "no" ]; then
        echo 
    #If user inputs invalid input, exit the script
    else
        echo "Invalid input, exiting script..."
        exit 1
    fi

    #Asks user if they want to remove some specific text
    echo "Would you like to remove some text? Yes/No: "
    read choice2

    #If user inputs yes, run the function
    if [ $choice2 == "Yes" ] || [ $choice2 == "yes" ]; then
        #Runs the function to remove text
        RemoveText
        echo
    #If user inputs no, move on
    elif [ $choice2 == "No" ] || [ $choice2 == "no" ]; then
        echo 
    #If user inputs invalid input, exit the script
    else
        echo "Invalid input, exiting script..."
        exit 1
    fi

    #Asks user if they want to add text
    echo "Would you like to add some text? Yes/No: "
    read choice3

    #If user inputs yes, add the inputted text
    if [ $choice3 == "Yes" ] || [ $choice3 == "yes" ]; then
        #Runs the function to add text
        AddText
        echo
    #If user inputs no, move on
    elif [ $choice3 == "No" ] || [ $choice3 == "no" ]; then
        echo 
    #If user inputs invalid input, exit the script
    else
        echo "Invalid input, exiting script..."
        exit 1
    fi

    #Asks user if they want to read the updated GAME_OF_DOCKERS.txt
    echo "Would you like to read the updated GAME_OF_DOCKERS.txt? Yes/No: "
    read choice4

    #If user inputs yes, print the contents of GAME_OF_DOCKERS.txt
    if [ $choice4 == "Yes" ] || [ $choice4 == "yes" ]; then
        #Prints the contents of GAME_OF_DOCKERS.txt
        cat ./GAME_OF_DOCKERS.txt
        echo
    #If user inputs no, move on
    elif [ $choice4 == "No" ] || [ $choice4 == "no" ]; then
        echo 
    #If user inputs invalid input, exit the script
    else
        echo "Invalid input, exiting script..."
        exit 1
    fi

    #Asks user if the want to terminate the script
    echo "Would you like to terminate the script? Yes/No: "
    read choice5

    #If user inputs yes, exit the script
    if [ $choice5 == "Yes" ] || [ $choice5 == "yes" ]; then
        echo "Exiting script..."
        exit 0
    #If user inputs no, restart the user prompts
    elif [ $choice5 == "No" ] || [ $choice5 == "no" ]; then
        echo
        Inputs
    #If user inputs invalid input, exit the script
    else
        echo "Invalid input, exiting script..."
        exit 1
    fi
}

#Runs functions
WriteFiles
Inputs