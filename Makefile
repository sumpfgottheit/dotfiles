
install: install-bash install-vim install-git install-misc

install-bash:
	rm -f ~/.bashrc
	rm -f ~/{.bashrc,.tmux.conf,.inputrc,.bash_profile}
	ln -s `pwd`/bashrc ~/.bashrc
	ln -s `pwd`/bash_profile ~/.bash_profile
	ln -s `pwd`/tmux.conf ~/.tmux.conf
	ln -s `pwd`/inputrc ~/.inputrc

install-vim:
	rm -fr ~/.vim ~/.vimrc
	ln -s `pwd`/vimrc ~/.vimrc
	ln -s `pwd`/vim ~/.vim

install-git:
	rm -fr ~/.gitconfig
	ln -s `pwd`/gitconfig ~/.gitconfig

install-misc:
	rm -f ~/.puppet-lint.rc
	ln -s `pwd`/puppet-lint.rc ~/.puppet-lint.rc

clean:
	rm -f ~/{.bashrc,.tmux.conf,.inputrc,.bash_profile}
	rm -fr ~/.vim ~/.vimrc
	rm -fr ~/.gitconfig
	rm -f ~/.puppet-lint.rc
