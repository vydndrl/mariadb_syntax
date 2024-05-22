create table author (id int auto_increment primary key,
name varchar(255), email varchar(255) not null unique,
password varchar(255),
create_time datetime default current_timestamp);

create table post (id int auto_increment primary key,
title varchar(255) not null,
contents varchar(3000));

create table author_address(id int auto_increment primary key,
city varchar(255), street varchar(255), author_id int unique not null,
foreign key(author_id) references author(id) on delete cascade);

create table author_post(id int auto_increment primary key,
author_id int not null, post_id int not null,
foreign key (author_id) references author(id),
foreign key (post_id) references post(id));