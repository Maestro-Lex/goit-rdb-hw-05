USE hw_3;

-- 1 --

SELECT
	*,
	(
    SELECT orders.customer_id
    FROM orders
    WHERE orders.id = order_details.order_id
    ) AS customer_id
FROM order_details;

-- 2 --

SELECT *
FROM order_details
WHERE order_id IN (
				  SELECT id
                  FROM orders
                  WHERE shipper_id = 3
                  );

-- 3 --

SELECT order_id, AVG(quantity)
FROM (
	 SELECT *
     FROM order_details
     WHERE quantity > 10
	 ) AS new_od
GROUP BY order_id;

-- 4 --

SELECT @@version;
WITH temp AS (
			   SELECT *
			   FROM order_details
			   WHERE quantity > 10
			   )
SELECT order_id, AVG(quantity)
FROM temp
GROUP BY order_id;

-- 5 --

DROP FUNCTION IF EXISTS div_func;

DELIMITER //

CREATE FUNCTION div_func (
	arg_1 FLOAT,
    arg_2 FLOAT
) RETURNS FLOAT
NO SQL
DETERMINISTIC

BEGIN
	DECLARE result FLOAT;
    SET result = arg_1 / arg_2;
RETURN result;
END

//
DELIMITER ;

SELECT quantity, div_func(quantity, 3)
FROM order_details;