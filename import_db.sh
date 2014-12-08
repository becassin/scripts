#!/bin/bash
# Create dump
ssh -l {server_username} {server_ip} "mysqldump -u {server_mysql_username} --password={server_mysql_password} {server_db_name} > {server_dump_file}"
# Download dump
scp -r {server_username}@{server_ip}:{server_dump_file} {local_dump_file}
# Find and replace (optionnal)
sed -i "" 's/{old_text}/{new_text}/g' {local_dump_file}
# Import dump locally
mysql -u {local_mysql_username} -p{local_mysql_password} {local_db_name} < {local_dump_file}