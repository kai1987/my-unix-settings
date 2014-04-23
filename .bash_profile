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
alias gp-all-sub='for i in $(find . -type d -maxdepth 1 -not -name .);  do cd $i; echo "git pull: $i"; gp; cd ..; done'
alias gci='git commit'
alias gcia='git commit -am '
alias gpush='git push'
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
alias ssh2m2='ssh modao@m2.sgfgames.com'
alias ssh2darkmac-home='ssh imac@darkmac-home'
alias ssh2gama='ssh modao@gamagama.cn'
alias ssh149='ssh user@192.168.90.149'
alias ssh154='ssh yi@192.168.90.154'
alias ssh2r3ticketman='ssh gamadeployer@r3ticketman.sgfgames.com'
alias ssh2ck1='ssh modao@ck1.sgfgames.com'

alias xt='xtitle'
alias grunt='grunt --stack'
alias redis-to-r3-atf='redis-cli -h r3.sgfgames.com -p 6390'
alias nw='npm run-script watch'
alias ns='npm start'
alias npminstall='npm config set registry http://registry.cnpmjs.org && npm install && npm config set registry http://registry.npmjs.org'
alias cnpm='npm config set registry http://registry.cnpmjs.org && echo set npm to cn registry'
alias enpm='npm config set registry http://registry.npmjs.org && echo set npm to origin registry'

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

# include git auto completion
source ~/.git-completion.bash


# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/ty/tools/cocos2d-x-3.0rc1/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable NDK_ROOT for cocos2d-x
export NDK_ROOT=/Users/ty/tools/android-ndk-r9d
export PATH=$NDK_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT=/Users/ty/tools/adt-bundle/sdk
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH
