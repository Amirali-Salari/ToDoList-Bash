#!/bin/bash

command=$1
shift

case $command in
  add)
    # Default values.
    title=""
    priority="L" # Set default priority to Low.
    
    while [[ "$1" != "" ]]; do
        case $1 in
            -t | --title )
                shift
                title="$1"
                ;;
            -p | --priority )
                shift
                priority="$1"
                if [[ "$priority" != "L" && "$priority" != "M" && "$priority" != "H" ]]; then
                    echo "Option -p|--priority Only Accept L|M|H"
                    exit 1
                fi
                ;;
            *)
                echo "Invalid Option: $1"
                exit 1
                ;;
        esac
        shift
    done

    if [[ "$title" == "" ]]; then
        echo "Option -t|--title Needs a Parameter"
        exit 1
    else
        # Add new task to tasks.csv file.
        echo "0,$priority,\"$title\"" >> tasks.csv
        echo "Task added successfully."
    fi
    ;;
    
  clear)
    echo "" > tasks.csv
    ;;
    
  list)
    awk '{print NR " | " $0}' tasks.csv | sed 's/,/ | /g'
    ;;
    
  *)
    echo "Command Not Supported!"
    exit 1
    ;;
esac
