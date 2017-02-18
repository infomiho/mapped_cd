# Mapped cd -

MAPPED_CD=~/.mappedCd

# If directory does not exist, create it
if [ ! -d $MAPPED_CD ]; then
		mkdir $MAPPED_CD
fi

c_usage()
{
	cat <<- EOF
	Usage: c [command] <name>

	Commands:
		add <name>	Adds the current working directory to your warp points
		rm <name>	Removes the given warp point
		list	        Print all stored warp points
		show <name>    Show the path to given warp point
		help		Show this extremely helpful text
	EOF
}

# Switch through possible commands
c() {
	if [[ $1 = "list" ]]; then
		c_list
	elif [[ $1 = "add" ]]; then
		c_add $2
	elif [[ $1 = "rm" ]]; then
		c_rm $2
	elif [[ $1 = "help" || $1 = "--help" ]]; then
		c_usage
	elif [[ $1 = "" ]]; then
		c_usage
	else
		c_cd $1
	fi
}

c_cd() {
	cd -P $MAPPED_CD/$1;
}

c_list() {
	ls -lah $MAPPED_CD/;
}

# Map current directory
c_add() {
	ln -s $(pwd) $MAPPED_CD/$1;
}

c_rm() {
	unlink $MAPPED_CD/$1;
}
