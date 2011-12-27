# History Options
# ###############

# Don't put duplicate lines in the history.
# export HISTCONTROL="ignoredups"

# Ignore some controlling instructions
# export HISTIGNORE="[   ]*:&:bg:fg:exit"

# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# use vi style bash input
set -o vi 


# Aliases
# #######

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias dp='ssh arkytan@dappad.com'
alias sshearth='ssh sgfdeployer@www.zuikong.com'
alias sshjupiter='ssh sgfdeployer@ping.zuikong.com'

# Some shortcuts for different directory listings
alias ls='ls -hF -G'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

# alias ls='ls -F --color=always'
alias ll='ls -l'
alias search=grep
alias mcd='mount /mnt/cdrom'
alias ucd='umount /mnt/cdrom'
alias mc='mc -c'
alias ..='cd ..'
alias ...='cd ../..'
alias up='cd ..'
alias qci='svn ci . -m "" --no-auth-cache '
alias cdp='cap deploy'
alias sup='svn up'
alias gs='git status'
alias gadd='git add'
alias gci='git commit'
alias gpush='git push'
alias gfetch='git fetch'
alias gmerge='git merge'


# Functions
# #########

# PS1="$(__svn_stat)[\[\033[32m\]\w\[\033[0m\]]\n\[\033[1;36m\]\u\[\033[1;33m\] -> \[\033[0m\]"
PS1="[\[\033[37m\]\w\[\033[0m\]]\n\[\033[1;36m\]\u\[\033[1;33m\] -> \[\033[0m\]"


