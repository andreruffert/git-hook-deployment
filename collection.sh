#!/bin/sh

#------------------------------------------------------------
# Define Vars
#------------------------------------------------------------
vPATH="/var/www/virtual/bf/"
DOMAIN="bnfy.de"
HASH="k43p01d"


#------------------------------------------------------------
# git checkout
#------------------------------------------------------------
GIT_WORK_TREE=$vPATH$HASH.$DOMAIN git checkout -f


#------------------------------------------------------------
# Datenbankdump einspielen
#------------------------------------------------------------
mysql bf_$HASH <$vPATH$HASH.$DOMAIN/db.sql


#------------------------------------------------------------
# .htaccess RewriteBase aktivieren
#------------------------------------------------------------
sed -i 's/#RewriteBase/RewriteBase/g' $vPATH$HASH.$DOMAIN/.htaccess


#------------------------------------------------------------
# Contao: localconfig.php $websitePath anpassen
#------------------------------------------------------------
sed -i 's/\/$HASH//g' $vPATH$HASH.$DOMAIN/system/config/localconfig.php


#------------------------------------------------------------
# Verzeichnisschutz hinzufügen
#------------------------------------------------------------
echo -e '\n\nAuthUserFile '$vPATH'.htpasswd\nAuthGroupFile /dev/null\nAuthName "Restricted Area"\nAuthType Basic\n<Limit GET>\nrequire valid-user\n</Limit>' >> $vPATH$HASH.$DOMAIN/.htaccess