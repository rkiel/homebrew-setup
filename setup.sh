rm -rf $HOME/.ssh
rm -rf $HOME/.gitconfig

echo
echo Creating SSH keys for GitHub
echo && read -p "enter email address associated with your GitHub.com account: " GITHUB_EMAIL
GITHUB_KEY=github_id_rsa
ssh-keygen -f ~/.ssh/$GITHUB_KEY -m PEM -t rsa -b 4096 -C $GITHUB_EMAIL
# openssl rsa -noout -text -in ~/.ssh/$GITHUB_KEY
echo
echo Loading SSH keys in keychain
ssh-add -K ~/.ssh/$GITHUB_KEY
echo                                          >> ~/.ssh/config
echo 'Host github.com'                        >> ~/.ssh/config
echo '  HostName github.com'                  >> ~/.ssh/config
echo "  IdentityFile ~/.ssh/$GITHUB_KEY"      >> ~/.ssh/config
chmod 600 ~/.ssh/config

echo
echo Creating SSH keys for general usage
echo && read -p "enter email address for general usage: " DEFAULT_EMAIL
DEFAULT_KEY=default_id_rsa
ssh-keygen -f ~/.ssh/$DEFAULT_KEY -m PEM -t rsa -b 4096 -C $DEFAULT_EMAIL
# openssl rsa -noout -text -in ~/.ssh/$DEFAULT_KEY
echo
echo Loading SSH keys in keychain
ssh-add -K ~/.ssh/$DEFAULT_KEY
echo                                          >> ~/.ssh/config
echo 'Host *'                                 >> ~/.ssh/config
echo '  IgnoreUnknown UseKeychain'            >> ~/.ssh/config
echo '  UseKeychain yes'                      >> ~/.ssh/config
echo '  AddKeysToAgent yes'                   >> ~/.ssh/config
echo '  PreferredAuthentications publickey'   >> ~/.ssh/config
echo "  IdentityFile ~/.ssh/$DEFAULT_KEY"     >> ~/.ssh/config
chmod 600 ~/.ssh/config

echo
echo Creating git global settings
echo && read -p "enter your user id for GitHub.com: " GITHUB_USER
git config --global user.name $GITHUB_USER
git config --global user.email $GITHUB_EMAIL
git config --global color.ui true
git config --global push.default simple

echo
echo Saving GitHub public key to paste buffer
cat ~/.ssh/$GITHUB_KEY.pub | pbcopy

echo
echo Login to your GitHub account
echo Under Account "=>" Settings
echo SSH and GPG keys
echo click New SSH key
echo paste in public key
echo
echo open -a Safari https://github.com/$GITHUB_USER
echo
