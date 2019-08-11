#!/bin/bash

#Created by Kegan Wong
#Bash script intended to insert header for all files in a directory.
#Works for java, c and c++ files.
#This script takes two arguments: The directory and the path to the directory.

#obtain arguments from script
DIRECTORY=$1
USERPATH=$2

#error messages
EMPTY_DIRECTORY="Directory does not contain any files."
BAD_PATH="Invalid path or directory provided."
FORM="Form: ./headerAllFiles.sh DIRECTORY PATH."
NUM_ARGS="Invalid number of arguments."
SOLVE_ERROR="Check by entering pwd in the appropriate folder."
WRONG_FILE="This program makes headers for only java, c++ and c."

#used for the header
CURRENT_DATE=$(date '+%m/%d/%Y')


#check for valid number of arguments
if [ $# -ne 2 ]
  then
  echo "$NUM_ARGS" 
  echo "$FORM" 
  exit 1

#check for invalid directory or path
elif [ ! `ls "$USERPATH"/.. 2>/dev/null | grep -w "$DIRECTORY"` ] 
  then
  echo "$BAD_PATH" 
  echo "$SOLVE_ERROR"
  echo "$FORM"
  exit 1

#check for empty directory
elif [ `ls -1 "$USERPATH" | wc -l` == 0 ]
  then
  echo "$EMPTY_DIRECTORY"
  exit 1

#loop through all files and append headers
else
  echo "Appending headers to all c, c++, java and text files..." 
  
  for allfiles in "$USERPATH"/*
  do
  
  FILE=`echo $allfiles | awk -F "/" '{print $NF}'`
  #append only to correct file type
  if [[ "$allfiles" = *".txt" ]] || [[ "$allfiles" = *".java" ]] || 
       [[ "$allfiles" = *".c" ]] || [[ "$allfiles" = *".cpp" ]] || 
         [[ "$allfiles" = *".h" ]] || [[ "$allfiles" = *".hpp" ]] || 
           [[ "$allfiles" = *".cc" ]] || [[ "$allfiles" = *".md" ]]  
  then
  `ex -sc '1i|/*
 * Name: Kegan Wong
 * Date: '$CURRENT_DATE'
 * File: '$FILE'  
 * Description:
 * Sources:
/*' -cx $allfiles`
  fi
done

echo "Operation: SUCCESS"
fi
