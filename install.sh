#!/bin/bash

if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# make sure profile exists
touch ~/.bash_profile

# upgrade bash version && add completion
grep -qxF '/usr/local/bin/bash' /etc/shells
if [ $? -ne 0 ]; then
  brew install bash
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash
fi
brew install bash-completion 
grep -qxF '[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"'  ~/.bash_profile
if [ $? -ne 0 ]; then
cat <<EOT >> ~/.bash_profile
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
EOT
fi


brew tap caskroom/cask
brew install ag autojump bash-git-prompt cloc ctags ctop curl dos2unix fasd git git-extras git-flow go hub htop httpie kubectl kubernetes-cli net-snmp nmap pass rpm ssh-copy-id the_silver_searcher tiff2png tmux tree vim wget
brew cask install chicken cyberduck docker dropbox balenaetcher firefox google-chrome iterm2 kindle skype slack spotify teamviewer vagrant visual-studio-code whatsapp opera virtualbox

# add completions for the above applications
grep -qxF 'source <(kubectl completion bash)'  ~/.bash_profile
if [ $? -ne 0 ]; then
cat <<EOT >> ~/.bash_profile
source <(kubectl completion bash)
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
EOT
fi