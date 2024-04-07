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

CREATE TABLE acthor(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
egn VARCHAR(10) NOT NULL,
phone VARCHAR(10) NOT NULL
);

CREATE TABLE flimsAndSerials(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE,
id_acthor INT NOT NULL,
FOREIGN KEY(id_acthor) REFERENCES acthor(id)
);

CREATE TABLE television(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

CREATE TABLE transmission(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
nameTvHost VARCHAR(100) NOT NULL,
description VARCHAR(100),
image VARCHAR(100)
);


CREATE TABLE raitingTransmission(
id INT AUTO_INCREMENT PRIMARY KEY,
score INT NOT NULL,
date DATETIME NOT NULL,
id_transmission INT NOT NULL,
id_user INT NOT NULL,
FOREIGN KEY (id_transmission) REFERENCES transmission(id),
FOREIGN KEY (id_user) REFERENCES user(id)
);


CREATE TABLE rairingFilms(
id INT AUTO_INCREMENT PRIMARY KEY,
score INT NOT NULL,
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

INSERT INTO flimsAndSerials(name,id_acthor)
VALUES('Spider-Man',1),('Fast and Furious',2),('The Bird box',3),('Wrong turn',4);

INSERT INTO television(name)
VALUES('BTV'),('Nova'),('Kino Nova'),('BTV Cinema');

INSERT INTO transmission(name,nameTvHost,description,image)
VALUES('На Кафе','Гала','','data:image/jpeg;base64,/mL7R4q6CpyeIEfCSdR/eY'),
('Времето','Натали Трифонова','информира ни за предстоящата метеорологична обстановка','data:image/jpeg;base64,/nbuwrvSdR/eY');

INSERT INTO raitingTransmission(score,date,id_transmission,id_user)
VALUES(98,'2024-03-02 12:30:00',2,1),(67,'2024-09-18 11:00:00',1,2),(60,'2023-09-08 23:00:00',2,1),(87,'2024-02-03 17:30:00',2,3);

INSERT INTO rairingFilms(score,date,id_flimsAndSerials,id_user)
VALUES(77,'2024-07-23 13:23:45',1,1),(99,'2024-08-08 11:00:00',2,2),(80,'2024-11-12 12:00:00',1,3),(100,'2024-12-27 23:00:00',3,3),(70,'2024-08-25 22:00:00',1,4),(99,'2024-09-19 15:56:00',4,4);

INSERT INTO televisionTransmission(id_television,id_transmission)
VALUES(1,1),(2,1),(2,1),(2,2);

INSERT INTO televisionFilm(id_television,id_flimsAndSerials)
VALUES(3,1),(2,2),(4,1),(4,3);

INSERT INTO televisionUser(id_television,id_user)
VALUES(1,1),(1,2),(2,3),(2,4);




