--Function which returns UTC now
CREATE OR REPLACE FUNCTION utc_now()
RETURNS TIMESTAMP without time zone 
AS $$
    BEGIN
            RETURN now() at time zone 'UTC';
    END;
$$ LANGUAGE plpgsql VOLATILE
    COST 1;

-- Merchant Table --
CREATE Table Merchant(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(200),
    sentiment    INTEGER DEFAULT 50,
    count        INTEGER DEFAULT 1
);

-- Product Table --
CREATE Table Product(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(200),
    sentiment    INTEGER DEFAULT 50,
    count        INTEGER DEFAULT 1,
    category     VARCHAR(200)
);

-- Merchant-Product Table --
CREATE Table MerchantProduct(
    id           SERIAL PRIMARY KEY,
    merchantId   INTEGER REFERENCES Merchant,
    productID    INTEGER REFERENCES Product,
    name         VARCHAR(200),
    sentiment    INTEGER DEFAULT 50,
    cost         INTEGER NOT NULL
);

-- Person Table --
CREATE Table Person(
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(200),
    age     INTEGER NOT NULL,
    sex     VARCHAR(50)
);

-- TransactionHistory Table --
CREATE Table TransactionHistory(
    id                     SERIAL PRIMARY KEY,
    transaction_date       TIMESTAMP DEFAULT utc_now(),
    merchant_product_id    INTEGER REFERENCES MerchantProduct,
    quantity               INTEGER NOT NULL,
    user_id                INTEGER REFERENCES Person
);

-- Survey Table --
CREATE Table Survey(
    id                         SERIAL PRIMARY KEY,
    transaction_id             INTEGER REFERENCES TransactionHistory,
    product_quality            INTEGER DEFAULT NULL,
    product_service_quality    INTEGER DEFAULT NULL,
    delivered_on_time          INTEGER DEFAULT NULL
);

-- Feedback Table --
CREATE Table Feedback(
    id         SERIAL PRIMARY KEY,
    content    VARCHAR(500),
    rating     INTEGER NOT NULL
);

-- SocialMedia Table --
CREATE Table SocialMedia(
    id         SERIAL PRIMARY KEY,
    content    VARCHAR(500)
);

INSERT INTO Merchant(name) VALUES ('ValueStore');
INSERT INTO Merchant(name) VALUES ('DelhiMetro');
INSERT INTO Merchant(name) VALUES ('Zone M');
INSERT INTO Merchant(name) VALUES ('Mobile HUB');
INSERT INTO Merchant(name) VALUES ('W-Mobile');
INSERT INTO Merchant(name) VALUES ('Imagine Store');
INSERT INTO Merchant(name) VALUES ('CELLSOUK');
INSERT INTO Merchant(name) VALUES ('Deccan Hub');
INSERT INTO Merchant(name) VALUES ('TRUSTSELL');
INSERT INTO Merchant(name) VALUES ('AB Tech');
INSERT INTO Merchant(name) VALUES ('India Mobiles');
INSERT INTO Merchant(name) VALUES ('DIGITAL STORE');
INSERT INTO Merchant(name) VALUES ('BCPL');
INSERT INTO Merchant(name) VALUES ('Fortune LifeStyle');
INSERT INTO Merchant(name) VALUES ('Shriram Communications');

INSERT INTO Product(name, category) VALUES ('Samsung S5', 'mobile');
INSERT INTO Product(name, category) VALUES ('Iphone 5S', 'mobile');
INSERT INTO Product(name, category) VALUES ('Moto G', 'mobile');
INSERT INTO Product(name, category) VALUES ('Sony Xperia Z', 'mobile');
INSERT INTO Product(name, category) VALUES ('Dell', 'laptop');
INSERT INTO Product(name, category) VALUES ('Mac', 'laptop');
INSERT INTO Product(name, category) VALUES ('Vaio', 'laptop');
INSERT INTO Product(name, category) VALUES ('Lenovo', 'laptop');
INSERT INTO Product(name, category) VALUES ('Adidas', 'shoe');
INSERT INTO Product(name, category) VALUES ('Nike', 'shoe');
INSERT INTO Product(name, category) VALUES ('Reebok', 'shoe');
INSERT INTO Product(name, category) VALUES ('Puma', 'shoe');


Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 5, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 0, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 2, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 5, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 4, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 2, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 5, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 5, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 2, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 2, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 3, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 1, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 0, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 5, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 1, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 4, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 3, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 5, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 3, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 1, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 0, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 2, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 2, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 0, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 4, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 2, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 0, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 2, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 3, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 1, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 5, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 5, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 0, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 1, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 5, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 0, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 4, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 4, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 4, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 2, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 5, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 1, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 3, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 0, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 5, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 2, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 2, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 0, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 3, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 1, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 2, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 0, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 0, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 1, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 4, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 0, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 5, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 5, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 3, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 4, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 1, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 2, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 3, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 4, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 3, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 0, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 1, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 2, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 1, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 0, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 1, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 5, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 2, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 3, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 5, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 0, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 3, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 0, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 5, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 2, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 0, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 3, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 5, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 5, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 0, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 5, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 0, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 5, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 5, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 0, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 0, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 1, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 4, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 3, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 4, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 2, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 2, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 4, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 4, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 5, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 5, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 0, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 4, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 2, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 1, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 4, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 0, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 5, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 1, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 1, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 3, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 4, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 5, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 4, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 5, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 1, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 0, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 5, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 5, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 2, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 5, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 1, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 5, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 1, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 5, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 1, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 3, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 5, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 3, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 0, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 5, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 2, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 2, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 4, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 5, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 5, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 3, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 2, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 1, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 4, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 2, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 4, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 4, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 2, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (4, 2, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (1, 1, 5);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 1, 4);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 5, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (3, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 2, 1);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 4, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 3, 2);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 5, 3);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 5, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 0, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (5, 0, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (2, 3, 0);
Insert into Survey (product_quality, product_service_quality, delivered_on_time) VALUES (0, 1, 3);

