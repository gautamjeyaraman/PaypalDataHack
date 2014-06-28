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
