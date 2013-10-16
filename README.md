my-unix-settings
================

## Install

```bash
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
