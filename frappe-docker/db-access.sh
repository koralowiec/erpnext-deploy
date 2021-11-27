#!/bin/bash

echo "Wait..."

while true
do
  mysqlcheck -A --password=$MYSQL_ROOT_PASSWORD
  if [ $? -eq 0 ]; then
    break
  fi
  sleep 1
done

try_patch() {
  echo "Wait..."
  sleep 90
  user=$(mysql --password=$MYSQL_ROOT_PASSWORD -e "select user from mysql.user;" | grep "_" | awk "{print $1}" | head -1)
  grant="GRANT ALL PRIVILEGES ON *.* to '${user}'@'%';"
  echo "Executing: ${grant}"
  mysql --password=$MYSQL_ROOT_PASSWORD -e "${grant}"
}

x=1
while [ $x -le 20 ]
do
  echo "Try number $x"
  try_patch

  if [ $? -eq 0 ]; then
    break
  fi

  x=$(( $x + 1 ))
done
