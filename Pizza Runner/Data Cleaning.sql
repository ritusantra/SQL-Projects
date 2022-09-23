/* Data Cleaning */ 

-- customer_orders table, runners_order
SELECT
  *
FROM customer_orders;
SELECT
  *
FROM customer_orders_new;

-- replacing 'null' string with null
UPDATE customer_orders_new
SET exclusions = REPLACE(exclusions, 'null', NULL)
WHERE exclusions = 'null';

UPDATE customer_orders_new
SET extras = REPLACE(extras, 'null', NULL)
WHERE extras = 'null';

SELECT *
FROM runner_orders;

SELECT *
FROM runner_orders_new;

-- replacing 'null' string with null
UPDATE runner_orders_new
SET pickup_time =
                 CASE pickup_time
                   WHEN 'null' THEN NULL
                   ELSE pickup_time
                 END,
    distance =
              CASE distance
                WHEN 'null' THEN NULL
                ELSE distance
              END,
    duration =
              CASE duration
                WHEN 'null' THEN NULL
                ELSE duration
              END,
    cancellation =
                  CASE cancellation
                    WHEN 'null' THEN NULL
                    ELSE cancellation
                  END;

-- removing 'km' and 'minutes'

UPDATE runner_orders_new
SET    distance = CASE
                    WHEN distance LIKE '%km%' THEN Trim('km' FROM distance)
                    ELSE distance
                  END,
       duration = CASE
                    WHEN duration LIKE '%minutes%' THEN Trim(
                    'minutes' FROM duration)
                    ELSE duration
                  END,
       duration = CASE
                    WHEN duration LIKE '%mins%' THEN Trim('mins' FROM duration)
                    ELSE duration
                  END,
       duration = CASE
                    WHEN duration LIKE '%minute%' THEN Trim(
                    'minute' FROM duration)
                    ELSE duration
                  END; 

-- alter the datatypes

ALTER TABLE runner_orders_new
  modify duration INTEGER;

ALTER TABLE runner_orders_new
  modify distance DECIMAL(5, 3);

ALTER TABLE runner_orders_new
  modify pickup_time TIMESTAMP;
