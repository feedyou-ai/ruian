#!/bin/bash
export PATH=$PATH:/Applications/MySQLWorkbench.app/Contents/MacOS

######################
USER="root"                  ## uživatel do DB
PASSWORD="secret"        ## heslo do DB
DB="ruian"                  ## databáze
TABLE="ruian_adresy"  ## tabulka v DB, kam se budou importovat data
HOST=127.0.0.1
PORT=3306
######################

rm -f ./output/*.csv

mysql -h${HOST} -P${PORT} -u${USER} -p${PASSWORD} ${DB} < ./export.sql

iconv --from-code windows-1250 --to-code utf8 ./output/CastObce.csv > ./CastObce.csv
iconv --from-code windows-1250 --to-code utf8 ./output/Obec.csv > ./Obec.csv
iconv --from-code windows-1250 --to-code utf8 ./output/Ulice.csv > ./Ulice.csv
iconv --from-code windows-1250 --to-code utf8 ./output/Adresa.csv > ./Adresa.csv