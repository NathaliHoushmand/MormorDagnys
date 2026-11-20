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

.print
.print Products by category
SELECT c.Name AS Category, p.Name AS Product
FROM ProductCategory c
JOIN Product p ON p.CategoryId = c.CategoryId
ORDER BY c.Name, p.Name;

.print
.print Recipe for Cinnamon bun
SELECT i.Name AS Ingredient, ri.AmountKg
FROM Product p
JOIN Recipe r ON r.ProductId = p.ProductId
JOIN RecipeIngredient ri ON ri.RecipeId = r.RecipeId
JOIN Ingredient i ON i.IngredientId = ri.IngredientId
WHERE p.Name = 'Cinnamon bun'
ORDER BY ri.AmountKg DESC;

.print
.print Number of ingredients per product
SELECT p.Name AS Product, COUNT(ri.IngredientId) AS Ingredients
FROM Product p
JOIN Recipe r ON r.ProductId = p.ProductId
JOIN RecipeIngredient ri ON ri.RecipeId = r.RecipeId
GROUP BY p.ProductId
ORDER BY Ingredients DESC, p.Name;

.print
.print Purchase history
SELECT pu.PurchaseDate, s.Name AS Supplier, i.Name AS Ingredient, pl.QuantityKg, pl.PricePerKg,
       ROUND(pl.QuantityKg * pl.PricePerKg, 2) AS LineTotal
FROM Purchase pu
JOIN Supplier s ON s.SupplierId = pu.SupplierId
JOIN PurchaseLine pl ON pl.PurchaseId = pu.PurchaseId
JOIN Ingredient i ON i.IngredientId = pl.IngredientId
ORDER BY pu.PurchaseDate, i.Name;

.print
.print Total spent per supplier
SELECT s.Name AS Supplier, COUNT(DISTINCT pu.PurchaseId) AS Orders,
       ROUND(SUM(pl.QuantityKg * pl.PricePerKg), 2) AS TotalSpent
FROM Supplier s
JOIN Purchase pu ON pu.SupplierId = s.SupplierId
JOIN PurchaseLine pl ON pl.PurchaseId = pu.PurchaseId
GROUP BY s.SupplierId
ORDER BY TotalSpent DESC;

.print
.print Purchase lines where the ingredient belongs to another supplier (should be empty)
SELECT pu.PurchaseId, pu.PurchaseDate, i.Name AS Ingredient
FROM Purchase pu
JOIN PurchaseLine pl ON pl.PurchaseId = pu.PurchaseId
JOIN Ingredient i ON i.IngredientId = pl.IngredientId
WHERE i.SupplierId <> pu.SupplierId;

.print
.print Products and their suppliers
SELECT DISTINCT p.Name AS Product, s.Name AS Supplier
FROM Product p
JOIN Recipe r ON r.ProductId = p.ProductId
JOIN RecipeIngredient ri ON ri.RecipeId = r.RecipeId
JOIN Ingredient i ON i.IngredientId = ri.IngredientId
JOIN Supplier s ON s.SupplierId = i.SupplierId
ORDER BY p.Name, s.Name;

.print
.print Number of products each supplier is needed for
SELECT s.Name AS Supplier, COUNT(DISTINCT p.ProductId) AS Products
FROM Supplier s
JOIN Ingredient i ON i.SupplierId = s.SupplierId
JOIN RecipeIngredient ri ON ri.IngredientId = i.IngredientId
JOIN Recipe r ON r.RecipeId = ri.RecipeId
JOIN Product p ON p.ProductId = r.ProductId
GROUP BY s.SupplierId
ORDER BY Products DESC, s.Name;

.print
.print Ingredient cost per batch
SELECT p.Name AS Product, ROUND(SUM(ri.AmountKg * i.PricePerKg), 2) AS CostPerBatch
FROM Product p
JOIN Recipe r ON r.ProductId = p.ProductId
JOIN RecipeIngredient ri ON ri.RecipeId = r.RecipeId
JOIN Ingredient i ON i.IngredientId = ri.IngredientId
GROUP BY p.ProductId
ORDER BY CostPerBatch DESC;

.print
.print Batches possible with current stock
SELECT p.Name AS Product, CAST(MIN(i.StockKg / ri.AmountKg) AS INTEGER) AS Batches
FROM Product p
JOIN Recipe r ON r.ProductId = p.ProductId
JOIN RecipeIngredient ri ON ri.RecipeId = r.RecipeId
JOIN Ingredient i ON i.IngredientId = ri.IngredientId
GROUP BY p.ProductId
ORDER BY Batches, p.Name;
