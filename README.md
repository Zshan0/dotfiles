# dotfiles
Useful dotfiles for a quicker setup

## Instructions

Add ppa usefull for ricing
```bash
sudo add-apt-repository ppa:kgilmer/speed-ricer
sudo apt-get update
```

Use lightdm as display-manager:
```bash
sudo apt install lightdm
```

Install some usefull stuff:
```bash
sudo apt install git polybar i3-gaps feh htop zsh vim-gtk cmake
chsh -s $(which zsh)
```

Logout and login to i3 after this

Install Oh-My-Zsh:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Copy config files:
```bash
cp .config/i3/config ~/.config/i3/
cp ladkiwallpaper.jpg ~/Pictures/
cp .config/polybar ~/.config/
cp .vimrc .bashrc .zshrc .Xresources .gitconfig ~/
```

Install kitty terminal

```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

Set kitty to default
```bash
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator `which kitty` 50
sudo update-alternatives --config x-terminal-emulator
```
Install lunarvim
```bash
sudo apt update
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
git clone https://github.com/neovim/neovim
cd neovim && make -j8
sudo make install
```

