#!/bin/bash

TOP_DIR=${PWD}
export PATH=${PATH}:${TOP_DIR}/api_sh

# unset apis
# apis="${apis}$(ls -1 ${TOP_DIR}/api_sh)"

# echo -e "${apis}" | tr ' ' '\n'

export BASE_URL="https://bestream-api.com/api/v1"                        
export HEADER_USER_TOKEN="USER-TOKEN:demo@obigo.com"
export HEADER_CLIENT_KEY="CLIENT-KEY:DvbzjZagSY3aRiG5LDRH"
export HEADER_CONTENT_TYPE="Content-Type:application/x-www-form-urlencoded"
export CURL_CMD="curl -X GET"
export TODAY=`date +%m-%d`
export OUTPUT=${TOP_DIR}/out/${TODAY}


. ${TOP_DIR}/api_sh/check_file.sh





# creating a menu with the following options
echo "SELECT YOUR FAVORITE FRUIT";
echo "1. Apple"
echo "2. Grapes"
echo "3. Mango"
echo "4. Exit from menu "
echo -n "Enter your menu choice [1-4]: "

# Running a forever loop using while statement
# This loop will run untill select the exit option.
# User will be asked to select option again and again
while :
do

# reading choice
read choice

# case statement is used to compare one value with the multiple cases.
case $choice in
  # Pattern 1
  1)  echo "You have selected the option 1"
      echo "Selected Fruit is Apple. ";;
  # Pattern 2
  2)  echo "You have selected the option 2"
      echo "Selected Fruit is Grapes. ";;
  # Pattern 3
  3)  echo "You have selected the option 3"
      echo "Selected Fruit is Mango. ";;    
  # Pattern 4
  4)  echo "Quitting ..."
      exit;;
  # Default Pattern
  *) echo "invalid option";;
  
esac
  echo -n "Enter your menu choice [1-4]: "
done