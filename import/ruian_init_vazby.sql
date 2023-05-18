DROP TABLE IF EXISTS `ruian_adresy_vazby`;
DROP TABLE IF EXISTS `ruian_vazby_cr`;
DROP TABLE IF EXISTS `ruian_soudrznosti`;
DROP TABLE IF EXISTS `ruian_kraje`;
DROP TABLE IF EXISTS `ruian_okresy`;
DROP TABLE IF EXISTS `ruian_adresy_vazby`;


CREATE TABLE `ruian_soudrznosti` (
  `id`    INT(11)     NOT NULL,
  `nazev` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;


INSERT INTO ruian_soudrznosti VALUES
  ('60', 'Jihov�chod'),
  ('35', 'Jihoz�pad'),
  ('86', 'Moravskoslezsko'),
  ('19', 'Praha'),
  ('51', 'Severov�chod'),
  ('43', 'Severoz�pad'),
  ('27', 'St�edn� �echy'),
  ('78', 'St�edn� Morava');


CREATE TABLE `ruian_kraje` (
  `id`            INT(11)     NOT NULL,
  `nazev`         VARCHAR(64) NOT NULL,
  `soudrznost_id` INT(11)     NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

INSERT INTO ruian_kraje VALUES
  (19, 'Hlavn� m�sto Praha', 19),
  (35, 'Jiho�esk� kraj', 35),
  (116, 'Jihomoravsk� kraj', 60),
  (51, 'Karlovarsk� kraj', 43),
  (108, 'Kraj Vyso�ina', 60),
  (86, 'Kr�lov�hradeck� kraj', 51),
  (78, 'Libereck� kraj', 51),
  (132, 'Moravskoslezsk� kraj', 86),
  (124, 'Olomouck� kraj', 78),
  (94, 'Pardubick� kraj', 51),
  (43, 'Plze�sk� kraj', 35),
  (27, 'St�edo�esk� kraj', 27),
  (60, '�steck� kraj', 43),
  (141, 'Zl�nsk� kraj', 78);

#KOD;NAZEV;VUSC_KOD;KRAJ_1960_KOD;NUTS_LAU;PLATI_OD;PLATI_DO;DATUM_VZNIKU
CREATE TABLE `ruian_okresy` (
  `id`           INT(11)     NOT NULL,
  `nazev`        VARCHAR(64) NOT NULL,
  `kraj_id`      INT(11)     NOT NULL,
  `kraj_1960_id` INT(11)     NOT NULL,
  `nuts_lau`     INT(11)     NOT NULL,
  `plati_od`     DATETIME    NOT NULL,
  `plati_do`     DATETIME    NOT NULL,
  `datum_vzniku` DATETIME    NOT NULL,
  PRIMARY KEY (`id`)

)
  ENGINE = InnoDB;

LOAD DATA LOCAL INFILE '../celky/UI_OKRES.csv' INTO TABLE ruian_okresy
CHARACTER SET cp1250 FIELDS TERMINATED BY ';' IGNORE 1 LINES;


CREATE TABLE `ruian_vazby_cr` (
  `cast_obce_id`      INT(11) NOT NULL,
  `obec_id`           INT(11) NOT NULL,
  `poverena_obec_id`  INT(11) NOT NULL,
  `rozsirena_obec_id` INT(11) NOT NULL,
  `okres_id`           INT(11) NOT NULL,
  `soudrznost_id`     INT(11) NOT NULL,
  `stat_id`           INT(11) NOT NULL
)
  ENGINE = InnoDB;

#COBCE_KOD;OBEC_KOD;OKRES_KOD;KRAJ_1960_KOD;STAT_KOD
CREATE TABLE `ruian_vazby_okresy` (
  `cast_obce_id` INT(11) NOT NULL,
  `obec_id`      INT(11) NOT NULL,
  `okres_id`     INT(11) NOT NULL,
  `kraj_1960_id` INT(11) NOT NULL,
  `stat_id`      INT(11) NOT NULL
)
  ENGINE = InnoDB;

#ADM_KOD;ULICE_KOD;COBCE_KOD;MOMC_KOD;MOP_KOD;SPRAVOBV_KOD;OBEC_KOD;POU_KOD;ORP_KOD;VUSC_KOD;VO_KOD
CREATE TABLE `ruian_adresy_vazby` (
  `adresa_id`              INT(11) NOT NULL,
  `ulice_id`               INT(11) NOT NULL,
  `cast_obce_id`           INT(11) NOT NULL,
  `mestsky_obvod_id`       INT(11) NOT NULL,
  `mestsky_obvod_praha_id` INT(11) NOT NULL,
  `sprav_obec_id`          INT(11) NOT NULL,
  `obec_id`                INT(11) NOT NULL,
  `pou_id`                 INT(11) NOT NULL,
  `orp_id`                 INT(11) NOT NULL,
  `vusc_id`                INT(11) NOT NULL,
  `vo_id`                  INT(11) NOT NULL
)
  ENGINE = InnoDB;