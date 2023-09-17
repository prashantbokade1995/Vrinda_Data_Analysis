-- drop database Zomato_DB;
create database Zomato_DB;

use Zomato_DB;

--drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 
INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'09-22-2017'),
		(3,'04-21-2017'),
		(2, '08-15-2018'),
		(4, '03-07-2019'),
		(5, '11-25-2020');

--drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 
INSERT INTO users(userid,signup_date) 
 VALUES (1,'09-02-2014'),
		(2,'01-15-2015'),
		(3,'04-11-2014'),
		(4, '06-12-2017'),
		(5, '09-05-2018');

--drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'04-19-2017',2),
		(3,'12-18-2019',1),
		(2,'07-20-2020',3),
		(1,'10-23-2019',2),
		(1,'03-19-2018',3),
		(3,'12-20-2016',2),
		(1,'11-09-2016',1),
		(1,'05-20-2016',3),
		(2,'09-24-2017',1),
		(1,'03-11-2017',2),
		(1,'03-11-2016',1),
		(3,'11-10-2016',1),
		(3,'12-07-2017',2),
		(3,'12-15-2016',2),
		(2,'11-08-2017',2),
		(2,'09-10-2018',3),
		(2, '01-08-2020', 2),
		(3, '06-05-2021', 1),
		(4, '09-15-2021', 3),
		(5, '02-22-2022', 2),
		(1, '07-18-2022', 1);


--drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
		(1,'p1',980),
		(2,'p2',870),
		(3,'p3',330),
		(4, 'p4', 450),
		(5, 'p5', 560);

select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;


--1. what is the total amount each customer spent on zomato?

-- select a.userid, a.product_id, b.price from sales a inner join product b on a.product_id = b.product_id


select a.userid, sum(b.price) from sales a inner join product b on a.product_id = b.product_id
group by a.userid

select a.userid, sum(b.price) total_amt_spent from sales a inner join product b on a.product_id = b.product_id
group by a.userid


--2. How many days has each customer visited zomamto?

select userid, count(distinct created_date) distinct_days from sales group by userid;

--3. what was the first product purchused by each other customer?

select * from 
(select *, rank() over(partition by userid order by created_date) rnk from sales ) a where rnk = 1;

--4. What is the most purchase item on the menu and how many times was it purchased by all customer?
Select product_id, count (product_id) from sales group by product_id order by count (product_id) desc;

Select top 1 product_id, count (product_id) from sales group by product_id order by count (product_id) desc;

Select top 1 product_id from sales group by product_id order by count (product_id) desc;

select * from sales where product_id =
(Select top 1 product_id from sales group by product_id order by count (product_id) desc)

select userid, count(product_id) cnt from sales where product_id =
(Select top 1 product_id from sales group by product_id order by count (product_id) desc)
group by userid


--5.Which item was the most popular for each customer ?

Select userid , product_id, count(product_id) cnt from sales group by userid, product_id


select * from 
(select *, rank() over(partition by userid order by cnt desc) rnk from 
(select userid, product_id, count(product_id) cnt from sales group by userid, product_id)a)b
where rnk =1



--6. Which item was the perfect first by the customer after the become a member


select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a inner join goldusers_signup b on a.userid = b.userid;

select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a inner join 
goldusers_signup b on a.userid = b.userid and created_date >= gold_signup_date;


select * from 
(select c. *, rank() over(partition by userid order by created_date) rnk from
(select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a inner join 
goldusers_signup b on a.userid = b.userid and created_date >= gold_signup_date
)c) d where rnk =1;

--7.which item as purchased just before the customer became a memeber?
select * from 
(select c. *, rank() over(partition by userid order by created_date desc) rnk from
(select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a inner join 
goldusers_signup b on a.userid = b.userid and created_date <= gold_signup_date
)c) d where rnk =1;

--8. what is the total order and amount spent for each memember before they become a member?

select userid, count(created_date), sum(price) from
(select c. *, d.price from 
(select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a inner join
goldusers_signup b on a.userid=b.userid and created_date <= gold_signup_date)c inner join product d on c.product_id = d.product_id)e
group by userid;


select userid, count(created_date) order_purchased, sum(price) total_amt_spent from
(select c. *, d.price from 
(select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a inner join
goldusers_signup b on a.userid=b.userid and created_date <= gold_signup_date)c inner join product d on c.product_id = d.product_id)e
group by userid;


