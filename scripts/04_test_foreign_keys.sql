PRAGMA foreign_keys = ON;

.print
.print Foreign keys switched on (1 = yes)
SELECT foreign_keys FROM pragma_foreign_keys;

.print
.print Test 1: ingredient from a supplier that does not exist (should fail)
INSERT INTO Ingredient (ArticleNumber, Name, PricePerKg, StockKg, ReorderLevelKg, SupplierId)
VALUES ('XX-0001', 'Ghost flour', 10, 5, 2, 999);

.print
.print Test 2: product in a category that does not exist (should fail)
INSERT INTO Product (Name, CategoryId) VALUES ('Ghost cake', 999);

.print
.print Test 3: recipe line with an ingredient that does not exist (should fail)
INSERT INTO RecipeIngredient (RecipeId, IngredientId, AmountKg) VALUES (1, 999, 0.5);

.print
.print Test 4: same ingredient twice in the same recipe (should fail)
INSERT INTO RecipeIngredient (RecipeId, IngredientId, AmountKg) VALUES (1, 1, 0.5);

.print
.print Test 5: delete a supplier that still has ingredients (should fail)
DELETE FROM Supplier WHERE SupplierId = 1;

.print
.print Test 6: purchase from a supplier that does not exist (should fail)
INSERT INTO Purchase (SupplierId, PurchaseDate) VALUES (999, '2026-11-20');

.print
.print Test 7: purchase line for a purchase that does not exist (should fail)
INSERT INTO PurchaseLine (PurchaseId, IngredientId, QuantityKg, PricePerKg) VALUES (999, 1, 5, 9.5);

.print
.print Test 8: negative price (should fail)
INSERT INTO Ingredient (ArticleNumber, Name, PricePerKg, StockKg, ReorderLevelKg, SupplierId)
VALUES ('XX-0002', 'Free flour', -5, 5, 2, 1);

.print
.print Test 9: valid ingredient for an existing supplier (should work)
INSERT INTO Ingredient (ArticleNumber, Name, PricePerKg, StockKg, ReorderLevelKg, SupplierId)
VALUES ('KK-9001', 'Baking powder', 55.00, 4.0, 2.0, 1);
SELECT i.ArticleNumber, i.Name, s.Name AS Supplier
FROM Ingredient i
JOIN Supplier s ON s.SupplierId = i.SupplierId
WHERE i.ArticleNumber = 'KK-9001';
DELETE FROM Ingredient WHERE ArticleNumber = 'KK-9001';

.print
.print Test 10: deleting a product also removes its recipe and recipe lines
BEGIN;
INSERT INTO Product (Name, CategoryId) VALUES ('Test bun', 1);
INSERT INTO Recipe (ProductId, Instructions) SELECT ProductId, 'Test' FROM Product WHERE Name = 'Test bun';
INSERT INTO RecipeIngredient (RecipeId, IngredientId, AmountKg)
SELECT r.RecipeId, 1, 1.0 FROM Recipe r JOIN Product p ON p.ProductId = r.ProductId WHERE p.Name = 'Test bun';
SELECT COUNT(*) AS LinesBeforeDelete FROM RecipeIngredient ri
JOIN Recipe r ON r.RecipeId = ri.RecipeId JOIN Product p ON p.ProductId = r.ProductId WHERE p.Name = 'Test bun';
DELETE FROM Product WHERE Name = 'Test bun';
SELECT COUNT(*) AS RecipesAfterDelete FROM Recipe WHERE Instructions = 'Test';
SELECT COUNT(*) AS LinesAfterDelete FROM RecipeIngredient WHERE RecipeId NOT IN (SELECT RecipeId FROM Recipe);
ROLLBACK;
