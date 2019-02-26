echo "Welcome to Easy Ubuntu Dev Setup 2.0"
echo "[SSH Key Generate Module]"
echo -e "Created By SUST CSE Developer Network (SCDN)\n"
echo -e "Maintained By RafikFarhad<rafikfarhad@gmail.com>\n"

echo "Step:1 [Generating a new SSH key]"
read -p 'Your Github/Gitlab Email ID:  ' email
ssh-keygen -t rsa -b 4096 -C "$email"
echo -e "SSH Key Generated Successfully\n"

echo "Step:2 [Adding your SSH key to the ssh-agent]"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
echo -e "SSH key added to the ssh-agent Successfully\n"

echo "Step:3 [Adding a new SSH key to your GitHub/Gitlab account]"
echo -e "Please Go to your Github/Gitlab account > SSH Key > Add New SSH Key; Paste the below Key and Save"
cat /root/.ssh/id_rsa.pub

echo "Thanks  !!!"
