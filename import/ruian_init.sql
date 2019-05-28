DELIMITER $$

DROP FUNCTION IF EXISTS `transliterate` $$
CREATE FUNCTION `transliterate` (original VARCHAR(128)) RETURNS VARCHAR(128)
BEGIN

  DECLARE translit VARCHAR(128) CHARSET cp1250 COLLATE cp1250_general_ci DEFAULT '';
  DECLARE len      INT(3)       DEFAULT 0;
  DECLARE pos      INT(3)       DEFAULT 1;
  DECLARE letter   CHAR(1) CHARSET cp1250 COLLATE cp1250_general_ci ;

  SET len = CHAR_LENGTH(original);

  WHILE (pos <= len) DO
    SET letter = SUBSTRING(original, pos, 1);

    CASE TRUE
      WHEN letter = 'Á' THEN SET translit = CONCAT(translit, 'a');
      WHEN letter = 'Ä' THEN SET translit = CONCAT(translit, 'a');
      WHEN letter = 'È' THEN SET translit = CONCAT(translit, 'c');
      WHEN letter = 'Ï' THEN SET translit = CONCAT(translit, 'd');
      WHEN letter = 'É' THEN SET translit = CONCAT(translit, 'e');
      WHEN letter = 'Ì' THEN SET translit = CONCAT(translit, 'e');
      WHEN letter = 'Í' THEN SET translit = CONCAT(translit, 'i');
      WHEN letter = 'Å' THEN SET translit = CONCAT(translit, 'l');
      WHEN letter = '¼' THEN SET translit = CONCAT(translit, 'l');
      WHEN letter = 'Ò' THEN SET translit = CONCAT(translit, 'n');
      WHEN letter = 'Ó' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = 'Ô' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = 'Ö' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = 'À' THEN SET translit = CONCAT(translit, 'r');
      WHEN letter = 'Ø' THEN SET translit = CONCAT(translit, 'r');
      WHEN letter = 'Š' THEN SET translit = CONCAT(translit, 's');
      WHEN letter = '' THEN SET translit = CONCAT(translit, 't');
      WHEN letter = 'Ú' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = 'Ù' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = 'Ü' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = 'Ý' THEN SET translit = CONCAT(translit, 'y');
      WHEN letter = 'Ž' THEN SET translit = CONCAT(translit, 'z');
      WHEN letter = 'á' THEN SET translit = CONCAT(translit, 'a');
      WHEN letter = 'ä' THEN SET translit = CONCAT(translit, 'a');
      WHEN letter = 'è' THEN SET translit = CONCAT(translit, 'c');
      WHEN letter = 'ï' THEN SET translit = CONCAT(translit, 'd');
      WHEN letter = 'é' THEN SET translit = CONCAT(translit, 'e');
      WHEN letter = 'ì' THEN SET translit = CONCAT(translit, 'e');
      WHEN letter = 'í' THEN SET translit = CONCAT(translit, 'i');
      WHEN letter = 'å' THEN SET translit = CONCAT(translit, 'l');
      WHEN letter = '¾' THEN SET translit = CONCAT(translit, 'l');
      WHEN letter = 'ò' THEN SET translit = CONCAT(translit, 'n');
      WHEN letter = 'ó' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = 'ô' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = 'ö' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = 'à' THEN SET translit = CONCAT(translit, 'r');
      WHEN letter = 'ø' THEN SET translit = CONCAT(translit, 'r');
      WHEN letter = 'š' THEN SET translit = CONCAT(translit, 's');
      WHEN letter = '' THEN SET translit = CONCAT(translit, 't');
      WHEN letter = 'ú' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = 'ù' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = 'ü' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = 'ý' THEN SET translit = CONCAT(translit, 'y');
      WHEN letter = 'ž' THEN SET translit = CONCAT(translit, 'z');
      WHEN letter = ' ' THEN SET translit = CONCAT(translit, ' ');      
      ELSE      
        SET translit = CONCAT(translit, letter);        
    END CASE;

    SET pos = pos + 1;
  END WHILE;

  RETURN lower(translit);

END $$

DELIMITER ;


ALTER DATABASE ruian CHARACTER SET cp1250 COLLATE cp1250_general_ci;

DROP TABLE IF EXISTS `ruian_adresy`;
CREATE TABLE `ruian_adresy` (
  `id`                      INT(11)        NOT NULL,
  `obec_id`                 INT(11)        NOT NULL,
  `nazev_obce`              VARCHAR(64)    NOT NULL,
  `momc_id`                 INT(11)    NOT NULL,
  `nazev_momc`              VARCHAR(64)    NOT NULL,
  `mop_id`                  INT(11)    NOT NULL,
  `nazev_mop`               VARCHAR(64)    NOT NULL,
  `casti_obce_id`           INT(11)        NOT NULL,
  `nazev_casti_obce`        VARCHAR(64)    NOT NULL,
  `ulice_id`                INT(11)    NOT NULL,
  `nazev_ulice`             VARCHAR(64)    NOT NULL,
  `typ_so`                  VARCHAR(16)    NOT NULL,
  `cislo_domovni`           INT(11)        NOT NULL,
  `cislo_orientacni`        INT(11)        NOT NULL,
  `znak_cisla_orientacniho` VARCHAR(4)     NOT NULL,
  `psc`                     MEDIUMINT(9)   NOT NULL,
  `souradnice_y`            DECIMAL(12, 2) NOT NULL,
  `souradnice_x`            DECIMAL(12, 2) NOT NULL,
  `plati_od`                DATETIME       NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;
