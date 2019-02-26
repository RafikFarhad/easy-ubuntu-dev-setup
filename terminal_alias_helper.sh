echo -e "Cloning Alias File..."
wget -q -O $HOME/.bash_aliases https://gist.githubusercontent.com/RafikFarhad/5a4c08717050820bdffe12bfc44eb680/raw
echo -e "Cloned"
echo -e "Default Shell: " $SHELL
echo -e ""
if [ $SHELL = "/bin/zsh" ];
then
    echo -e "Adding to ZShell Config"
    if grep -Fxq "source $HOME/.bash_aliases" ~/.zshrc
    then
        echo -e "Already present in config file [Skipping]"
    else
        echo -e "Copied to .zshrc"
        echo -e "source $HOME/.bash_aliases" >> ~/.zshrc
    fi
    echo -e "Reloading ZShell config"
    source ~/.zshrc
    echo -e "Done !~!"
fi
if [ $SHELL = "/bin/bash" ];
then
    echo -e "Adding to Bash Config"
    if grep -Fxq "source $HOME/.bash_aliases" ~/.bashrc
    then
        echo -e "Already present in config file [Skipping]"
    else
        echo -e "Copied to .bashrc"
        echo -e "source $HOME/.bash_aliases" >> ~/.bashrc
    fi
    source $HOME/.bashrc
    echo -e "Reloading Bash config"
    echo -e "Done !~!"
fi
echo -e ""
echo -e "Author:"
echo -e "RafikFarhad<rafikfarhad@gmail.com>"
