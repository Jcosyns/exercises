-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema exercise4_model
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema exercise4_model
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `exercise4_model` ;
USE `exercise4_model` ;

-- -----------------------------------------------------
-- Table `exercise4_model`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4_model`.`Medical` (
  `idMedical` INT NOT NULL,
  `Overtime_rate` INT NULL,
  PRIMARY KEY (`idMedical`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4_model`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4_model`.`Specialist` (
  `idSpecialist` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`idSpecialist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4_model`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4_model`.`Bill` (
  `idBill` INT NOT NULL,
  `Total` DECIMAL(2) NULL,
  `idPayment` INT NOT NULL,
  PRIMARY KEY (`idBill`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4_model`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4_model`.`Doctor` (
  `idDoctor` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Salary` DECIMAL(2) NULL,
  `idSpecialist` INT NULL,
  `idMedical` INT NULL,
  `idBill` INT NULL,
  PRIMARY KEY (`idDoctor`),
  INDEX `fk_Doctor_Medical_idx` (`idMedical` ASC) VISIBLE,
  INDEX `fk_Doctor_Specialist1_idx` (`idSpecialist` ASC) VISIBLE,
  INDEX `fk_Doctor_Bill1_idx` (`idBill` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Medical`
    FOREIGN KEY (`idMedical`)
    REFERENCES `exercise4_model`.`Medical` (`idMedical`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_Specialist1`
    FOREIGN KEY (`idSpecialist`)
    REFERENCES `exercise4_model`.`Specialist` (`idSpecialist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_Bill1`
    FOREIGN KEY (`idBill`)
    REFERENCES `exercise4_model`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4_model`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4_model`.`Payment` (
  `idPayment` INT NOT NULL,
  `Details` VARCHAR(45) NULL,
  `Method` VARCHAR(45) NULL,
  PRIMARY KEY (`idPayment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4_model`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4_model`.`Patient` (
  `idPatient` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Date_of_birth` DATE NULL,
  `idPayment` INT NULL,
  PRIMARY KEY (`idPatient`),
  INDEX `fk_Patient_Payment1_idx` (`idPayment` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_Payment1`
    FOREIGN KEY (`idPayment`)
    REFERENCES `exercise4_model`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4_model`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4_model`.`Appointment` (
  `idAppointment` INT NOT NULL,
  `Date` DATE NULL,
  `Time` DATETIME NULL,
  `idDoctor` INT NULL,
  `idPatient` VARCHAR(45) NULL,
  PRIMARY KEY (`idAppointment`),
  INDEX `fk_Appointment_Doctor1_idx` (`idDoctor` ASC) VISIBLE,
  INDEX `fk_Appointment_Patient1_idx` (`idPatient` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Doctor1`
    FOREIGN KEY (`idDoctor`)
    REFERENCES `exercise4_model`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`idPatient`)
    REFERENCES `exercise4_model`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4_model`.`Bill_has_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4_model`.`Bill_has_Payment` (
  `Bill_idBill` INT NULL,
  `Payment_idPayment` INT NULL,
  `Bill_has_Paymentid` INT NOT NULL,
  INDEX `fk_Bill_has_Payment_Payment1_idx` (`Payment_idPayment` ASC) VISIBLE,
  INDEX `fk_Bill_has_Payment_Bill1_idx` (`Bill_idBill` ASC) VISIBLE,
  PRIMARY KEY (`Bill_has_Paymentid`),
  CONSTRAINT `fk_Bill_has_Payment_Bill1`
    FOREIGN KEY (`Bill_idBill`)
    REFERENCES `exercise4_model`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_Payment_Payment1`
    FOREIGN KEY (`Payment_idPayment`)
    REFERENCES `exercise4_model`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
