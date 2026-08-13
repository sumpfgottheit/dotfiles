
install:
	rm -f ~/{bashrc,.bash_profile,.tmux.conf,.vimrc}
	rm -fr ~/.vim
	cp bashrc ~/.bashrc
	cp bash_profile ~/.bash_profile
	cp tmux.conf ~/.tmux.conf
	cp vimrc ~/.vimrc
	cp -a vim ~/.vim
	mkdir -p ~/.config/ghostty
	cp ghostty-config ~/.config/ghostty/config
	mkdir -p ~/.config/zellij/layouts
	cp zellij-config.kdl ~/.config/zellij/config.kdl
	cp zellij-layout-default.kdl ~/.config/zellij/layouts/default.kdl
	mkdir -p ~/bin
	cp -a bin/* ~/bin
	mkdir -p ~/.config/direnv
	cp direnvrc ~/.config/direnv
	cp starship.toml ~/.config/ 
	mkdir -p ~/.config/git/
	cp gitignore ~/.config/git/ignore

