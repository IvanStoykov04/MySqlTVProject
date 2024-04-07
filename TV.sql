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

CREATE TABLE flimsAndSerials(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE,
nameActor VARCHAR(100) NOT NULL
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
id_transmission INT NOT NULL,
id_user INT NOT NULL,
FOREIGN KEY (id_transmission) REFERENCES transmission(id),
FOREIGN KEY (id_user) REFERENCES user(id)
);


CREATE TABLE rairingFilms(
id INT AUTO_INCREMENT PRIMARY KEY,
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