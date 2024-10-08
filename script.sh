#!/bin/bash

# Load environment variables from .env file
source .env

# Get current date and time
DATE=$(date +"%Y%m%d%H%M%S")

# Create backup
mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/${DB_NAME}_backup_$DATE.sql

# Optional: Remove backups older than 7 days
find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -exec rm {} \;

echo "Backup of $DB_NAME completed and saved to $BACKUP_DIR/${DB_NAME}_backup_$DATE.sql"
