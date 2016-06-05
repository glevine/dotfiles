# Add the desired zsh to /etc/shells
if ! grep -Fxq $(which zsh) /etc/shells
then
    sudo sh -c "echo $(which zsh) >> /etc/shells"
fi

# Change the default shell to zsh
if test $(which zsh) != $SHELL
then
    chsh -s $(which zsh) $(whoami)
fi

# Fix an Apple misconfiguration for zsh
if [ -e /etc/zshenv ]
then
    sudo mv -i /etc/{zshenv,zshrc}
fi