-- If buying each product generate points for ₹5 formato point and each product have Different purchasing point 
--for ex eh p1 5rs =1  point for p2 10rs=5 zomato points and p3 5rs=1 point 2rs =1 zomato point
--Calculate point collected by each customer and for which product most point have been given till now 


select e. *, amt/points total_points from
(select d. *, case when product_id=1 then 5 when product_id = 2 then 2 when product_id=3 then 5 else 0 end as points from 
(select c.userid, c.product_id, sum(price) amt from
(select a. *, b.price from sales a inner join product b on a.product_id=b.product_id) c
group by userid,product_id)d)e;

select userid, sum(total_points) from
(select e. *, amt/points total_points from
(select d. *, case when product_id=1 then 5 when product_id = 2 then 2 when product_id=3 then 5 else 0 end as points from 
(select c.userid, c.product_id, sum(price) amt from
(select a. *, b.price from sales a inner join product b on a.product_id=b.product_id) c
group by userid,product_id)d)e)f group by userid;


select userid, sum(total_points)*2.5 total_money_earned from
(select e. *, amt/points total_points from
(select d. *, case when product_id=1 then 5 when product_id = 2 then 2 when product_id=3 then 5 else 0 end as points from 
(select c.userid, c.product_id, sum(price) amt from
(select a. *, b.price from sales a inner join product b on a.product_id=b.product_id) c
group by userid,product_id)d)e)f group by userid;


select e. *, amt/points total_points from
(select d. *, case when product_id=1 then 5 when product_id = 2 then 2 when product_id=3 then 5 else 0 end as points from 
(select c.userid, c.product_id, sum(price) amt from
(select a. *, b.price from sales a inner join product b on a.product_id=b.product_id) c
group by userid,product_id)d)e

select product_id, sum(total_points) total_money_earned from
(select e. *, amt/points total_points from
(select d. *, case when product_id=1 then 5 when product_id = 2 then 2 when product_id=3 then 5 else 0 end as points from 
(select c.userid, c.product_id, sum(price) amt from
(select a. *, b.price from sales a inner join product b on a.product_id=b.product_id) c
group by userid,product_id)d)e)f group by product_id;


select * , rank() over(order by total_money_earned desc) rnk from
(select product_id, sum(total_points) total_money_earned from
(select e. *, amt/points total_points from
(select d. *, case when product_id=1 then 5 when product_id = 2 then 2 when product_id=3 then 5 else 0 end as points from 
(select c.userid, c.product_id, sum(price) amt from
(select a. *, b.price from sales a inner join product b on a.product_id=b.product_id) c
group by userid,product_id)d)e)f group by product_id)f

select * from 
(select * , rank() over(order by total_money_earned desc) rnk from
(select product_id, sum(total_points) total_money_earned from
(select e. *, amt/points total_points from
(select d. *, case when product_id=1 then 5 when product_id = 2 then 2 when product_id=3 then 5 else 0 end as points from 
(select c.userid, c.product_id, sum(price) amt from
(select a. *, b.price from sales a inner join product b on a.product_id=b.product_id) c
group by userid,product_id)d)e)f group by product_id)f)g where rnk=1;


--10. In the first one year after a customer joins the gold program including their joint date irrespective 
--of what the customer have purchased for every 10 ruppees Send 
--who are more one or 3 and what was their point earning in their first year 
--1zp = 2rs
--0.5zp = 1rs

select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a inner join 
goldusers_signup b on a.userid=b.userid and created_date >= gold_signup_date;

select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a inner join 
goldusers_signup b on a.userid=b.userid and created_date >= gold_signup_date and created_date <= DATEADD(year, 1, gold_signup_date);

select c. *, d.price from
(select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a inner join 
goldusers_signup b on a.userid=b.userid and created_date >= gold_signup_date and created_date <= DATEADD(year, 1, gold_signup_date))c 
inner join product d on c.product_id=d.product_id;

select c. *, d.price*0.5 total_points_earned from
(select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a inner join 
goldusers_signup b on a.userid=b.userid and created_date >= gold_signup_date and created_date <= DATEADD(year, 1, gold_signup_date))c 
inner join product d on c.product_id=d.product_id;

--11. rank on tranction of the customers

select *, rank() over(partition by userid order by created_date) rnk from sales;

-- rnk all the transaction for each member whenever they are a zomato gold member for every non gold member transaction  mark as na

select * from sales;

select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a left join
goldusers_signup b on a.userid = b.userid and created_date >= gold_signup_date;


