/* D. Pricing and Ratings */

/* 1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - 
how much money has Pizza Runner made so far if there are no delivery fees? */

SELECT
  runner.runner_id,
  SUM(CASE
    WHEN pname.pizza_name LIKE '%meat%' THEN 12
    WHEN pname.pizza_name LIKE '%veg%' THEN 10
  END) AS pizzas_cost
FROM runner_orders_new runner
LEFT JOIN customer_orders_new cust
  ON runner.order_id = cust.order_id
LEFT JOIN pizza_names pname
  ON pname.pizza_id = cust.pizza_id
WHERE runner.pickup_time IS NOT NULL
GROUP BY runner.runner_id;


/* 2. What if there was an additional $1 charge for any pizza extras?
  - Add cheese is $1 extra */

SELECT
  runner.runner_id,
  SUM(CASE
    WHEN pname.pizza_name LIKE '%meat%' THEN 12
    WHEN pname.pizza_name LIKE '%veg%' THEN 10
  END) AS pizzas_cost,
  SUM(CASE WHEN top.topping_name IS NOT NULL THEN 1 END) AS extras_cost
FROM runner_orders_new runner
LEFT JOIN customer_orders_new cust
  ON runner.order_id = cust.order_id
LEFT JOIN pizza_recipes_new recipe
  ON cust.extras = recipe.toppings
LEFT JOIN pizza_toppings top
  ON top.topping_id = cust.extras
LEFT JOIN pizza_names pname
  ON pname.pizza_id = cust.pizza_id
GROUP BY runner.runner_id;

/* 3. The Pizza Runner team now wants to add an additional ratings system that allows customers 
to rate their runner, how would you design an additional table for this new dataset - 
generate a schema for this new table and insert your own data for ratings for each successful 
customer order between 1 to 5. */

CREATE TABLE runner_ratings (
  order_id int,
  runner_rating int
);


INSERT INTO runner_ratings (order_id, runner_rating)
  VALUES (1, 3), (2, 4), (3, 4), (4, 5), (5, 3.5), (6, 0), (7, 3.5), (8, 3), (9, 0), (10, 3);

SELECT
  *
FROM runner_ratings;

/* 4. Using your newly generated table - can you join all of the information together 
to form a table which has the following information for successful deliveries?
customer_id
order_id
runner_id
rating
order_time
pickup_time
Time between order and pickup
Delivery duration
Average speed
Total number of pizzas */

SELECT
  cust.customer_id,
  cust.order_id,
  runner.runner_id,
  rating.runner_rating,
  cust.order_time,
  runner.pickup_time,
  timediff(runner.pickup_time, cust.order_time) AS 'Time between order and pickup',
  runner.duration,
  ROUND(AVG(runner.distance / (runner.duration / 60)), 2) AS 'avg_speed_in_km/hr',
  COUNT(cust.pizza_id) AS 'Total Pizza'
FROM customer_orders_new cust
INNER JOIN runner_orders_new runner
  ON cust.order_id = runner.order_id
INNER JOIN runner_ratings rating
  ON cust.order_id = rating.order_id
WHERE runner.pickup_time IS NOT NULL
GROUP BY cust.customer_id,
         cust.order_id,
         runner.runner_id,
         cust.order_time,
         runner.pickup_time;




/* 5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with 
no cost for extras and each runner is paid $0.30 per kilometre traveled - 
how much money does Pizza Runner have left over after these deliveries?*/


SELECT
  cust.order_id,
  runner.runner_id,
  SUM(CASE
    WHEN pname.pizza_name LIKE '%meat%' THEN 12
    WHEN pname.pizza_name LIKE '%veg%' THEN 10
  END) AS pizzas_cost,
  SUM(runner.distance) AS distance_travelled,
  CASE
    WHEN runner.distance IS NOT NULL THEN SUM(runner.distance) * 0.3
  END AS paid_to_runner
FROM runner_orders_new runner
LEFT JOIN customer_orders_new cust
  ON runner.order_id = cust.order_id
LEFT JOIN pizza_names pname
  ON pname.pizza_id = cust.pizza_id
WHERE runner.pickup_time IS NOT NULL
GROUP BY cust.order_id,
         runner.runner_id;

/* E. Bonus Questions */

/* If Danny wants to expand his range of pizzas - how would this impact the existing data design? 
Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with 
all the toppings was added to the Pizza Runner menu? */

INSERT INTO pizza_names (pizza_id, pizza_name)
  VALUES (3, 'Supreme Pizza');

INSERT INTO pizza_recipes (pizza_id, toppings)
  VALUES (3, '1,2,3,4,5,6,7,8,9,10,11,12');