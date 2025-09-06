
install:
	rm -f ~/{bashrc,.bash_profile,.tmux.conf,.vimrc}
	rm -fr ~/.vim
	cp bashrc ~/.bashrc
	cp bash_profile ~/.bash_profile
	cp tmux.conf ~/.tmux.conf
	cp vimrc ~/.vimrc
	cp -a vim ~/.vim
	install -D ghostty-config ~/.config/ghostty/config
	mkdir -p ~/bin
	cp -a bin/* ~/bin
	mkdir -p ~/.config/direnv
	cp direnvrc ~/.config/direnv
	cp starship.toml ~/.config/ 
