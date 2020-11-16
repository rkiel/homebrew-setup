export GITHUB_RKIEL="git@github.com:rkiel"
export LOCAL_RKIEL=~/GitHub/rkiel

cd /Users/Shared
rm -rf images-starter
git clone $GITHUB_RKIEL/images-starter.git

ls -l ~/Downloads
echo && read -p "enter Google Chrome DMG: " VendorDMG
# VendorDMG="googlechrome.dmg"
APPLICATION="Google Chrome"
hdiutil attach ~/Downloads/"$VendorDMG"  -nobrowse
cp -pPR  /Volumes/"$APPLICATION"/"$APPLICATION".app /Applications/
ApplicationDMG="$(hdiutil info | grep "/Volumes/$APPLICATION" | awk '{ print $1 }')"
hdiutil detach $ApplicationDMG
rm -rf ~/Downloads/"$VendorDMG"

ls -l ~/Downloads
echo && read -p "enter Firefox DMG: " VendorDMG
#cd ~/Downloads && VendorDMG=`ls Firefox*.dmg`
APPLICATION="Firefox"
hdiutil attach ~/Downloads/"$VendorDMG"  -nobrowse
cp -pPR  /Volumes/"$APPLICATION"/"$APPLICATION".app /Applications/
ApplicationDMG="$(hdiutil info | grep "/Volumes/$APPLICATION" | awk '{ print $1 }')"
hdiutil detach $ApplicationDMG
rm -rf ~/Downloads/"$VendorDMG"

/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo               > /tmp/rvm
echo "##########" >> /tmp/rvm
echo "# RVM"      >> /tmp/rvm
echo "##########" >> /tmp/rvm
cat /tmp/rvm      >> ~/.bash_profile
cat /tmp/rvm      >> ~/.bashrc
\curl -sSL https://get.rvm.io | /bin/zsh -s stable --autolibs=enable
source ~/.bashrc
RUBY_CURRENT=2.7
RUBY_PREVIOUS=2.6
rvm install $RUBY_CURRENT
rvm install $RUBY_PREVIOUS
rvm --default use $RUBY_CURRENT

echo               > /tmp/nvm
echo "##########" >> /tmp/nvm
echo "# NVM"      >> /tmp/nvm
echo "##########" >> /tmp/nvm
cat /tmp/nvm      >> ~/.bashrc
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash
source ~/.bashrc
nvm ls-remote|grep Latest|grep LTS|grep Erbium
echo && read -p "enter Node (current version): " NODE_CURRENT
nvm ls-remote|grep Latest|grep LTS|grep Dubnium
echo && read -p "enter Node (previous version): " NODE_PREVIOUS
nvm install $NODE_CURRENT
nvm install $NODE_PREVIOUS
nvm alias default $NODE_PREVIOUS
mkdir -p $LOCAL_RKIEL && cd $_
rm -rf node-utilities
git clone ${GITHUB_RKIEL}/node-utilities.git
cd $LOCAL_RKIEL/node-utilities
./install/bin/setup zsh

brew install pyenv
echo                                        > /tmp/python
echo "##########"                          >> /tmp/python
echo "# Python"                            >> /tmp/python
echo "##########"                          >> /tmp/python
cat /tmp/python                            >> ~/.bash_profile
cat /tmp/python                            >> ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"'    >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"'              >> ~/.bashrc
source ~/.bash_profile
source ~/.bashrc
PYTHON_CURRENT=3.9.0
pyenv install $PYTHON_CURRENT
pyenv global $PYTHON_CURRENT

pyenv global $PYTHON_CURRENT
pip3 install awscli --upgrade --user
echo 'export PATH=~/.local/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
aws --version
mkdir -p $LOCAL_RKIEL && cd $_
rm -rf aws-utilities
git clone ${GITHUB_RKIEL}/aws-utilities.git
cd $LOCAL_RKIEL/aws-utilities
./install/bin/setup
source ~/.bash_profile
awssu

REPO="zsh-utilities"
mkdir -p ${LOCAL_RKIEL} && cd $_
rm -rf $REPO
git clone ${GITHUB_RKIEL}/${REPO}.git
cd ${LOCAL_RKIEL}/${REPO}
./install/bin/setup

echo && read -p "enter FEATURE_USER: " FEATURE_USER
mkdir -p $LOCAL_RKIEL && cd $_
rm -rf git-utilities
git clone ${GITHUB_RKIEL}/git-utilities.git
cd $LOCAL_RKIEL/git-utilities
./install/bin/setup --user $FEATURE_USER

mkdir -p $LOCAL_RKIEL && cd $_
rm -rf vim-setup
git clone ${GITHUB_RKIEL}/vim-setup.git
cd $LOCAL_RKIEL/vim-setup
./install/bin/setup

cd ~/Downloads && unzip atom-mac.zip
mv ~/Downloads/Atom.app /Applications
cd /usr/local
sudo mkdir -p bin
cd /usr/local/bin
sudo ln -nfs /Applications/Atom.app/Contents/Resources/app/atom.sh atom
sudo ln -nfs /Applications/Atom.app/Contents/Resources/app/apm/node_modules/.bin/apm apm
mkdir -p $LOCAL_RKIEL && cd $_
rm -rf atom-setup
git clone ${GITHUB_RKIEL}/atom-setup.git
cd ~/GitHub/rkiel/atom-setup
./install/bin/setup --install

cd ~/Downloads && unzip VSCode-darwin-stable.zip
VSCODE="Visual Studio Code"
mv ~/Downloads/"$VSCODE".app /Applications
mkdir -p $LOCAL_RKIEL && cd $_
rm -rf vscode-setup
git clone ${GITHUB_RKIEL}/vscode-setup.git
cd vscode-setup
echo "source $LOCAL_RKIEL/vscode-setup/vs-code.bash" >> ~/.bash_profile
source ~/.bash_profile
code --install-extension esbenp.prettier-vscode
code --install-extension vscodevim.vim
code --install-extension vscode-icons-team.vscode-icons
code --install-extension dbaeumer.vscode-eslint
mkdir -p ~/Library/'Application Support'/Code/User && pushd "$_"
ln -nfs $LOCAL_RKIEL/vscode-setup/settings.json .
popd
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

echo && read -p "enter AWS account id/name: " MY_AWS_ID
echo && read -p "enter AWS user name: " MY_AWS_USER
echo && read -p "enter AWS region: " MY_AWS_REGION
awssu add $MY_AWS_ID $MY_AWS_USER ~/Downloads/credentials.csv $MY_AWS_REGION json
awssu pki $MY_AWS_ID $MY_AWS_USER
CODECOMMIT_KEY=codecommit_id_rsa
ssh-add -K ~/.ssh/$CODECOMMIT_KEY
awssu use $MY_AWS_ID $MY_AWS_USER
awssu safe
