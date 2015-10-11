#!/bin/bash

LOC=`python $HOME/dotfiles/bin/get_location.py`

if [[ "$LOC" == "campus" ]]; then
    HOST=ssh.sec.bnl.local
else
    HOST=ssh.bnl.gov
fi

FIRST_CHAR=`echo $USER | awk '{print toupper(substr($0,0,1))}'`

Z_PATH="Users/$FIRST_CHAR/$USER"
echo "user=$USER host=$HOST z_drive path: $Z_PATH"

echo "Configuring 127.0.0.2..."
sudo ifconfig lo0 127.0.0.2 alias up

echo "Opening up finder in the background..."
open "smb://127.0.0.2/$Z_PATH" &

echo "Starting SSH tunnel for samba access..."
echo "You can access the z-drive until this ssh session ends."
sudo ssh -o ForwardAgent=yes -o IdentityFile=$HOME/.ssh/id_rsa_osx.pub -L 127.0.0.2:445:bnlnt1b.b459.bnl.gov:445 "$USER@$HOST"
