#!/bin/bash
set -e

echo "Starting MySQL..."
/etc/init.d/mysql start

echo "Waiting for MySQL to be ready..."
for i in {1..30}; do
  if mysql -u root -e "SELECT 1" &> /dev/null; then
    echo "MySQL is ready!"
    break
  fi
  echo "Waiting... ($i/30)"
  sleep 1
done

echo "Setting up database..."
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Darsh123';"
mysql -u root -pDarsh123 -e "CREATE DATABASE IF NOT EXISTS ecommerce;"
mysql -u root -pDarsh123 ecommerce < /ecommerce.sql
mysql -u root -pDarsh123 -e "CREATE USER IF NOT EXISTS 'dockeruser'@'localhost' IDENTIFIED BY 'Darsh123';"
mysql -u root -pDarsh123 -e "GRANT ALL PRIVILEGES ON ecommerce.* TO 'dockeruser'@'localhost';"
mysql -u root -pDarsh123 -e "FLUSH PRIVILEGES;"

echo "Database ready!"

echo "Starting Tomcat..."
exec catalina.sh run