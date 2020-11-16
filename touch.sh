if [[ `uname -a` =~ "microsoft" ]]; then
	echo "NO"
elif [[ `uname -a` =~ "Linux" ]]; then
	echo "YES"
fi

