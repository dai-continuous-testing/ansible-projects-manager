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
	echo -e "\n-------------------------------------------------------"
	echo "$repo"
	if [ -d "$repo" ]; then
	   echo "folder already exists"
	else
		git clone $GIT_BASE_URL/$repo.git
	fi
	cd $current_dir/$repo
	echo "current_dir=`pwd`"
	git fetch --all
	if [ "$DRY_RUN" == "yes" ]; then
		echo "$repo : $new_branch will be created from $branch"
	else
		git checkout -b $new_branch $branch
		# git branch --set-upstream-to=origin/$new_branch $new_branch
		git push -u origin $new_branch
	fi
	cd -
done
IFS=$OLD_IFS
