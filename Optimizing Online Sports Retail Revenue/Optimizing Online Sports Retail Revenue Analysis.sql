/* 1. Count the total number of products, along with the number of non-missing values in description, listing_price, and last_visited. */

SELECT Count(*)               AS total_rows,
       Count(i.description)   AS count_description,
       Count(f.listing_price) AS count_listing_price,
       Count(t.last_visited)  AS count_last_visited
FROM   info i
       INNER JOIN finance f
               ON i.product_id = f.product_id
       INNER JOIN traffic t
               ON i.product_id = t.product_id; 
               
/* 2. Find out how listing_price varies between Adidas and Nike products. */

SELECT b.brand,
       f.listing_price :: NUMERIC :: INTEGER,
       COUNT(f.*)
FROM   brands b
      INNER JOIN finance f
               ON b.product_id = f.product_id
WHERE  f.listing_price > 0
GROUP  BY b.brand,
          f.listing_price
ORDER  BY f.listing_price DESC; 


/* 3. Create labels for products grouped by price range and brand. */

SELECT b.brand,
       COUNT(f.product_id),
       SUM(f.revenue) AS total_revenue,
       CASE
         WHEN f.listing_price < 42 THEN 'Budget'
         WHEN f.listing_price >= 42
              AND f.listing_price < 74 THEN 'Average'
         WHEN f.listing_price >= 74
              AND f.listing_price < 129 THEN 'Expensive'
         WHEN f.listing_price >= 129 THEN 'Elite'
       END            AS price_category
FROM   brands b
       INNER JOIN finance f
               ON b.product_id = f.product_id
WHERE  b.brand IS NOT NULL
GROUP  BY b.brand,
          price_category
ORDER  BY total_revenue DESC; 

/* 4. Calculate the average discount offered by brand.*/

SELECT b.brand,
       AVG(f.discount) * 100 AS average_discount
FROM   brands b
       INNER JOIN finance f
               ON b.product_id = f.product_id
GROUP  BY b.brand
HAVING b.brand IS NOT NULL
ORDER  BY average_discount; 

/* 5. Calculate the correlation between reviews and revenue. */

SELECT CORR(r.reviews, f.revenue) AS review_revenue_corr
FROM   reviews r
       INNER JOIN finance f
               ON r.product_id = f.product_id; 
               
/* 6. Split description into bins in increments of one hundred characters, and calculate average rating by for each bin. */

SELECT TRUNC(LENGTH(i.description), -2)              AS description_length,
       ROUND(AVG(r.rating :: NUMERIC), 2) :: NUMERIC AS average_rating
FROM   info i
       INNER JOIN reviews r
               ON i.product_id = r.product_id
WHERE  i.description IS NOT NULL
GROUP  BY description_length
ORDER  BY description_length; 


/* 7. Count the number of reviews per brand per month. */

SELECT b.brand,
       EXTRACT(month FROM t.last_visited) AS month,
       COUNT(r.product_id)                AS num_reviews
FROM   traffic t
       INNER JOIN reviews r
               ON t.product_id = r.product_id
       INNER JOIN brands b
               ON b.product_id = t.product_id
GROUP  BY b.brand,
          month
HAVING b.brand IS NOT NULL
       AND EXTRACT(month FROM t.last_visited) IS NOT NULL
ORDER  BY b.brand,
          month; 
          
/* 8. Create the footwear CTE, then calculate the number of products and average revenue from these items. */

WITH footwear
AS
  (
             SELECT     i.description,
                        f.revenue
             FROM       info i
             INNER JOIN finance f
             ON         i.product_id = f.product_id
             WHERE      i.description ilike '%shoe%'
             OR         i.description ilike '%trainer%'
             OR         i.description ilike '%foot%'
             AND        i.description IS NOT NULL)
  SELECT   count(*)                                             AS num_footwear_products,
           percentile_disc(0.5) within GROUP (ORDER BY revenue) AS median_footwear_revenue
  FROM     footwear;
  
/* 9. Copy the code used to create footwear then use a filter to return only products that are not in the CTE. */

WITH footwear
AS
  (
             SELECT     i.description,
                        f.revenue
             FROM       info i
             INNER JOIN finance f
             ON         i.product_id = f.product_id
             WHERE      i.description ilike '%shoe%'
             OR         i.description ilike '%trainer%'
             OR         i.description ilike '%foot%'
             AND        i.description IS NOT NULL)
  SELECT     count(i.*)                                             AS num_clothing_products,
             percentile_disc(0.5) within GROUP (ORDER BY f.revenue) AS median_clothing_revenue
  FROM       info i
  INNER JOIN finance f
  ON         i.product_id = f.product_id
  WHERE      i.description NOT IN
             (
                    SELECT description
                    FROM   footwear);