select c. *, rank() over (partition by userid order by gold_signup_date desc) rnk from
(select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a left join
goldusers_signup b on a.userid = b.userid and created_date >= gold_signup_date)c;


select c.*, case when gold_signup_date is null then 0 else rank() over (partition by userid order by gold_signup_date desc) end as rnk from
(select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a left join
goldusers_signup b on a.userid = b.userid and created_date >= gold_signup_date)c;

select e.  *, case when rnk=0 then 'na' else rnk end as rnkk from
(select c.*, cast((case when gold_signup_date is null then 0 else rank() over (partition by userid order by gold_signup_date desc) end)as varchar) as rnk from
(select a.userid, a.created_date, a.product_id, b.gold_signup_date from sales a left join
goldusers_signup b on a.userid = b.userid and created_date >= gold_signup_date)c)e;



-- Average Transaction Amount by Customer:
SELECT userid, AVG(price) AS avg_transaction_amount
FROM sales
JOIN product ON sales.product_id = product.product_id
GROUP BY userid;


-- Total Revenue and Expenses:
SELECT SUM(price) AS total_revenue
FROM sales
JOIN product ON sales.product_id = product.product_id;

SELECT SUM(price) AS total_expenses
FROM product;


-- Top Selling Products:
SELECT product_id, product_name, COUNT(product_id) AS total_sold
FROM sales
JOIN product ON sales.product_id = product.product_id
GROUP BY product_id, product_name
ORDER BY total_sold DESC;




-- Customer Conversion Rate (Gold Signup):
SELECT COUNT(DISTINCT userid) AS total_customers,
       COUNT(DISTINCT CASE WHEN gold_signup_date IS NOT NULL THEN userid END) AS gold_customers,
       (COUNT(DISTINCT CASE WHEN gold_signup_date IS NOT NULL THEN userid END) * 100.0 / COUNT(DISTINCT userid)) AS conversion_rate
FROM users
LEFT JOIN goldusers_signup ON users.userid = goldusers_signup.userid;

-- Customer Conversion Rate (Gold Signup):
SELECT COUNT(DISTINCT u.userid) AS total_customers,
       COUNT(DISTINCT CASE WHEN g.gold_signup_date IS NOT NULL THEN u.userid END) AS gold_customers,
       (COUNT(DISTINCT CASE WHEN g.gold_signup_date IS NOT NULL THEN u.userid END) * 100.0 / COUNT(DISTINCT u.userid)) AS conversion_rate
FROM users u
LEFT JOIN goldusers_signup g ON u.userid = g.userid;


-- Loyal Customers (Frequent Buyers):
SELECT userid, COUNT(userid) AS total_transactions
FROM sales
GROUP BY userid
HAVING COUNT(userid) >= 5;


-- Inactive Customers (No Purchases):
SELECT users.userid, users.signup_date
FROM users
LEFT JOIN sales ON users.userid = sales.userid
WHERE sales.userid IS NULL;



-- Average Points Earned by Product:
SELECT product_id, AVG(price / points) AS avg_points_earned
FROM product
GROUP BY product_id;


-- Average Points Earned by Product:
SELECT product_id, AVG(price / 
  CASE
    WHEN product_id = 1 THEN 5
    WHEN product_id = 2 THEN 2
    WHEN product_id = 3 THEN 5
    ELSE 0
  END
) AS avg_points_earned
FROM product
GROUP BY product_id;


-- Top Earning Customers (Points):
SELECT userid, SUM(price / points) AS total_points_earned
FROM sales
JOIN product ON sales.product_id = product.product_id
GROUP BY userid
ORDER BY total_points_earned DESC;


-- Top Earning Customers (Points):
SELECT s.userid, SUM(p.price / 
  CASE
    WHEN p.product_id = 1 THEN 5
    WHEN p.product_id = 2 THEN 2
    WHEN p.product_id = 3 THEN 5
    ELSE 0
  END
) AS total_points_earned
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.userid
ORDER BY total_points_earned DESC;


-- Total Orders andRevenue by Month:
SELECT EXTRACT(MONTH FROM created_date) AS month,
       COUNT(userid) AS total_orders,
       SUM(price) AS total_revenue
FROM sales
JOIN product ON sales.product_id = product.product_id
GROUP BY month;

-- Total Orders andRevenue by Month:
SELECT MONTH(created_date) AS month,
       COUNT(userid) AS total_orders,
       SUM(price) AS total_revenue
FROM sales
JOIN product ON sales.product_id = product.product_id
GROUP BY MONTH(created_date)
ORDER BY month;
-- 


