#!/bin/bash

GREEN="\e[1;32m"
RED="\e[1;31m"
BLUE="\e[1;36m"
WHITE="\e[1;37m"
RESET="\e[1;0m"

UNDERLINE="\e[3m"

PREFIX="${GREEN}Mumble ${RESET}| "
ERROR="${RED}Mumble ${RESET}| "

echo -e "${PREFIX}${UNDERLINE}What is the port of the server to stop ?${RESET}"
read -p "- " PORT

if [ -z $PORT ]
then
	echo -e "${ERROR}${UNDERLINE}Please, provide the port of the mumble server to delete."
	exit 1
fi

echo ""
echo -e "${PREFIX}Killing process using port ${RESET}${BLUE}"$PORT"${RESET}."
echo -e "${PREFIX}Please, wait a bit."
echo ""

fuser -k "$PORT"/udp

echo ""
echo -e "${PREFIX}Process killed."
echo -e "${PREFIX}Deleting files."
echo ""

rm ./$PORT.ini ./$PORT.log ./$PORT.sqlite

echo ""
echo -e "${PREFIX}All files have been deleted."
echo ""
