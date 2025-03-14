
/* The following query gets the total value of each users portfolio*/

SELECT 
Users.User_id,
Users.Name + ' ' + Users.Surname AS "Portfolio owner",
FORMAT(SUM(CAST(Transactions.quantity AS int) * CAST(Transactions.price AS int)),'c0','en-US') AS "Total portfolio value"
From users INNER JOIN Transactions
ON users.user_id = Transactions.user_id
GROUP BY Users.User_id, Users.Name, Users.Surname;

/* The following query establishes the TOP 5  most frequebtly traded stocks*/
SELECT top 5
Stocks.stock_id,
Stocks.company_name,
Stocks.symbol,
COUNT(transactions.transaction_id) AS "Trade count"
FROM stocks JOIN transactions
ON stocks.stock_id = transactions.stock_id
Group BY  stocks.stock_id, stocks.company_name, Stocks.symbol;


/* The following query establishes the average price of the stocks over time*/
SELECT
stocks.symbol, 
FORMAT(AVG (transactions.price), 'C0','en-US') As "Average cost per unit"
FROM stocks JOIN transactions
ON stocks.stock_id = transactions.stock_id
Group BY stocks.symbol
Order BY "Average cost per unit";

/* calculates a transfre fee for each stock*/
SELECT
transaction_id,
Format(((quantity*price)*0.10),'c0', 'en-US') AS "commision"
FROM Transactions;

/* Finds the most valuble sector acording to trade value */
SELECT
stocks.sector,
FORMAT(SUM (transactions.quantity * transactions.price), 'C0', 'en-US') AS "Total trade value"
FROM stocks JOIN transactions 
ON stocks.stock_id= transactions.stock_id
GROUP BY stocks.sector
ORDER BY "Total trade value";



/* Determines each users current stock holdings */
SELECT 
users.user_id, 
 Users.name, 
 Users.surname, 
 Stocks.symbol, 
 Stocks.company_name, 
 SUM(CASE WHEN Transactions.type = 'BUY' THEN CAST(Transactions.quantity AS INT) ELSE -CAST(transactions.quantity AS INT) END) AS total_quantity
FROM users 
JOIN transactions  ON Users.user_id = Transactions.user_id
JOIN stocks  ON Transactions.stock_id = Stocks.stock_id
GROUP BY users.user_id, users.name, users.surname, stocks.symbol, stocks.company_name
HAVING SUM(CASE WHEN transactions.type = 'BUY' THEN CAST(transactions.quantity AS INT) ELSE -CAST(transactions.quantity AS INT) END) > 0  
ORDER BY users.user_id, stocks.symbol;




