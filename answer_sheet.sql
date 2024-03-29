--1
SELECT *
FROM orders
WHERE salesman_id = (
    SELECT salesman_id
    FROM salesman
    WHERE name = 'Paul Adam '
);

--2
select * 
from orders 
where salesman_id  in(
	select salesman_id 
	from salesman
	where city ='London'
);
--3
select * 
from orders 
where customer_id =3007;

--4
select * from
orders 
where purch_amt > (select 
				   avg(purch_amt) as avg_amt
				   from orders
				   where ord_date ='2012-10-10'
				  );
--5
select * 
from orders
where customer_id in (select customer_id
					 from customer
					 where city ='New York'
					);

--6
select commission
from salesman
where city ='Paris';

--7 
select cust_name
from customer
where customer_id <= 2001
and salesman_id =(select salesman_id
				 from salesman
				 where name = 'Mc Lyon');
select name from salesman;		

SELECT *
FROM customer
WHERE customer_id < 2001
AND salesman_id = (
    SELECT salesman_id
    FROM salesman
    WHERE name ='Mc Lyon'
);

--8
SELECT grade, COUNT(*) AS count
FROM customer
WHERE city = 'New York' 
  AND grade > (
    SELECT AVG(grade)
    FROM customer
    WHERE city = 'New York'
  )
GROUP BY grade;			

--9
SELECT ord_no, salesman_id,purch_amt, ord_date
FROM orders
WHERE salesman_id IN (
    SELECT salesman_id
    FROM salesman
    WHERE commission = (
        SELECT MAX(commission)
        FROM salesman
    )
);

--10
select o.* , c.cust_name
from orders o 
join customer c on o.customer_id =c.customer_id
where ord_date ='2012-08-17'

--11

select s.salesman_id, s.name
from salesman s
join customer c on s.salesman_id = c.salesman_id
group by s.salesman_id
having count(*) >1

--12 
SELECT *
FROM orders
WHERE purch_amt > (
    SELECT AVG(purch_amt) AS avg_purch_amt
    FROM orders
);		

--13
SELECT *
FROM orders
WHERE purch_amt >= (
    SELECT AVG(purch_amt) AS avg_purch_amt
    FROM orders
);		


--14

select ord_date , sum(purch_amt)	 
from orders o
group by ord_date
having sum(purch_amt) > (
	select 1000 + Max(purch_amt)
	from orders b
	where o.ord_date =b.ord_date
)

--
--15
select * 
from customer
where exists (
	select * 
	from customer
	where city = 'London'
)
--16
SELECT DISTINCT s.*
FROM salesman s
JOIN customer a ON s.salesman_id = a.salesman_id
JOIN customer b ON s.salesman_id = b.salesman_id AND a.cust_name <> b.cust_name;

--17
--18
select * 
from salesman a
where exists (
	select * from customer b
	where b.salesman_id= a.salesman_id
	and 1 < (
		select count (*)
		from orders  s
		where s.customer_id = b.customer_id
	)
)

--19
select * from salesman s
join customer b on s.salesman_id = b.salesman_id
where s.city = b.city


--20
select * from salesman
where  city =any (select city from customer)



select * from salesman a
where exists (
	select * from 
	customer b
	where a.name < b.cust_name
)

--22


select * from customer a
where grade > any (
	select grade from customer b
	where b.city < 'New York'
)
-- 23
select * 
from orders
where purch_amt > any (
	select purch_amt
	from orders 
	where ord_date ='2012-09-10'
)

select * from orders
--24
select * 
from orders a
where purch_amt <  any (
	select purch_amt
	from orders a, customer b
	where a.salesman_id = b.salesman_id
	and b.city ='London'
)

--25

select * 
from orders a
where purch_amt < (
	select max(purch_amt)
	from orders a, customer b
	where a.salesman_id = b.salesman_id 
	and b.city ='London'
	
				  )
--26
select * from customer
where grade > all (select grade
			   from customer
			   where city ='New York'
			  )
			  
--27			  
select sum(purch_amt) as total_amount, a.salesman_id, b.name, b.city
from orders a
join salesman b on a.salesman_id = b.salesman_id
join  customer c on b.salesman_id = c.salesman_id
where b.city in (
	select c.city
	from customer c
)
group by a.salesman_id,b.name,b.city

--28
select * from customer 
where grade <> All(
	select grade
	from customer 
	where city ='London' and 
)

--29 
select * 
from customer 
where grade <> any(
	select grade 
	from customer 
	where city = 'Paris' and grade is not null
)
-- 30
select * 
from customer 
where grade <> any(
	select grade 
	from customer 
	where city = 'Dallas City' and grade is not null
)
