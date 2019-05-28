-- CastObce
SELECT 'PartitionKey','RowKey','Nazev','Nazev@type','NazevAscii','NazevAscii@type','Obec','Obec@type','Okres','Okres@type'
UNION ALL
SELECT co.`psc` AS `PartitionKey`, co.`id` AS `RowKey`, co.`Nazev`, 'Edm.String' AS `Nazev@type`, co.nazev_ascii AS `NazevAscii`, 'Edm.String' AS `NazevAscii@type`, o.`nazev` AS `Obec`, 'Edm.String' AS `Obec@type`, ok.`nazev` AS `Okres`, 'Edm.String' AS `Okres@type`
FROM `ruian_casti_obce` co
JOIN `ruian_obce` o ON o.id = co.obec_id
JOIN `ruian_okresy` ok ON ok.id = o.okres_id
INTO OUTFILE '/var/lib/mysql-files/CastObce.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Obec
SELECT 'PartitionKey','RowKey','Nazev','Nazev@type','NazevAscii','NazevAscii@type','Okres','Okres@type'
UNION ALL
SELECT o.`okres_id` AS `PartitionKey`, o.`id` AS `RowKey`, o.`Nazev`, 'Edm.String' AS `Nazev@type`, o.`nazev_ascii` as `NazevAscii`, 'Edm.String' AS `NazevAscii@type`, ok.`nazev` AS `Okres`, 'Edm.String' AS `Okres@type`
FROM `ruian_obce` o
JOIN `ruian_okresy` ok ON ok.id = o.okres_id
INTO OUTFILE '/var/lib/mysql-files/Obec.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Ulice
SELECT 'PartitionKey','RowKey','Nazev','Nazev@type','CastObceId','CastObceId@type'
UNION ALL
SELECT
a.`psc` AS `PartitionKey`, 
u.`id` AS `RowKey`, 
u.`nazev_ulice` AS `Nazev`, 
'Edm.String' AS `Nazev@type`,
u.`casti_obce_id` AS `CastObceId`, 
'Edm.String' AS `CastObceId@type`
FROM `ruian_ulice` u
-- joinovat psc pres adresy - ulice muze lezet ve vice mestkych castech
JOIN `ruian_adresy` a ON u.id=a.ulice_id
GROUP BY u.id, a.psc
INTO OUTFILE '/var/lib/mysql-files/Ulice.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Adresa
SELECT 'PartitionKey','RowKey','TypSo','TypSo@type','CisloDomovni','CisloDomovni@type','CisloOrientacni','CisloOrientacni@type','CastObce','CastObce@type','CastObceId','CastObceId@type','UliceId','UliceId@type','Ulice','Ulice@type','ObecId','ObecId@type','Obec','Obec@type'
UNION ALL
SELECT
a.`psc` AS `PartitionKey`,
a.`id` AS `RowKey`,
a.`typ_so` AS `TypSo`,
'Edm.String' AS `TypSo@type`,
a.`cislo_domovni` AS `CisloDomovni`,
'Edm.String' AS `CisloDomovni@type`,
a.`cislo_orientacni` AS `CisloOrientacni`,
'Edm.String' AS `CisloOrientacni@type`,
a.`nazev_casti_obce` AS `CastObce`,
'Edm.String' AS `CastObce@type`,
a.`casti_obce_id` AS `CastObceId`,
'Edm.String' AS `CastObceId@type`,
COALESCE(a.`ulice_id`,'') AS `UliceId`,
'Edm.String' AS `UliceId@type`,
COALESCE(u.`nazev_ulice`,'') AS `Ulice`,
'Edm.String' AS `Ulice@type`,
o.`id` AS `ObecId`,
'Edm.String' AS `ObecId@type`,
o.`nazev` AS `Obec`,
'Edm.String' AS `Obec@type`
-- IF( p.adm_id = a.id, 'true', 'false' ) AS `Pokryti`,
-- 'Edm.Boolean' AS `Pokryti@type`
FROM `ruian_adresy` a
JOIN `ruian_obce` o ON o.id = a.`obec_id`
LEFT OUTER JOIN `ruian_ulice` u ON u.id = a.`ulice_id`
-- LEFT OUTER JOIN `pokryti` p ON p.adm_id = a.`id`
INTO OUTFILE '/var/lib/mysql-files/Adresa.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';