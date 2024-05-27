use TSQL2012;

-- date time function
select '20133001' as old_date, GETDATE() as today;
-- day wise datediff
select '20133001' as pre_day, GETDATE () as today, DATEDIFF(day,'20130101',getdate()) as diff;
--month
select '20133001' as pre_day, GETDATE () as today, DATEDIFF(MONTH,'20130101',getdate()) as diff;
--year
select '20133001' as pre_day, GETDATE () as today, DATEDIFF(YEAR,'20130101',getdate()) as diff;

-- add day month year
select '20133001' as pre_day, GETDATE () as today, DATEADD(day,1,getdate()) as 'add';
select '20133001' as pre_day, GETDATE () as today, DATEADD(month,1,getdate()) as 'add';
select '20133001' as pre_day, GETDATE () as today, DATEADD(year,1,getdate()) as 'add';




-- if i have any month first day data how can i get last date
select '20133001' as pre_day,dateadd(month,1,getdate()) as 'last day';


-- end of month 

 




