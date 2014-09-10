USE [TradeLite]
GO
------- STORE ------------
INSERT INTO Store(Name) VALUES ('Склад');
INSERT INTO Store(Name) VALUES ('Точка 1');
INSERT INTO Store(Name) VALUES ('Точка 2');
INSERT INTO Store(Name) VALUES ('Магазин');
--------------------------

------- ProductDictionary ------------
INSERT INTO tlProductDictionary(Name, Price) VALUES('Юбка Armani синяя',              350);
INSERT INTO tlProductDictionary(Name, Price) VALUES('Юбка Armani красная',            300);
INSERT INTO tlProductDictionary(Name, Price) VALUES('Юбка Armani зеленая',            300);
INSERT INTO tlProductDictionary(Name, Price) VALUES('Куртка City Classic коричневая', 500);
INSERT INTO tlProductDictionary(Name, Price) VALUES('Куртка City Classic зеленая',    500);
INSERT INTO tlProductDictionary(Name, Price) VALUES('Куртка City Classic красная',    450);
--------------------------------------

------- Product ------------
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (1, 3, 'M');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (2, 4, 'L');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (3, 1, 'XL');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (4, 2, 'XXL');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (1, 3, 'XXXL');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (2, 4, 'S');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (3, 1, 'M');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (4, 2, 'L');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (5, 3, 'M');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (6, 4, 'M');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (1, 1, 'S');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (2, 2, 'M');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (3, 3, 'XL');
INSERT INTO Product(IDProduct, IDStore, Size) VALUES (4, 4, 'XXL');
-----------------------------