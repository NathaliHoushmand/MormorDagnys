PRAGMA foreign_keys = ON;

INSERT INTO Supplier (Name, Address, ContactPerson, Phone, Email) VALUES
('Kullens Kvarn AB',          'Kvarnvagen 7, 262 32 Angelholm',        'Dennis Whitaker', '0431-48 21 60', 'dennis.whitaker@kullenskvarn.example'),
('Hallands Mejeri & Agg',     'Mejerigatan 15, 302 50 Halmstad',       'Rachel Donovan',  '035-17 44 90',  'rachel@hallandsmejeri.example'),
('Sodra Socker & Sotsaker',   'Sockerbruksgatan 2, 231 42 Trelleborg', 'Tyler Brennan',   '0410-33 08 15', 'tbrennan@sodrasocker.example'),
('Orient Spice Import',       'Importgatan 9, 211 20 Malmo',           'Megan Hollis',    '040-61 77 03',  'megan.hollis@orientspice.example'),
('Kakao & Konfektyr',         'Kakaogatan 5, 411 18 Goteborg',         'Austin Reyes',    '031-80 25 40',  'areyes@kakaokonfekt.example');

INSERT INTO Ingredient (ArticleNumber, Name, PricePerKg, StockKg, ReorderLevelKg, SupplierId) VALUES
('KK-2041', 'Wheat flour',     8.90, 140.0, 60.0, 1),
('KK-2057', 'Rye flour',      10.40,  38.5, 40.0, 1),
('KK-3102', 'Fresh yeast',    52.00,   7.5,  8.0, 1),
('KK-4001', 'Salt',            5.50,  25.0, 10.0, 1),
('HM-118',  'Butter',         81.50,  52.0, 30.0, 2),
('HM-204',  'Whole milk',      9.80,  64.0, 45.0, 2),
('HM-377',  'Eggs',           29.00,  16.5, 20.0, 2),
('SS-5503', 'Sugar',          11.90,  85.0, 35.0, 3),
('SS-5518', 'Pearl sugar',    31.50,  13.0, 10.0, 3),
('SS-6120', 'Vanilla sugar',  96.00,   1.8,  2.0, 3),
('OS-0912', 'Cardamom',      395.00,   2.8,  2.0, 4),
('OS-0915', 'Cinnamon',      118.00,   3.4,  2.5, 4),
('OS-1307', 'Sesame seeds',   44.00,   5.5,  4.0, 4),
('KC-7701', 'Dark chocolate', 92.00,  11.0, 15.0, 5),
('KC-7712', 'Cocoa powder',   74.00,   6.0,  5.0, 5);

INSERT INTO ProductCategory (Name) VALUES
('Buns'),
('Bread'),
('Pastry');

INSERT INTO Product (Name, CategoryId) VALUES
('Cinnamon bun',   1),
('Cardamom bun',   1),
('Rye bread',      2),
('Sesame loaf',    2),
('Chocolate cake', 3),
('Vanilla hearts', 3);

INSERT INTO Recipe (ProductId, Instructions) VALUES
(1, 'Knead the dough, let it rise, roll out and spread with butter, sugar and cinnamon. Cut, proof and bake.'),
(2, 'Knead cardamom dough, let it rise, twist into knots, top with pearl sugar and bake.'),
(3, 'Mix rye and wheat flour, let it rise slowly, shape and bake at lower heat.'),
(4, 'Knead a plain wheat dough, shape loaves, cover with sesame seeds and bake.'),
(5, 'Melt chocolate and butter, whisk in eggs and sugar, fold in flour and cocoa, bake.'),
(6, 'Rub butter into flour and sugar, add vanilla sugar and egg, chill, cut out and bake.');

WITH v (Product, Ingredient, Amount) AS (VALUES
    ('Cinnamon bun',   'Wheat flour',    3.000),
    ('Cinnamon bun',   'Fresh yeast',    0.120),
    ('Cinnamon bun',   'Sugar',          0.400),
    ('Cinnamon bun',   'Butter',         0.600),
    ('Cinnamon bun',   'Whole milk',     1.500),
    ('Cinnamon bun',   'Cinnamon',       0.050),
    ('Cinnamon bun',   'Salt',           0.040),

    ('Cardamom bun',   'Wheat flour',    3.000),
    ('Cardamom bun',   'Fresh yeast',    0.120),
    ('Cardamom bun',   'Sugar',          0.400),
    ('Cardamom bun',   'Butter',         0.600),
    ('Cardamom bun',   'Whole milk',     1.500),
    ('Cardamom bun',   'Cardamom',       0.030),
    ('Cardamom bun',   'Pearl sugar',    0.150),
    ('Cardamom bun',   'Salt',           0.040),

    ('Rye bread',      'Rye flour',      2.000),
    ('Rye bread',      'Wheat flour',    1.000),
    ('Rye bread',      'Fresh yeast',    0.050),
    ('Rye bread',      'Salt',           0.060),
    ('Rye bread',      'Sugar',          0.050),

    ('Sesame loaf',    'Wheat flour',    3.000),
    ('Sesame loaf',    'Fresh yeast',    0.090),
    ('Sesame loaf',    'Salt',           0.050),
    ('Sesame loaf',    'Sesame seeds',   0.200),
    ('Sesame loaf',    'Whole milk',     1.000),
    ('Sesame loaf',    'Butter',         0.150),

    ('Chocolate cake', 'Dark chocolate', 0.500),
    ('Chocolate cake', 'Butter',         0.400),
    ('Chocolate cake', 'Eggs',           0.500),
    ('Chocolate cake', 'Sugar',          0.350),
    ('Chocolate cake', 'Wheat flour',    0.250),
    ('Chocolate cake', 'Cocoa powder',   0.060),

    ('Vanilla hearts', 'Wheat flour',    1.000),
    ('Vanilla hearts', 'Butter',         0.600),
    ('Vanilla hearts', 'Sugar',          0.300),
    ('Vanilla hearts', 'Vanilla sugar',  0.040),
    ('Vanilla hearts', 'Eggs',           0.150)
)
INSERT INTO RecipeIngredient (RecipeId, IngredientId, AmountKg)
SELECT r.RecipeId, i.IngredientId, v.Amount
FROM v
JOIN Product p ON p.Name = v.Product
JOIN Recipe r ON r.ProductId = p.ProductId
JOIN Ingredient i ON i.Name = v.Ingredient;
