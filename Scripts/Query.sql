Select firstName, lastname, title from employee 
limit 5;
--Question 1

Select emp.firstName,
        emp.lastname,
        emp.title,
        mng.firstname AS ManagerFirstname,
        mng.lastname AS ManagerLastName
FROM
  employee emp
INNER JOIN employee mng
ON emp.managerId = mng.employeeId;

--Question:2

SELECT emp.firstName,
      emp.lastname,
      emp.title
FROM employee emp
LEFT JOIN sales S 
ON emp.employeeId = s.employeeId
WHERE emp.title = 'Sales Person' 
AND s.salesId IS NULL;

-- Question 3

SELECT c.firstname, c.lastname,c.address,s.salesAmount, s.soldDate
FROM customer C
INNER JOIN sales s
  ON c.customerId = s.customerId 
UNION -- Customer with missing sales data
SELECT c.firstname, c.lastname,c.address,s.salesAmount, s.soldDate
FROM customer C
LEFT JOIN sales s
  ON c.customerId = s.customerId 
WHERE s.salesId IS NULL
UNION --Sales with missing customer data
SELECT c.firstname,c.lastname,c.address,s.salesAmount,s.soldDate
FROM sales s
LEFT JOIN customer c
  ON c.customerId = s.customerId 
WHERE s.salesId IS NULL;

--Question 4

SELECT e.employeeId,e.firstName,e.lastName, Count(*) AS NumberofCarsSold
FROM Sales s
INNER JOIN employee e
 ON s.employeeId = e.employeeId
 Group By e.employeeId,e.firstName,e.lastName
 Order By NumberofCarsSold DESC;

--Question 5
SELECT e.employeeId,e.firstName,e.lastName,Min(s.salesAmount) AS LeastExpensive , Max(s.salesAmount) AS MostExpensive
From sales s
INNER JOIN employee e
  ON s.employeeId = e.employeeId
WHERE s.soldDate >= Date('now', 'start of year')
GROUP BY e.employeeId, e.firstName,e.lastName;

--Question 6

SELECT  e.employeeId,
        e.firstName,
        e.lastName,
        Min(s.salesAmount) AS LeastExpensive , 
        Max(s.salesAmount) AS MostExpensive,
        Count (*) AS NumOfCarsSold
From sales s
INNER JOIN employee e
  ON s.employeeId = e.employeeId
WHERE s.soldDate >= Date('now', 'start of year')
GROUP BY e.employeeId, e.firstName,e.lastName
Having Count(*) >5;


--Question 7

With CTE AS (
SELECT strftime('%Y', soldDate) as Soldyear,
       salesAmount
FROM sales )
SELECT Soldyear,
     Format("$%.2f", Sum(salesAmount)) as Annualsales
FROM cte
Group BY Soldyear
         
--Question 8

SELECT e.firstName,e.lastName,
SUM(CASE WHEN strftime('%m',s.soldDate) = '01'
Then s.salesAmount END) AS JanSales ,

SUM(CASE WHEN strftime('%m',s.soldDate) = '02'
Then s.salesAmount END) AS FebSales ,

SUM(CASE WHEN strftime('%m',s.soldDate) = '03'
Then s.salesAmount END) AS MarchSales ,

SUM(CASE WHEN strftime('%m',s.soldDate) = '04'
Then s.salesAmount END) AS AprilSales ,

SUM(CASE WHEN strftime('%m',s.soldDate) = '05'
Then s.salesAmount END) AS MaySales ,

SUM(CASE WHEN strftime('%m',s.soldDate) = '06'
Then s.salesAmount END) AS JunSales ,

SUM(CASE WHEN strftime('%m',s.soldDate) = '07'
Then s.salesAmount END) AS JulSales ,

SUM(CASE WHEN strftime('%m',s.soldDate) = '08'
Then s.salesAmount END) AS AugSales ,

SUM(CASE WHEN strftime('%m',s.soldDate) = '09'
Then s.salesAmount END) AS SepSales ,

SUM(CASE WHEN strftime('%m',s.soldDate) = '10'
Then s.salesAmount END) AS OctSales, 

SUM(CASE WHEN strftime('%m',s.soldDate) = '11'
Then s.salesAmount END) AS NovSales ,

SUM(CASE WHEN strftime('%m',s.soldDate) = '12'
Then s.salesAmount END) AS DecSales 

From sales s 
Inner Join employee e
  ON s.employeeId = e.employeeId
WHERE s.soldDate >= '2021.01.01'
AND s.soldDate < '2022.01.01'
GROUP BY e.employeeId,e.firstName,e.lastName
Order By e.employeeId,e.firstName,e.lastName

--Question 9

Select s.soldDate, s.salesAmount, i.colour , i.year
FROM sales s 
INNER JOIN inventory i
 ON s.inventoryId = i.inventoryId
 WHERE i.modelId IN(Select modelId From model where EngineType = 'Electric')

 --Question 10

 