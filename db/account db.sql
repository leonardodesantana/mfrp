-- create database if not exists mfrp;
use mfrp;

create table if not exists users(
	id INT auto_increment primary key,
	userName VARCHAR(50) not null unique,
	userEmail VARCHAR(100) not null unique,
	hashedPassword VARCHAR(255) not null,
	salt VARCHAR(255) not null,
	hwSerial VARCHAR(100) not null unique,
	creationDate TIMESTAMP not null,
	lastLogin TIMESTAMP not null
);

