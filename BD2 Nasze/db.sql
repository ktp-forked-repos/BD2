SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`artist` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`artist` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `country` VARCHAR(30) NULL ,
  `biography` TINYTEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `name_INDEX` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`album` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(60) NOT NULL ,
  `year` DATE NOT NULL ,
  `info` TINYTEXT NULL ,
  `artist_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `title_INDEX` (`title` ASC) ,
  INDEX `fk_album_artist1` (`artist_id` ASC) ,
  CONSTRAINT `fk_album_artist1`
    FOREIGN KEY (`artist_id` )
    REFERENCES `mydb`.`artist` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(35) NOT NULL ,
  `parentId` INT ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_category_category1` (`parentId` ASC) ,
  CONSTRAINT `fk_category_category1`
    FOREIGN KEY (`parentId` )
    REFERENCES `mydb`.`category` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`song` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`song` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(45) NOT NULL ,
  `price` DECIMAL(5,2) NOT NULL DEFAULT 0.00 ,
  `album_id` INT NOT NULL ,
  `category_id` INT NOT NULL ,
  `artist_id` INT NOT NULL ,
  `counter` INT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`, `artist_id`) ,
  INDEX `fk_song_album` (`album_id` ASC) ,
  INDEX `fk_song_category1` (`category_id` ASC) ,
  INDEX `fk_song_artist1` (`artist_id` ASC) ,
  INDEX `title_INDEX` (`title` ASC) ,
  CONSTRAINT `fk_song_album`
    FOREIGN KEY (`album_id` )
    REFERENCES `mydb`.`album` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_song_category1`
    FOREIGN KEY (`category_id` )
    REFERENCES `mydb`.`category` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_song_artist1`
    FOREIGN KEY (`artist_id` )
    REFERENCES `mydb`.`artist` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`comments` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `author` VARCHAR(20) NOT NULL DEFAULT 'Anonymous' ,
  `date` DATETIME NOT NULL ,
  `text` TINYTEXT NOT NULL ,
  `rate` INT NOT NULL DEFAULT 3 ,
  `song_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_comments_song1` (`song_id` ASC) ,
  CONSTRAINT `fk_comments_song1`
    FOREIGN KEY (`song_id` )
    REFERENCES `mydb`.`song` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`user` (
  `login` VARCHAR(20) NOT NULL ,
  `password` VARCHAR(32) NOT NULL ,
  `email` VARCHAR(30) NOT NULL ,
  `firstname` VARCHAR(30) NOT NULL ,
  `lastname` VARCHAR(45) NOT NULL ,
  `address1` VARCHAR(45) NOT NULL ,
  `address2` VARCHAR(30) NULL ,
  `phone` INT NOT NULL ,
  `state` VARCHAR(20) NOT NULL ,
  `city` VARCHAR(30) NOT NULL ,
  `postalCode` VARCHAR(6) NOT NULL ,
  `regDate` DATETIME NOT NULL ,
  `lastLogin` DATETIME NOT NULL ,
  `lvl` INT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`login`) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `password_INDEX` (`password` ASC) ,
  INDEX `lvl_INDEX` (`lvl` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`favList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`favList` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`favList` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(45) NOT NULL ,
  `user_login` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`, `user_login`) ,
  INDEX `fk_favList_user1` (`user_login` ASC) ,
  CONSTRAINT `fk_favList_user1`
    FOREIGN KEY (`user_login` )
    REFERENCES `mydb`.`user` (`login` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shoppingCart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`shoppingCart` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`shoppingCart` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_login` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`, `user_login`) ,
  INDEX `fk_shoppingCart_user1` (`user_login` ASC) ,
  CONSTRAINT `fk_shoppingCart_user1`
    FOREIGN KEY (`user_login` )
    REFERENCES `mydb`.`user` (`login` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`order` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` DATETIME NOT NULL ,
  `status` INT NOT NULL DEFAULT 0 ,
  `notes` TINYTEXT NULL ,
  `shippingFirstname` VARCHAR(20) NOT NULL ,
  `shippingLastname` VARCHAR(45) NOT NULL ,
  `shippingAddress1` VARCHAR(45) NOT NULL ,
  `shippingAddress2` VARCHAR(30) NULL ,
  `shippingEmail` VARCHAR(30) NOT NULL ,
  `shippingPhone` INT NOT NULL ,
  `shippingstate` VARCHAR(20) NOT NULL ,
  `shippingCity` VARCHAR(30) NOT NULL ,
  `shippingPostalCode` VARCHAR(6) NOT NULL ,
  `paymentFirstname` VARCHAR(20) NOT NULL ,
  `paymentLastname` VARCHAR(45) NOT NULL ,
  `paymentAddress1` VARCHAR(45) NOT NULL ,
  `paymentAddress2` VARCHAR(30) NULL ,
  `paymentEmail` VARCHAR(30) NOT NULL ,
  `paymentPhone` INT NOT NULL ,
  `paymentState` VARCHAR(20) NOT NULL ,
  `paymentCity` VARCHAR(30) NOT NULL ,
  `paymentPostalCode` VARCHAR(6) NOT NULL ,
  `price` DECIMAL(10,2) NOT NULL DEFAULT 0.00 ,
  `user_login` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`, `user_login`) ,
  INDEX `fk_order_user1` (`user_login` ASC) ,
  CONSTRAINT `fk_order_user1`
    FOREIGN KEY (`user_login` )
    REFERENCES `mydb`.`user` (`login` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`song_has_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`song_has_order` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`song_has_order` (
  `song_id` INT NOT NULL ,
  `order_id` INT NOT NULL ,
  INDEX `fk_song_has_order_order1` (`order_id` ASC) ,
  INDEX `fk_song_has_order_song1` (`song_id` ASC) ,
  CONSTRAINT `fk_song_has_order_song1`
    FOREIGN KEY (`song_id` )
    REFERENCES `mydb`.`song` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_song_has_order_order1`
    FOREIGN KEY (`order_id` )
    REFERENCES `mydb`.`order` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`song_has_favList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`song_has_favList` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`song_has_favList` (
  `song_id` INT NOT NULL ,
  `favList_id` INT NOT NULL ,
  INDEX `fk_song_has_favList_favList1` (`favList_id` ASC) ,
  INDEX `fk_song_has_favList_song1` (`song_id` ASC) ,
  CONSTRAINT `fk_song_has_favList_song1`
    FOREIGN KEY (`song_id` )
    REFERENCES `mydb`.`song` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_song_has_favList_favList1`
    FOREIGN KEY (`favList_id` )
    REFERENCES `mydb`.`favList` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`song_has_shoppingCart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`song_has_shoppingCart` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`song_has_shoppingCart` (
  `song_id` INT NOT NULL ,
  `shoppingCart_id` INT NOT NULL ,
  INDEX `fk_song_has_shoppingCart_shoppingCart1` (`shoppingCart_id` ASC) ,
  INDEX `fk_song_has_shoppingCart_song1` (`song_id` ASC) ,
  CONSTRAINT `fk_song_has_shoppingCart_song1`
    FOREIGN KEY (`song_id` )
    REFERENCES `mydb`.`song` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_song_has_shoppingCart_shoppingCart1`
    FOREIGN KEY (`shoppingCart_id` )
    REFERENCES `mydb`.`shoppingCart` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Przyk³adowe inserty do tabel
-- -----------------------------------------------------
INSERT INTO `mydb`.`artist` (
`id` ,
`name` ,
`country` ,
`biography`
)
VALUES (
'1', 'Samora', 'Poland', 'Folk Rock Polska'
), (
'2', 'Olle', 'Russia', 'Team Allama'
);

INSERT INTO `album` (`id`, `title`, `year`, `info`, `artist_id`) VALUES
(1, 'Samora', '2003-02-04', 'Not album of tabbaco', 1),
(2, 'Saturday Night Wrist', '2009-06-04', 'My album from the clouds!', 1),
(3, 'Some tracks', '2001-01-08', NULL, 2);

INSERT INTO `mydb`.`song` (
`id` ,
`title` ,
`price` ,
`album_id` ,
`category_id` ,
`artist_id` ,
`counter`
)
VALUES (
'1', 'Hole in the Sy', '8.00', '2', '1', '1', '0'
), (
'2', 'Rapturentia', '1.00', '2', '1', '1', '0'
), (
'3', 'Beware of me', '2.00', '2', '1', '1', '0'
), (
'4', 'Her Waves', '3.33', '2', '1', '1', '0'
), (
'5', 'Du bist mein', '1.50', '2', '1', '1', '0'
)

INSERT INTO `mydb`.`song` (
`id` ,
`title` ,
`price` ,
`album_id` ,
`category_id` ,
`artist_id` ,
`counter`
)
VALUES (
NULL , 'Elka', '1.00', '1', '1', '1', '0'
), (
NULL , 'Needles are Pins', '2.00', '1', '1', '1', '0'
), (
NULL , 'Minetaa', '2.00', '1', '1', '1', '0'
), (
NULL , 'Hell is today so beautiful', '1.00', '1', '1', '1', '0'
);

--	Procedury
--	Usuwanie komentarzy do zadanego cd
Create Procedure delComm(IN songId INT)
	DELETE FROM `mydb`.`comments` WHERE song_id = songId;
--	Zwracanie cd z najwiêksz¹ ocen¹
Create Procedure retTop()
	Select song_id from `mydb`.`comments` Group By song_id Order By rate Limit 1;
--	Zwrócenie 10 najczêœciej kupowanych cd:
Create Procedure retHot()
	Select * From `mydb`.`song` Order By counter, id Desc Limit 10;
--	Zwrócenie kategorii z ich dzieæmi (2 procedury)
CREATE PROCEDURE get_childs_sub (IN nid INT)
BEGIN
  DECLARE n INT;
  DECLARE done INT DEFAULT 0;
  DECLARE cur CURSOR FOR SELECT id FROM category WHERE parentId = nid;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  
OPEN cur;
get_childs_fetch_loop: LOOP
    FETCH cur INTO n;

    IF done = 1 THEN
      LEAVE get_childs_fetch_loop;
    END IF;
    INSERT INTO __childs VALUES ( n );

    CALL get_childs_sub(n);

  END LOOP get_childs_fetch_loop;
  CLOSE cur;
END;

CREATE PROCEDURE get_childs (IN nid INT)
BEGIN
  DECLARE n INT;

  DROP TEMPORARY TABLE IF EXISTS __childs;
  CREATE TEMPORARY TABLE __childs (
    node_id INT NOT NULL PRIMARY KEY
  );
  SELECT COUNT(*)
    FROM category
   WHERE parentId = nid INTO n;
  IF n <> 0 THEN
    CALL get_childs_sub(nid);
  END IF;
  SELECT t1.*
    FROM category AS t1
      JOIN __childs on node_id = id;
END;

--	Trigger
--	Licznik pobrañ dla kazdego cd
Create Trigger raiseCount Before Insert On `mydb`.`song_has_order`
For Each Row
	UPDATE `mydb`.`song` SET counter = counter+1 WHERE id = NEW.song_id;
--	Rabat przy zakupie powy¿ej 10 cd
CREATE TRIGGER addDiscount 
  BEFORE AFTER ON `mydb`.`order`
  FOR EACH ROW
BEGIN
  DECLARE i INTEGER;
  SELECT COUNT(*) INTO i FROM `mydb`.`song_has_order` WHERE order_id = NEW.id;
  IF i > 9 THEN
    UPDATE `mydb`.`order` SET price = CEIL(price*9/10) WHERE id = NEW.id;
  END IF;
END;
