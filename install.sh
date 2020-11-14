cd /Users/Shared
rm -rf images-starter
git clone $GITHUB_RKIEL/images-starter.git

VendorDMG="googlechrome.dmg"
hdiutil attach ~/Downloads/"$VendorDMG"  -nobrowse
CHROME="Google Chrome"
cp -pPR  /Volumes/"$CHROME"/"$CHROME".app /Applications/
GoogleChromeDMG="$(hdiutil info | grep "/Volumes/$CHROME" | awk '{ print $1 }')"
hdiutil detach $GoogleChromeDMG
rm -rf ~/Downloads/"$VendorDMG"


cd ~/Downloads && VendorDMG=`ls Firefox*.dmg`
hdiutil attach ~/Downloads/"$VendorDMG"  -nobrowse
cp -pPR  /Volumes/Firefox/Firefox.app /Applications/
FirefoxDMG="$(hdiutil info | grep /Volumes/Firefox | awk '{ print $1 }')"
hdiutil detach $FirefoxDMG
rm -rf ~/Downloads/"$VendorDMG"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

\curl -sSL https://get.rvm.io | bash -s stable --autolibs=enable

RUBY_CURRENT=2.7
RUBY_PREVIOUS=2.6
rvm install $RUBY_CURRENT
rvm install $RUBY_PREVIOUS
rvm --default use $RUBY_CURRENT

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
git clone ${GITHUB_RKIEL}/node-utilities.git

cd $LOCAL_RKIEL/node-utilities
./install/bin/setup
