#!/bin/bash

#Created by Kegan Wong
#Bash script intended to insert a single header for java, c and c++ files.
#This script takes three arguments: The directory, the file, and the path to 
#the directory.

#obtain arguments from script
DIRECTORY=$1
FILE=$2
USERPATH=$3

#error messages
BAD_FILE="File does not exist."
BAD_PATH="Invalid path or directory provided."
FORM="Form: ./headerSingleFile.sh DIRECTORY FILE PATH{EXCLUDING FILE}"
NUM_ARGS="Invalid number of arguments."
SOLVE_ERROR="Check by entering pwd in the appropriate folder."
WRONG_FILE="This program makes headers for only java, c++ and c."

#used for the header
CURRENT_DATE=$(date '+%m/%d/%Y')

#check for valid number of arguments
if [ $# -ne 3 ]
  then
  echo "$NUM_ARGS" 
  echo "$FORM" 
  exit 1

#check for invalid directory
elif [ ! `ls "$USERPATH"/.. 2>/dev/null | grep -w "$DIRECTORY"` ] 
  then
  echo "$BAD_PATH" 
  echo "$SOLVE_ERROR"
  echo "$FORM"
  exit 1

#check for nonexistent file
elif [[ ! `ls "$USERPATH"/ 2>/dev/null | grep -w "$FILE"` ]]
  then
  echo "$BAD_FILE"
  echo "$FORM"
  exit 1

#check for correct file type
elif [[ "$FILE" = *".txt" ]] || [[ "$FILE" = *".java" ]] || 
       [[ "$FILE" = *".c" ]] || [[ "$FILE" = *".cpp" ]] || 
         [[ "$FILE" = *".h" ]] || [[ "$FILE" = *".hpp" ]] || 
           [[ "$FILE" = *".cc" ]]
  then
  `ex -sc '1i|/*
 * Name: Kegan Wong
 * Date: '$CURRENT_DATE'
 * File: '$FILE'
 * Description:
 * Sources:
/*' -cx "$USERPATH"/"$FILE"`

else
  echo "$WRONG_FILE"
  exit 1
fi
