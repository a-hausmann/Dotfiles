# 20121018: first, source the .bash_functions file.
. ~/.bash_functions

# 20121018: substitute alias for function in .bash_functions.
alias ll='ls -l'
# Put "~/bin" first so I can use my versions if necessary.
PATH=~/bin:~/Documents/AA/Website/Flyers/a33-bin:$PATH

# 20100301: Include Python language setups.
PYTHONSTARTUP=${HOME}/bin/bin-python/0-startup.py
# 20100418: Added bin-perl to path.
# 20121119: Added bin-java to path.
PATH=~/src/work:~/bin/bin-perl:~/bin/bin-python:~/bin/bin-java:$PATH
# 20121018: substitute alias for function in .bash_functions.
#alias idle='env python /usr/lib/python2.6/idlelib/idle.py &'
#alias idle3='env python3 /usr/lib/python3.1/idlelib/idle.py &'

# 20100301: Leave the EXPORT of PATH until just before presenting the menu.
export PATH
# 20100418: Create cvs root path.
#export CVSROOT='/data/arnold/cvs'
#export CVSEDITOR='/usr/bin/vim'
#export WORK="$HOME/src/work"

# Set editor to vi or emacs
# 20140217: Screw THAT! Just make it vi. (Note, cannot set to "vim" as that is
# an "invalid option." Must be a bash thing.
#printf "\nChoose a bash command line editor.\n"
#printf "1) vi \n2) emacs.\n"
#read -p "Enter selection [1]: "
#case $REPLY in
#	2)	set -o emacs;printf "setting editor to EMACS\n";;
#	*)	set -o vi;printf "setting editor to vi\n";;
#esac
set -o vi

#20130525: Change prompt to two-liner, putting complete $PWD in titlebar.
PS1='\[\e]2;${PWD}\a\]\[\e[1;31m\]\u@\h: \[\e[1;34m\]\w\n \$ \[\e[m\]'

#20140316: Tell Bash History to ignore duplicate commands.
export HISTCONTROL=erasedups

