#!/bin/bash

ESC="\033"
RESET="${ESC}[0m"

GREEN_FG="${ESC}[32m"
RED_FG="${ESC}[31m"

BOLD_ON="${ESC}[1m"
BOLD_OFF="${ESC}[22m"
ITALIC_ON="${ESC}[3m"
ITALIC_OFF="${ESC}[23m"


activate() {
    if [ "$#" -gt 1 ]; then
        echo "${RED_FG}${BOLD_ON}Error${BOLD_OFF}: Illegal number of parameters.${RESET}"
        return 1
    elif [ "$#" -eq 1 ]; then
        venv=$1
    elif [ "$#" -eq 0 ]; then
        venv=`basename "$PWD"`
    fi

    if [ ! -f "$HOME/.venv/$venv/bin/activate" ]; then
        echo "${RED_FG}${BOLD_ON}Error${BOLD_OFF}: Chould not find a virtual environment named ${ITALIC_ON}'$venv'${ITALIC_OFF}.${RESET}"
        return 1
    fi

    echo "${GREEN_FG}${BOLD_ON}Activate $venv...${RESET}"
    source "$HOME/.venv/$venv/bin/activate"

    echo "${GREEN_FG}${BOLD_ON}Upgrade pip...${RESET}"
    pip install -U pip
}

venv() {
    if [ "$#" -ne 1 ]; then
        echo "${RED_FG}${BOLD_ON}Error${BOLD_OFF}: Illegal number of parameters.${RESET}"
        return 1
    fi

    if [ -e "$HOME/.venv/$1" ]; then
        echo "${RED_FG}${BOLD_ON}Error${BOLD_OFF}: There already exists an environment named ${ITALIC_ON}'$1'${ITALIC_OFF}.${RESET}"
        return 1
    fi

    echo "${GREEN_FG}${BOLD_ON}Create a new virtual environment for ${ITALIC_ON}'$1'${ITALIC_OFF}...${RESET}"
    python3 -m venv "$HOME/.venv/$1"
}

mkv() {
    venv $1
}

rmv() {
    if [ "$#" -ne 1 ]; then
        echo "${RED_FG}Error: Illegal number of parameters.${RESET}"
        return 1
    fi

    if [ ! -d "$HOME/.venv/$1" ]; then
        echo "${RED_FG}${BOLD_ON}Error${BOLD_OFF}: Chould not find a virtual environment named ${ITALIC_ON}'$1'${ITALIC_OFF}.${RESET}"
        return 1
    fi

    rm -rd "$HOME/.venv/$1"
}

lv() {
    ls -l "$HOME/.venv/"
}
