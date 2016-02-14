# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

##
# Your previous /Users/saf/.bash_profile file was backed up as /Users/saf/.bash_profile.macports-saved_2015-11-08_at_11:07:16
##

# MacPorts Installer addition on 2015-11-08_at_11:07:16: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

