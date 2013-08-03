drop schema stocks;
create schema stocks;

create domain symbolD as varchar(10);
create domain companynameD as text;
create domain openD as float;
create domain highD as float;
create domain lowD as float;
create domain volumeD as float;
create domain adj_closeD as float;
create domain startdateD as date;
create domain enddateD as date;

create domain priceD as float;
create domain changeD as float;
create domain volumeD as float;
create domain avg_daily_volumeD as float;
create domain stock_exchangeD as text;
create domain market_capD as float;
create domain book_valueD as float;
create domain ebitdaD as float;
create domain dividend_per_shareD as float;
create domain dividend_yieldD as float;
create domain earnings_per_shareD as float;
create domain fiftytwo_week_highD as float;
create domain fiftytwo_week_lowD as float;
create domain fifty_day_moving_avgD as float;
create domain 
       twohundred_day_moving_avgD as float;
create domain price_earnings_ratioD as float;
create domain 
       price_earnings_growth_ratioD as float;
create domain price_sales_ratioD as float;
create domain price_book_ratioD as float;
create domain short_ratioD as float;

create domain stockqueryidD as int;
create domain stockdetailqueryidD as int;
create domain symbolidD as int;
create domain stockpricedataidD as int;
create domain stockdetaildataidD as int;
create domain stockexchangeidD as int;

create domain autoencoderidD as int;
create domain classifieridD as int;

create domain encoderd as blob;
create domain decoderD as blob;
create domain classifierD as blob;

create type classifierT
       as enum ('decisiontree','logisticregression');

create table stockquery(
       stockqueryid serial primary key,
       created timestamp default not null now(),
       symbol symbolD not null,
       startdate startdateD not null,
       enddate enddateD not null,
       unique (symbol, startdate, enddate)
);
create table stockdetailquery(
       stockdetailqueryid serial primary key,
       created timestamp default now(),
       symbol symbolD,
       date date,
       unique (symbol, date)
);
create table symbols(
       symbolid serial primary key,
       created timestamp default not null now(),
       symbol symbolD not null unique,
       companyname companynameD
);
create table stockpricedata(
       stockpriceid serial primary key,
       created timestamp default not null now(),

       date date not null,
       symbol int references symbols,
       open openD not null,
       high highD not null,
       low lowD not null,
       volume volumeD not null,
       adj_close adj_closeD not null,
       unique (date,symbol)
);
create table stockexchanges(
       stockexchangeid serial primary key,
       created timestamp default now(),
       stock_exchange stock_exchangeD 
       		      not null unique
);
create table stockdetaildata(
       stockdetailid serial primary key,
       created timestamp default now(),

       date date not null,
       symbol int references symbols,
       price priceD,
       change changeD,
       volume volumeD,
       avg_daily_volume avg_daily_volumeD,
       stock_exchange int 
       		      references stockexchanges,
       market_cap market_capD,
       book_value book_valueD,
       ebitda ebitdaD,
       dividend_per_share dividend_per_shareD,
       dividend_yield dividend_yieldD,
       earnings_per_share earnings_per_shareD,
       fiftytwo_week_high fiftytwo_week_highD,
       fiftytwo_week_low fiftytwo_week_lowD,
       fifty_day_moving_avg fifty_day_moving_avgD,
       twohundred_day_moving_avg 
       				 twohundred_day_moving_avgD,
       price_earnings_ratio price_earnings_ratioD,
       price_earnings_growth_ratio 
       				   price_earnings_growth_ratioD,
       price_sales_ratio price_sales_ratioD,
       price_book_ratio price_book_ratioD,
       short_ratio short_ratioD,
       unique (date,symbol)
);

-- create function addsymbol(text) 
--        returns void as
--        $$
--        insert into symbols (symbol) values ($1);
--        $$
--        language sql;
-- create function removesymbol(text) 
--        returns void as
--        $$
--        delete from symbols where symbol = $1;
--        $$
--        language sql;

--  stock     | text                        | 
--  date      | date                        | 
--  open      | double precision            | 
--  high      | double precision            | 
--  low       | double precision            | 
--  close     | double precision            | 
--  volume    | double precision            | 
--  adj_close | double precision            | 

-- create function adddata(text,date,float,float,float,
--                      float,float,float) 
--        returns void as
--        $$
--        insert into stockdata (stock,date,
--        open,high,low,close,volume,adj_close) 
--        values ($1,$2,$3,$4,$5,$6,$7,$8);
--        $$
--        language sql;
-- create function removedata(text,date) 
--        returns void as
--        $$
--        delete from stockdata where = $1;
--        $$
--        language sql;

-- create function adddetaildata() 
--        returns void as
--        $$
--        $$
--        language sql;
-- create function removedetaildata() 
--        returns void as
--        $$
--        $$
--        language sql;

-- create function addstockquery() 
--        returns void as
--        $$
--        $$
--        language sql;
-- create function removestockquery() 
--        returns void as
--        $$
--        $$
--        language sql;
-- create function addstockdetailquery() 
--        returns void as
--        $$
--        $$
--        language sql;
-- create function removestockdetailquery() 
--        returns void as
--        $$
--        $$
--        language sql;
