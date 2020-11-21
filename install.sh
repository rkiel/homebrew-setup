export GITHUB_RKIEL="git@github.com:rkiel"
export LOCAL_RKIEL=~/GitHub/rkiel

echo && read -p "enter SHELL (bash/zsh): " MY_SHELL
if [ "${MY_SHELL}" == "zsh" ] ; then
  MY_PROFILE=~/.zprofile
  MY_RC=~/.zshrc
  MY_BIN=/bin/zsh
else
  MY_PROFILE=~/.bash_profile
  MY_RC=~/.bashrc
  MY_BIN=/bin/bash
fi

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

${MY_BIN} -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo               > /tmp/rvm
echo "##########" >> /tmp/rvm
echo "# RVM"      >> /tmp/rvm
echo "##########" >> /tmp/rvm
cat /tmp/rvm      >> ${MY_PROFILE}
cat /tmp/rvm      >> ${MY_RC}
\curl -sSL https://get.rvm.io | ${MY_BIN} -s stable --autolibs=enable
source ${MY_RC}
RUBY_CURRENT=2.7
RUBY_PREVIOUS=2.6
rvm install $RUBY_CURRENT
rvm install $RUBY_PREVIOUS
rvm --default use $RUBY_CURRENT

echo               > /tmp/nvm
echo "##########" >> /tmp/nvm
echo "# NVM"      >> /tmp/nvm
echo "##########" >> /tmp/nvm
cat /tmp/nvm      >> ${MY_RC}
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | ${MY_BIN}
source ${MY_RC}
nvm ls-remote|grep Latest|grep LTS|grep Erbium
echo && read -p "enter Node (current version): " NODE_CURRENT
nvm ls-remote|grep Latest|grep LTS|grep Dubnium
echo && read -p "enter Node (previous version): " NODE_PREVIOUS
nvm install $NODE_CURRENT
nvm install $NODE_PREVIOUS
nvm alias default $NODE_PREVIOUS
REPO="node-utilities"
mkdir -p ${LOCAL_RKIEL} && cd $_
rm -rf ${REPO}
git clone ${GITHUB_RKIEL}/${REPO}.git
cd ${LOCAL_RKIEL}/${REPO}
./install/bin/setup ${MY_SHELL}

brew install pyenv
echo                                        > /tmp/python
echo "##########"                          >> /tmp/python
echo "# Python"                            >> /tmp/python
echo "##########"                          >> /tmp/python
cat /tmp/python                            >> ${MY_PROFILE}
cat /tmp/python                            >> ${MY_RC}
echo 'export PYENV_ROOT="$HOME/.pyenv"'    >> ${MY_PROFILE}
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ${MY_PROFILE}
echo 'eval "$(pyenv init -)"'              >> ${MY_RC}
source ${MY_PROFILE}
source ${MY_RC}
PYTHON_CURRENT=3.9.0
pyenv install $PYTHON_CURRENT
pyenv global $PYTHON_CURRENT

pyenv global $PYTHON_CURRENT
pip3 install awscli --upgrade --user
echo 'export PATH=~/.local/bin:$PATH' >> ${MY_PROFILE}
source ${MY_PROFILE}
aws --version
REPO="aws-utilities"
mkdir -p ${LOCAL_RKIEL} && cd $_
rm -rf ${REPO}
git clone ${GITHUB_RKIEL}/${REPO}.git
cd ${LOCAL_RKIEL}/${REPO}
./install/bin/setup ${MY_SHELL}

echo && read -p "enter FEATURE_USER: " FEATURE_USER
REPO="git-utilities"
mkdir -p ${LOCAL_RKIEL} && cd $_
rm -rf ${REPO}
git clone ${GITHUB_RKIEL}/${REPO}.git
cd ${LOCAL_RKIEL}/${REPO}
./install/bin/setup ${FEATURE_USER} ${MY_SHELL}

REPO="vim-setup"
mkdir -p $LOCAL_RKIEL && cd $_
rm -rf ${REPO}
git clone ${GITHUB_RKIEL}/${REPO}.git
cd ${LOCAL_RKIEL}/${REPO}
./install/bin/setup ${MY_SHELL}

cd ~/Downloads && unzip atom-mac.zip
mv ~/Downloads/Atom.app /Applications
cd /usr/local
sudo mkdir -p bin
cd /usr/local/bin
sudo ln -nfs /Applications/Atom.app/Contents/Resources/app/atom.sh atom
sudo ln -nfs /Applications/Atom.app/Contents/Resources/app/apm/node_modules/.bin/apm apm
REPO="atom-setup"
mkdir -p $LOCAL_RKIEL && cd $_
rm -rf ${REPO}
git clone ${GITHUB_RKIEL}/${REPO}.git
cd ${LOCAL_RKIEL}/${REPO}
./install/bin/setup install

cd ~/Downloads && unzip VSCode-darwin-stable.zip
VSCODE="Visual Studio Code"
mv ~/Downloads/"$VSCODE".app /Applications
REPO="vscode-setup"
mkdir -p $LOCAL_RKIEL && cd $_
rm -rf ${REPO}
git clone ${GITHUB_RKIEL}/${REPO}.git
cd ${LOCAL_RKIEL}/${REPO}
./install/bin/setup ${MY_SHELL}

echo && read -p "enter AWS account id/name: " MY_AWS_ID
echo && read -p "enter AWS user name: " MY_AWS_USER
echo && read -p "enter AWS region: " MY_AWS_REGION
awssu add $MY_AWS_ID $MY_AWS_USER ~/Downloads/credentials.csv $MY_AWS_REGION json
awssu pki $MY_AWS_ID $MY_AWS_USER
CODECOMMIT_KEY=codecommit_id_rsa
ssh-add -K ~/.ssh/$CODECOMMIT_KEY
awssu use $MY_AWS_ID $MY_AWS_USER
awssu safe
