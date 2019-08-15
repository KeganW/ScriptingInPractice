#!/bin/bash

#Created by Kegan Wong
#Bash script intended to compare the sizes for all files in a directory.
#This script takes the path to the directory of interest.

#Error messages.
NUM_ARGS="Invalid number of arguments."
FORM="./count.sh path1"
EXAMPLE="./compareFiles.sh ~/Desktop/Projects/"
BAD_PATH="Invalid path provided."

#Obtain arguments from script.
PATH1=$1

#Arrays to store information.
declare -a store_sizes
declare -a store_files
declare -a display

#Helper variable to track position.
declare -i local_index=0

#Used to append individual elements in the array
display_string=""

#Used to loop until condition is met.
true=1

#Check for valid number of arguments.
if [ $# -ne 1 ]
  then
  echo "$NUM_ARGS" 
  echo "Form: "$FORM""
  echo "Example: "$EXAMPLE"" 
  exit 1

#Check for valid paths.
elif [ ! -d "$PATH1" ] 
  then
  echo "$BAD_PATH"
  echo "Form: "$FORM""
  exit 1
fi

#Obtain sizes of each file in the directory.
for allfiles in "$PATH1"/*
  do

  #Obtain file name and append information into arrays.
  FILE=`echo $allfiles | awk -F "/" '{print $NF}'`
  store_sizes[local_index]=`stat -f %z "$PATH1"/"$FILE"`
  store_files[local_index]="$FILE"
  display_string="${store_sizes[local_index]} bytes:"$FILE""
  display[local_index]="$display_string"
  local_index=("$local_index + 1")

done

#Append to temporary file in order to use sort
while [ "$local_index" != 0 ]
  do
  echo ${display["$local_index"-1]} >> "$PATH1"/tempsortedKW.txt
  local_index="$local_index"-1 
done

#Store in string to display new lines
display_string=`sort -n "$PATH1"/tempsortedKW.txt`
echo "$display_string"

#Remove temporary file
`rm "$PATH1"/tempsortedKW.txt`
