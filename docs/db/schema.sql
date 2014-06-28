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

import random
for i in range(0,15):
    print str(random.randint(34500, 37000))+" "+str(random.randint(43000, 46000))+" "+str(random.randint(13000, 14500))+" "+str(random.randint(27000, 28500))+" "+str(random.randint(48000, 52000))+" "+str(random.randint(68000, 72000))+" "+str(random.randint(45500, 47000))+" "+str(random.randint(59000, 62500))+" "+str(random.randint(4000, 4999))+" "+str(random.randint(5000, 6499))+" "+str(random.randint(4500, 5499))+" "+str(random.randint(2000, 2999))
