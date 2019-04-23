#!/bin/bash
export PATH=$PATH:/Applications/MySQLWorkbench.app/Contents/MacOS

set -e

#LASTDATE=`date -d "$(date +%Y-%m-01) -1 day" +%Y%m%d`
LASTDATE="20181031"

NAME="${LASTDATE}_OB_ADR_csv.zip"
NAME_STRUKT="${LASTDATE}_strukt_ADR.csv.zip"

CESTA_K_CSV_STRUKT="./strukturovane-CSV"  ## cesta, kde se rozbalil archiv struktury
SEZNAM="/tmp/seznam.txt"     ## může zůstat přednastaveno, je to jen dočasný soubor

######################
USER="root"                  ## uživatel do DB
PASSWORD="viridiumcz"        ## heslo do DB
DB="ruian"                  ## databáze
TABLE="ruian_adresy"  ## tabulka v DB, kam se budou importovat data
HOST=127.0.0.1
PORT=3308
######################


echo "Stahuji strukturu..."
#wget "http://vdp.cuzk.cz/vymenny_format/csv/$NAME_STRUKT"
#unzip ${NAME_STRUKT}
#rm ${NAME_STRUKT}

echo "Inicializace databaze..."
mysql -h${HOST} -P${PORT} -u ${USER} -p${PASSWORD} --default-character-set=cp1250 --local_infile=1 ${DB} < ruian_init_vazby.sql
echo "adresni-mista-vazby-cr"
mysql -h${HOST} -P${PORT} -u ${USER} -p${PASSWORD} --local_infile=1 ${DB} -e "LOAD DATA LOCAL INFILE '${CESTA_K_CSV_STRUKT}/adresni-mista-vazby-cr.csv' INTO TABLE ruian_adresy_vazby CHARACTER SET cp1250 FIELDS TERMINATED BY ';' IGNORE 1 LINES"
echo "vazby-cr"
mysql -h${HOST} -P${PORT} -u ${USER} -p${PASSWORD} --local_infile=1 ${DB} -e "LOAD DATA LOCAL INFILE '${CESTA_K_CSV_STRUKT}/vazby-cr.csv' INTO TABLE ruian_vazby_cr CHARACTER SET cp1250 FIELDS TERMINATED BY ';' IGNORE 1 LINES"
echo "vazby-okresy-cr"
mysql -h${HOST} -P${PORT} -u ${USER} -p${PASSWORD} --local_infile=1 ${DB} -e "LOAD DATA LOCAL INFILE '${CESTA_K_CSV_STRUKT}/vazby-okresy-cr.csv' INTO TABLE ruian_vazby_okresy CHARACTER SET cp1250 FIELDS TERMINATED BY ';' IGNORE 1 LINES"

rm -rf ${CESTA_K_CSV_STRUKT}
exit;
