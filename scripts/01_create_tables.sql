PRAGMA foreign_keys = ON;

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
