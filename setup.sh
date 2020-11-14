echo && read -p "enter GitHub EMAIL ADDRESS: " GITHUB_EMAIL

GITHUB_KEY=github_id_rsa
echo $GITHUB_KEY $GITHUB_EMAIL
ssh-keygen -f ~/.ssh/$GITHUB_KEY -m PEM -t rsa -b 4096 -C $GITHUB_EMAIL

openssl rsa -noout -text -in ~/.ssh/$GITHUB_KEY

ssh-add -K ~/.ssh/$GITHUB_KEY

echo                                          >> ~/.ssh/config
echo 'Host github.com'                        >> ~/.ssh/config
echo '  HostName github.com'                  >> ~/.ssh/config
echo "  IdentityFile ~/.ssh/$GITHUB_KEY"      >> ~/.ssh/config
chmod 600 ~/.ssh/config

echo && read -p "enter default EMAIL ADDRESS: " DEFAULT_EMAIL

DEFAULT_KEY=default_id_rsa
echo $DEFAULT_KEY $DEFAULT_EMAIL
ssh-keygen -f ~/.ssh/$DEFAULT_KEY -m PEM -t rsa -b 4096 -C $DEFAULT_EMAIL

openssl rsa -noout -text -in ~/.ssh/$DEFAULT_KEY

ssh-add -K ~/.ssh/$DEFAULT_KEY

echo                                          >> ~/.ssh/config
echo 'Host *'                                 >> ~/.ssh/config
echo '  IgnoreUnknown UseKeychain'            >> ~/.ssh/config
echo '  UseKeychain yes'                      >> ~/.ssh/config
echo '  AddKeysToAgent yes'                   >> ~/.ssh/config
echo '  PreferredAuthentications publickey'   >> ~/.ssh/config
echo "  IdentityFile ~/.ssh/$DEFAULT_KEY"     >> ~/.ssh/config
chmod 600 ~/.ssh/config
