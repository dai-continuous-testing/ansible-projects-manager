#!/bin/bash

# source common vars
# Load the helper functions.
path=`readlink -f "${BASH_SOURCE:-$0}"`
script_dir_path=`dirname $path`
. $script_dir_path/helper.sh
# Load the global env file
load_envfile $script_dir_path/.env

if [ $# -ne 2 ]; then
	echo "Exactly two arguments are required. main_branch and new_branch"
	exit 1
fi

branch=$1
new_branch=$2
current_dir=`pwd`
OLD_IFS=$IFS
IFS=$','
for repo in $ANSIBLE_REPOS
do
echo "cloning repo $repo"
	if [ -d "$repo" ]; then
	   echo "Repo already present"
	else
		git clone --quiet $GIT_BASE_URL/$repo.git
	fi
	
	if [ $? == "0" ]; then

	cd $current_dir/$repo
	git fetch --quiet --all
	git checkout --quiet $branch
	git pull --quiet
	git checkout -b $new_branch $branch
	# git branch --set-upstream-to=origin/$new_branch $new_branch
	git push -u origin $new_branch
	cd -
	else
		echo "something went wrong with $repo"
	fi
done
IFS=$OLD_IFS
