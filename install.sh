export GITHUB_RKIEL="git@github.com:rkiel"
export LOCAL_RKIEL=~/GitHub/rkiel

SNAPSHOT=/tmp/snapshot
COMPLETED=/tmp/completed
mkdir -p $COMPLETED

echo && read -p "enter SHELL (bash/zsh): " MY_SHELL
if [ "${MY_SHELL}" == "zsh" ] ; then
  MY_PROFILE=~/.zprofile
  MY_RC=~/.zshrc
  MY_BIN=/bin/zsh
  MY_BASH=/bin/bash
else
  MY_PROFILE=~/.bash_profile
  MY_RC=~/.bashrc
  MY_BIN=/bin/bash
  MY_BASH=/bin/bash
fi

TOUCH=$COMPLETED/images-starter.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  cd /Users/Shared
  rm -rf images-starter
  git clone $GITHUB_RKIEL/images-starter.git
  mkdir -p $SNAPSHOT/images-starter
  cp ~/.[bz]* $SNAPSHOT/images-starter
  touch $TOUCH
fi

TOUCH=$COMPLETED/chrome-app.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  ls -l ~/Downloads
  echo && read -p "enter Google Chrome DMG: " VendorDMG
  if [ ! -z "${VendorDMG}" ] ; then
    APPLICATION="Google Chrome"
    hdiutil attach ~/Downloads/"$VendorDMG"  -nobrowse
    cp -pPR  /Volumes/"$APPLICATION"/"$APPLICATION".app /Applications/
    ApplicationDMG="$(hdiutil info | grep "/Volumes/$APPLICATION" | awk '{ print $1 }')"
    hdiutil detach $ApplicationDMG
    rm -rf ~/Downloads/"$VendorDMG"
  fi
  touch $TOUCH
fi

TOUCH=$COMPLETED/firefox-app.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  ls -l ~/Downloads
  echo && read -p "enter Firefox DMG: " VendorDMG
  if [ ! -z "${VendorDMG}" ] ; then
    APPLICATION="Firefox"
    hdiutil attach ~/Downloads/"$VendorDMG"  -nobrowse
    cp -pPR  /Volumes/"$APPLICATION"/"$APPLICATION".app /Applications/
    ApplicationDMG="$(hdiutil info | grep "/Volumes/$APPLICATION" | awk '{ print $1 }')"
    hdiutil detach $ApplicationDMG
    rm -rf ~/Downloads/"$VendorDMG"
  fi
  touch $TOUCH
fi

TOUCH=$COMPLETED/homebrew.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  ${MY_BASH} -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  touch $TOUCH
fi

TOUCH=$COMPLETED/rvm.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  echo               > /tmp/rvm
  echo "##########" >> /tmp/rvm
  echo "# RVM"      >> /tmp/rvm
  echo "##########" >> /tmp/rvm
  cat /tmp/rvm      >> ${MY_PROFILE}
  cat /tmp/rvm      >> ${MY_RC}
  \curl -sSL https://get.rvm.io | ${MY_BASH} -s stable --autolibs=enable
  if [ "${MY_SHELL}" == "zsh" ] ; then
    # echo >> ${MY_RC}
    # echo "# Add RVM to PATH for scripting. Make sure this is the last PATH variable change." >> ${MY_RC}
    # echo 'export PATH="$PATH:$HOME/.rvm/bin"' >> ${MY_RC}
    echo >> ${MY_PROFILE}
    echo '[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*' >> ${MY_PROFILE}
    rm -rf ~/.bashrc
    rm -rf ~/.bash_profile
    rm -rf ~/.profile
    rm -rf ~/.mkshrc
    echo >  ~/.zlogin
    source ${MY_PROFILE}
    source ${MY_RC}
  else
    source ${MY_RC}
  fi
  RUBY_CURRENT=2.7
  RUBY_PREVIOUS=2.6
  rvm install $RUBY_CURRENT
  rvm install $RUBY_PREVIOUS
  rvm --default use $RUBY_CURRENT

  mkdir -p $SNAPSHOT/rvm
  cp ~/.[bz]* $SNAPSHOT/rvm
  touch $TOUCH
fi

TOUCH=$COMPLETED/nvm.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  echo               > /tmp/nvm
  echo "##########" >> /tmp/nvm
  echo "# NVM"      >> /tmp/nvm
  echo "##########" >> /tmp/nvm
  cat /tmp/nvm      >> ${MY_RC}
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | ${MY_BASH}
  source ${MY_RC}
  nvm ls-remote|grep Latest|grep LTS|grep Erbium
  echo && read -p "enter Node (current version): " NODE_CURRENT
  nvm ls-remote|grep Latest|grep LTS|grep Dubnium
  echo && read -p "enter Node (previous version): " NODE_PREVIOUS
  nvm install $NODE_CURRENT
  nvm install $NODE_PREVIOUS
  nvm alias default $NODE_PREVIOUS
  mkdir -p $SNAPSHOT/nvm
  cp ~/.[bz]* $SNAPSHOT/nvm
  touch $TOUCH
