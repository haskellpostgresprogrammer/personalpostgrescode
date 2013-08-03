drop schema youtube;
create schema youtube;

create type racyfilter as enum ('include','exclude');
create type orderbyfilter as enum ('relevance',
                              'viewcount','published','rating');
create type timefilter as enum ('today',
                          'thisweek','thismonth','alltime');

create table youtubequery(
    id serial primary key,
    created timestamp default now(),
    search_terms text,
    racy racyfilter,
    maxresults integer,
    startindex integer,
    orderby orderbyfilter,
    time timefilter,
    category text,
    keywords text,
    author text
    );

create domain url as text;

create table videotag(
    id serial primary key,
    created timestamp default now(),
    tag text
    );

create table youtubedata(
    id serial primary key,
    created timestamp default now(),
    videoid text,
    videotitle text,
    videopublishedon timestamp,
    videodescription text,
    videocategory text,
    videowatchpage url,
    videoflashplayer url,
    videoduration integer,
    videoviewcount integer,
    videorating float,
    alternateformat1 url,
    alternateformat2 url,
    thumbnail1 url,
    thumbnail2 url,
    thumbnail3 url,
    thumbnail4 url
    );

create table videotagsmap(
    id serial primary key,
    created timestamp default now(),
    video int references youtubedata,
    tag int references videotag
    );
