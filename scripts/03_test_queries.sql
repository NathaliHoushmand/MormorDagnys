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
