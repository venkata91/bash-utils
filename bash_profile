export CLICOLOR='true'
export LSCOLORS="gxfxcxdxbxCgCdabagacad"
export EDITOR=vim

# Git branch in good-looking prompt.
parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Prompt with Git branch
# Explanation of the weird lines: \u Username, \h Host, \w Path, tput setaf is the color definition
# export PS1='\[$(tput setaf 7)\]\u@\[$(tput setaf 2)\]\h:\[$(tput setaf 4)\]\w\[$(tput setaf 1)\]$(parse_git_branch)\[$(tput sgr0)\] $ '
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# Bonus track: SSH autocompleting hostnames, write ssh and press tab
complete -W "$(while read line; do echo ${line%%[, ]*}; done < ~/.ssh/known_hosts)" ssh

# Git autocompletion
# Requires that you execute the following commented line:
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
test -f ~/.git-completion.bash && . $_

# start ssh agent during the mac bootup
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

source ~/.bashrc
source ~/.profile
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/venkat/Downloads/google/google-cloud-sdk/path.bash.inc' ]; then source '/Users/venkat/Downloads/google/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/venkat/Downloads/google/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/venkat/Downloads/google/google-cloud-sdk/completion.bash.inc'; fi
export PATH="/usr/local/opt/openssl/bin:$PATH"
