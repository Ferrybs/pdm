#!/bin/bash

help(){
    echo "Syntax: ./build.sh [-h] or [option]"
    echo
    echo "Options:"
    echo "-h                  Print the help"
    echo "clean               Cleans Flutter's build cache"
    echo "get                 Downloads all dependencies using pub get"
    echo "build               Generate files using build_runner"
    echo "all                 Runs all Flutter's command above" 
    echo "safety-check        Checks dependency status for null-safety"
    echo "update-dependencies Updates dependencies for null-safe versions and download packages" 
}

clean(){
    echo "Cleaning Flutter's build cache"
    flutter clean
}

get(){
    echo "Getting all dependencies through pub get"
    flutter pub get
}

build(){
    echo "Generating files using build_runner and delete-conflicting-outputs"
    flutter pub run build_runner build --delete-conflicting-outputs 
}

safety-check(){
    echo "Checking dependencies status for null-safety"
    dart pub outdated --mode=null-safety
}

update-dependencies(){
    echo "Updating dependencies for null-safe versions and download packages"
    dart pub outdated --mode=null-safety
    dart pub get
}

all(){
    echo "Cleaning Flutter's build cache"
    flutter clean
    echo "----------------------------------------"

    echo "Getting all dependencies through pub get"
    flutter pub get
    echo "----------------------------------------"

    echo "Generating files using build_runner and delete-conflicting-outputs"
    flutter pub run build_runner build --delete-conflicting-outputs 
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         help
         exit;;
   esac
done

case "$1" in

    clean)
        clean
        ;;
    get)
        get
        ;;
    build)
        build
        ;;
    all)
        all
        ;;
    safety-check)
        safety-check
        ;;
    update-dependencies)
        update-dependencies
        ;;
    *)
        echo "Option doesn't exist"
        ;;
esac

