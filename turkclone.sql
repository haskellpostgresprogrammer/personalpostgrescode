\c postgres
drop database ranker;
create database ranker;
\c ranker

-- domains

create domain id as integer;
create domain email as varchar(100);
create domain user_name as email;
create domain user_id as id;
create domain short_title as varchar(100);
create domain short_description as varchar(500);
create domain long_text as varchar(3000);

-- tables

create table users(
       id serial primary key,
       user_name user_name unique,
       creation_time timestamp default now());

-- triggers

-- user functions

create function user_id(user_name) returns integer as
       $$
       select id from users where user_name = $1;
       $$ language sql;

create function add_user(user_name) returns void as
       $$
       insert into users(user_name) values ($1);
       $$ language sql;

create function latest_users() returns setof record as
       $$
       select * from users order by creation_time desc limit 10;
       $$ language sql;

create function earliest_users() returns setof record as
       $$
       select * from users order by creation_time asc limit 10;
       $$ language sql;
