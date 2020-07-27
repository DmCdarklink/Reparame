-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`rep_tiposervicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rep_tiposervicio` (
  `Indice` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Indice`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`rep_tipousuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rep_tipousuario` (
  `Indice` INT NOT NULL,
  `Descripcion` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`Indice`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`rep_datosusuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rep_datosusuario` (
  `Id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `Rut` CHAR(10) NOT NULL,
  `Nombres` VARCHAR(45) NULL DEFAULT NULL,
  `Apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `Telefono` INT NULL DEFAULT NULL,
  `Direccion` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Region` VARCHAR(80) NULL,
  `Comuna` VARCHAR(80) NULL DEFAULT NULL,
  `Password` VARCHAR(200) NULL DEFAULT NULL,
  `Tipo_Usuario` INT NULL DEFAULT '1',
  `posted` INT NULL DEFAULT NULL,
  `rep_datosusuariocol` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_Usuario`),
  INDEX `TIPO_idx` (`Tipo_Usuario` ASC) VISIBLE,
  CONSTRAINT `TIPO`
    FOREIGN KEY (`Tipo_Usuario`)
    REFERENCES `mydb`.`rep_tipousuario` (`Indice`))
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`rep_datosproveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rep_datosproveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `Id_usuario` INT NULL DEFAULT NULL,
  `Nombre_Negocio` VARCHAR(45) NULL DEFAULT NULL,
  `Telefono_Negocio` INT NULL DEFAULT NULL,
  `Descripcion_Negocio` VARCHAR(200) NULL DEFAULT NULL,
  `Tipo_Servicio` INT NULL DEFAULT NULL,
  `Valoracion` INT NOT NULL DEFAULT '5',
  PRIMARY KEY (`id_proveedor`),
  INDEX `SERVICIO_idx` (`Tipo_Servicio` ASC) VISIBLE,
  INDEX `USUARIO_idx` (`Id_usuario` ASC) VISIBLE,
  CONSTRAINT `SERVICIO`
    FOREIGN KEY (`Tipo_Servicio`)
    REFERENCES `mydb`.`rep_tiposervicio` (`Indice`),
  CONSTRAINT `USUARIO`
    FOREIGN KEY (`Id_usuario`)
    REFERENCES `mydb`.`rep_datosusuario` (`Id_Usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`rep_estadosservicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rep_estadosservicios` (
  `Indice_Estado` INT NOT NULL AUTO_INCREMENT,
  `Descripcion_Estado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Indice_Estado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`rep_solicitudservicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rep_solicitudservicio` (
  `Indice_Solicitud` INT NOT NULL AUTO_INCREMENT,
  `Fecha_Solicitud` DATE NULL DEFAULT NULL,
  `Titulo_Servicio` VARCHAR(45) NOT NULL,
  `Descripcion_Solicitud` VARCHAR(200) NOT NULL,
  `Region_Servicio` VARCHAR(80) NOT NULL,
  `Comuna_Servicio` VARCHAR(80) NOT NULL,
  `Calle_Servicio` VARCHAR(45) NOT NULL,
  `Estado_Solicitud` INT NULL DEFAULT NULL,
  `Cotizacion_Tecnico` VARCHAR(200) NULL DEFAULT NULL,
  `Id_proveedor` INT NULL DEFAULT NULL,
  `Fecha_Solicitud_Servicio` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Id_Usuario` INT NULL DEFAULT NULL,
  `estado` INT NULL DEFAULT NULL,
  `numero_calle` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Indice_Solicitud`),
  INDEX `Estado_idx` (`Estado_Solicitud` ASC) VISIBLE,
  INDEX `Proveedor_idx` (`Id_proveedor` ASC) VISIBLE,
  CONSTRAINT `Estado`
    FOREIGN KEY (`Estado_Solicitud`)
    REFERENCES `mydb`.`rep_estadosservicios` (`Indice_Estado`),
  CONSTRAINT `Proveedor`
    FOREIGN KEY (`Id_proveedor`)
    REFERENCES `mydb`.`rep_datosproveedor` (`id_proveedor`))
ENGINE = InnoDB
AUTO_INCREMENT = 38
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`rep_fichaservicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rep_fichaservicio` (
  `Indice_Ficha` INT NOT NULL AUTO_INCREMENT,
  `Solicitud` INT NULL DEFAULT NULL,
  `Id_proveedor` INT NULL DEFAULT NULL,
  `Fecha_Trabajo` DATE NULL DEFAULT NULL,
  `Observacion_Cliente` VARCHAR(200) NULL DEFAULT NULL,
  `Observacion_Proveedor` VARCHAR(200) NULL DEFAULT NULL,
  `Valoracion_Cliente` INT NULL DEFAULT NULL,
  `Valoracion_Proveedor` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Indice_Ficha`),
  INDEX `Solicitud_idx` (`Solicitud` ASC) VISIBLE,
  INDEX `Proveedor_idx` (`Id_proveedor` ASC) VISIBLE,
  CONSTRAINT `Proveedor_Ficha`
    FOREIGN KEY (`Id_proveedor`)
    REFERENCES `mydb`.`rep_datosproveedor` (`id_proveedor`),
  CONSTRAINT `Solicitud`
    FOREIGN KEY (`Solicitud`)
    REFERENCES `mydb`.`rep_solicitudservicio` (`Indice_Solicitud`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sessions` (
  `session_id` VARCHAR(128) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin' NOT NULL,
  `expires` INT UNSIGNED NOT NULL,
  `data` MEDIUMTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`session_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `rep_tiposervicio` (`Indice`, `Descripcion`) VALUES
(1, 'Gasfiter'),
(2, 'Electricista'),
(3, 'Jardineria'),
(4, 'Carpinteria');

INSERT INTO `rep_tipousuario` (`Indice`, `Descripcion`) VALUES
(1, 'Cliente'),
(2, 'Técnico');

Insert into `rep_estadosservicios` values (1, 'Ingresada'),(2, 'Presupuesto'),(3, 'Rechazada'),(4, 'Finalizada');