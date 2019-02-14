echo "Cloning Alias File..."
wget -q -O $HOME/.bash_aliases https://gist.githubusercontent.com/RafikFarhad/5a4c08717050820bdffe12bfc44eb680/raw
echo "Cloned"
echo "Default Shell: " $SHELL
echo ""
if [ $SHELL = "/bin/zsh" ];
then
    echo "Adding to ZShell Config"
    if grep -Fxq "source $HOME/.bash_aliases" ~/.zshrc
    then
        echo "Already present in config file [Skipping]"
    else
        echo "Copied to .zshrc"
        echo "source $HOME/.bash_aliases" >> ~/.zshrc
    fi
    echo "Reloading ZShell config"
    source ~/.zshrc
    echo "Done !~!"
fi
if [ $SHELL = "/bin/bash" ];
then
    echo "Adding to Bash Config"
    if grep -Fxq "source $HOME/.bash_aliases" ~/.bashrc
    then
        echo "Already present in config file [Skipping]"
    else
        echo "Copied to .bashrc"
        echo "source $HOME/.bash_aliases" >> ~/.bashrc
    fi
    source $HOME/.bashrc
    echo "Reloading Bash config"
    echo "Done !~!"
fi
echo ""
echo "Author:"
echo "RafikFarhad<rafikfarhad@gmail.com>"
