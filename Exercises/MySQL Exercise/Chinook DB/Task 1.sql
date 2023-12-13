-- Q.1 What is the title of the album with AlbumId 67? 
SELECT TITLE FROM ALBUMS WHERE AlbumId=67;

-- Q.2 Find the name and length (in seconds) of all tracks that have length between 50 and 70 seconds. 
SELECT NAME , Milliseconds/1000 AS SONG_LEN FROM TRACKS WHERE (Milliseconds/1000) > 50 AND (Milliseconds/1000) < 70;

-- Q.3 List all the albums by artists with the word ‘black’ in their name. 
SELECT * FROM albums 
JOIN artists ON artists.ArtistId = albums.ArtistId
WHERE NAME LIKE "%BLACK%";

-- Q.4 Provide a query showing a unique/distinct list of billing countries from the Invoice table 
SELECT DISTINCT BillingCountry AS UNIQUE_CITY FROM invoices ; 

-- Q.5 Display the city with highest sum total invoice. 
SELECT  SUM(Total) AS TOTAL_INVOICE , BillingCity  FROM invoices GROUP BY BillingCity
ORDER BY SUM(Total) DESC
LIMIT 1  ;

-- Q.6 Produce a table that lists each country and the number of customers in that country. (You only need to include countries that have
--  customers) in descending order. (Highest count at the top) 
SELECT BillingCountry , COUNT(CustomerId) AS CUST_COUNT 
FROM invoices
GROUP BY BillingCountry
HAVING CUST_COUNT > 1 
ORDER BY CUST_COUNT DESC ;

-- Q.7 Find the top five customers in terms of sales i.e. find the five customers whose total combined invoice amounts are the highest. 
-- Give their name, CustomerId and total invoice amount. Use join 
SELECT CUST.CustomerId , CUST.FirstName || " " || CUST.LastName AS NAME , SUM(total) AS TOT_AMT 
FROM invoices INN
JOIN customers CUST ON CUST.CustomerId = INN.CustomerId
GROUP BY BillingCountry
ORDER BY TOT_AMT DESC
LIMIT 5; 
-- Q.8 Find out state wise count of customerID and list the names of states with count of customerID in decreasing order. Note:- do not 
-- include where states is null value. 
SELECT COUNT(CustomerId) as TOT_CUST , State 
from customers
WHERE STATE IS NOT NULL
GROUP BY STATE
ORDER BY TOT_CUST DESC ;
 
-- Q.9 How many Invoices were there in 2009 and 2011? 
SELECT COUNT(InvoiceId) 
FROM invoices
WHERE SUBSTRING(InvoiceDate,1,4) = '2009' OR SUBSTRING(InvoiceDate ,1,4) = '2011';

-- Q.10 Provide a query showing only the Employees who are Sales Agents. 
SELECT * FROM employees
WHERE Title = "Sales Support Agent" ; 


/************************************************* EXERCISE - 2 ************************************************************/

-- Q.1 Display Most used media types: their names and count in descending order. 
SELECT media_types.NAME ,COUNT(tracks.MediaTypeId) as USED
FROM media_types
JOIN tracks ON media_types.MediaTypeId = tracks.MediaTypeId
GROUP BY tracks.MediaTypeId
ORDER BY USED DESC;

-- Q.2 Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, 
-- Invoice ID, Date of the invoice and billing country. 
SELECT CUST.FirstName , CUST.LastName , INN.InvoiceDate , INN.InvoiceId  , INN.BillingCountry 
FROM customers CUST 
JOIN invoices INN ON CUST.CustomerId = INN.CustomerId
WHERE CUST.Country = "Brazil" ;

-- Q.3 Display artist name and total track count of the top 10 rock bands from dataset. 

-- Q.4 Display the Best customer (in case of amount spent). Full name (first name and last name) 
SELECT CUST.FirstName ||" " || CUST.LastName AS FULL_NAME, SUM(INN.total) AS TOTAL_AMT
FROM customers CUST 
JOIN invoices INN ON CUST.CustomerId = INN.CustomerId
GROUP BY INN.CustomerId 
ORDER BY TOTAL_AMT DESC
LIMIT 1 ; 

-- Q.5 Provide a query showing Customers (just their full names, customer ID and country) who are not in the US. 
SELECT CustomerId , FirstName ||" "|| LastName AS FULL_NAME, Country FROM customers
WHERE Country != "US" ; 

-- Q.6 Provide a query that shows the total number of tracks in each playlist in descending order. The Playlist name should be included on the resultant table. 
SELECT PL.Name  , COUNT(PLT.TrackId) AS TOT_TRACKS FROM playlists PL 
JOIN playlist_track AS PLT 
ON PLT.PlaylistId = PL.PlaylistId
GROUP BY PLT.PlaylistId 
ORDER BY TOT_TRACKS DESC ; 

-- Q.7 Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre. 
SELECT AL.Title , MT.Name ,GEN.Name FROM TrackS TR
JOIN albums AL ON AL.AlbumId = TR.AlbumId
JOIN media_types MT ON MT.MediaTypeId = TR.MediaTypeId
JOIN genres GEN ON GEN.GenreId = TR.GenreId ;

-- Q.8 Provide a query that shows the top 10 bestselling artists. (In terms of earning). 
SELECT AR.Name ,COUNT(Quantity) AS TOT_SALES
FROM invoice_items AS INN_I
JOIN tracks AS TR ON INN_I.TrackId = TR.TrackId
JOIN albums AS AL ON AL.AlbumId= TR.AlbumId
JOIN artists AS AR ON AR.ArtistId= AL.ArtistId
GROUP BY AR.ArtistId
ORDER BY TOT_SALES DESC
LIMIT 10 ;

-- Q.9 Provide a query that shows the most purchased Media Type. 
SELECT media_types.Name AS MOST_PURCHASE
FROM media_types 
JOIN tracks ON tracks.MediaTypeId = media_types.MediaTypeId
JOIN invoice_items ON tracks.TrackId = invoice_items.TrackId
ORDER BY (invoice_items.Quantity * invoice_items.UnitPrice) DESC
LIMIT 1 ; 

-- Q.10 Provide a query that shows the purchased tracks of 2013. Display Track name and Units sold. 
