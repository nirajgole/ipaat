#!/bin/bash
source ./_math.sh

while [ true ]
do

echo "Do you want to continue(y/n)?"
read response

if [ $response == "n" ]
then
echo "Thanks and Bye!"
break
fi

echo Enter first number:
read num1
echo Enter second number:
read num2
echo "Enter operation ["add", "sub", "div"]"
read op

OPERATION=$op

case $OPERATION in
"add")
add_two $num1 $num2
;;
"sub")
sub_two $num1 $num2
;;
"div")
div $num1 $num2
;;
*) echo "Not an operation"
;;
esac
done