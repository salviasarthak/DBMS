-- Write a DELETE query to delete John Doe's details from Customers table and see changes in Orders table
DELETE FROM Customers
where customer_name = 'John Doe';
Select * from Orders;