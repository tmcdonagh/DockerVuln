CREATE USER 'test'@'%' IDENTIFIED WITH mysql_native_password BY 'test';
GRANT SELECT, INSERT, DELETE ON * . * TO 'test'@'%';
FLUSH PRIVILEGES;

CREATE DATABASE clouddb;
USE clouddb;

CREATE TABLE users(
  ID int NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  time VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID)
);