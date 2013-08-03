\c postgres
drop database prioritizer;
create database prioritizer;
\c prioritizer

-- domains

create domain id as integer;
create domain email as varchar(100);

-- tables

create table users(
       id serial primary key,
       user_name varchar(100) unique not null,
       email email unique not null,
       password varchar(100) not null,
       creation_time timestamp default now()
       );

create table tasks(
       id serial primary key,
       task_text var_char(1000) not null,
       created_by integer references users not null,
       enabled boolean default True
       );

create table profits(
       profit_estimate integer not null,
       created_by integer references users not null,
       task integer references tasks not null
       );

-- views
create view task_

-- functions

create function user_id(email) returns integer as
       $$
       select id from users where email = $1;
       $$ language sql;

create function add_user(email,password,nickname) 
       returns void as
       $$
       insert into users (email,password,nickname) 
       values ($1,$2,$3);
       $$ language sql;

create function check_password(email,pwd) 
       returns boolean as
       $$
       declare passed boolean;
       begin
		select (password = $2) into passed
		from users where email = $1;
		return passed;
       end       
       $$ language plpgsql;

create function add_task(email,task_text) 
       returns void as
       $$
       insert into tasks (creator,task_text) values (user_id($1),$2);
       $$ language sql;

create function add_profit(email,profit,task_id) 
       returns void as
       $$
       insert into costs (creator,profit_estimate,task_id) 
       values (user_id($1),$2,$3);
       $$ language sql;

create function disable_task(task_id,email)
       returns void as
       $$
       update tasks set enabled FALSE where id = $1 
       AND email = user_id($2);
       $$ language sql;

create function reenable_task(task_id,email)
       returns void as
       $$
       update tasks set enabled TRUE where id = $1
       AND email = user_id($2);
       $$ language sql;
