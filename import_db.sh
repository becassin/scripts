#!/bin/bash
# Create dump
ssh -l {server_username} {server_ip} "mysqldump -u {server_mysql_username} --password={server_mysql_password} {server_db_name} > {server_dump_file}"
echo Created dump

# Download dump
scp -r {server_username}@{server_ip}:{server_dump_file} {local_dump_file}
echo Downloaded dump

# Find and replace (optionnal)
sed -i "" 's/{old_text}/{new_text}/g' {local_dump_file}
echo Replaced text

# Import dump locally
mysql -u {local_mysql_username} -p{local_mysql_password} {local_db_name} < {local_dump_file}
echo Imported dump

# Removing files
ssh -l {server_username} {server_ip} "rm {server_dump_file}"
rm {local_dump_file}
echo Removed files
echo All good.