# Mumble Manager

This program is used to manage mumble server. It is based on the [mumble-voip](https://github.com/mumble-voip/mumble/) repository to create custom mumble servers.

The program contains two main bash files:
- [./create-server.sh](./create-server.sh)
- [./delete-server.sh](./delete-server.sh)

## Create Server

Creating a mumble server with this program is very easy. All you have to do is start the [./create-server.sh](./create-server.sh) file.
It will then ask you a few questions for the configuration of your server like:
- The name of the mumble server ;
- The description, also known as the welcome message of the server ;
- The maximum number of users on the server ;

Then, the program will create the mumble server and start it.
And.... That's all, you can know use your mumble server. The port, as well as the SuperUser password will be given to you so you can conncet and manage your server as you wish.

## Delete Server

Deleting a server is even easier than creating one. Just run the [./delete-server.sh](./delete-server.sh) file and provide the port when the program asks you.
It will automatically detect witch server to delete, and also delete all the files related to this mumble server.

# Made By My Own

This program has been made all by my own. Please, don't use it as your own or without mentoning me as the original creator.
