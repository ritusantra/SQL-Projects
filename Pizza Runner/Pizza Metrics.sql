/* A. Pizza Metrics */

-- 1. How many pizzas were ordered?
SELECT
  COUNT(pizza_id) AS total_pizza_ordered
FROM customer_orders_new;

-- 2. How many unique customer orders were made?
SELECT
  COUNT(DISTINCT order_id) AS unique_customer_orders
FROM customer_orders_new;


-- 3. How many successful orders were delivered by each runner?
SELECT
  runner_id,
  COUNT(order_id) AS orders_delivered
FROM runner_orders_new
WHERE pickup_time IS NOT NULL
GROUP BY runner_id;


-- 4. How many of each type of pizza was delivered?
SELECT
  pname.pizza_name,
  COUNT(pname.pizza_id) AS no_of_pizzas
FROM runner_orders_new run
LEFT JOIN customer_orders_new cust
  ON run.order_id = cust.order_id
LEFT JOIN pizza_names pname
  ON cust.pizza_id = pname.pizza_id
WHERE run.pickup_time IS NOT NULL
GROUP BY pname.pizza_id;


-- 5. How many Vegetarian and Meatlovers were ordered by each customer?
SELECT
  cust.customer_id,
  pname.pizza_name,
  COUNT(order_id) AS no_of_pizzas
FROM customer_orders_new cust
LEFT JOIN pizza_names pname
  ON cust.pizza_id = pname.pizza_id
GROUP BY cust.customer_id,
         pname.pizza_id
ORDER BY cust.customer_id;

-- 6. What was the maximum number of pizzas delivered in a single order?
WITH max_no_of_pizza
AS (SELECT
  run.order_id,
  COUNT(cust.pizza_id) AS total_pizzas_delivered,
  DENSE_RANK() OVER (ORDER BY COUNT(cust.pizza_id) DESC) AS rnk
FROM runner_orders_new run
LEFT JOIN customer_orders_new cust
  ON run.order_id = cust.order_id
WHERE run.pickup_time IS NOT NULL
GROUP BY run.order_id)
SELECT
  order_id,
  MAX(total_pizzas_delivered) AS max_no_of_pizza_delivered
FROM max_no_of_pizza
WHERE rnk = 1;

-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT
  cust.customer_id,
  SUM(CASE
    WHEN (cust.exclusions IS NOT NULL AND
      cust.exclusions <> '') OR
      (cust.extras IS NOT NULL AND
      cust.extras <> '') THEN 1
    ELSE 0
  END) AS atleast_one_change,
  SUM(CASE
    WHEN (cust.exclusions IS NULL OR
      cust.exclusions = '') AND
      (cust.extras IS NULL OR
      cust.extras = '') THEN 1
    ELSE 0
  END) AS no_change
FROM runner_orders_new run
LEFT JOIN customer_orders_new cust
  ON run.order_id = cust.order_id
WHERE run.pickup_time IS NOT NULL
GROUP BY cust.customer_id
ORDER BY cust.customer_id;

-- 8. How many pizzas were delivered that had both exclusions and extras?
SELECT
  run.order_id,
  cust.customer_id,
  cust.pizza_id
FROM runner_orders_new run
LEFT JOIN customer_orders_new cust
  ON run.order_id = cust.order_id
WHERE run.pickup_time IS NOT NULL
AND cust.exclusions IS NOT NULL
AND cust.extras IS NOT NULL
AND cust.exclusions <> ''
AND cust.extras <> '';

SELECT
  cust.order_id,
  cust.customer_id,
  SUM(CASE
    WHEN ((cust.exclusions IS NOT NULL AND
      cust.exclusions <> '') AND
      (cust.extras IS NOT NULL AND
      cust.extras <> '')) THEN 1
    ELSE 0
  END) AS 'exclusions + extras'
FROM runner_orders_new run
LEFT JOIN customer_orders_new cust
  ON run.order_id = cust.order_id
WHERE run.pickup_time IS NOT NULL
GROUP BY cust.order_id
ORDER BY 'exclusions + extras' DESC;

-- 9. What was the total volume of pizzas ordered for each hour of the day?
SELECT
  HOUR(order_time) AS 'Hour',
  COUNT(order_id) AS total_volume_of_pizza
FROM customer_orders_new
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);

-- 10. What was the volume of orders for each day of the week?
SELECT
  DAYNAME(order_time) AS 'Day',
  COUNT(order_id) AS volumn_of_orders
FROM customer_orders_new
GROUP BY DAYNAME(order_time);