-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema genbank exemplo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema genbank exemplo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `genbank exemplo` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `genbank exemplo` ;

-- -----------------------------------------------------
-- Table `genbank exemplo`.`definition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`definition` (
  `def_id` INT NOT NULL AUTO_INCREMENT,
  `definition` VARCHAR(200) NULL DEFAULT NULL,
  `locus_accession` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`def_id`),
  UNIQUE INDEX `def_id_UNIQUE` (`def_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`locus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`locus` (
  `accession` VARCHAR(20) NOT NULL,
  `locus_name` VARCHAR(20) NOT NULL,
  `molecule` VARCHAR(20) NOT NULL,
  `segment_type` VARCHAR(20) NULL,
  `genbank_date` VARCHAR(20) NULL,
  `genbank_division` VARCHAR(3) NULL,
  PRIMARY KEY (`accession`),
  UNIQUE INDEX `GI_UNIQUE` (`accession` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`sequences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`sequences` (
  `seq` MEDIUMTEXT NOT NULL,
  `seq_length` INT NOT NULL,
  `locus_accession` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`locus_accession`),
  CONSTRAINT `fk_sequences_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `genbank exemplo`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`locus_keywords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`locus_keywords` (
  `locus_keyword_id` INT NOT NULL AUTO_INCREMENT,
  `locus_accession` VARCHAR(20) NOT NULL,
  `key_order` INT NULL,
  `keyword_name` VARCHAR(45) NULL,
  PRIMARY KEY (`locus_keyword_id`),
  INDEX `fk_keywords_locus1_idx` (`locus_accession` ASC) VISIBLE,
  UNIQUE INDEX `locus_keyword_id_UNIQUE` (`locus_keyword_id` ASC) VISIBLE,
  CONSTRAINT `fk_keywords_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `genbank exemplo`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`source` (
  `source_id` INT NOT NULL AUTO_INCREMENT,
  `scientific_name` VARCHAR(100) NOT NULL,
  `locus_accession` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`source_id`),
  UNIQUE INDEX `source_id_UNIQUE` (`source_id` ASC) VISIBLE,
  INDEX `fk_source_locus1_idx` (`locus_accession` ASC) VISIBLE,
  UNIQUE INDEX `locus_accession_UNIQUE` (`locus_accession` ASC) VISIBLE,
  CONSTRAINT `fk_source_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `genbank exemplo`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`taxonomy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`taxonomy` (
  `taxonomy_id` INT NOT NULL AUTO_INCREMENT,
  `taxonomy` VARCHAR(500) NOT NULL,
  `locus_accession` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`taxonomy_id`),
  UNIQUE INDEX `taxonomy_id_UNIQUE` (`taxonomy_id` ASC) VISIBLE,
  INDEX `fk_taxonomy_locus1_idx` (`locus_accession` ASC) VISIBLE,
  UNIQUE INDEX `locus_accession_UNIQUE` (`locus_accession` ASC) VISIBLE,
  CONSTRAINT `fk_taxonomy_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `genbank exemplo`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`reference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`reference` (
  `reference_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(500) NULL,
  `journal` VARCHAR(500) NULL,
  `pubmed_id` VARCHAR(45) NULL,
  `locus_accession` VARCHAR(20) NOT NULL,
  `ref_location` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`reference_id`),
  UNIQUE INDEX `reference_id_UNIQUE` (`reference_id` ASC) VISIBLE,
  UNIQUE INDEX `pubmed_id_UNIQUE` (`pubmed_id` ASC) VISIBLE,
  INDEX `fk_reference_locus1_idx` (`locus_accession` ASC) VISIBLE,
  CONSTRAINT `fk_reference_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `genbank exemplo`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`pubmed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`pubmed` (
  `pubmed_id` VARCHAR(45) NOT NULL,
  `title` VARCHAR(500) NULL,
  `date` VARCHAR(20) NULL,
  `source` VARCHAR(500) NULL,
  `issue` VARCHAR(20) NULL,
  `pages` VARCHAR(45) NULL,
  `doi` VARCHAR(500) NULL,
  INDEX `fk_pubmed_reference1_idx` (`pubmed_id` ASC) VISIBLE,
  PRIMARY KEY (`pubmed_id`),
  CONSTRAINT `fk_pubmed_reference1`
    FOREIGN KEY (`pubmed_id`)
    REFERENCES `genbank exemplo`.`reference` (`pubmed_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`authors` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(100) NULL,
  `pubmed_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`author_id`),
  UNIQUE INDEX `author_id_UNIQUE` (`author_id` ASC) VISIBLE,
  INDEX `fk_authors_pubmed1_idx` (`pubmed_id` ASC) VISIBLE,
  CONSTRAINT `fk_authors_pubmed1`
    FOREIGN KEY (`pubmed_id`)
    REFERENCES `genbank exemplo`.`pubmed` (`pubmed_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`feat_source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`feat_source` (
  `feat_source_id` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(500) NULL,
  `organism` VARCHAR(500) NULL,
  `db_xref` VARCHAR(500) NULL,
  `locus_accession` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`feat_source_id`),
  UNIQUE INDEX `feat_source_id_UNIQUE` (`feat_source_id` ASC) VISIBLE,
  INDEX `fk_feat_source_locus1_idx` (`locus_accession` ASC) VISIBLE,
  CONSTRAINT `fk_feat_source_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `genbank exemplo`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`feat_cds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`feat_cds` (
  `feat_cds_id` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(500) NULL,
  `codon_start` VARCHAR(500) NULL,
  `product` VARCHAR(500) NULL,
  `protein_ib` VARCHAR(500) NULL,
  `translation` MEDIUMTEXT NULL,
  `locus_accession` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`feat_cds_id`),
  UNIQUE INDEX `feat_cds_id_UNIQUE` (`feat_cds_id` ASC) VISIBLE,
  INDEX `fk_feat_cds_locus1_idx` (`locus_accession` ASC) VISIBLE,
  CONSTRAINT `fk_feat_cds_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `genbank exemplo`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`feat_gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`feat_gene` (
  `gene_id` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(500) NOT NULL,
  `name` VARCHAR(500) NULL,
  `locus_accession` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`gene_id`),
  UNIQUE INDEX `gene_id_UNIQUE` (`gene_id` ASC) VISIBLE,
  INDEX `fk_feat_gene_locus1_idx` (`locus_accession` ASC) VISIBLE,
  CONSTRAINT `fk_feat_gene_locus1`
    FOREIGN KEY (`locus_accession`)
    REFERENCES `genbank exemplo`.`locus` (`accession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
