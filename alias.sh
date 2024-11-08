#!/bin/bash

RESET=""
GREEN_FG=""
RED_FG=""
BOLD_ON=""
BOLD_OFF=""
ITALIC_ON=""
ITALIC_OFF=""

# Add color and styles if the scirpt runs from a terminal
if [ -t 1 ]; then
    ESC="\033"
    RESET="${ESC}[0m"

    GREEN_FG="${ESC}[32m"
    RED_FG="${ESC}[31m"

    BOLD_ON="${ESC}[1m"
    BOLD_OFF="${ESC}[22m"
    ITALIC_ON="${ESC}[3m"
    ITALIC_OFF="${ESC}[23m"
fi


activate() {
    USAGE_MESSAGE="usage: activate [<venv_name>]"

    if [ "$#" -gt 1 ]; then
        echo "${RED_FG}${BOLD_ON}Error${BOLD_OFF}: Illegal number of parameters.${RESET}"
        echo ""
        echo $USAGE_MESSAGE

        return 1
    fi

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo $USAGE_MESSAGE
        echo ""
        echo "  Activates a specified virtual environment. Defaults to the current directory name if no name is provided."
        echo ""
        echo "Options:"
        echo "  -h, --help    Show this message and exit."

        return 0
    fi

    if [ "$#" -eq 1 ]; then
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

    echo "${GREEN_FG}${BOLD_ON}Upgrade pip, setuptools and wheel...${RESET}"
    pip install -U pip setuptools wheel
}

venv() {
    USAGE_MESSAGE="usage: venv <venv_name>"

    if [ "$#" -ne 1 ]; then
        echo "${RED_FG}${BOLD_ON}Error${BOLD_OFF}: Illegal number of parameters.${RESET}"
        echo ""
        echo $USAGE_MESSAGE

        return 1
    fi

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo $USAGE_MESSAGE
        echo ""
        echo "  Creates a new virtual environment with the specified name."
        echo ""
        echo "Options:"
        echo "  -h, --help    Show this message and exit."

        return 0
    fi

    if [ -e "$HOME/.venv/$1" ]; then
        echo "${RED_FG}${BOLD_ON}Error${BOLD_OFF}: There already exists an environment named ${ITALIC_ON}'$1'${ITALIC_OFF}.${RESET}"
        return 1
    fi

    echo "${GREEN_FG}${BOLD_ON}Create a new virtual environment for ${ITALIC_ON}'$1'${ITALIC_OFF}...${RESET}"
    python3 -m venv "$HOME/.venv/$1"
}

mkv() {
    USAGE_MESSAGE="usage: mkv <venv_name>"

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo $USAGE_MESSAGE
        echo ""
        echo "  Alias for the 'venv' function. Creates a new virtual environment with the specified name."
        echo ""
        echo "Options:"
        echo "  -h, --help    Show this message and exit."

        return 0
    fi

    if [ "$#" -ne 1 ]; then
        echo "${RED_FG}mkv: illegal number of parameters${RESET}"
        echo ""
        echo $USAGE_MESSAGE

        return 1
    fi

    venv $1
}

rmv() {
    USAGE_MESSAGE="usage: rmv <venv_name>"

    if [ "$#" -ne 1 ]; then
        echo "${RED_FG}Error: Illegal number of parameters.${RESET}"
        echo ""
        echo $USAGE_MESSAGE

        return 1
    fi

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo $USAGE_MESSAGE
        echo ""
        echo "  Removes the specified virtual environment."
        echo ""
        echo "Options:"
        echo "  -h, --help    Show this message and exit."

        return 0
    fi

    if [ "$1" = "--help" ]; then
        echo $USAGE_MESSAGE
        echo ""
        echo "Removes the specified virtual environment."

        return 0
    fi

    if [ ! -d "$HOME/.venv/$1" ]; then
        echo "${RED_FG}${BOLD_ON}Error${BOLD_OFF}: No virtual environment named ${ITALIC_ON}'$1'${ITALIC_OFF} found.${RESET}"
        return 1
    fi

    echo "${GREEN_FG}${BOLD_ON}Removing virtual environment ${ITALIC_ON}'$1'${ITALIC_OFF}...${RESET}"
    rm -rd "$HOME/.venv/$1"
}

lv() {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "usage: lv"
        echo ""
        echo "  Lists all virtual environments in the '$HOME/.venv' directory."
        echo ""
        echo "Options:"
        echo "  -h, --help    Show this message and exit."

        return 0
    fi

    if [ -d "$HOME/.venv/" ]; then
        ls -l "$HOME/.venv/"
    else
        echo "${RED_FG}${BOLD_ON}Error${BOLD_OFF}: Folder ${ITALIC_ON}'$HOME/.venv'${ITALIC_OFF} not found.${RESET}"
        return 1
    fi
}
