-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema database_exam
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema database_exam
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `database_exam` ;
USE `database_exam` ;

-- -----------------------------------------------------
-- Table `database_exam`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `database_exam`.`patient` (
  `idpatient` INT UNSIGNED NOT NULL,
  `patient_name` VARCHAR(100) NULL,
  `patient_gender` ENUM('M', 'F') NULL,
  `patient_age` INT(3) NULL,
  PRIMARY KEY (`idpatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `database_exam`.`syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `database_exam`.`syndrome` (
  `idsyndrome` INT UNSIGNED NOT NULL,
  `syndrome_name` VARCHAR(60) NULL,
  `description` TEXT(200) NULL,
  PRIMARY KEY (`idsyndrome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `database_exam`.`gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `database_exam`.`gene` (
  `idgene` INT UNSIGNED NOT NULL,
  `gene_name` VARCHAR(45) NULL,
  `description` TEXT(200) NULL,
  PRIMARY KEY (`idgene`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `database_exam`.`mutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `database_exam`.`mutation` (
  `idmutation` INT UNSIGNED NOT NULL,
  `start` INT(10) NULL,
  `end` INT(10) NULL,
  `chromosome` VARCHAR(1) NULL,
  `idgene` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idmutation`),
  INDEX `fk_mutation_1_idx` (`idgene` ASC) VISIBLE,
  CONSTRAINT `fk_mutation_1`
    FOREIGN KEY (`idgene`)
    REFERENCES `database_exam`.`gene` (`idgene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `database_exam`.`patient_mutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `database_exam`.`patient_mutation` (
  `idpatient_mutation` INT UNSIGNED NOT NULL,
  `idpatient` INT UNSIGNED NOT NULL,
  `idmutation` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idpatient_mutation`),
  INDEX `fk_patient_mutation_1_idx` (`idpatient` ASC) VISIBLE,
  INDEX `fk_patient_mutation_2_idx` (`idmutation` ASC) VISIBLE,
  CONSTRAINT `fk_patient_mutation_1`
    FOREIGN KEY (`idpatient`)
    REFERENCES `database_exam`.`patient` (`idpatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_mutation_2`
    FOREIGN KEY (`idmutation`)
    REFERENCES `database_exam`.`mutation` (`idmutation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `database_exam`.`mutation_syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `database_exam`.`mutation_syndrome` (
  `idmutation_syndrome` INT UNSIGNED NOT NULL,
  `mutationid` INT UNSIGNED NOT NULL,
  `idsyndrome` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idmutation_syndrome`),
  INDEX `fk_mutation_syndrome_1_idx` (`mutationid` ASC) VISIBLE,
  INDEX `fk_mutation_syndrome_2_idx` (`idsyndrome` ASC) VISIBLE,
  CONSTRAINT `fk_mutation_syndrome_1`
    FOREIGN KEY (`mutationid`)
    REFERENCES `database_exam`.`mutation` (`idmutation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mutation_syndrome_2`
    FOREIGN KEY (`idsyndrome`)
    REFERENCES `database_exam`.`syndrome` (`idsyndrome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
