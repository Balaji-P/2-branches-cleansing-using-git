
#######################################
# SCRIPT 1 - PREVIEW BRANCH DELETIONS #
#######################################
# will print the names of the branches that have been merged into develop and master in green and branches that are only merged into develop but not master in red.
BRANCHES_IN_MASTER=`git branch -r --merged origin/master | grep -v -E '(\*|master$|develop$)' | cut -f2- -d '/' | tr '\n' ';'` && export BRANCHES_IN_MASTER && git branch -r --merged origin/develop | grep -v -E '(\*|master$|develop$)' | cut -f2- -d '/' | xargs -L1 bash -c 'if [ $(grep -o "$0" <<< "$BRANCHES_IN_MASTER" | wc -l) -gt 0 ] ; then printf "\e[0;32m $0 \e[0m\n"; else printf "\e[0;31m $0 is merged into DEVELOP but not MASTER \e[0m\n"; fi';

#################################################################################################################################
# SCRIPT 2 - DANGER -- RUN AT YOUR OWN RISK -- The following script will DELETE the branches listed in the above preview script #
#################################################################################################################################
# The following script is the same as the above script
BRANCHES_IN_MASTER=`git branch -r --merged origin/master | grep -v -E '(\*|master$|develop$)' | cut -f2- -d '/' | tr '\n' ';'` && export BRANCHES_IN_MASTER && git branch -r --merged origin/develop | grep -v -E '(\*|master$|develop$)' | cut -f2- -d '/' | xargs -L1 bash -c 'if [ $(grep -o "$0" <<< "$BRANCHES_IN_MASTER" | wc -l) -gt 0 ] ; then printf "\e[0;32m DELETING: $0 \e[0m\n" && git push origin --delete $0; else printf "\e[0;31m $0 is merged into DEVELOP but not MASTER \e[0m\n"; fi';

git remote update -p