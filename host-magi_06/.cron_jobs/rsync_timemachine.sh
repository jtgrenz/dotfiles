 #!/bin/sh
# This script is executed by launchd
# and is called from ~/Library/LaunchAgents/com.plisterine.rsync_time_machine.plist

export PATH=/usr/local/bin/:$PATH
alias echo='echo $(date): "$1"'

# VOLUME=/Volumes/Encrypted_Google_Drive_Backup
VOLUME=/Volumes/Backup

echo
echo
echo "============================="
echo "Starting..."
echo "Checking for Volume " $VOLUME/
echo
if [[ -d "$VOLUME" ]]; then

  # SCRIPT=~/.cron_jobs/rsync-time-backup/rsync_tmbackup.sh
  SOURCE=~/
  # DEST=$VOLUME/Magi-06/
  DEST=$VOLUME/rsync/Magi-06/home/
  EXCLUDE=~/.cron_jobs/rsync_timemachine_exclude_file
  FLAGS='-D --compress --numeric-ids --links --hard-links --one-file-system --itemize-changes --times --recursive --perms --owner --group --stats --human-readable'

  MYPID="$$"
  PIDFILE="$VOLUME/rsync/Magi-06/rsync.pid.txt"

  echo "Starting Backup to " $DEST
  echo
  osascript -e 'display notification "Backing up Home to /Volumes/Backup/Magi-06/" with title "Rsync Time Machine"'
  # $SCRIPT $SOURCE $DEST $EXCLUDE
  echo $$ > $PIDFILE
  rsync $FLAGS --exclude-from=$EXCLUDE --partial-dir=.rsync_partial $SOURCE $DEST
fi

  rm -f $PIDFILE
echo "Complete"
echo
