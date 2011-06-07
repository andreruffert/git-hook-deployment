#!/bin/sh

#------------------------------------------------------------
# Define Vars
#------------------------------------------------------------
DOMAIN="domain.tld"
HASH="kxxpxxd"


#------------------------------------------------------------
# git checkout
#------------------------------------------------------------
GIT_WORK_TREE=/var/www/virtual/bf/$HASH.$DOMAIN git checkout -f


#------------------------------------------------------------
# Datenbankdump einspielen
#------------------------------------------------------------
mysql bf_$HASH </var/www/virtual/bf/$HASH.$DOMAIN/db.sql


#------------------------------------------------------------
# .htaccess RewriteBase aktivieren
#------------------------------------------------------------
sed -i 's/#RewriteBase/RewriteBase/g' /var/www/virtual/bf/$HASH.$DOMAIN/.htaccess


#------------------------------------------------------------
# Contao: localconfig.php $websitePath anpassen
#------------------------------------------------------------
sed -i 's/\/$HASH//g' /var/www/virtual/bf/$HASH.$DOMAIN/system/config/localconfig.php


#------------------------------------------------------------
# Verzeichnisschutz hinzufügen
#------------------------------------------------------------
echo -e '\n\nAuthUserFile /var/www/virtual/bf/.htpasswd\nAuthGroupFile /dev/null\nAuthName "Restricted Area"\nAuthType Basic\n<Limit GET>\nrequire valid-user\n</Limit>' >> /var/www/virtual/bf/$HASH.$DOMAIN/.htaccess