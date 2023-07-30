#Project Overview:
#In this data analysis project, we aim to analyze a dataset containing information about book sales and customer preferences. 
#The dataset includes tables for Customers, Orders, Publisher, Author, Books, OrderItems, and more. 
#Our goal is to gain insights into book sales patterns, and customer preferences, and identify the best-selling book.


#Analyze book sales trends, including the total number of orders and sales revenue over time.

SELECT TO_CHAR(o.OrderDate, 'YYYY-MM') AS "Month",
       COUNT(o.Order#) AS "Total Orders",
       SUM(b.Retail * oi.Quantity) AS "Sales Revenue"
FROM Orders o
JOIN OrderItems oi ON o.Order# = oi.Order#
JOIN Books b ON oi.ISBN = b.ISBN
GROUP BY TO_CHAR(o.OrderDate, 'YYYY-MM')
ORDER BY TO_CHAR(o.OrderDate, 'YYYY-MM');

#Identify the best-selling book and its corresponding sales revenue.
SELECT b.Title AS "Best-Selling Book",
       COUNT(oi.ISBN) AS "Number of Orders",
       SUM(oi.Quantity * oi.PaidEach) AS "Total Sales Revenue"
FROM Books b
JOIN OrderItems oi ON b.ISBN = oi.ISBN
GROUP BY b.Title
ORDER BY SUM(oi.Quantity) DESC
FETCH FIRST 1 ROWS ONLY;

#Identify the month with the highest book sales and the best-selling book for that month
SELECT TO_CHAR(o.OrderDate, 'YYYY-MM') AS "Month",
       b.Title AS "Best-Selling Book",
       COUNT(oi.Order#) AS "Number of Orders"
FROM Orders o
JOIN OrderItems oi ON o.Order# = oi.Order#
JOIN Books b ON oi.ISBN = b.ISBN
GROUP BY TO_CHAR(o.OrderDate, 'YYYY-MM'), b.Title
HAVING COUNT(oi.Order#) = (SELECT MAX(orders_count) 
                           FROM (SELECT TO_CHAR(o2.OrderDate, 'YYYY-MM') AS order_month,
                                        COUNT(oi2.Order#) AS orders_count
                                 FROM Orders o2
                                 JOIN OrderItems oi2 ON o2.Order# = oi2.Order#
                                 GROUP BY TO_CHAR(o2.OrderDate, 'YYYY-MM'), oi2.ISBN) sub_query)
ORDER BY "Month", "Number of Orders" DESC
FETCH FIRST 1 ROWS ONLY;


#Based on the given data, it can be inferred that "BODYBUILD IN 10 MINUTES A DAY" is the best-selling book in April,
#and its popularity may be attributed to people's plans to get in shape before summer. 
#Therefore, it can be concluded that if the bookstore sells more books related to bodybuilding and fitness, it can potentially increase its profits. 
#With the data suggesting that this particular book performs well in April due to the upcoming summer season and people's interest in fitness goals, 
#the bookstore can strengthen its marketing and merchandising efforts for books related to bodybuilding, exercise, health, diet, and nutrition. 
#The bookstore can attract customers' attention and encourage purchases by offering a diverse selection of fitness-related books and organizing related events or promotions.
