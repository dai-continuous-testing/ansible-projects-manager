

# source common vars
# Load the helper functions.
path=`readlink -f "${BASH_SOURCE:-$0}"`
script_dir_path=`dirname $path`
. $script_dir_path/helper.sh
# Load the global env file
load_envfile $script_dir_path/.env


branch=${1:-$MAIN_BRANCH}
current_dir=`pwd`
for repo in $ANSIBLE_REPOS
do
	if [ -d "$repo" ]; then
	   echo "Repo already present"
	else
		git clone $GIT_BASE_URL/$repo.git
	fi
	cd $current_dir/$repo
	echo "current_dir=`pwd`"
	git fetch --all
	git checkout $branch
	git pull
	cd -
done
