-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema appmysql_development
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema appmysql_development
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `appmysql_development` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `appmysql_development` ;

-- -----------------------------------------------------
-- Table `appmysql_development`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appmysql_development`.`clients` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `gender` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `email` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `password` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `cpf` VARCHAR(11) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `street` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `number` INT(10) NOT NULL,
  `neighborhood` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `city` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `state` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `zip_code` VARCHAR(8) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `complement` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `appmysql_development`.`payment_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appmysql_development`.`payment_status` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `payment_status` VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `appmysql_development`.`shipping_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appmysql_development`.`shipping_status` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `shipping_status` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `appmysql_development`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appmysql_development`.`orders` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `total_price` DECIMAL(10,2) NOT NULL,
  `payment_method` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `shipping_method` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `date` DATETIME NOT NULL,
  `payment_status` INT(11) NOT NULL,
  `shipping_status` INT(11) NOT NULL,
  `clients_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `payment_status`, `shipping_status`, `clients_id`),
  INDEX `fk_orders_payment_status1_idx` (`payment_status` ASC),
  INDEX `fk_orders_shipping_status1_idx` (`shipping_status` ASC),
  INDEX `fk_orders_clients1_idx` (`clients_id` ASC),
  CONSTRAINT `fk_orders_clients1`
    FOREIGN KEY (`clients_id`)
    REFERENCES `appmysql_development`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_payment_status1`
    FOREIGN KEY (`payment_status`)
    REFERENCES `appmysql_development`.`payment_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_shipping_status1`
    FOREIGN KEY (`shipping_status`)
    REFERENCES `appmysql_development`.`shipping_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 185
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `appmysql_development`.`posters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appmysql_development`.`posters` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `small` TINYINT(1) NOT NULL,
  `medium` TINYINT(1) NOT NULL,
  `large` TINYINT(1) NOT NULL,
  `price_small` DECIMAL(10,2) NOT NULL,
  `price_medium` DECIMAL(10,2) NOT NULL,
  `price_large` DECIMAL(10,2) NOT NULL,
  `category` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `active` TINYINT(1) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `image` LONGBLOB NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 118
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `appmysql_development`.`orders_has_posters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appmysql_development`.`orders_has_posters` (
  `orders_id` INT(11) NOT NULL,
  `orders_clients_id` INT(11) NOT NULL,
  `posters_id` INT(11) NOT NULL,
  `size` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `amount` INT(11) NOT NULL,
  INDEX `fk_orders_has_posters_posters1_idx` (`posters_id` ASC),
  INDEX `fk_orders_has_posters_orders1_idx` (`orders_id` ASC, `orders_clients_id` ASC),
  CONSTRAINT `fk_orders_has_posters_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `appmysql_development`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_posters_posters1`
    FOREIGN KEY (`posters_id`)
    REFERENCES `appmysql_development`.`posters` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `appmysql_development`.`vouchers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appmysql_development`.`vouchers` (
  `id_serial` INT(11) NOT NULL AUTO_INCREMENT,
  `id` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  `clients_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_serial`, `clients_id`),
  INDEX `fk_voucher_clients1_idx` (`clients_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
