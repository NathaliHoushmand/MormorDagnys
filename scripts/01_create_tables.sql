PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS RecipeIngredient;
DROP TABLE IF EXISTS Recipe;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS ProductCategory;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS Supplier;

CREATE TABLE Supplier (
    SupplierId    INTEGER PRIMARY KEY AUTOINCREMENT,
    Name          TEXT NOT NULL UNIQUE,
    Address       TEXT NOT NULL,
    ContactPerson TEXT NOT NULL,
    Phone         TEXT NOT NULL,
    Email         TEXT NOT NULL UNIQUE
);

CREATE TABLE Ingredient (
    IngredientId   INTEGER PRIMARY KEY AUTOINCREMENT,
    ArticleNumber  TEXT NOT NULL UNIQUE,
    Name           TEXT NOT NULL,
    PricePerKg     REAL NOT NULL CHECK (PricePerKg >= 0),
    StockKg        REAL NOT NULL DEFAULT 0 CHECK (StockKg >= 0),
    ReorderLevelKg REAL NOT NULL DEFAULT 0 CHECK (ReorderLevelKg >= 0),
    SupplierId     INTEGER NOT NULL,
    FOREIGN KEY (SupplierId) REFERENCES Supplier (SupplierId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE ProductCategory (
    CategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
    Name       TEXT NOT NULL UNIQUE
);

CREATE TABLE Product (
    ProductId  INTEGER PRIMARY KEY AUTOINCREMENT,
    Name       TEXT NOT NULL UNIQUE,
    CategoryId INTEGER NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES ProductCategory (CategoryId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Recipe (
    RecipeId     INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductId    INTEGER NOT NULL UNIQUE,
    Instructions TEXT,
    FOREIGN KEY (ProductId) REFERENCES Product (ProductId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE RecipeIngredient (
    RecipeId     INTEGER NOT NULL,
    IngredientId INTEGER NOT NULL,
    AmountKg     REAL NOT NULL CHECK (AmountKg > 0),
    PRIMARY KEY (RecipeId, IngredientId),
    FOREIGN KEY (RecipeId) REFERENCES Recipe (RecipeId)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (IngredientId) REFERENCES Ingredient (IngredientId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX idx_ingredient_supplier ON Ingredient (SupplierId);
CREATE INDEX idx_product_category ON Product (CategoryId);
CREATE INDEX idx_recipeingredient_ingredient ON RecipeIngredient (IngredientId);
