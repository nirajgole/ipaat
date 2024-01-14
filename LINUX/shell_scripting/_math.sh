#!/bin/bash

function add_two(){
    local a=$1
    local b=$2
    echo "Sum of two " $((a+b))
}

function sub_two(){
    local a=$1
    local b=$2
    echo "Sum of two " $((a-b))
}

function div(){
    local a=$1
    local b=$2
    if [ $2==0]
    then echo "Division Error"
    else echo "Sum of two " $((a/b))
    fi
}