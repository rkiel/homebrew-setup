Homebrew
# Updates

## Login as Admin

#### macOS

Apple -> About this Mac -> Software Update -> Update All
Reboot

#### Chrome

Chrome -> About Google Chrome

#### Atom

Atom -> About Atom -> Restart and Install

#### Homebrew

[from their FAQ](https://docs.brew.sh/FAQ.html)

First update the formulae and Homebrew itself:

```bash
brew --version
brew update
brew --version
```

You can now find out what is outdated with:

```bash
brew outdated
```

Upgrade everything with:

```bash
brew upgrade
```

Or upgrade a specific formula with:

```bash
brew upgrade <formula>
```

Dealing with node

```bash
brew uninstall node
brew install node
brew link node
brew doctor
brew postinstall node
```




