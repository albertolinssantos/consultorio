-- MySQL Script generated by MySQL Workbench
-- 05/26/16 15:00:42
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema banco_consultorio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema banco_consultorio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `banco_consultorio` DEFAULT CHARACTER SET utf8 ;
USE `banco_consultorio` ;

-- -----------------------------------------------------
-- Table `banco_consultorio`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`funcionario` (
  `func_id` INT NOT NULL AUTO_INCREMENT,
  `func_nome` VARCHAR(45) NULL,
  `func_dt_nasc` DATE NULL,
  `func_salario` DOUBLE NULL,
  `func_genero` CHAR(2) NULL,
  `func_estado_civil` VARCHAR(45) NULL,
  `func_profissao` VARCHAR(45) NULL,
  `func_endereco` VARCHAR(45) NULL,
  `func_tel_fixo` VARCHAR(15) NULL,
  `func_tel_cel` VARCHAR(15) NULL,
  `func_dt_admissao` DATE NULL,
  `func_imagem` VARCHAR(100) NULL,
  PRIMARY KEY (`func_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco_consultorio`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`paciente` (
  `pac_idpaciente` INT NOT NULL AUTO_INCREMENT,
  `pac_nome` VARCHAR(45) NULL,
  `pac_dt_nasc` DATE NULL,
  `pac_genero` CHAR(2) NULL,
  `pac_estado_civil` VARCHAR(45) NULL,
  `pac_profissao` VARCHAR(45) NULL,
  `pac_endereco` VARCHAR(45) NULL,
  `pac_tel_fixo` VARCHAR(15) NULL,
  `pac_tel_cel` VARCHAR(15) NULL,
  `pac_dt_cadastro` DATE NULL,
  `pac_foto` VARCHAR(45) NULL,
  `funcionario_func_id` INT NOT NULL,
  PRIMARY KEY (`pac_idpaciente`, `funcionario_func_id`),
  INDEX `fk_paciente_funcionario1_idx` (`funcionario_func_id` ASC),
  CONSTRAINT `fk_paciente_funcionario1`
    FOREIGN KEY (`funcionario_func_id`)
    REFERENCES `banco_consultorio`.`funcionario` (`func_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco_consultorio`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`fornecedor` (
  `for_id` INT NOT NULL AUTO_INCREMENT,
  `for_nome` VARCHAR(45) NULL,
  `for_endereco` VARCHAR(45) NULL,
  `for_tel_fixo` VARCHAR(15) NULL,
  `for_tel_cel` VARCHAR(15) NULL,
  `funcionario_func_id` INT NOT NULL,
  PRIMARY KEY (`for_id`, `funcionario_func_id`),
  INDEX `fk_fornecedor_funcionario1_idx` (`funcionario_func_id` ASC),
  CONSTRAINT `fk_fornecedor_funcionario1`
    FOREIGN KEY (`funcionario_func_id`)
    REFERENCES `banco_consultorio`.`funcionario` (`func_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco_consultorio`.`material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`material` (
  `mat_id` INT NOT NULL AUTO_INCREMENT,
  `mat_descricao` VARCHAR(45) NULL,
  `mat_qtde` INT NULL,
  `mat_dt_validade` DATE NULL,
  `mat_valor` DOUBLE NULL,
  `fornecedor_for_id` INT NOT NULL,
  `funcionario_func_id` INT NOT NULL,
  PRIMARY KEY (`mat_id`),
  INDEX `fk_material_fornecedor1_idx` (`fornecedor_for_id` ASC),
  INDEX `fk_material_funcionario1_idx` (`funcionario_func_id` ASC),
  CONSTRAINT `fk_material_fornecedor1`
    FOREIGN KEY (`fornecedor_for_id`)
    REFERENCES `banco_consultorio`.`fornecedor` (`for_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_material_funcionario1`
    FOREIGN KEY (`funcionario_func_id`)
    REFERENCES `banco_consultorio`.`funcionario` (`func_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco_consultorio`.`fornece`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`fornece` (
  `fornecedor_for_id` INT NOT NULL,
  `material_mat_id` INT NOT NULL,
  PRIMARY KEY (`fornecedor_for_id`, `material_mat_id`),
  INDEX `fk_fornecedor_has_material_material1_idx` (`material_mat_id` ASC),
  INDEX `fk_fornecedor_has_material_fornecedor_idx` (`fornecedor_for_id` ASC),
  CONSTRAINT `fk_fornecedor_has_material_fornecedor`
    FOREIGN KEY (`fornecedor_for_id`)
    REFERENCES `banco_consultorio`.`fornecedor` (`for_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fornecedor_has_material_material1`
    FOREIGN KEY (`material_mat_id`)
    REFERENCES `banco_consultorio`.`material` (`mat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco_consultorio`.`agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`agenda` (
  `age_id` INT NOT NULL AUTO_INCREMENT,
  `age_nome` VARCHAR(45) NULL,
  `age_telefone` VARCHAR(15) NULL,
  `age_dia` DATE NULL,
  `age_hora` TIME(6) NULL,
  `age_motivo` VARCHAR(45) NULL,
  PRIMARY KEY (`age_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco_consultorio`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`servico` (
  `ser_id` INT NOT NULL AUTO_INCREMENT,
  `ser_descricao` VARCHAR(45) NULL,
  `ser_valor` DOUBLE NULL,
  PRIMARY KEY (`ser_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco_consultorio`.`dente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`dente` (
  `den_id` INT NOT NULL,
  `den_nome` VARCHAR(45) NULL,
  PRIMARY KEY (`den_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco_consultorio`.`orcamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`orcamento` (
  `orc_id` INT NOT NULL AUTO_INCREMENT,
  `orc_data` DATE NULL,
  `paciente_pac_idpaciente` INT NOT NULL,
  PRIMARY KEY (`orc_id`, `paciente_pac_idpaciente`),
  INDEX `fk_orcamento_paciente1_idx` (`paciente_pac_idpaciente` ASC),
  CONSTRAINT `fk_orcamento_paciente1`
    FOREIGN KEY (`paciente_pac_idpaciente`)
    REFERENCES `banco_consultorio`.`paciente` (`pac_idpaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco_consultorio`.`lista_orcamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`lista_orcamento` (
  `list_id` INT NOT NULL AUTO_INCREMENT,
  `dente_den_id` INT NOT NULL,
  `servico_ser_id` INT NOT NULL,
  `orcamento_orc_id` INT NOT NULL,
  PRIMARY KEY (`list_id`, `dente_den_id`, `servico_ser_id`, `orcamento_orc_id`),
  INDEX `fk_lista_orcamento_dente1_idx` (`dente_den_id` ASC),
  INDEX `fk_lista_orcamento_servico1_idx` (`servico_ser_id` ASC),
  INDEX `fk_lista_orcamento_orcamento1_idx` (`orcamento_orc_id` ASC),
  CONSTRAINT `fk_lista_orcamento_dente1`
    FOREIGN KEY (`dente_den_id`)
    REFERENCES `banco_consultorio`.`dente` (`den_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lista_orcamento_servico1`
    FOREIGN KEY (`servico_ser_id`)
    REFERENCES `banco_consultorio`.`servico` (`ser_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lista_orcamento_orcamento1`
    FOREIGN KEY (`orcamento_orc_id`)
    REFERENCES `banco_consultorio`.`orcamento` (`orc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banco_consultorio`.`tratamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco_consultorio`.`tratamento` (
  `funcionario_func_id` INT NOT NULL,
  `lista_orcamento_list_id` INT NOT NULL,
  `lista_orcamento_dente_den_id` INT NOT NULL,
  `lista_orcamento_servico_ser_id` INT NOT NULL,
  `lista_orcamento_orcamento_orc_id` INT NOT NULL,
  `material_mat_id` INT NOT NULL,
  `tra_data` DATE NULL,
  `tra_hora` TIME(6) NULL,
  PRIMARY KEY (`funcionario_func_id`, `lista_orcamento_list_id`, `lista_orcamento_dente_den_id`, `lista_orcamento_servico_ser_id`, `lista_orcamento_orcamento_orc_id`, `material_mat_id`),
  INDEX `fk_funcionario_has_lista_orcamento_lista_orcamento1_idx` (`lista_orcamento_list_id` ASC, `lista_orcamento_dente_den_id` ASC, `lista_orcamento_servico_ser_id` ASC, `lista_orcamento_orcamento_orc_id` ASC),
  INDEX `fk_funcionario_has_lista_orcamento_funcionario1_idx` (`funcionario_func_id` ASC),
  INDEX `fk_tratamento_material1_idx` (`material_mat_id` ASC),
  CONSTRAINT `fk_funcionario_has_lista_orcamento_funcionario1`
    FOREIGN KEY (`funcionario_func_id`)
    REFERENCES `banco_consultorio`.`funcionario` (`func_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_has_lista_orcamento_lista_orcamento1`
    FOREIGN KEY (`lista_orcamento_list_id` , `lista_orcamento_dente_den_id` , `lista_orcamento_servico_ser_id` , `lista_orcamento_orcamento_orc_id`)
    REFERENCES `banco_consultorio`.`lista_orcamento` (`list_id` , `dente_den_id` , `servico_ser_id` , `orcamento_orc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tratamento_material1`
    FOREIGN KEY (`material_mat_id`)
    REFERENCES `banco_consultorio`.`material` (`mat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
