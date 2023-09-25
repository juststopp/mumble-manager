#!/bin/bash

read -p "What is the name of your server ? " NAME
read -p "How many users do you except to have at most ? " USERS
read -p "What is the description of your server ? (The welcome message) " DESCRIPTION
read -p "Do you wan't a password for your mumble server ? (Leave blank if not)" PASSWORD

if [[ ! $NAME ]];
then
	echo "Please, provide a name for the mumble server."
	exit 1
fi

LAST_CREATED_FILE=$(ls -Art | tail -n 1)
LAST_CREATED_PORT=$(cut -d'.' -f1 <<<$LAST_CREATED_FILE)

LAST_PORT_AS_INT=$((LAST_CREATED_PORT))
NEW_PORT=$((LAST_PORT_AS_INT + 1))

if [ $NEW_PORT == 1 ]
then
	NEW_PORT=10000
fi

echo " "
echo "Last used port is "$LAST_CREATED_PORT". Now using port "$NEW_PORT" for mumble server."
echo "Creating new config file."
echo " "

NEW_FILE=""$NEW_PORT

cp default-config.ini $NEW_FILE.ini

echo " "
echo "Config file created using port "$NEW_PORT"."
echo "Updating configuration..."
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
echo "Configuration updated."
echo "Starting mumble server..."
echo " "

./murmur.x86 -ini $NEW_FILE.ini

sleep 2

LINE=$(grep 'SuperUser' ./$NEW_FILE.log)
SUPW=$(echo "$LINE" | awk -F "'" '{print $4}')

echo " "
echo "Mumble server started. Have fun!"
echo "Link to connect: mumble://mumble.juststop.dev:"$NEW_PORT
echo "Here is the SuperUser password: "$SUPW
echo " "
