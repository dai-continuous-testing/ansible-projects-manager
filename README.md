# ansible-projects-manager
Scripts to manage ansible roles and working with them

These scripts are to aid developers in worflows invoving ansible projects in experitest. This will help you in 
1. Releasing a new product release. Say you want to create a 23.3 release, There is a script to create and push 23.3 branch on all ansible repos.
2. You are trying to add common settings to all ansible roles like deleting log files older that 30 days. This should be added to all roles. 



## Notes: 
### When a new ansible role for a component is added, You need to update the list in .env file

## Usage:

1. sh clone_pull_all_repos.sh
2. sh create_branch_and_push.sh master 23.10