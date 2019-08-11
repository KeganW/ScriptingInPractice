#!/bin/bash

#Created by Kegan Wong
#Bash script intended to compare a pattern or word count for two files.
#This script takes two path arguments to the desired files.

#Error messages.
NUM_ARGS="Invalid number of arguments."
FORM="./count.sh path1 path2"
EXAMPLE="./compareFiles.sh ~/Desktop/Project/example.txt ~/Desktop/Food/mayo.txt
BAD_PATH="Invalid path(s) provided."

#Obtain arguments from script.
FILE1=$1
FILE2=$2

#Variable used to loop until user input is correct.
true=1

#Check for valid number of arguments.
if [ $# -ne 2 ]
  then
  echo "$NUM_ARGS" 
  echo "Form: "$FORM""
  echo "Example: "$EXAMPLE"" 
  exit 1

#Check for valid paths.
elif [ ! `ls "$FILE1" 2>/dev/null` ] 
  then
  echo "$BAD_PATH"
  echo "Form: "$FORM""
  exit 1
fi

#Prompts user until correct input.
while [ "$true" == 1 ]
  do 
  read -p "I want to compare frequencies of a... (word/pattern) " choice
  read -p "What pattern or word do you want to compare? " pattern

#Checks for word matches between two files.
if [ "$choice" == "word" ]
  then
  num1=`grep -o -w "$pattern" "$FILE1" | wc -l`
  num2=`grep -o -w "$pattern" "$FILE2" | wc -l`
  true=0

#Checks for pattern matches between two files, including substrings and chars.
elif [ "$choice" == "pattern" ]
  then
  num1=`grep -o  "$pattern" "$FILE1" | wc -l`
  num2=`grep -o  "$pattern" "$FILE2" | wc -l`
  true=0

else 
  echo "You need to type word or pattern when prompted."
  fi
done

#Determines if both files have same frequencies.
if [ "$num1" == "$num2" ]
  then
  echo "Both files have EQUAL frequencies."

else 
  echo "$FILE1" : "$num1"
  echo "$FILE2" : "$num2"
  echo "Both files have DIFFERENT frequencies."
fi
