-- MySQL Script generated by MySQL Workbench
-- Mon Mar 25 09:41:15 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
-- -----------------------------------------------------
-- Schema inTouch
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inTouch` DEFAULT CHARACTER SET utf8 ;
USE `inTouch` ;

-- -----------------------------------------------------
-- Table `inTouch`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inTouch`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(20) NOT NULL,
  `name` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NULL,
  `birthdate` DATE NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nick_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `Id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`email` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `inTouch`.`PendingFriendship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inTouch`.`PendingFriendship` (
  `id` INT NOT NULL,
  `sender` INT NOT NULL,
  `receiver` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Friendship_User_idx` (`sender` ASC) VISIBLE,
  INDEX `fk_Friendship_User1_idx` (`receiver` ASC) VISIBLE,
  CONSTRAINT `fk_Friendship_User`
    FOREIGN KEY (`sender`)
    REFERENCES `inTouch`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Friendship_User1`
    FOREIGN KEY (`receiver`)
    REFERENCES `inTouch`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `inTouch`.`Group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inTouch`.`Group` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `creationDate` DATE NOT NULL,
  `description` VARCHAR(45) NULL,
  `type` INT NULL,
  PRIMARY KEY (`id`))
;


-- -----------------------------------------------------
-- Table `inTouch`.`Post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inTouch`.`Post` (
  `id` INT NOT NULL,
  `body` VARCHAR(500) NULL,
  `publishedDate` DATE NOT NULL,
  `group` INT NULL,
  `author` INT NOT NULL,
  `private` TINYINT(1) NOT NULL DEFAULT 1,
  `attachment` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Post_Group1_idx` (`group` ASC) VISIBLE,
  INDEX `fk_Post_User1_idx` (`author` ASC) VISIBLE,
  CONSTRAINT `fk_Post_Group1`
    FOREIGN KEY (`group`)
    REFERENCES `inTouch`.`Group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_User1`
    FOREIGN KEY (`author`)
    REFERENCES `inTouch`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `inTouch`.`Membership`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inTouch`.`Membership` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `admin` TINYINT(1) NOT NULL DEFAULT 0,
  `group` INT NOT NULL,
  `member` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Membership_Group1_idx` (`group` ASC) VISIBLE,
  INDEX `fk_Membership_User1_idx` (`member` ASC) VISIBLE,
  CONSTRAINT `fk_Membership_Group1`
    FOREIGN KEY (`group`)
    REFERENCES `inTouch`.`Group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Membership_User1`
    FOREIGN KEY (`member`)
    REFERENCES `inTouch`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `inTouch`.`Friendship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inTouch`.`Friendship` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `friend1` INT NOT NULL,
  `friend2` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Friendship_User1_idx` (`friend1` ASC) VISIBLE,
  INDEX `fk_Friendship_User2_idx` (`friend2` ASC) VISIBLE,
  CONSTRAINT `fk_Friendship_User1`
    FOREIGN KEY (`friend1`)
    REFERENCES `inTouch`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Friendship_User2`
    FOREIGN KEY (`friend2`)
    REFERENCES `inTouch`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `inTouch`.`PendingMembership`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inTouch`.`PendingMembership` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `invitation` TINYINT(1) NOT NULL,
  `user` INT NOT NULL,
  `group` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_PendingMembership_User1_idx` (`user` ASC) VISIBLE,
  INDEX `fk_PendingMembership_Group1_idx` (`group` ASC) VISIBLE,
  CONSTRAINT `fk_PendingMembership_User1`
    FOREIGN KEY (`user`)
    REFERENCES `inTouch`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PendingMembership_Group1`
    FOREIGN KEY (`group`)
    REFERENCES `inTouch`.`Group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;
