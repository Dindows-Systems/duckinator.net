#!/usr/bin/env bash
# To generate the cron entry, run this script with -cron

SCRIPT=$(readlink -f $0)
DIR=`dirname $SCRIPT`
LOG=$DIR/git_pull.log

if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$1" != "" ]; then
  echo
  echo "Add the following cron entry for this to auto-run every 10 minutes:"
  echo
  echo "*/3 * * * * ${SCRIPT}"
  echo
  exit
fi

cd $DIR
echo -en "$(date):\n  " >> $LOG
git pull &> last_git_pull.log
cat last_git_pull.log >> $LOG

