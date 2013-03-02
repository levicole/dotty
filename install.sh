ln -s ~/my/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/my/dotfiles/.vim ~/.vim
ln -s ~/my/dotfiles/.vimrc ~/.vimrc
ln -s ~/my/dotfiles/.ackrc ~/.ackrc
ln -s ~/my/dotfiles/.irbrc ~/.irbrc
ln -s ~/my/dotfiles/.screenrc ~/.screenrc

pushd .
cd ~/my/dotfiles/.vim/bundles
git submodule init
git submodule update
popd
