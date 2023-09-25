read "What is the port of the server to stop ? " PORT

if [ -z $PORT ]
then
	echo "Please, provide the port of the mumble server to delete."
	exit 1
fi

echo ""
echo "Killing process using port "$PORT"."
echo "Please, wait a bit."
echo ""

fuser -k "$PORT"/udp

echo ""
echo "Process killed."
echo "Deleting files."
echo ""

rm ./$PORT.ini ./$PORT.log ./$PORT.sqlite

echo ""
echo "All files have been deleted."
echo ""
