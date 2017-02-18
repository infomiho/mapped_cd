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
		<name>	Changes your current directory to one mapped by <name>
		add <name>	Maps current directory to <name>
		rm <name>	Removes the mapping by <name>
		list	Print all stored mappings
		show <name>    Show the full path to <name>
		help		Show this
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
	elif [[ $1 = "show" ]]; then
		c_show $2
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
	ls -lh $MAPPED_CD/;
}

# Map current directory
c_add() {
	ln -s $(pwd) $MAPPED_CD/$1;
}

c_rm() {
	unlink $MAPPED_CD/$1;
}

c_show() {
	readlink -e $MAPPED_CD/$1;
}
