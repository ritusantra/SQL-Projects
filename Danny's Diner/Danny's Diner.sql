-- 1. What is the total amount each customer spent at the restaurant?

select s.customer_id, sum(m.price) as 'Total Amount'
from sales s
left join menu m
on s.product_id = m.product_id
group by s.customer_id;

-- 2. How many days has each customer visited the restaurant?

select customer_id, count(distinct order_date) as '# of days visited'
from sales
group by customer_id;


-- 3. What was the first item from the menu purchased by each customer?

select s.customer_id, min(s.order_date) as 'Order Date', 
m.product_name as 'First Item Purchased'
from sales s
left join menu m
on m.product_id = s.product_id
group by s.customer_id;


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

select * from (select m.product_name as 'Most Purchased Item',
count(*) as '# of Times Purchased',
dense_rank() over(order by count(*) desc) as rnk 
from sales s
left join menu m
on s.product_id = m.product_id
group by m.product_name) t
where rnk = 1;

-- 5. Which item was the most popular for each customer?

-- solution 1
with 
cte as (select customer_id, product_id, count(product_id) as cnt
from sales group by customer_id, product_id),
cte_rnk as (select customer_id, product_id, cnt, rank() over(partition by customer_id
order by cnt desc) as rnk from cte )
select c.customer_id, c.product_id, m.product_name, c.cnt from cte_rnk c
left join menu m
on c.product_id = m.product_id
where c.rnk = 1
group by c.customer_id,m.product_id;

-- solution 2
with cte as
(select s.customer_id, m.product_name, count(m.product_name) as cnt,
dense_rank() over(partition by customer_id order by count(m.product_name)) as rnk
from sales s
left join menu m
on s.product_id = m.product_id
group by s.customer_id, m.product_name)
select * from cte where rnk = 1;

-- 6. Which item was purchased first by the customer after they became a member?

with cte as(select s.customer_id, s.product_id, s.order_date, m.join_date,
dense_rank() over(partition by s.customer_id order by s.order_date) as rnk
from sales s
inner join members m
on s.customer_id = m.customer_id
and s.order_date >= m.join_date)
select cte.customer_id, cte.order_date, menu.product_name
from cte 
inner join menu
on cte.product_id = menu.product_id
where rnk = 1;

-- 7. Which item was purchased just before the customer became a member?

-- solution 1
with cte as(select s.customer_id, s.order_date, s.product_id, m.join_date
from sales s 
inner join members m
on s.customer_id = m.customer_id
where s.order_date < m.join_date)
select cte.customer_id, cte.order_date, cte.join_date, menu.product_name
from cte
inner join menu
on cte.product_id = menu.product_id
order by 1;

-- solution 2
with cte as(select s.customer_id, s.order_date, s.product_id, m.join_date,
dense_rank() over(partition by s.customer_id order by s.order_date) as rnk from sales s 
inner join members m
on s.customer_id = m.customer_id
where s.order_date < m.join_date)
select cte.customer_id, cte.order_date, cte.join_date, menu.product_name
from cte
inner join menu
on cte.product_id = menu.product_id
order by 1;

-- 8. What is the total items and amount spent for each member before they became a member?

with cte as 
(select s.customer_id, s.order_date, sum(menu.price) as 'Amount', 
count(s.product_id) as 'Itemcount'
from sales s
inner join menu
on s.product_id = menu.product_id
group by s.customer_id, s.product_id, s.order_date)
select cte.customer_id, sum(cte.Amount) as 'Total Amount', 
count(cte.Itemcount) as 'Total Items' from cte 
inner join members m 
on cte.customer_id = m.customer_id
where cte.order_date < m.join_date
group by cte.customer_id;

/* 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - 
how many points would each customer have?*/

with cte as(select *, 
case
	when product_name = 'sushi' then price*10*2 
	else price*10
end points 
from menu)
select s.customer_id, sum(cte.points) as 'Total points' from cte
inner join sales s
on s.product_id = cte.product_id
group by s.customer_id;


/* 10. In the first week after a customer joins the program (including their join date) 
they earn 2x points on all items, not just sushi - 
how many points do customer A and B have at the end of January?*/


with cte as
(select m.customer_id, m.join_date, 
date_add(m.join_date, interval 6 day) as valid_date,
last_day('2021-01-01') as last_date from members m)
select *,
 sum(case
  when m.product_name = 'sushi' then 2 * 10 * m.price
  when s.order_date between cte.join_date and cte.valid_date then 2 * 10 * m.price
  else 10 * m.price
  end) as points
from cte
inner join sales as s
 on cte.customer_id = s.customer_id
inner join menu as m
 on s.product_id = m.product_id
where s.order_date < cte.last_date
group by cte.customer_id, s.order_date, cte.join_date, cte.valid_date, cte.last_date, m.product_name, m.price;

-- Bonus 1

select s.customer_id,s.order_date,	m.product_name,	m.price,
case
	when s.order_date >= me.join_date then 'Y'
    else 'N'
end as member
from sales s
left join menu m
on s.product_id = m.product_id
left join members me
on s.customer_id  = me.customer_id;

-- Bonus 2

with cte as (select s.customer_id,s.order_date,	m.product_name,	m.price,
case
	when s.order_date >= me.join_date then 'Y'
    else 'N'
end as member
from sales s
left join menu m
on s.product_id = m.product_id
left join members me
on s.customer_id  = me.customer_id)
select *, case
	when member = 'Y' then dense_rank() over(partition by s.customer_id,cte.member order by s.order_date)
    else null
end as ranking
from cte
order by 1,2;
