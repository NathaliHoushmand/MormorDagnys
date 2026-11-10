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
