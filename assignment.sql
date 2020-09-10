-- Creating the schema
create schema assignment;

-- Using `assignment` schema
USE `assignment`;

SET SQL_SAFE_UPDATES = 0;
SET sql_mode='';

-- we have imported date as text and changing it to datetime format as below:

update assignment.`bajaj` set `Date` = str_to_date(Date, "%d-%M-%Y")
 where 1=1;
 
 /*  as per the assignment,we have to reate a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA.
 (This has to be done for all 6 stocks).Creating table balaji1 as below
 */
 
 CREATE TABLE bajaj1
 (select date, `Close Price` as  `Close Price` ,
  ROW_NUMBER() OVER (ORDER BY date ASC) RowNumber,
  avg(`Close Price`) over (order by date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by date asc rows 49 preceding) as `50 Day MA`
  from bajaj);
  
update assignment.`eicher` set `Date` = str_to_date(Date, "%d-%M-%Y")
 where 1=1;
 
 -- creating table eicher1 for part 1 of the assignment

CREATE TABLE eicher1
 (select date, `Close Price` as  `Close Price` ,
  ROW_NUMBER() OVER (ORDER BY date ASC) RowNumber,
  avg(`Close Price`) over (order by date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by date asc rows 49 preceding) as `50 Day MA`
  from eicher);
  
  update assignment.`hero` set `Date` = str_to_date(Date, "%d-%M-%Y")
  where 1=1;
 
 -- creating table hero1 for part 1 of the assignment
 
 CREATE TABLE hero1
 (select date, `Close Price` as  `Close Price` ,
  ROW_NUMBER() OVER (ORDER BY date ASC) RowNumber,
  avg(`Close Price`) over (order by date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by date asc rows 49 preceding) as `50 Day MA`
  from hero);
  
  update assignment.`infosys` set `Date` = str_to_date(Date, "%d-%M-%Y")
 where 1=1;
 
 -- creating table infosys1 for part 1 of the assignment
 
 CREATE TABLE infosys1
 (select date, `Close Price` as  `Close Price` ,
  ROW_NUMBER() OVER (ORDER BY date ASC) RowNumber,
  avg(`Close Price`) over (order by date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by date asc rows 49 preceding) as `50 Day MA`
  from infosys);
 
 update assignment.`tcs` set `Date` = str_to_date(Date, "%d-%M-%Y")
 where 1=1;
 
 -- creating table tcs1 for part 1 of the assignment
 
 CREATE TABLE tcs1
 (select date, `Close Price` as  `Close Price` ,
  ROW_NUMBER() OVER (ORDER BY date ASC) RowNumber,
  avg(`Close Price`) over (order by date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by date asc rows 49 preceding) as `50 Day MA`
  from tcs);
  
  update assignment.`tvs` set `Date` = str_to_date(Date, "%d-%M-%Y")
 where 1=1;
 
 -- creating table tvs1 for part 1 of the assignment
 
 CREATE TABLE tvs1
 (select date, `Close Price` as  `Close Price` ,
  ROW_NUMBER() OVER (ORDER BY date ASC) RowNumber,
  avg(`Close Price`) over (order by date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by date asc rows 49 preceding) as `50 Day MA`
  from tvs);
 

    
	/* creating master table containing the date and 
    close price of all the six stocks. (Column header for the price is the name of the stock),part(2) of assignment
    */
    
   CREATE TABLE `master1` as
   (  SELECT b.Date as `Date`, 
    b.`Close Price` as `Bajaj`,
    t.`Close Price` as `TCS`,
    tv.`Close Price` as `TVS`,
    i.`Close Price` as `Infosys`,
    e.`Close Price` as `Eicher`,
    h.`Close Price` as `Hero`
    FROM `bajaj` b
    Inner Join `tcs`  t ON b.date= t.date
    Inner Join `tvs` tv ON t.date= tv.date
    Inner Join `infosys` i ON tv.date=i.date
    Inner Join `eicher`e  ON i.date= e.date
    Inner Join `hero` h ON e.date= h.date);
    
/* To use the table created in Part(1) to generate buy and sell signal and
Store this in another table named 'bajaj2'.We have to  Perform this operation for all stocks.
*/
-- creating table bajaj2 as mentioned above to generate signal
    
create table bajaj2 as
(    select date, `Close Price`,
	case
		WHEN RowNumber > 49 AND (`20 Day MA` > `50 Day MA`) then 'Buy'
          WHEN RowNumber > 49 AND (`20 Day MA` < `50 Day MA`) then 'Sell'
		else 'Hold'
	end as `Signal`
from bajaj1);

-- creating table eicher2 to generate signal(hold/buy/sell)

create table eicher2 as
(    select date, `Close Price`,
	case
		WHEN RowNumber > 49 AND (`20 Day MA` > `50 Day MA`) then 'Buy'
          WHEN RowNumber > 49 AND (`20 Day MA` < `50 Day MA`) then 'Sell'
		else 'Hold'
	end as `Signal`
from eicher1);

-- creating table hero2 to generate signal(hold/buy/sell)
    
  create table hero2 as
(    select date, `Close Price`,
	case
		WHEN RowNumber > 49 AND (`20 Day MA` > `50 Day MA`) then 'Buy'
          WHEN RowNumber > 49 AND (`20 Day MA` < `50 Day MA`) then 'Sell'
		else 'Hold'
	end as `Signal`
from hero1);  

-- creating table infosys2 to generate signal(hold/buy/sell)

create table infosys2 as
(    select date, `Close Price`,
	case
		WHEN RowNumber > 49 AND (`20 Day MA` > `50 Day MA`) then 'Buy'
          WHEN RowNumber > 49 AND (`20 Day MA` < `50 Day MA`) then 'Sell'
		else 'Hold'
	end as `Signal`
from infosys1); 

-- creating table tcs2 to generate signal(hold/buy/sell)

create table tcs2 as
(    select date, `Close Price`,
	case
		WHEN RowNumber > 49 AND (`20 Day MA` > `50 Day MA`) then 'Buy'
          WHEN RowNumber > 49 AND (`20 Day MA` < `50 Day MA`) then 'Sell'
		else 'Hold'
	end as `Signal`
from tcs1); 

-- creating table tvs2 to generate signal(hold/buy/sell)

create table tvs2 as
(    select date, `Close Price`,
	case
		WHEN RowNumber > 49 AND (`20 Day MA` > `50 Day MA`) then 'Buy'
          WHEN RowNumber > 49 AND (`20 Day MA` < `50 Day MA`) then 'Sell'
		else 'Hold'
	end as `Signal`
from tvs1); 

/* To create a User defined function, that takes the date as input and 
returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.The function is defined as below
*/

delimiter //
create function signal_bajaj_date( bajaj_date date)
returns varchar(16)
deterministic
begin

declare signal_bajaj varchar(16);

select `Signal` into signal_bajaj 
from bajaj2
where `Date` = bajaj_date;

return signal_bajaj;

end //

delimiter ;
    
    