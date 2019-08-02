#!/bin/bash

#Created by Kegan Wong
#Bash script intented to insert header for java, c and c++ files.

#obtain arguments from script
DIRECTORY=$1
FILE=$2
USERPATH=$3

#error messages
BAD_FILE="File does not exist."
BAD_PATH="Invalid path or directory provided."
FORM="Form: ./args DIRECTORY FILE PATH."
NUM_ARGS="Invalid number of arguments."
SOLVE_ERROR="Check by entering pwd in the appropriate folder."
WRONG_FILE="This program makes headers for only java, c++ and c."
#used for the header
CURRENTDATE=$(date '+%m/%d/%Y')

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

#check for invalid file
elif [[ ! `ls "$USERPATH"/ 2>/dev/null | grep -w "$FILE"` ]]
  then
  echo "$BAD_FILE"
  echo "$FORM"
  exit 1
fi

#insert header in respective file
`ex -sc '1i|/*
 * Name: Kegan Wong
 * Date: '$CURRENTDATE'
 * File: '$FILE'
 * Description:
 * Sources:
/*' -cx "$USERPATH"/"$FILE"`
