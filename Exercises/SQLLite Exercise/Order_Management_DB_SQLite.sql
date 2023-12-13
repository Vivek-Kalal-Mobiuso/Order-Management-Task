/* 1. Write a query to Display the product details (product_class_code, product_id, product_desc, product_price,) as per the following criteria 
 and sort them in descending order of category: a. If the category is 2050, increase the price by 2000 b. If the category is 2051, increase the 
 price by 500 c. If the category is 2052, increase the price by 600. Hint: Use case statement. no permanent change in table required. (60 ROWS) [NOTE: PRODUCT TABLE] */
 
SELECT PRODUCT_CLASS_CODE , PRODUCT_ID , PRODUCT_DESC , PRODUCT_PRICE ,
CASE 
	WHEN PRODUCT_CLASS_CODE = 2050 THEN PRODUCT_PRICE + 2000
	WHEN PRODUCT_CLASS_CODE = 2051 THEN PRODUCT_PRICE + 500
	WHEN PRODUCT_CLASS_CODE = 2052 THEN PRODUCT_PRICE + 600
	ELSE PRODUCT_PRICE
	END PRODUCT
FROM PRODUCT ;

/*	2. Write a query to display (product_class_desc, product_id, product_desc, product_quantity_avail ) and Show inventory status of products 
as below as per their available quantity: a. For Electronics and Computer categories, if available quantity is <= 10, show 'Low stock', 
11 <= qty <= 30, show 'In stock', >= 31, show 'Enough stock' b. For Stationery and Clothes categories, if qty <= 20, show 'Low stock', 
21 <= qty <= 80, show 'In stock', >= 81, show 'Enough stock' c. Rest of the categories, if qty <= 15 – 'Low Stock', 16 <= qty <= 50 – 'In Stock',
 >= 51 – 'Enough stock' For all categories, if available quantity is 0, show 'Out of stock'. Hint: Use case statement. (60 ROWS) 
 [NOTE: TABLES TO BE USED – product, product_class]*/

SELECT PRODUCT_CLASS_DESC , PRODUCT_ID , PRODUCT_DESC , PRODUCT_QUANTITY_AVAIL ,
	CASE 
		WHEN PRODUCT_QUANTITY_AVAIL = 0 THEN "OUT OF STOCK"
		WHEN PRODUCT_CLASS_DESC = 'Electronics' OR PRODUCT_CLASS_DESC = 'Computer'
		THEN 
			CASE
-- 			WHEN PRODUCT_QUANTITY_AVAIL = 0 THEN "OUT OF STOCK"
			WHEN PRODUCT_QUANTITY_AVAIL <= 10 THEN "LOW STOCK"
			WHEN PRODUCT_QUANTITY_AVAIL >= 11 AND PRODUCT_QUANTITY_AVAIL <= 30 THEN "IN STOCK"
			ELSE "ENOUGH STOCK"
			END
		WHEN PRODUCT_CLASS_DESC = 'Stationery' OR PRODUCT_CLASS_DESC = 'Clothes'
		THEN 
			CASE
-- 			WHEN PRODUCT_QUANTITY_AVAIL = 0 THEN "OUT OF STOCK"
			WHEN PRODUCT_QUANTITY_AVAIL <= 20 THEN "LOW STOCK"
			WHEN PRODUCT_QUANTITY_AVAIL >= 21 AND PRODUCT_QUANTITY_AVAIL <= 80 THEN "IN STOCK"
			ELSE "ENOUGH STOCK"
			END
		ELSE
			CASE
-- 			WHEN PRODUCT_QUANTITY_AVAIL = 0 THEN "OUT OF STOCK"
			WHEN PRODUCT_QUANTITY_AVAIL <= 15 THEN "LOW STOCK"
			WHEN PRODUCT_QUANTITY_AVAIL >= 16 AND PRODUCT_QUANTITY_AVAIL <= 50 THEN "IN STOCK"
			ELSE "ENOUGH STOCK"
			END
		END STATUS
	FROM PRODUCT
	JOIN PRODUCT_CLASS
	ON PRODUCT.PRODUCT_CLASS_CODE = PRODUCT_CLASS.PRODUCT_CLASS_CODE;
	

