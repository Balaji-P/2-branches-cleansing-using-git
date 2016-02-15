# will print the names of the branches that have been merged into develop and master in green and branches that are only merged into develop but not master in red.
BRANCHES_IN_MASTER=`git branch -r --merged origin/master | grep -v -E '(\*|master$|develop$)' | tr '\n' ';'` && export BRANCHES_IN_MASTER && git branch -r --merged origin/develop | grep -v -E '(\*|master$|develop$)' | xargs -L1 bash -c 'if [ $(grep -o "$0" <<< "$BRANCHES_IN_MASTER" | wc -l) -gt 0 ] ; then printf "\e[0;32m $0 \e[0m\n"; else printf "\e[0;31m $0 is merged into Develop but not Master \e[0m\n"; fi';

git remote update -p