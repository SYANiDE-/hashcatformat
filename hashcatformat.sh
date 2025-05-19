#!/bin/bash

for line in $(cat -); do 
    while getopts "m:h" opt; do
        case $opt in
            m)
                case $OPTARG in
                    13100)
                        username=$((cut -d '*' -f 2 | awk -F '$' '{print $2 "\\" $1}') <<<$line)
                        password=$(cut -d ':' -f 2- <<<$line)
                        echo -e "${username}:${password}"
                        ;;
                    *)
                        echo -e "[!] $OPTARG not yet supported"
                        exit 0
                        ;;
                esac
                ;;
            h)
                echo "USAGE: $0 -m [modenum]"
                exit 0
                ;;
            *)
                echo "Invalid argument. Supported: (m, h)"
                exit 0
            ;;
        esac
    done
done