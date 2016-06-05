if ! [ -d ~/.nvm ]
then
    mkdir ~/.nvm
fi

nvm install stable

if test ! $(which spoof)
then
  sudo npm install spoof -g
fi
