#!/bin/sh

ESC="\033"
RESET="${ESC}[0m"

GREEN_FG="${ESC}[32m"

BOLD_ON="${ESC}[1m"
BOLD_OFF="${ESC}[22m"


activate() {
    echo "${GREEN_FG}${BOLD_ON}Activate $1...${RESET}"
    source ~/.venv/$1/bin/activate

    echo "${GREEN_FG}${BOLD_ON}Upgrade pip...${RESET}"
    pip install -U pip
}

venv() {
    echo "${GREEN_FG}${BOLD_ON}Create a new virtual enviroment for $1...${RESET}"
    python3 -m venv ~/.venv/$1
}

mkv() {
    venv $1
}

rmv() {
    rm -rf ~/.venv/$1
}

lv() {
    ls -l ~/.venv/
}
