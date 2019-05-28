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
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'a');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'a');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'c');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'd');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'e');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'e');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'i');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'l');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'l');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'n');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'r');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'r');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 's');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 't');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'y');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'z');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'a');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'a');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'c');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'd');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'e');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'e');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'i');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'l');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'l');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'n');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'o');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'r');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'r');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 's');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 't');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'u');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'y');
      WHEN letter = '�' THEN SET translit = CONCAT(translit, 'z');
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
