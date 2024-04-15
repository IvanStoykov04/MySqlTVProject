DROP DATABASE IF EXISTS tv;
CREATE DATABASE tv;
USE tv;

CREATE TABLE USER(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
egn VARCHAR(10) NOT NULL UNIQUE,
phone VARCHAR(10) NOT NULL UNIQUE,
adress VARCHAR(100)
);

CREATE TABLE leadTV(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
egn VARCHAR(10) NOT NULL
);

CREATE TABLE acthor(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
egn VARCHAR(10) NOT NULL,
phone VARCHAR(10) NOT NULL
);

CREATE TABLE flimsAndSerials(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE actorInFilms(
id INT AUTO_INCREMENT PRIMARY KEY,
id_actor INT NOT NULL,
id_filmsAndSerials INT NOT NULL,
FOREIGN KEY(id_actor) REFERENCES acthor(id),
FOREIGN KEY(id_filmsAndSerials) REFERENCES flimsAndSerials(id)
);

CREATE TABLE television(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

CREATE TABLE transmission(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description VARCHAR(100),
image VARCHAR(100)
);


CREATE TABLE leadTransmision(
id INT AUTO_INCREMENT PRIMARY KEY,
id_leadTV INT NOT NULL,
id_transmision INT NOT NULL,
FOREIGN KEY (id_leadTV) REFERENCES leadTV(id),
FOREIGN KEY (id_transmision) REFERENCES transmission(id)
);

CREATE TABLE raitingTransmission(
id INT AUTO_INCREMENT PRIMARY KEY,
score INT,
date DATETIME NOT NULL,
id_transmission INT NOT NULL,
id_user INT NOT NULL,
FOREIGN KEY (id_transmission) REFERENCES transmission(id),
FOREIGN KEY (id_user) REFERENCES user(id)
);


CREATE TABLE rairingFilms(
id INT AUTO_INCREMENT PRIMARY KEY,
score INT,
date DATETIME NOT NULL,
id_flimsAndSerials INT NOT NULL,
id_user INT NOT NULL,
FOREIGN KEY (id_flimsAndSerials) REFERENCES flimsAndSerials(id),
FOREIGN KEY (id_user) REFERENCES user(id)
);

CREATE TABLE televisionTransmission(
id INT AUTO_INCREMENT PRIMARY KEY,
id_television INT NOT NULL,
id_transmission INT NOT NULL,
FOREIGN KEY(id_television) REFERENCES television(id),
FOREIGN KEY(id_transmission) REFERENCES transmission(id)
);


CREATE TABLE televisionFilm(
id INT AUTO_INCREMENT PRIMARY KEY,
id_television INT NOT NULL,
id_flimsAndSerials INT NOT NULL,
FOREIGN KEY (id_television) REFERENCES television(id),
FOREIGN KEY (id_flimsAndSerials) REFERENCES flimsAndSerials(id)
);


CREATE TABLE televisionUser(
id INT AUTO_INCREMENT PRIMARY KEY,
id_television INT NOT NULL,
id_user INT NOT NULL,
FOREIGN KEY (id_television) REFERENCES television(id),
FOREIGN KEY (id_user) REFERENCES user(id)
);



INSERT INTO user(name,egn,phone,adress)
VALUES ('Иван Стойков','0441076754','0895642143','София Младост'),
('Николай Любомиров','0213456345','0877448765','Перник'),
('Ани Младенова','9876542945','0877236514','София Дружба'),
('Емилия Владиславова','9923746582','0895876534','Варна'),
('Сашо Петров','0132746536','0895680023','Елин Пелин');

INSERT INTO acthor(name,egn,phone)
VALUES('Том Холанд','8765346538','0895663423'),('Вин Дизел','9988773354','0987653452'),('Треванте Родс','7765348765','0989675434'),('Шарлот Вега','8998899876','0877449930');

INSERT INTO flimsAndSerials(name)
VALUES('Spider-Man'),('Fast and Furious'),('The Bird box'),('Wrong turn');

INSERT INTO actorInFilms(id_actor,id_filmsAndSerials)
VALUES(1,1),(2,2),(3,1);

INSERT INTO television(name)
VALUES('BTV'),('Nova'),('Kino Nova'),('BTV Cinema');

INSERT INTO leadTV(name,egn)
VALUES('Гала','8878657435'),('Натали Трифонова','8909876534');

INSERT INTO transmission(name,description,image)
VALUES('На Кафе','','data:image/jpeg;base64,/mL7R4q6CpyeIEfCSdR/eY'),
('Времето','информира ни за предстоящата метеорологична обстановка','data:image/jpeg;base64,/nbuwrvSdR/eY');

INSERT INTO leadTransmision(id_leadTV,id_transmision)
VALUES(1,1),(2,2);

INSERT INTO raitingTransmission(score,date,id_transmission,id_user)
VALUES(98,'2024-03-02 12:30:00',2,1),(67,'2024-09-18 11:00:00',1,2),(60,'2023-09-08 23:00:00',2,1),(87,'2024-02-03 17:30:00',2,3);


INSERT INTO rairingFilms(score,date,id_flimsAndSerials,id_user)
VALUES(77,'2024-07-23 13:23:45',1,1),(99,'2024-08-08 11:00:00',2,2),(80,'2024-11-12 12:00:00',1,3),(100,'2024-12-27 23:00:00',3,3),(70,'2024-08-25 22:00:00',1,4),(99,'2024-09-19 15:56:00',4,4),(NULL,'2024-07-23 13:56:00',1,4);

INSERT INTO televisionTransmission(id_television,id_transmission)
VALUES(1,1),(2,1),(2,1),(2,2);

INSERT INTO televisionFilm(id_television,id_flimsAndSerials)
VALUES(3,1),(2,2),(4,1),(4,3);

INSERT INTO televisionUser(id_television,id_user)
VALUES(1,1),(1,2),(2,3),(2,4);


-- requests
-- request 1
-- Извеждаме всички потребители с адрес варна
SELECT * FROM user
WHERE adress='Варна';


-- request 2
-- извеждаме средния резултат от оценките на потребителите на даден филм
SELECT AVG(score) FROM rairingFilms
GROUP BY id
HAVING id=1;

-- request 3
-- извеждаме actors  филмите в които участват
SELECT acthor.name AS acthorName, flimsAndSerials.name AS filmsName
FROM acthor JOIN actorInFilms
ON acthor.id=actorInFilms.id_actor
JOIN flimsAndSerials
ON actorInFilms.id_filmsAndSerials=flimsAndSerials.id;


-- request4
-- ИЗВЕЖДАМЕ ИМЕНАТА НА ФИЛМИТЕ ДОРИ И ДА НЯМАТ РЕЗУЛТАТИ
SELECT flimsAndSerials.name,rairingFilms.score
FROM flimsAndSerials JOIN rairingFilms
ON flimsAndSerials.id=rairingFilms.id_flimsAndSerials;


-- REQUEST 5
-- ИЗВЕЖДАМЕ ИМЕТО НА USER-А И ИМЕТО НА ПРЕДАВАНЕТО КОЕТО Е РЕЙТНАЛ
SELECT user.name AS userName, transmission.name AS transmissionName
FROM user JOIN transmission
ON user.id IN(
SELECT raitingTransmission.id_user FROM raitingTransmission
WHERE raitingTransmission.id_transmission=transmission.id);

-- REQUEST 6
-- извеждаме името на потребителя и общия брой на предаванията , които е рейтнал
SELECT user.name, COUNT(raitingTransmission.id_user)
FROM user JOIN raitingTransmission
ON user.id=raitingTransmission.id_user
GROUP BY raitingTransmission.id_user;


-- request 7(triger)
-- създаваме 
DROP TABLE IF EXISTS transmission_log;
CREATE TABLE transmission_log(
id INT AUTO_INCREMENT PRIMARY KEY,
operation ENUM('INSERT','UPDATE','DELETE') NOT NULL,
old_name VARCHAR(100),
nаw_name VARCHAR(100),
old_description VARCHAR(100),
new_description VARCHAR(100),
old_image VARCHAR(100),
new_image VARCHAR(100),
dateOfLog DATETIME
)ENGINE = Innodb;

-- CREATE TRIGER
delimiter |
CREATE TRIGGER after_transmission_update AFTER UPDATE ON transmission
FOR EACH ROW
BEGIN
INSERT INTO transmission_log(operation,
old_name,
naw_name,
old_description,
new_description,
old_image,
new_image,
dateOfLog)
VALUES ('UPDATE',OLD.name,NEW.name,OLD.description,NEW.description,
OLD.image,NEW.image,NOW());
END;
|
Delimiter ;


UPDATE transmission
SET description='На кафе'
WHERE id =1;


-- REQUEST 8
-- курсор










