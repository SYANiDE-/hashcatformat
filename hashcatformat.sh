#!/bin/bash

IFS=$'\n' readarray -t lines

function looper {
    OPTARG=$1
    for line in ${lines[@]}; do 
        case $OPTARG in
            2100)
                # 2100 | Domain Cached Credentials 2 (DCC2), MS Cache 2
                username=$(cut -d '#' -f 2 <<<$line)
                password=$(cut -d ':' -f 2 <<<$line)
                echo -e "${username}:${password}"
                ;;
            13100)
                # 13100 | Kerberos 5, etype 23, TGS-REP
                username=$((\
                    cut -d '*' -f 2 |\
                    awk -F '$' '{print $2 "\\\\" $1}') <<<$line)
                password=$(cut -d ':' -f 2- <<<$line)
                echo -e "${username}:${password}"
                ;;
            18200)
                # 18200 | Kerberos 5, etype 23, AS-REP
                username=$((\
                    cut -d '$' -f 4 |cut -d ':' -f 1 | tr '@' ' ' |\
                    awk -F ' ' '{print $2 "\\\\" $1 }') <<<$line)
                password=$(cut -d ':' -f 3 <<<$line)
                echo -e "${username}:${password}"
                ;;
            *)
                echo -e "[!] $OPTARG not yet supported"
                exit 0
                ;;
        esac
    done
}

while getopts "m:h" opt; do
    case $opt in
        m) looper $OPTARG ;;
        h) echo "USAGE: $0 -m [modenum]" ; exit 0 ;;
        *) echo "Invalid argument. Supported: (m, h)"; exit 0 ;;
    esac
done
