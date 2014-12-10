#!/bin/bash

# Variables
SERVER_USERNAME="server_uname"
SERVER_IP="server_ip"
SERVER_MYSQL_USERNAME="server_mysql"
SERVER_MYSQL_HOST="server_host"
SERVER_MYSQL_PASSWORD="server_pass"
SERVER_DB_NAME="server_db_name"
SERVER_DUMP_FILE="/var/www/tmp_dump.sql"
LOCAL_DUMP_FILE="/Library/WebServer/Documents/tmp_dump.sql"
LOCAL_MYSQL_USERNAME="local_user"
LOCAL_MYSQL_PASSWORD="local_pass"
LOCAL_DB_NAME="local_db"
OLD_TEXT="old_text"
NEW_TEXT="new_text"

# Create dump
ssh -l $SERVER_USERNAME $SERVER_IP "mysqldump -h $SERVER_MYSQL_HOST -u $SERVER_MYSQL_USERNAME --password=$SERVER_MYSQL_PASSWORD $SERVER_DB_NAME > $SERVER_DUMP_FILE"
echo Created dump

# Download dump
scp -r $SERVER_USERNAME@$SERVER_IP:$SERVER_DUMP_FILE $LOCAL_DUMP_FILE
echo Downloaded dump

# Find and replace (optionnal)
sed -i "" 's/$OLD_TEXT/$NEW_TEXT/g' $LOCAL_DUMP_FILE
echo Replaced text

# Import dump locally
mysql -u $LOCAL_MYSQL_USERNAME -p$LOCAL_MYSQL_PASSWORD $LOCAL_DB_NAME < $LOCAL_DUMP_FILE
echo Imported dump

# Removing files
ssh -l $SERVER_USERNAME $SERVER_IP "rm $SERVER_DUMP_FILE"
rm $LOCAL_DUMP_FILE
echo Removed files
echo All good.