
# source common vars
# Load the helper functions.
path=`readlink -f "${BASH_SOURCE:-$0}"`
script_dir_path=`dirname $path`
. $script_dir_path/helper.sh
# Load the global env file
load_envfile $script_dir_path/.env


branch=${1:-$MAIN_BRANCH}
current_dir=`pwd`

OLD_IFS=$IFS
IFS=$','
for repo in $ANSIBLE_REPOS; do
	echo "Cloning $repo"
	if [ -d "$repo" ]; then
	   	echo "Repo already present"
	else
		git clone --quiet $GIT_BASE_URL/$repo.git
	fi

	# Making sure we have repo there.
	if [ -d "$repo" ]; then
	  	cd $current_dir/$repo
	  	# echo "current_dir=`pwd`"
	  	git fetch --quiet --all
	  	git checkout --quiet $branch
	  	git pull --quiet
		cd -
  	else
	  	echo "Couldn't clone $repo. Moving to next one"
	fi
done

IFS=$OLD_IFS
