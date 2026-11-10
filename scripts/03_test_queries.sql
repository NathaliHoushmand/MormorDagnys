PRAGMA foreign_keys = ON;

.headers on
.mode column

.print
.print Suppliers
SELECT SupplierId, Name, ContactPerson, Phone, Email FROM Supplier;

.print
.print Ingredients per supplier
SELECT s.Name AS Supplier, i.ArticleNumber, i.Name AS Ingredient, i.PricePerKg
FROM Supplier s
JOIN Ingredient i ON i.SupplierId = s.SupplierId
ORDER BY s.Name, i.Name;

.print
.print Time to reorder
SELECT i.Name AS Ingredient, i.StockKg, i.ReorderLevelKg, s.Name AS Supplier, s.Phone
FROM Ingredient i
JOIN Supplier s ON s.SupplierId = i.SupplierId
WHERE i.StockKg <= i.ReorderLevelKg
ORDER BY s.Name, i.Name;
