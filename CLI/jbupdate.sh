
# Update Script for macOS
# Description:
# checks for any updates, using homebrew, AppStore, and Apple Software Updates
# Requirements:
# homebrew - https://brew.sh/
# mas-cli - https://github.com/mas-cli/mas

echo "===> Checking for updates..."
echo "===> Running homebrew..."
brew update

echo "===> Outdated homebrew packages"
brew outdated

echo "===> Running MAS..."
mas outdated

echo "===> Running Apple Software Update"
softwareupdate -l
