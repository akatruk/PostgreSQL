#!/bin/bash

# Source Database Credentials
SRC_HOST="10.0.0.10"
SRC_DB="postgres"
SRC_USER="postgres"
SRC_PASS="******"

# Destination Database Credentials
DST_HOST="10.0.0.11"
DST_DB="postgres"
DST_USER="postgres"
DST_PASS="******"

# Backup Directory Name (for multi-threaded dumps)
BACKUP_DIR="/tmp/${SRC_DB}_backup"
# Export Source Database Password for pg_dump
export PGPASSWORD=$SRC_PASS

# Ensure Backup Directory Exists
if [ -e "$BACKUP_DIR" ]; then
    if [ ! -d "$BACKUP_DIR" ]; then
        echo "Error: $BACKUP_DIR exists but is not a directory."
        unset PGPASSWORD
        exit 1
    fi
else
    mkdir -p "$BACKUP_DIR"
fi

# Start timing
START_TIME=$(date +%s)

# Step 1: Backup the Source Database with Multi-Threading
echo "Starting multi-threaded backup of database $SRC_DB from $SRC_HOST..."
pg_dump -h "$SRC_HOST" -U "$SRC_USER" -d "$SRC_DB" -F d -j 4 -f "$BACKUP_DIR" -v
if [ $? -ne 0 ]; then
    echo "Error: Backup failed."
    END_TIME=$(date +%s)
    TOTAL_TIME=$((END_TIME - START_TIME))
    echo "Process ended. Total time taken: $TOTAL_TIME seconds."
    unset PGPASSWORD
    exit 1
fi
echo "Backup completed successfully. Directory: $BACKUP_DIR"

# Step 2: Export Destination Database Password for pg_restore
export PGPASSWORD=$DST_PASS

# Step 3: Restore the Backup to the Destination Database with Multi-Threading
echo "Starting multi-threaded restore to database $DST_DB on $DST_HOST..."
pg_restore -h "$DST_HOST" -U "$DST_USER" -d "$DST_DB" --no-owner --role="$DST_USER" --clean --if-exists -j 4 -v "$BACKUP_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Restore failed."
    END_TIME=$(date +%s)
    TOTAL_TIME=$((END_TIME - START_TIME))
    echo "Process ended. Total time taken: $TOTAL_TIME seconds."
    unset PGPASSWORD
    exit 1
fi
echo "Restore completed successfully."

# End timing
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))

# Cleanup
unset PGPASSWORD
echo "Process completed successfully."
echo "Total time taken: $TOTAL_TIME seconds."
