#!/bin/bash

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\033[0;34m"
COLOR_LIGHT_RED="\033[1;31m"
COLOR_LIGHT_GREEN="\033[1;32m"
COLOR_WHITE="\033[1;37m"
COLOR_LIGHT_GRAY="\033[0;37m"
COLOR_COLOR_NONE="\e[0m"

##############################################
# Functions that deal with colorizing output #
##############################################

#--------------
# $1 is the colour to use, the rest will be echoed in this colour
#--------------
function echo_color {
	echo -n -e $1
	shift
	echo -n -e $*
	echo -e $COLOR_COLOR_NONE
}

function echo_red { 
	echo_color $COLOR_RED $* 
}

function echo_yellow { 
	echo_color $COLOR_YELLOW $* 
}

function echo_green { 
	echo_color $COLOR_GREEN $* 
}

function echo_blue { 
	echo_color $COLOR_BLUE $* 
}


#--------------
# Move the Cursor 4 Columns to the right and echo a green "success"
#--------------
function echo_success {
	echo -n -e "\033[4C"
	echo_green success
}

function echo_failed {
	echo -n -e "\033[4C"
	echo_red failed
}

function echo_unknown {
	echo -n -e "\033[4C"
	echo_yellow unknown
}

##############################################################################
# Functions that deal with exiting with a specific exitcode and errormessage #
##############################################################################

#--------------
# $1 is the exitcode, the rest will be echoed to stderr, followed by a red 'failed'
#--------------
function exit_n {
	exitcode=$1
	shift
	echo $*			1>&2
	echo_red failed 1>&2
	exit $exitcode
}

function exit1() {
	exit_n 1 $*
}

function exit2() {
	exit_n 2 $*
}

function exit_with_message() {
	exit_n 1 $*
}

###########################################
# Functions that deal with error handling #
###########################################

#--------------
# Setup the errorhandler, that on most errors, exit1 will be called with the
# scriptname and the linenumber where the error occured
#--------------
function set_default_error_handler {
	set -o pipefail 	# trace ERR throug pipes
	set -o errtrace 	# trace ERR through 'time command' and other functions
	set -o nounset  	# set -u -> do not use uninitialized variables
	set -o errexit  	# exit if any statement fails
	trap 'exit1 Fehler in $0 in Zeile $LINENO mit Errorcode $?' ERR
}


function unset_default_error_handler {
	set +o pipefail 	# trace ERR throug pipes
	set +o errtrace 	# trace ERR through 'time command' and other functions
	set +o nounset  	# set -u -> do not use uninitialized variables
	set +o errexit  	# exit if any statement fails
	trap - ERR
}

#echo_red Rot ist eine schöne Farbe
#echo_yellow Gelb ist eine schöne Farbe
#echo_green Grün ist eine schöne Farbe
#echo_blue Blau ist eine schöne Farbe
