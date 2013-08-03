drop schema crowdfunding_planner_singleuser;
create schema crowdfunding_planner_singleuser;

create type video_or_image as enum ('video','image');
create domain days as int;
create type completion_state as enum ('complete','incomplete');
create type finish_state as enum ('finished','not finished');
create type terminated_state as enum ('terminated','not terminated');

create table crowdfund_sites(
       id serial primary key,
       site varchar(1000)
       );

create table campaigns(
       id serial primary key,
       description text not null
       title references title_choices,
       pitch references pitch_choices,
       goal_amount money,
       time_limit days,
       video int references video_choices,
       image int references image_choices,
       video_image_choice video_or_image,
       crowdfund_site int references crowdfund_sites,
       is_ready completion_state,
       is_finished finish_state,
       is_terminated terminated_state
       );

create table title_choices(
       id serial primary key,
       title varchar(100),
       is_terminated terminated_state
       );
create table pitch_choices(
       id serial primary key,
       pitch varchar(20000),
       is_terminated terminated_state
       );
create table rewards(
       id serial primary key,
       campaign references campaigns,
       reward_price money,
       reward varchar(1000),
       is_terminated terminated_state
       );

create table video_choices(
       id serial primary key,
       filename varchar(1000),
       is_terminated terminated_state
       );
create table image_choices(
       id serial primary key,
       filename varchar(1000),
       is_terminated terminated_state
       );

-- create table social_media(
--        id int primary key,
--        site varchar(1000),
--        message varchar(10000),       
--        is_terminated terminated_state,
--        is_finished finish_state,
--        audience_size int       
--        );

-- create table comments();
-- create table comment_campaign();
-- create table comment_title();
-- create table comment_pitch();
-- create table comment_video();
-- create table comment_image();
-- create table comment_marketing_idea();
-- create table comment_crowdfundsite();

-- #         fsqltitletable("Campaigns","campaigns",""),
-- #                         ["by tag",
-- #                          "by creation date",
-- #                          "by campaign time limit",
-- #                          "by estimated ",
-- #                          "by estimated time to produce product",
-- #                          "by estimated cost to produce product",
-- #                          "by recent activity"
-- #                          "by activity"
-- #                          ]),