fi

TOUCH=$COMPLETED/node-utilities.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  REPO="node-utilities"
  mkdir -p ${LOCAL_RKIEL} && cd $_
  rm -rf ${REPO}
  git clone ${GITHUB_RKIEL}/${REPO}.git
  cd ${LOCAL_RKIEL}/${REPO}
  ./install/bin/setup ${MY_SHELL}
  mkdir -p $SNAPSHOT/node-utilities
  cp ~/.[bz]* $SNAPSHOT/node-utilities
  touch $TOUCH
fi

TOUCH=$COMPLETED/python.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
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
  PYTHON_CURRENT=3.8.0
  pyenv install $PYTHON_CURRENT
  pyenv global $PYTHON_CURRENT
  touch $TOUCH
fi

TOUCH=$COMPLETED/awscli.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  pyenv global $PYTHON_CURRENT
  pip3 install awscli --upgrade --user
  echo 'export PATH=~/.local/bin:$PATH' >> ${MY_PROFILE}
  source ${MY_PROFILE}
  aws --version
  touch $TOUCH
fi

TOUCH=$COMPLETED/aws-utilities.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  REPO="aws-utilities"
  mkdir -p ${LOCAL_RKIEL} && cd $_
  rm -rf ${REPO}
  git clone ${GITHUB_RKIEL}/${REPO}.git
  cd ${LOCAL_RKIEL}/${REPO}
  ./install/bin/setup ${MY_SHELL}
  touch $TOUCH
fi

TOUCH=$COMPLETED/git-utilities.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  echo && read -p "enter FEATURE_USER: " FEATURE_USER
  REPO="git-utilities"
  mkdir -p ${LOCAL_RKIEL} && cd $_
  rm -rf ${REPO}
  git clone ${GITHUB_RKIEL}/${REPO}.git
  cd ${LOCAL_RKIEL}/${REPO}
  ./install/bin/setup ${FEATURE_USER} ${MY_SHELL}
  touch $TOUCH
fi

TOUCH=$COMPLETED/vim-setup.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  REPO="vim-setup"
  mkdir -p $LOCAL_RKIEL && cd $_
  rm -rf ${REPO}
  git clone ${GITHUB_RKIEL}/${REPO}.git
  cd ${LOCAL_RKIEL}/${REPO}
  ./install/bin/setup ${MY_SHELL}
  touch $TOUCH
fi

TOUCH=$COMPLETED/atom-app.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  if [ -e ~/Downloads/atom-mac.zip ]; then
    cd ~/Downloads && unzip atom-mac.zip
  fi
  mv ~/Downloads/Atom.app /Applications
  cd /usr/local
  sudo mkdir -p bin
  cd /usr/local/bin
  sudo ln -nfs /Applications/Atom.app/Contents/Resources/app/atom.sh atom
  sudo ln -nfs /Applications/Atom.app/Contents/Resources/app/apm/node_modules/.bin/apm apm
  touch $TOUCH
fi

TOUCH=$COMPLETED/atom-setup.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  REPO="atom-setup"
  mkdir -p $LOCAL_RKIEL && cd $_
  rm -rf ${REPO}
  git clone ${GITHUB_RKIEL}/${REPO}.git
  cd ${LOCAL_RKIEL}/${REPO}
  ./install/bin/setup install
  touch $TOUCH
fi

TOUCH=$COMPLETED/vscode-app.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  cd ~/Downloads && unzip VSCode-darwin-stable.zip
  VSCODE="Visual Studio Code"
  mv ~/Downloads/"$VSCODE".app /Applications
  touch $TOUCH
fi

TOUCH=$COMPLETED/vscode-setup.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  REPO="vscode-setup"
  mkdir -p $LOCAL_RKIEL && cd $_
  rm -rf ${REPO}
  git clone ${GITHUB_RKIEL}/${REPO}.git
  cd ${LOCAL_RKIEL}/${REPO}
  ./install/bin/setup ${MY_SHELL}
  touch $TOUCH
fi

if [ "${MY_SHELL}" == "zsh" ] ; then
  sudo chmod -R 755 /usr/local/share/zsh
fi

TOUCH=$COMPLETED/awssu.txt
if [ ! -e $TOUCH ] ; then
  echo "***** ${TOUCH} *****"
  echo && read -p "enter AWS account id/name: " MY_AWS_ID
  echo && read -p "enter AWS user name: " MY_AWS_USER
  echo && read -p "enter AWS region: " MY_AWS_REGION
  awssu add $MY_AWS_ID $MY_AWS_USER ~/Downloads/credentials.csv $MY_AWS_REGION json
  awssu pki $MY_AWS_ID $MY_AWS_USER
  CODECOMMIT_KEY=codecommit_id_rsa
  ssh-add -K ~/.ssh/$CODECOMMIT_KEY
  awssu use $MY_AWS_ID $MY_AWS_USER
  awssu safe
  touch $TOUCH
fi
