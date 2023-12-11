/*7. Write a query to display carton id, (len*width*height) as carton_vol and identify the optimum carton (carton with the least volume 
whose volume is greater than the total volume of all items (len * width * height * product_quantity)) for a given order whose order id 
is 10006, Assume all items of an order are packed into one single carton (box). (1 ROW) [NOTE: CARTON TABLE] */

SELECT CARTON_ID , (LEN*WIDTH*HEIGHT) AS CARTON_VOL FROM CARTON
GROUP BY CARTON_VOL
HAVING CARTON_VOL > (SELECT SUM(P.LEN * P.WIDTH * P.HEIGHT * OI.PRODUCT_QUANTITY ) AS PRODUCT_VOL 
						FROM PRODUCT P
						JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID = P.PRODUCT_ID
						WHERE ORDER_ID = 10006
						GROUP BY OI.ORDER_ID)
ORDER BY CARTON_VOL ASC
LIMIT 1;

/*8. Write a query to display details (customer id,customer fullname,order id,product quantity) of customers who bought more than ten 
(i.e. total order qty) products per shipped order. (11 ROWS) [NOTE: TABLES TO BE USED - online_customer, order_header, order_items,]*/

SELECT OC.CUSTOMER_ID , OC.CUSTOMER_ID,OC.CUSTOMER_FNAME || " " || OC.CUSTOMER_LNAME AS CUSTOMER_FULLNAME, OH.ORDER_ID , SUM(OI.PRODUCT_QUANTITY) AS TOTAL_QTY
FROM ONLINE_CUSTOMER OC
JOIN ORDER_HEADER OH ON OH.CUSTOMER_ID = OC.CUSTOMER_ID
JOIN ORDER_ITEMS OI ON OI.ORDER_ID = OH.ORDER_ID
WHERE OH.ORDER_STATUS = 'Shipped'
GROUP BY OI.ORDER_ID
HAVING SUM(PRODUCT_QUANTITY) > 10;

/*9. Write a query to display the order_id, customer id and customer full name of customers along with (product_quantity) as total quantity 
of products shipped for order ids > 10060. (6 ROWS) [NOTE: TABLES TO BE USED - online_customer, order_header, order_items]*/

SELECT OH.ORDER_ID, OC.CUSTOMER_ID,OC.CUSTOMER_FNAME || " " || OC.CUSTOMER_LNAME AS CUSTOMER_FULLNAME, OH.ORDER_ID , 
SUM(OI.PRODUCT_QUANTITY) AS TOTAL_QTY , OH.ORDER_STATUS
FROM ONLINE_CUSTOMER OC
JOIN ORDER_HEADER OH ON OH.CUSTOMER_ID = OC.CUSTOMER_ID
JOIN ORDER_ITEMS OI ON OI.ORDER_ID = OH.ORDER_ID
WHERE OH.ORDER_STATUS = 'Shipped' 
GROUP BY OH.ORDER_ID
HAVING OH.ORDER_ID > 10060 ;

/*10. Write a query to display product class description ,total quantity (sum(product_quantity),Total value (product_quantity * product price) 
and show which class of products have been shipped highest(Quantity) to countries outside India other than USA? Also show the total value of 
those items. (1 ROWS)[NOTE:PRODUCT TABLE,ADDRESS TABLE,ONLINE_CUSTOMER TABLE,ORDER_HEADER TABLE,ORDER_ITEMS TABLE,PRODUCT_CLASS TABLE]*/

SELECT PC.PRODUCT_CLASS_DESC,
		SUM(OI.PRODUCT_QUANTITY) AS TOTAL_QTY , 
        SUM(OI.PRODUCT_QUANTITY * P.PRODUCT_PRICE)AS TOTAL_VAL
FROM ONLINE_CUSTOMER OC
        JOIN ADDRESS AD ON OC.ADDRESS_ID = AD.ADDRESS_ID
		JOIN ORDER_HEADER OH ON OH.CUSTOMER_ID = OC.CUSTOMER_ID
		JOIN ORDER_ITEMS OI ON OI.ORDER_ID = OH.ORDER_ID
		JOIN PRODUCT P ON P.PRODUCT_ID = OI.PRODUCT_ID
		JOIN PRODUCT_CLASS PC ON P.PRODUCT_CLASS_CODE = PC.PRODUCT_CLASS_CODE
WHERE COUNTRY NOT IN ('India' , 'USA') 
GROUP BY PC.PRODUCT_CLASS_CODE
ORDER BY TOTAL_QTY DESC LIMIT 1; 