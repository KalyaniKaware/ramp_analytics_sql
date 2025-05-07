/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021. */

with per_day as (
                  select  transaction_time::date as trx_date,
                          sum(transaction_amount) as total_amount
                  from transactions
                  group by 1
				)
, rolling_3_day_avg as (
					select trx_date,
 						   avg(total_amount) 
                            over (order by trx_date 
                                  rows between 2 preceding and current row
                                 ) as rolling_3_avg
  					from per_day 
				)
select 	trx_date,
		rolling_3_avg
from rolling_3_day_avg
order by 1;
