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
alias g='git'
alias gs='git status'
alias ga='git add'
alias gp='git pull'
alias gp-all-sub='for i in $(find . -type d -maxdepth 1 -not -name .);  do cd $i; echo "git pull: $i"; gp; cd ..; done'
alias gci='git commit'
alias gcia='git commit -am '
alias gsub-updat-all='git submodule foreach git submodule update'
alias gpush='git push'
alias gfetch='git fetch'
alias gmerge='git merge'
alias mocha='mocha --reporter spec '
alias ssh2r3ticketman='ssh gamadeployer@r3ticketman.sgfgames.com'
alias xt='xtitle'
alias grunt='grunt --stack'
alias nw='npm run-script watch'
alias ns='npm start'
alias npminstall='npm config set registry http://registry.cnpmjs.org && npm install && npm config set registry http://registry.npmjs.org'
alias cnpm='npm config set registry http://registry.cnpmjs.org && echo set npm to cn registry'
alias enpm='npm config set registry http://registry.npmjs.org && echo set npm to origin registry'
alias json-format='cat $1 | python -mjson.tool'
export PATH=/usr/local/bin:${PATH}

# Functions
# #########

# 全文检索
hint () { grep "$1" . -r | grep -v svn; }

# 全文检索大小写不敏感
hinti () { grep "$1" . -ir | grep -v svn; }

PS1="[\[\033[37m\]\w\[\033[0m\]]\n\[\033[1;36m\]\u@\h\[\033[1;33m\] -> \[\033[0m\]"

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# enable autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# include git auto completion
source ~/.git-completion.bash

# include android sdk auto completion
#source /usr/local/etc/bash_completion.d

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_HOME=/usr/local/opt/android-sdk

export PATH=$ANDROID_HOME:$PATH
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

# add by quick-cocos2d-x setup, DATE: 2014-06-13 TIME: 18:17:03
export QUICK_COCOS2DX_ROOT="$(echo `cd ~/workspaces/quick-cocos2d-x && pwd`)"

# include php55 into path
export PATH="$(brew --prefix homebrew/php/php55)/bin:$PATH"

# add quick-cocos2d-x related lua files into LUA_PATH
if ! [[ -z "$QUICK_COCOS2DX_ROOT" ]]; then
 export LUA_PATH="${QUICK_COCOS2DX_ROOT}/framework/?.lua;${LUA_PATH}"
fi

# NOTE: cocos2d-x-v3 中的 lua 接口文件在 lua.vim 的扫描时报错，所以我拿出来到 .vim/lua 目录下，做二次加工
export LUA_PATH="$(echo `cd ~/.vim/lua/cocos2d-x-v3/ && pwd`)/?.lua;${LUA_PATH}"

#export COCOS2DX_V3_ROOT="/Users/ty/workspaces/cocos2d-x"
# add cocos2d-x related lua files into LUA_PATH
#if ! [[ -z "$COCOS2DX_V3_ROOT" ]]; then
 #export LUA_PATH="${COCOS2DX_V3_ROOT}/cocos/scripting/lua-bindings/script/?.lua;${LUA_PATH}"
#fi

