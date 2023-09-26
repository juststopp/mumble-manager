#!/bin/bash

GREEN="\e[1;32m"
RED="\e[1;31m"
BLUE="\e[1;36m"
WHITE="\e[1;37m"
RESET="\e[1;0m"

UNDERLINE="\e[3m"

PREFIX="${GREEN}Mumble ${RESET}| "
ERROR="${RED}Mumble ${RESET}| "

echo -e "${PREFIX}${UNDERLINE}What is the name of your server ?${RESET} "
read -p "- " NAME

if [[ ! $NAME ]];
then
        echo -e "${ERROR}${UNDERLINE}Please, provide a name for the mumble server.${RESET}"
        exit 1
fi

echo -e "${PREFIX}${UNDERLINE}How many users do you except to have at most ?${RESET}"
read -p "- " USERS

USERS_AS_INT=$((USERS))

if [[ $USERS_AS_INT -lt 1 ]] || [[ $USERS_AS_INT -gt 999 ]]
then
	echo -e "${ERROR}${UNDERLINE}The number of users is invalid. (0 < USERS < 1000)."
	exit 1
fi

echo -e "${PREFIX}${UNDERLINE}What is the description of your server ? (The welcome message)${RESET} "
read -p "- " DESCRIPTION

echo -e "${PREFIX}${UNDERLINE}Do you wan't a password for your mumble server ? (Leave blank if not)${RESET} "
read -p "- " PASSWORD

LAST_CREATED_FILE=$(ls -Art | tail -n 1)
LAST_CREATED_PORT=$(cut -d'.' -f1 <<<$LAST_CREATED_FILE)

LAST_PORT_AS_INT=$((LAST_CREATED_PORT))
NEW_PORT=$((LAST_PORT_AS_INT + 1))

if [ $NEW_PORT == 1 ]
then
        NEW_PORT=10000
fi

echo " "
echo -e "${PREFIX}Last used port is ${RESET}${RED}"$LAST_CREATED_PORT"${RESET}. Now using port ${BLUE}"$NEW_PORT"${RESET} for mumble server."
echo -e "${PREFIX}Creating new config file."
echo " "

NEW_FILE=""$NEW_PORT

cp default-config.ini $NEW_FILE.ini

echo " "
echo -e "${PREFIX}Config file created using port ${RESET}${BLUE}"$NEW_PORT"${RESET}."
echo -e "${PREFIX}Updating configuration..."
echo " "

echo "port="$NEW_PORT >> $NEW_FILE.ini
echo "database="$NEW_FILE".sqlite" >> $NEW_FILE.ini
echo "logfile="$NEW_FILE".log" >> $NEW_FILE.ini
echo "registerName="$NAME >> $NEW_FILE.ini
echo "serverpassword="$PASSWORD >> $NEW_FILE.ini
echo "welcometext="$DESCRIPTION >> $NEW_FILE.ini

USERS_AS_INT=$((USERS))
echo "users="$USERS_AS_INT >> $NEW_FILE.ini

echo " "
echo -e "${PREFIX}Configuration updated."
echo -e "${PREFIX}Starting mumble server..."
echo " "

./murmur.x86 -ini $NEW_FILE.ini

sleep 2

LINE=$(grep 'SuperUser' ./$NEW_FILE.log)
SUPW=$(echo "$LINE" | awk -F "'" '{print $4}')

echo " "
echo -e "${PREFIX}Mumble server started. Have fun!"
echo -e "${PREFIX}Link to connect: ${BLUE}mumble://mumble.juststop.dev:"$NEW_PORT
echo -e "${PREFIX}Here is the SuperUser password: ${BLUE}"$SUPW
echo " "
