with quarter_volume AS 
(
    select c.algorithm, 
    sum(t.volume) as sum_volume, 
    datepart(quarter, t.dt) as quarter_2020
    from coins c 
    JOIN transactions t ON c.code = t.coin_code
    where datepart(year, t.dt) = 2020
    group by c.algorithm,  datepart(quarter, t.dt)
)     

select c.algorithm,
qv1.sum_volume as transactions_Q1,
qv2.sum_volume as transactions_Q2,
qv3.sum_volume as transactions_Q3,
qv4.sum_volume as transactions_Q4
from coins c
LEFT JOIN quarter_volume qv1 
ON c.algorithm = qv1.algorithm
and qv1.quarter_2020 = 1

LEFT JOIN quarter_volume qv2
ON c.algorithm = qv2.algorithm
and qv2.quarter_2020 = 2

LEFT JOIN quarter_volume qv3
ON c.algorithm = qv3.algorithm
and qv3.quarter_2020 = 3

LEFT JOIN quarter_volume qv4
ON c.algorithm = qv4.algorithm
and qv4.quarter_2020 = 4
where c.code NOT LIKE 'DOGE'

order by c.algorithm