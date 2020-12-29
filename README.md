### Downloads

* [Google Chrome](http://www.google.com/chrome/)
* [Firefox](https://www.mozilla.org/en-US/firefox/)
* [Atom](https://atom.io/)
* [Visual Studio Code](https://code.visualstudio.com/)
* [1Password](https://1password.com/downloads/mac/)
* [Spotify](https://www.spotify.com/us/download/mac/)
* [OpenVPN](https://openvpn.net/download-open-vpn/)
* [Avast](https://www.avast.com/en-us/free-mac-security)
* [Zoom](https://zoom.us/download#client_4meeting)

### Install Xcode

```bash
xcode-select --install
```

### Download

Clone this project

```bash
git clone https://github.com/rkiel/macos-updates.git
cd macos-updates
```

### Setup

* create SSH keys
* configure git
* configure GitHub

```bash
./setup.sh
```

### Install

* install bash/zsh
* clone repositories
* install languages, browsers and IDEs

```bash
./install.sh
```

### Cleanup


When testing of dot files is complete.

```bash
rm -rf /tmp/snapshot
```

When everything has been successfully installed.

```bash
cd
rm -rf ~/macos-updates
rm -rf /tmp/completed
```

## Resources

### SSH

- [Simplify Your Life With an SSH Config File](https://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/)
- [OpenSSH Config File Examples](https://www.cyberciti.biz/faq/create-ssh-config-file-on-linux-unix/)
- [Using the SSH Config File](https://linuxize.com/post/using-the-ssh-config-file/)
- [Automatically add SSH keys to SSH agent with GNOME and macOS](https://www.michelebologna.net/2018/automatically-add-ssh-keys-to-ssh-agent-running-in-gnome-and-macos/)
- [How to manage multiple GitHub accounts on a single machine with SSH keys](https://www.freecodecamp.org/news/manage-multiple-github-accounts-the-ssh-way-2dadc30ccaca/)
- [Multiple SSH Keys settings for different github account](https://gist.github.com/jexchan/2351996)

### Chrome

- [Install latest version of Google Chrome without re-packaging](https://www.jamf.com/jamf-nation/discussions/20894/install-latest-version-of-google-chrome-without-re-packaging)
