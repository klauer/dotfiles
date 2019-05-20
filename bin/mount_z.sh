#!/bin/bash

HOST=pslogin.slac.stanford.edu

Z_PATH="my storage"

echo "user=$USER host=$HOST z_drive path: $Z_PATH"

echo "Configuring 127.0.0.2..."
sudo ifconfig lo0 127.0.0.2 alias up

echo "Opening up finder in the background..."
open "smb://127.0.0.2/$Z_PATH" &

echo "Starting SSH tunnel for samba access..."
echo "You can access the z-drive until this ssh session ends."
sudo ssh -L 127.0.0.2:445:win.slac.stanford.edu:445 "$USER@$HOST"
