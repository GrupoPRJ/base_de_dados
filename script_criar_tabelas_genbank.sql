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
-- Table `genbank exemplo`.`locus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`locus` (
  `GI` INT NOT NULL AUTO_INCREMENT,
  `locus_name` VARCHAR(10) NOT NULL,
  `molecule` VARCHAR(10) NOT NULL,
  `segment_type` VARCHAR(10) NULL,
  `direction` VARCHAR(10) NULL,
  `genbank_date` DATE NULL,
  `genbank_division` VARCHAR(3) NULL,
  PRIMARY KEY (`GI`),
  UNIQUE INDEX `GI_UNIQUE` (`GI` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`definition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`definition` (
  `def_id` INT NOT NULL AUTO_INCREMENT,
  `definition` VARCHAR(200) NULL DEFAULT NULL,
  `locus_GI` INT NOT NULL,
  PRIMARY KEY (`def_id`),
  INDEX `fk_definition_locus_idx` (`locus_GI` ASC) VISIBLE,
  UNIQUE INDEX `def_id_UNIQUE` (`def_id` ASC) VISIBLE,
  UNIQUE INDEX `locus_GI_UNIQUE` (`locus_GI` ASC) VISIBLE,
  CONSTRAINT `fk_definition_locus`
    FOREIGN KEY (`locus_GI`)
    REFERENCES `genbank exemplo`.`locus` (`GI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`sequences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`sequences` (
  `seq_id` INT NOT NULL AUTO_INCREMENT,
  `seq` MEDIUMTEXT NOT NULL,
  `seq_length` INT NOT NULL,
  `locus_GI` INT NOT NULL,
  PRIMARY KEY (`seq_id`),
  INDEX `fk_sequences_locus1_idx` (`locus_GI` ASC) VISIBLE,
  UNIQUE INDEX `seq_id_UNIQUE` (`seq_id` ASC) VISIBLE,
  UNIQUE INDEX `locus_GI_UNIQUE` (`locus_GI` ASC) VISIBLE,
  CONSTRAINT `fk_sequences_locus1`
    FOREIGN KEY (`locus_GI`)
    REFERENCES `genbank exemplo`.`locus` (`GI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`accession`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`accession` (
  `accession_number` VARCHAR(20) NOT NULL,
  `Version` VARCHAR(20) NOT NULL,
  `locus_GI` INT NOT NULL,
  PRIMARY KEY (`accession_number`),
  INDEX `fk_accession_locus1_idx` (`locus_GI` ASC) VISIBLE,
  UNIQUE INDEX `accession_number_UNIQUE` (`accession_number` ASC) VISIBLE,
  UNIQUE INDEX `Version_UNIQUE` (`Version` ASC) VISIBLE,
  UNIQUE INDEX `locus_GI_UNIQUE` (`locus_GI` ASC) VISIBLE,
  CONSTRAINT `fk_accession_locus1`
    FOREIGN KEY (`locus_GI`)
    REFERENCES `genbank exemplo`.`locus` (`GI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`keywords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`keywords` (
  `keyword_id` INT NOT NULL AUTO_INCREMENT,
  `keywords_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`keyword_id`),
  UNIQUE INDEX `keyword_id_UNIQUE` (`keyword_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`locus_keywords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`locus_keywords` (
  `locus_keyword_id` INT NOT NULL AUTO_INCREMENT,
  `locus_GI` INT NOT NULL,
  `keywords_keyword_id` INT NOT NULL,
  `key_order` INT NOT NULL,
  PRIMARY KEY (`locus_keyword_id`),
  INDEX `fk_keywords_locus1_idx` (`locus_GI` ASC) VISIBLE,
  INDEX `fk_locus_keywords_keywords1_idx` (`keywords_keyword_id` ASC) VISIBLE,
  UNIQUE INDEX `locus_keyword_id_UNIQUE` (`locus_keyword_id` ASC) VISIBLE,
  UNIQUE INDEX `locus_GI_UNIQUE` (`locus_GI` ASC) VISIBLE,
  UNIQUE INDEX `keywords_keyword_id_UNIQUE` (`keywords_keyword_id` ASC) VISIBLE,
  CONSTRAINT `fk_keywords_locus1`
    FOREIGN KEY (`locus_GI`)
    REFERENCES `genbank exemplo`.`locus` (`GI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locus_keywords_keywords1`
    FOREIGN KEY (`keywords_keyword_id`)
    REFERENCES `genbank exemplo`.`keywords` (`keyword_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`feat_source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`feat_source` (
  `feat_source_id` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(45) NULL,
  `organism` VARCHAR(45) NULL,
  `db_xref` VARCHAR(45) NULL,
  `chromossome` VARCHAR(45) NULL,
  PRIMARY KEY (`feat_source_id`),
  UNIQUE INDEX `feat_source_id_UNIQUE` (`feat_source_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`feat_cds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`feat_cds` (
  `feat_cds_id` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(45) NULL,
  `codon_start` VARCHAR(45) NULL,
  `product` VARCHAR(45) NULL,
  `protein_db` VARCHAR(45) NULL,
  `translation` MEDIUMTEXT NULL,
  PRIMARY KEY (`feat_cds_id`),
  UNIQUE INDEX `feat_cds_id_UNIQUE` (`feat_cds_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`gene` (
  `gene_id` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(45) NOT NULL,
  `name` VARCHAR(20) NULL,
  PRIMARY KEY (`gene_id`),
  UNIQUE INDEX `gene_id_UNIQUE` (`gene_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`locus_features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`locus_features` (
  `features_id` INT NOT NULL AUTO_INCREMENT,
  `locus_GI` INT NOT NULL,
  `feat_source_feat_source_id` INT NOT NULL,
  `feat_cds_feat_cds_id` INT NOT NULL,
  `gene_gene_id` INT NOT NULL,
  PRIMARY KEY (`features_id`),
  INDEX `fk_features_locus1_idx` (`locus_GI` ASC) VISIBLE,
  INDEX `fk_locus_features_feat_source1_idx` (`feat_source_feat_source_id` ASC) VISIBLE,
  INDEX `fk_locus_features_feat_cds1_idx` (`feat_cds_feat_cds_id` ASC) VISIBLE,
  INDEX `fk_locus_features_gene1_idx` (`gene_gene_id` ASC) VISIBLE,
  UNIQUE INDEX `features_id_UNIQUE` (`features_id` ASC) VISIBLE,
  UNIQUE INDEX `locus_GI_UNIQUE` (`locus_GI` ASC) VISIBLE,
  UNIQUE INDEX `feat_source_feat_source_id_UNIQUE` (`feat_source_feat_source_id` ASC) VISIBLE,
  UNIQUE INDEX `feat_cds_feat_cds_id_UNIQUE` (`feat_cds_feat_cds_id` ASC) VISIBLE,
  UNIQUE INDEX `gene_gene_id_UNIQUE` (`gene_gene_id` ASC) VISIBLE,
  CONSTRAINT `fk_features_locus1`
    FOREIGN KEY (`locus_GI`)
    REFERENCES `genbank exemplo`.`locus` (`GI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locus_features_feat_source1`
    FOREIGN KEY (`feat_source_feat_source_id`)
    REFERENCES `genbank exemplo`.`feat_source` (`feat_source_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locus_features_feat_cds1`
    FOREIGN KEY (`feat_cds_feat_cds_id`)
    REFERENCES `genbank exemplo`.`feat_cds` (`feat_cds_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locus_features_gene1`
    FOREIGN KEY (`gene_gene_id`)
    REFERENCES `genbank exemplo`.`gene` (`gene_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`taxonomy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`taxonomy` (
  `taxonomy_id` INT NOT NULL AUTO_INCREMENT,
  `taxonomy` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`taxonomy_id`),
  UNIQUE INDEX `taxonomy_id_UNIQUE` (`taxonomy_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`source` (
  `source_id` INT NOT NULL AUTO_INCREMENT,
  `scientific_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`source_id`),
  UNIQUE INDEX `source_id_UNIQUE` (`source_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`locus_source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`locus_source` (
  `locus_GI` INT NOT NULL,
  `taxonomy_taxonomy_id` INT NOT NULL,
  `source_source_id` INT NOT NULL,
  INDEX `fk_locus_source_locus1_idx` (`locus_GI` ASC) VISIBLE,
  INDEX `fk_locus_source_taxonomy1_idx` (`taxonomy_taxonomy_id` ASC) VISIBLE,
  INDEX `fk_locus_source_source1_idx` (`source_source_id` ASC) VISIBLE,
  UNIQUE INDEX `locus_GI_UNIQUE` (`locus_GI` ASC) VISIBLE,
  UNIQUE INDEX `taxonomy_taxonomy_id_UNIQUE` (`taxonomy_taxonomy_id` ASC) VISIBLE,
  UNIQUE INDEX `source_source_id_UNIQUE` (`source_source_id` ASC) VISIBLE,
  CONSTRAINT `fk_locus_source_locus1`
    FOREIGN KEY (`locus_GI`)
    REFERENCES `genbank exemplo`.`locus` (`GI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locus_source_taxonomy1`
    FOREIGN KEY (`taxonomy_taxonomy_id`)
    REFERENCES `genbank exemplo`.`taxonomy` (`taxonomy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locus_source_source1`
    FOREIGN KEY (`source_source_id`)
    REFERENCES `genbank exemplo`.`source` (`source_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`reference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`reference` (
  `reference_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NULL,
  `journal` VARCHAR(150) NULL,
  `pubmed` VARCHAR(150) NULL,
  PRIMARY KEY (`reference_id`),
  UNIQUE INDEX `reference_id_UNIQUE` (`reference_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`locus_reference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`locus_reference` (
  `ref_order` INT NOT NULL,
  `locus_GI` INT NOT NULL,
  `reference_reference_id` INT NOT NULL,
  INDEX `fk_locus_reference_locus1_idx` (`locus_GI` ASC) VISIBLE,
  INDEX `fk_locus_reference_reference1_idx` (`reference_reference_id` ASC) VISIBLE,
  UNIQUE INDEX `locus_GI_UNIQUE` (`locus_GI` ASC) VISIBLE,
  UNIQUE INDEX `reference_reference_id_UNIQUE` (`reference_reference_id` ASC) VISIBLE,
  CONSTRAINT `fk_locus_reference_locus1`
    FOREIGN KEY (`locus_GI`)
    REFERENCES `genbank exemplo`.`locus` (`GI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locus_reference_reference1`
    FOREIGN KEY (`reference_reference_id`)
    REFERENCES `genbank exemplo`.`reference` (`reference_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genbank exemplo`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `genbank exemplo`.`authors` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(100) NULL,
  `reference_reference_id` INT NOT NULL,
  PRIMARY KEY (`author_id`),
  INDEX `fk_authors_reference1_idx` (`reference_reference_id` ASC) VISIBLE,
  UNIQUE INDEX `author_id_UNIQUE` (`author_id` ASC) VISIBLE,
  CONSTRAINT `fk_authors_reference1`
    FOREIGN KEY (`reference_reference_id`)
    REFERENCES `genbank exemplo`.`reference` (`reference_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
