/*B. Runner and Customer Experience */

-- 1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT
  week(registration_date) AS weekday,
  COUNT(runner_id) AS no_of_runners_registered
FROM runners
GROUP BY week(registration_date);

-- 2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order

WITH avg_time
AS (SELECT
  run.runner_id,
  cust.order_id,
  cust.order_time,
  run.pickup_time,
  TIMESTAMPDIFF(minute, cust.order_time, run.pickup_time) AS minutes_to_pickup
FROM customer_orders_new cust
LEFT JOIN runner_orders_new run
  ON cust.order_id = run.order_id
WHERE run.pickup_time IS NOT NULL
GROUP BY cust.order_id)
SELECT
  runner_id,
  ROUND(AVG(minutes_to_pickup), 2)
FROM avg_time
GROUP BY runner_id;

-- 3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

WITH avg_time
AS (SELECT
  run.runner_id,
  cust.order_id,
  COUNT(cust.pizza_id) AS no_of_pizza,
  cust.order_time,
  run.pickup_time,
  TIMESTAMPDIFF(minute, cust.order_time, run.pickup_time) AS minutes_to_pickup
FROM customer_orders_new cust
LEFT JOIN runner_orders_new run
  ON cust.order_id = run.order_id
WHERE run.pickup_time IS NOT NULL
GROUP BY cust.order_id)
SELECT
  no_of_pizza,
  ROUND(AVG(minutes_to_pickup), 2)
FROM avg_time
GROUP BY no_of_pizza;

-- 4. What was the average distance travelled for each customer?
SELECT
  cust.customer_id,
  ROUND(AVG(run.distance), 2)
FROM runner_orders_new run
LEFT JOIN customer_orders_new cust
  ON run.order_id = cust.order_id
WHERE run.pickup_time IS NOT NULL
GROUP BY cust.customer_id
ORDER BY cust.customer_id;

-- 5. What was the difference between the longest and shortest delivery times for all orders?
WITH time_diff
AS (SELECT
  order_id,
  duration
FROM runner_orders_new
WHERE pickup_time IS NOT NULL
GROUP BY order_id)
SELECT
  MAX(duration) - MIN(duration) AS delivery_time_diff
FROM time_diff;

-- 6. What was the average speed for each runner for each delivery and do you notice any trend for these values

SELECT
  runner_id,
  order_id,
  ROUND(AVG(distance / (duration / 60)), 2) AS 'avg_speed_in_km/hr'
FROM runner_orders_new
WHERE pickup_time IS NOT NULL
GROUP BY runner_id,
         order_id;


-- 7. What is the successful delivery percentage for each runner?
WITH delivery
AS (SELECT
  runner_id,
  order_id,
  cancellation,
  CASE
    WHEN (cancellation IS NULL OR
      cancellation = '') THEN 0
    ELSE 1
  END AS flag
FROM runner_orders_new)
SELECT
  runner_id,
  COUNT(flag) AS total_delivery,
  COUNT(CASE
    WHEN flag = 1 THEN 1
  END) AS cancelled,
  COUNT(CASE
    WHEN flag = 0 THEN 0
  END) AS successfully_delivered,
  ROUND(COUNT(CASE
    WHEN flag = 0 THEN 0
  END) / COUNT(flag) * 100, 0) AS 'successful_delivery_%'
FROM delivery
GROUP BY runner_id;