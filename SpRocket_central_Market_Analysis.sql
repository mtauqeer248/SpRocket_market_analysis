 with cte as (
 select count(gender) as total_count,
  (
  select count(gender) as female from `gc01-377205.KMPG_Internship.Customer_info`
  where gender='Female'
) female ,
( select count(gender) as male

from `gc01-377205.KMPG_Internship.Customer_info`
where gender='Male' 
) male from `gc01-377205.KMPG_Internship.Customer_info`

where gender!='unknown'
 )
 select concat(round((male*100)/total_count,1),'%') as male_per,concat(round((female*100)/total_count,1),'%') as female_per
from cte ;

select gender ,round( avg(cast(age_of_customers as float64)),1) avg_age from `gc01-377205.KMPG_Internship.Customer_info`
where age_of_customers != 'notKnown'
group by gender
having gender!='unknown' ;
--which industry and which role people belong who did most purchases in last 3 year timespan
select 
 distinct (job_industry_category) ,job_title,
count (cast(past_3_years_bike_related_purchases as int64)) as bike_purchases 
from `gc01-377205.KMPG_Internship.Customer_info`
where past_3_years_bike_related_purchases  != 'unknown' and 
past_3_years_bike_related_purchases  !='notKnown'
group by job_industry_category,job_title
having job_title !='notKnown' and job_industry_category !='n/a'
order by bike_purchases desc;
--state with most transactions
select 
distinct(state),
count(transaction_date) 
from `gc01-377205.KMPG_Internship.Customer_info` c 
join `gc01-377205.KMPG_Internship.addresses` a using(customer_id)
join `gc01-377205.KMPG_Internship.Transaction` t using(customer_id)
group by state;

--address with most transaction

select 
first_name,
last_name,
address,
count(transaction_date) 
from `gc01-377205.KMPG_Internship.Customer_info` c 
join `gc01-377205.KMPG_Internship.addresses` a using(customer_id)
join `gc01-377205.KMPG_Internship.Transaction` t using(customer_id)
group by first_name,last_name ,address
order by count(transaction_date) desc
limit 1000;

--avg age of custumer with most purchases

select 
cast(age_of_customers as int64) age ,
count(transaction_date) most_purchases
from `gc01-377205.KMPG_Internship.Customer_info` c 
join `gc01-377205.KMPG_Internship.addresses` a using(customer_id)
join `gc01-377205.KMPG_Internship.Transaction` t using(customer_id)
--where cast(age_of_customers as int64) != 123 and age_of_customers !='notKnown'
group by age_of_customers
order by count(transaction_date) desc
limit 1000;