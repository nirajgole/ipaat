CREATE DATABASE Project2

use Project2

CREATE TABLE role (
  id int PRIMARY KEY,
  role_name varchar(100)
);


CREATE TABLE user_account (
  id int PRIMARY KEY,
  user_name varchar(100),
  email varchar(254),
  password varchar(100),
  password_salt varchar(50),
  password_hash_algorithm varchar(50)
);


CREATE TABLE user_has_role (
  id int PRIMARY KEY,
  role_start_time timestamp,
  role_end_time datetime2 NOT NULL,
  user_account_id int,
  role_id int
);


CREATE TABLE user_has_status (
  id int PRIMARY KEY,
  status_start_time timestamp,
  status_end_time DATETIME2,
  user_account_id int,
  status_id int
);

CREATE TABLE status (
  id int PRIMARY KEY,
  status_name varchar(100),
  is_user_working bit
);

ALTER TABLE user_has_role ADD FOREIGN KEY (role_id) REFERENCES role (id);

ALTER TABLE user_has_status ADD FOREIGN KEY (status_id) REFERENCES status (id);

ALTER TABLE user_has_status ADD FOREIGN KEY (user_account_id) REFERENCES user_account (id);

ALTER TABLE user_has_role ADD FOREIGN KEY (user_account_id) REFERENCES user_account (id);

INSERT INTO role values(101,'Admin')
INSERT INTO role values(102,'Guest')
INSERT INTO role values(103,'Basic')

INSERT INTO user_account VALUES(201,'barney','bar@gmail.com','bar@123','asd121jkADl34asdas','SHA-256')
INSERT INTO user_account VALUES(202,'jessica','jess@gmail.com','jess@123','65465q32234DF12aD34','bcrypt')

INSERT INTO user_has_role (id,role_end_time,user_account_id,role_id) VALUES(1,'1998-01-01',201,103)
INSERT INTO user_has_role (id,role_end_time,user_account_id,role_id) VALUES(2,'1999-01-01',202,101)

INSERT INTO user_has_status (id,status_end_time,user_account_id,status_id) VALUES(501,'1999-01-01',201,1)
INSERT INTO user_has_status (id,status_end_time,user_account_id,status_id) VALUES(502,'1998-01-01',202,2)

INSERT INTO [status] VALUES(1,'LIVE',1)
INSERT INTO [status] VALUES(2,'AWAY',0)


TRUNCATE TABLE user_has_role

TRUNCATE TABLE user_has_status

TRUNCATE TABLE role

TRUNCATE TABLE status

TRUNCATE TABLE user_account