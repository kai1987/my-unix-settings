# Unix 开发工作环境同步

包含：bash_profile, _vimrc, _screenrc

## 安装方法

**第1步: 把服务器上的配置文件拉到本地**

```bash
rm -rf ~/.vim && \
rm -rf ~/temp/my-unix-settings && \
mkdir -p ~/temp && \
cd ~/temp && \
git clone git@github.com:yi/my-unix-settings.git && \
rm -rf ~/.git && \
mv ./my-unix-settings/.git ~ && \
cd ~ && \
git reset --hard HEAD && \
rm -rf ~/temp/my-unix-settings
```


**第2步: 安装 vbundle vim 插件管理器 **

```bash
git clone -b quick-x https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```


**第3步: 启动vim,并且安装插件

```bash
vi
```

vi 启动之后执行 `:BundleInstall`

**重新启动vim，所有配置生效**


