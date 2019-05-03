#!/bin/sh

export PATH=/usr/local/bin/:$PATH
alias echo='echo $(date): "$1"'

atWork=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep "SSID: Shopify")
CLOUDMOUNT='/Volumes/GoogleDrive'
BACKUPFILE='/Volumes/GoogleDrive/My Drive/gocryptfs_backup' # uses google drive file stream but it doesnt support hardlinks
# BACKUPFILE='/Volumes/GoogleDrive/gocryptfs_backup' # usese google-drive-ocamlfuse
BACKUPMOUNTPOINT="/Volumes/Backup"
VOLUME=$BACKUPMOUNTPOINT
EXTPASS="security find-generic-password -a jongrenning -s backup_fs -w"
alias gocryptfs='/usr/local/bin/gocryptfs'
alias google-drive-ocamlfuse='/Users/jongrenning/.opam/system/bin/google-drive-ocamlfuse'


echo
echo
echo "============================="
echo "Starting..."
echo "Checking if should mount..."

if [[ $1 = '-f' ]]; then
  echo '$1' is $1
  SHOULD_MOUNT=true
elif [[ ! -z $atWork ]]; then
  echo "Connected to $atWork"
   SHOULD_MOUNT=true
else
   SHOULD_MOUNT=false
   echo Should not mount
fi


if [[ $SHOULD_MOUNT = true ]]; then
  echo "Should Mount Backup"
  if [[ -d "$CLOUDMOUNT" ]]; then
    if [[ -d "$BACKUPMOUNTPOINT" ]]; then
      echo "Backup drive is already mounted."
    else
      echo "$CLOUDMOUNT is mounted. Mounting $BACKUPMOUNTPOINT"
      # open /Volumes/GoogleDrive/My\ Drive/Encrypted_Backup_Magi-06.sparsxebundle.sparsebundle
      # open /Volumes/GoogleDrive/My\ Drive/Encrypted_Backup_Magi-06_HFS.sparsebundle
      gocryptfs -extpass="$EXTPASS" "$BACKUPFILE" $BACKUPMOUNTPOINT
      osascript -e 'display notification "Mounted encrypted backup drive" with title "Rsync Time Machine"'
    fi
  else
    echo "$CLOUDMOUNT is not mounted. Mounting $CLOUDMOUNT"
    open -a Google\ Drive\ File\ Stream
    # mkdir $CLOUDMOUNT
    # google-drive-ocamlfuse -o="volname=GoogleDrive" $CLOUDMOUNT
    sleep 2
    echo "Mounting $BACKUPMOUNTPOINT"
    gocryptfs -extpass=$EXTPASS $BACKUPFILE $BACKUPMOUNTPOINT
    osascript -e 'display notification "Mounted Cloud drive and encrypted backup drive" with title "Rsync Time Machine"'
    # open /Volumes/GoogleDrive/My\ Drive/Encrypted_Backup_Magi-06.sparsxebundle.sparsebundle
    # open /Volumes/GoogleDrive/My\ Drive/Encrypted_Backup_Magi-06_HFS.sparsebundle
  fi

else
  echo "Not connected to Shopify or Shopify Guest"
    if [[ -d "$BACKUPMOUNTPOINT" ]]; then
      if [[ -e "$BACKUPMOUNTPOINT/Magi-06/backup.inprogress" ]]; then
        backuppid=$(cat "$BACKUPMOUNTPOINT/Magi-06/backup.inprogress")
        echo "rsync-timemachine is running as process: $backuppid. Killing $backuppid."
        osascript -e 'display notification "Stopping backup" with title "Rsync Time Machine"'
        kill $backuppid
      fi
      echo "Unmounting backup drive"
      sleep 4
      diskutil umount $BACKUPMOUNTPOINT
      osascript -e 'display notification "Unmounted encrypted backup drive" with title "Rsync Time Machine"'
    fi
fi

echo "Complete"
echo
