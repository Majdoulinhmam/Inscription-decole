-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema myproject
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `myproject` ;

-- -----------------------------------------------------
-- Schema myproject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `myproject` DEFAULT CHARACTER SET utf8 ;
USE `myproject` ;

-- -----------------------------------------------------
-- Table `myproject`.`Etudiant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Etudiant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(50) NOT NULL,
  `Prenom` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Telephone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Email_UNIQUE` ON `myproject`.`Etudiant` (`Email` ASC);

CREATE UNIQUE INDEX `Telephone_UNIQUE` ON `myproject`.`Etudiant` (`Telephone` ASC);


-- -----------------------------------------------------
-- Table `myproject`.`Annee_scolaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Annee_scolaire` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `annee` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myproject`.`Filiere`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Filiere` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `fin_inscription` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myproject`.`Inscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Inscription` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Date_inscription` DATE NOT NULL,
  `nombre_echeance` INT NOT NULL,
  `montant_total` DECIMAL(10,2) NOT NULL,
  `Annee_scolaire_id` INT NOT NULL,
  `Filiere_id` INT NOT NULL,
  `Etudiant_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Inscription_Annee_scolaire1`
    FOREIGN KEY (`Annee_scolaire_id`)
    REFERENCES `myproject`.`Annee_scolaire` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inscription_Filiere1`
    FOREIGN KEY (`Filiere_id`)
    REFERENCES `myproject`.`Filiere` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inscription_Etudiant1`
    FOREIGN KEY (`Etudiant_id`)
    REFERENCES `myproject`.`Etudiant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `myproject`.`Inscription` (`id` ASC);

CREATE INDEX `fk_Inscription_Annee_scolaire1_idx` ON `myproject`.`Inscription` (`Annee_scolaire_id` ASC);

CREATE INDEX `fk_Inscription_Filiere1_idx` ON `myproject`.`Inscription` (`Filiere_id` ASC);

CREATE INDEX `fk_Inscription_Etudiant1_idx` ON `myproject`.`Inscription` (`Etudiant_id` ASC);


-- -----------------------------------------------------
-- Table `myproject`.`Echeances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Echeances` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `montant` DECIMAL(10,2) NOT NULL,
  `date_echeance` DATE NOT NULL,
  `Inscription_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Echeances_Inscription1`
    FOREIGN KEY (`Inscription_id`)
    REFERENCES `myproject`.`Inscription` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Echeances_Inscription1_idx` ON `myproject`.`Echeances` (`Inscription_id` ASC);


-- -----------------------------------------------------
-- Table `myproject`.`Paiement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Paiement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Montant` DECIMAL(10,2) NOT NULL,
  `Date_paiemant` DATE NOT NULL,
  `mode_paiement` VARCHAR(20) NOT NULL,
  `Echeances_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Paiement_Echeances1`
    FOREIGN KEY (`Echeances_id`)
    REFERENCES `myproject`.`Echeances` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `myproject`.`Paiement` (`id` ASC);

CREATE INDEX `fk_Paiement_Echeances1_idx` ON `myproject`.`Paiement` (`Echeances_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
