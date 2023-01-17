-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema grupo_PRJ
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema grupo_PRJ
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `grupo_PRJ` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin ;
USE `grupo_PRJ` ;

-- -----------------------------------------------------
-- Table `grupo_PRJ`.`locus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`locus` (
  `accession` VARCHAR(30) NOT NULL,
  `locus_name` VARCHAR(45) NOT NULL,
  `molecule` VARCHAR(45) NOT NULL,
  `segment_type` VARCHAR(45) NULL DEFAULT NULL,
  `genbank_date` VARCHAR(45) NULL DEFAULT NULL,
  `genbank_division` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`accession`),
  UNIQUE INDEX `accession_UNIQUE` (`accession` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`reference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`reference` (
  `reference_id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(500) NULL DEFAULT NULL,
  `journal` VARCHAR(500) NULL DEFAULT NULL,
  `pubmed_id` VARCHAR(45) NULL DEFAULT NULL,
  `locus_accession` VARCHAR(30) NOT NULL,
  `ref_location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`reference_id`),
  UNIQUE INDEX `reference_id_UNIQUE` (`reference_id` ASC) ,
  UNIQUE INDEX `pubmed_id_UNIQUE` (`pubmed_id` ASC) ,
  INDEX `fk_reference_locus1_idx` (`locus_accession` ASC) ,
  CONSTRAINT `fk_reference_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `grupo_PRJ`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`pubmed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`pubmed` (
  `pubmed_id` VARCHAR(45) NOT NULL,
  `title` VARCHAR(500) NULL DEFAULT NULL,
  `date` VARCHAR(45) NULL DEFAULT NULL,
  `source` VARCHAR(500) NULL DEFAULT NULL,
  `issue` VARCHAR(45) NULL DEFAULT NULL,
  `pages` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`pubmed_id`),
  CONSTRAINT `fk_pubmed_reference1`
    FOREIGN KEY (`pubmed_id`)
    REFERENCES `grupo_PRJ`.`reference` (`pubmed_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`authors` (
  `authors_id` INT(11) NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(100) NULL DEFAULT NULL,
  `pubmed_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`authors_id`),
  UNIQUE INDEX `authors_id_UNIQUE` (`authors_id` ASC) ,
  INDEX `fk_authors_pubmed1_idx` (`pubmed_id` ASC) ,
  CONSTRAINT `fk_authors_pubmed1`
    FOREIGN KEY (`pubmed_id`)
    REFERENCES `grupo_PRJ`.`pubmed` (`pubmed_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`definition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`definition` (
  `def_id` INT(11) NOT NULL AUTO_INCREMENT,
  `definition` VARCHAR(500) NOT NULL,
  `locus_accession` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`def_id`),
  UNIQUE INDEX `def_id_UNIQUE` (`def_id` ASC) ,
  INDEX `fk_definition_locus1_idx` (`locus_accession` ASC) ,
  CONSTRAINT `fk_definition_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `grupo_PRJ`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`feat_cds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`feat_cds` (
  `feat_cds_id` INT(11) NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(500) NULL DEFAULT NULL,
  `codon_start` VARCHAR(500) NULL DEFAULT NULL,
  `product` VARCHAR(500) NULL DEFAULT NULL,
  `protein_id` VARCHAR(500) NULL DEFAULT NULL,
  `translation` MEDIUMTEXT NULL DEFAULT NULL,
  `locus_accession` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`feat_cds_id`),
  UNIQUE INDEX `feat_cds_id_UNIQUE` (`feat_cds_id` ASC) ,
  INDEX `fk_feat_cds_locus1_idx` (`locus_accession` ASC) ,
  CONSTRAINT `fk_feat_cds_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `grupo_PRJ`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`feat_gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`feat_gene` (
  `feat_gene_id` INT(11) NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(500) NULL DEFAULT NULL,
  `name` VARCHAR(500) NULL DEFAULT NULL,
  `locus_accession` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`feat_gene_id`),
  UNIQUE INDEX `feat_gene_id_UNIQUE` (`feat_gene_id` ASC) ,
  INDEX `fk_feat_gene_locus1_idx` (`locus_accession` ASC) ,
  CONSTRAINT `fk_feat_gene_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `grupo_PRJ`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`feat_source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`feat_source` (
  `feat_source_id` INT(11) NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(500) NULL DEFAULT NULL,
  `organism` VARCHAR(500) NULL DEFAULT NULL,
  `db_xref` VARCHAR(500) NULL DEFAULT NULL,
  `locus_accession` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`feat_source_id`),
  UNIQUE INDEX `feat_source_id_UNIQUE` (`feat_source_id` ASC) ,
  INDEX `fk_feat_source_locus1_idx` (`locus_accession` ASC) ,
  CONSTRAINT `fk_feat_source_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `grupo_PRJ`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`locus_keywords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`locus_keywords` (
  `locus_keyword_id` INT(11) NOT NULL AUTO_INCREMENT,
  `locus_accession` VARCHAR(30) NOT NULL,
  `key_order` VARCHAR(45) NULL DEFAULT NULL,
  `keyword_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`locus_keyword_id`),
  UNIQUE INDEX `locus_keyword_id_UNIQUE` (`locus_keyword_id` ASC) ,
  INDEX `fk_locus_keywords_locus1_idx` (`locus_accession` ASC) ,
  CONSTRAINT `fk_locus_keywords_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `grupo_PRJ`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`sequences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`sequences` (
  `seq` MEDIUMTEXT NOT NULL,
  `seq_length` INT(11) NOT NULL,
  `locus_accession` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`locus_accession`),
  CONSTRAINT `fk_sequences_locus`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `grupo_PRJ`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`taxonomy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`taxonomy` (
  `taxonomy_id` INT(11) NOT NULL AUTO_INCREMENT,
  `taxonomy` VARCHAR(500) NOT NULL,
  `locus_accession` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`taxonomy_id`),
  UNIQUE INDEX `source_id_UNIQUE` (`taxonomy_id` ASC) ,
  INDEX `fk_source_locus1_idx` (`locus_accession` ASC) ,
  CONSTRAINT `fk_source_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `grupo_PRJ`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `grupo_PRJ`.`source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo_PRJ`.`source` (
  `source_id` INT(11) NOT NULL AUTO_INCREMENT,
  `scientific_name` VARCHAR(100) NOT NULL,
  `locus_accession` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`source_id`),
  UNIQUE INDEX `taxonomy_id_UNIQUE` (`source_id` ASC) ,
  INDEX `fk_taxonomy_locus1_idx` (`locus_accession` ASC) ,
  CONSTRAINT `fk_taxonomy_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `grupo_PRJ`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
