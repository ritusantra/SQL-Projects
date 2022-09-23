/* C. Ingredient Optimisation */

/* 1. What are the standard ingredients for each pizza?
Recreating pizza recipe table such that each row has pizza id and topping*/

CREATE TABLE pizza_recipes_new (
  pizza_id integer,
  toppings integer
);
INSERT INTO pizza_recipes_new (pizza_id, toppings)
  VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6)
  , (1, 7), (1, 8), (1, 9), (1, 10),
  (2, 4), (2, 6), (2, 7), (2, 9), (2, 11), (2, 12);

SELECT
  *
FROM pizza_recipes_new;

WITH cte
AS (SELECT
  n.pizza_id,
  n.pizza_name,
  t.topping_name
FROM pizza_names n
LEFT JOIN pizza_recipes_new r
  ON n.pizza_id = r.pizza_id
LEFT JOIN pizza_toppings t
  ON r.toppings = t.topping_id
ORDER BY n.pizza_id)
SELECT
  pizza_name,
  group_concat(topping_name) AS standard_ingredients
FROM cte
GROUP BY pizza_name;

-- 2. What was the most commonly added extra?

SELECT
  extras,
  COUNT(*)
FROM customer_orders_new
GROUP BY extras;

-- 3. What was the most common exclusion?

SELECT
  exclusions,
  COUNT(*)
FROM customer_orders_new
GROUP BY exclusions;

/* 4. Generate an order item for each record in the customers_orders table in the format of one of the following:
-- Meat Lovers
-- Meat Lovers - Exclude Beef
-- Meat Lovers - Extra Bacon
-- Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers */

SELECT
  *
FROM customer_orders_new;
SELECT
  cust.order_id,
  cust.customer_id,
  pname.pizza_name,
  toppng.topping_name
FROM customer_orders_new cust
LEFT JOIN pizza_names pname
  ON cust.pizza_id = pname.pizza_id
LEFT JOIN pizza_recipes_new recipe
  ON pname.pizza_id = recipe.pizza_id
LEFT JOIN pizza_toppings toppng
  ON recipe.toppings = toppng.topping_id;

-- 5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
-- For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"


SELECT
  cust.order_id,
  cust.customer_id,
  cust.pizza_id,
  group_concat(topping.topping_name) AS Ingredients
FROM customer_orders_new cust
INNER JOIN pizza_recipes_new recipe
  ON cust.pizza_id = recipe.pizza_id
INNER JOIN pizza_toppings topping
  ON topping.topping_id = recipe.toppings
GROUP BY cust.order_id,
         cust.customer_id,
         cust.pizza_id;

-- 6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?


SELECT
  pnames.pizza_name,
  COUNT(recipes.toppings) AS Count_of_Ingredients
FROM pizza_names pnames
INNER JOIN pizza_recipes_new recipes
  ON pnames.pizza_id = recipes.pizza_id
GROUP BY pnames.pizza_name;