/*	3. Write a query to Show the count of cities in all countries other than USA & MALAYSIA, with more than 1 city, in the 
descending order of CITIES. (2 rows) [NOTE: ADDRESS TABLE, Do not use Distinct] */
SELECT COUNTRY , COUNT(CITY) AS CITY_COUNT 
FROM ADDRESS
WHERE COUNTRY NOT IN ('USA' , 'Malaysia')
GROUP BY COUNTRY
HAVING CITY_COUNT > 1;

/* 4. Write a query to display the customer_id,customer full name ,city,pincode,and order details (order id, product class desc, 
product desc, subtotal(product_quantity * product_price)) for orders shipped to cities whose pin codes do not have any 0s 
in them. Sort the output on customer name and subtotal. (52 ROWS) [NOTE: TABLE TO BE USED - online_customer, address, 
order_header, order_items, product, product_class] */

SELECT OC.CUSTOMER_ID,OC.CUSTOMER_FNAME || " " || OC.CUSTOMER_LNAME AS CUSTOMER_FULLNAME, A.CITY , OI.ORDER_ID , 
PC.PRODUCT_CLASS_DESC , P.PRODUCT_DESC ,OI.PRODUCT_QUANTITY * P.PRODUCT_PRICE AS SUBTOTAL , A.PINCODE FROM ONLINE_CUSTOMER OC
JOIN ADDRESS A ON A.ADDRESS_ID = OC.ADDRESS_ID
JOIN ORDER_HEADER OH ON OH.CUSTOMER_ID = OC.CUSTOMER_ID
JOIN ORDER_ITEMS OI ON OI.ORDER_ID = OH.ORDER_ID
JOIN PRODUCT P ON P.PRODUCT_ID = OI.PRODUCT_ID
JOIN PRODUCT_CLASS PC ON PC.PRODUCT_CLASS_CODE = P.PRODUCT_CLASS_CODE
WHERE A.PINCODE NOT LIKE '%0%' AND OH.ORDER_STATUS = 'Shipped';

/* 5. Write a Query to display product id,product description,totalquantity(sum(product quantity) for an item which has 
been bought maximum no. of times (Quantity Wise) along with product id 201. (USE SUB-QUERY) (1 ROW) 
[NOTE: ORDER_ITEMS TABLE, PRODUCT TABLE] */

SELECT PRODUCT.PRODUCT_ID, PRODUCT_DESC , SUM(ORDER_ITEMS.PRODUCT_QUANTITY) AS TOTAL_QUANTITY 
FROM PRODUCT
JOIN ORDER_ITEMS
ON ORDER_ITEMS.PRODUCT_ID = PRODUCT.PRODUCT_ID
WHERE ORDER_ITEMS.PRODUCT_ID = '201'
GROUP BY ORDER_ITEMS.PRODUCT_ID
ORDER BY TOTAL_QUANTITY DESC 
LIMIT 1;

/*6. Write a query to display the customer_id,customer name, email and order details (order id, product desc,product qty, 
subtotal(product_quantity * product_price)) for all customers even if they have not ordered any item.(225 ROWS) 
[NOTE: TABLE TO BE USED - online_customer, order_header, order_items, product]*/
SELECT OC.CUSTOMER_ID , OC.CUSTOMER_FNAME || " " || OC.CUSTOMER_LNAME AS CUSTOMER_FULLNAME , OC.CUSTOMER_EMAIL , OI.ORDER_ID , P.PRODUCT_DESC 
, OI.PRODUCT_QUANTITY, OI.PRODUCT_QUANTITY * P.PRODUCT_PRICE AS SUBTOTAL 
FROM ONLINE_CUSTOMER OC
LEFT JOIN ORDER_HEADER OH ON OH.CUSTOMER_ID = OC.CUSTOMER_ID
LEFT JOIN ORDER_ITEMS OI ON OI.ORDER_ID = OH.ORDER_ID
LEFT JOIN PRODUCT P ON P.PRODUCT_ID = OI.PRODUCT_ID;
