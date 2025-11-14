#!/bin/sh
set -e

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="/backup/mysql_backup_${TIMESTAMP}.sql.gz"

echo "[INFO] Starting MySQL backup..."

mysqldump -h mysql -u root -p"$MYSQL_PWD" --all-databases | gzip > "$BACKUP_FILE"

echo "[INFO] Backup completed: $BACKUP_FILE"

# Delete old backups
find /backup -type f -name "*.sql.gz" -mtime +${BACKUP_RETENTION_DAYS} -delete

echo "[INFO] Old backups removed."
