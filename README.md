# run cron

crontab -e
0 3 \* \* \* script.sh >> backup/logs/backup.log 2>&1
