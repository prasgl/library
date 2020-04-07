CREATE DATABASE library;

USE library;

SET @username = 'prasgl',
	@password = 'test1234',
	@rolename = 'admin',
	@menudesc = 'home';

CREATE TABLE user (id VARCHAR(36), name VARCHAR(40), password VARCHAR(40));

INSERT INTO user VALUES (uuid(), @username, @password);

SELECT @userid := id FROM user WHERE name = @username;

CREATE TABLE role (id VARCHAR(36), name VARCHAR(40));

INSERT INTO role VALUES (uuid(), @rolename);

SELECT @roleid := id FROM role WHERE name = @rolename;

CREATE TABLE user_role (id VARCHAR(36), userid VARCHAR(36), roleid VARCHAR(36));

INSERT INTO user_role VALUES (uuid(), @userid, @roleid);

SELECT @user_role_id := id FROM user_role WHERE (userid = @userid AND roleid = @roleid);

CREATE TABLE menu (id VARCHAR(36), description VARCHAR(100));

INSERT INTO menu VALUES (uuid(), @menudesc);

SELECT @menuid := id FROM menu WHERE description = @menudesc;

CREATE TABLE role_menu (id VARCHAR(36), user_role_id VARCHAR(36), menuid VARCHAR(36)); 

INSERT INTO role_menu VALUES (uuid(), @user_role_id, @menuid);
