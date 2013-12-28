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

# Some shortcuts for different directory listings
alias ls='ls -hF -G'                 # classify files in colour
# alias ls='ls -hF -G --color=auto'                 # classify files in colour
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
alias sci='svn ci '
alias svns='svn status'
alias cdp='cap deploy'
alias sup='svn up'
alias gs='git status'
alias ga='git add'
alias gp='git pull'
alias gp-all-sub='for i in $(find . -type d -maxdepth 1 -not -name .);  do echo "git pull: $i"; gp; done'
alias gci='git commit'
alias gcia='git commit -am '
alias gpush='git push origin master'
alias gfetch='git fetch'
alias gmerge='git merge'
alias nginx-start='sudo /etc/init.d/nginx start'
alias redis-to147='redis-cli -h 192.168.90.147 -p 6379'
alias redis-to230='redis-cli -h 192.168.90.230 -p 6379'
alias redis-monitor-147='redis-cli -h 192.168.90.147 monitor'
alias mocha='mocha --reporter spec '
alias ssh156='ssh modao@192.168.90.156'
alias ssh166='ssh sgfdeployer@192.168.90.166'
alias ssh2asset='ssh asset@192.168.90.156'
alias ssh147='ssh modao@192.168.90.147'
alias ssh162='ssh 192.168.90.162'
alias ssh2m2='ssh m2.sgfgames.com'
alias ssh2imac='ssh imac@192.168.10.100'
alias xt='xtitle'
alias grunt='grunt --stack'
alias redis-to-r3-atf='redis-cli -h r3.sgfgames.com -p 6390'
alias nw='npm run-script watch'

export PATH=/usr/local/bin:${PATH}
export SVN_EDITOR=vi

# Functions
# #########

hint () { grep "$1" . -ir | grep -v svn; }

# PS1="$(__svn_stat)[\[\033[32m\]\w\[\033[0m\]]\n\[\033[1;36m\]\u\[\033[1;33m\] -> \[\033[0m\]"
PS1="[\[\033[37m\]\w\[\033[0m\]]\n\[\033[1;36m\]\u@\h\[\033[1;33m\] -> \[\033[0m\]"

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi


