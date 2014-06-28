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


-- INSERT INTO Merchant --
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


-- INSERT INTO Product --
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


-- INSERT INTO MerchantProduct --
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('6', '9', '4163');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('6', '11', '5237');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('6', '12', '2592');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('6', '3', '14498');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('8', '9', '4876');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('8', '11', '5495');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('8', '12', '2605');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('8', '2', '44700');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('8', '3', '14416');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('8', '4', '27310');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('4', '1', '35672');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('4', '2', '43184');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('4', '3', '13653');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('4', '4', '27269');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('4', '5', '49626');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('4', '6', '68875');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('4', '7', '46487');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('4', '8', '60549');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('10', '9', '4245');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('10', '12', '2935');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('10', '2', '45933');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('10', '3', '14185');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('10', '6', '71199');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('10', '7', '46038');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('10', '8', '59491');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('1', '9', '4104');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('1', '10', '5400');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('1', '1', '35724');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('1', '2', '44726');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('1', '5', '50058');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('1', '6', '68494');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('13', '10', '5436');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('13', '11', '4897');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('13', '12', '2978');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('13', '1', '35944');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('13', '4', '28343');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('13', '7', '46608');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('7', '1', '34590');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('7', '2', '43562');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('7', '4', '27080');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('7', '6', '70198');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('7', '8', '60096');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('5', '1', '35768');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('5', '2', '44626');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('5', '5', '51992');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('5', '6', '69536');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('15', '1', '36471');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('15', '2', '43029');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('15', '3', '14301');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('15', '4', '27615');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('15', '5', '50735');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('15', '6', '71299');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('15', '7', '46593');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('15', '8', '62246');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('12', '9', '4020');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('12', '12', '2291');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('12', '1', '35840');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('12', '3', '14306');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('12', '4', '27460');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('12', '6', '68529');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('12', '8', '61290');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('9', '12', '2590');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('9', '4', '27508');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('11', '2', '45017');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('11', '3', '14269');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('11', '4', '28212');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('11', '5', '49545');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('11', '7', '46068');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('11', '8', '61307');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('14', '9', '4822');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('14', '10', '6205');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('14', '11', '4902');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('14', '12', '2153');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('14', '1', '36992');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('14', '4', '27596');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('14', '5', '48198');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('14', '8', '59130');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('3', '3', '13923');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('3', '4', '27657');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('3', '7', '45897');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('3', '8', '59816');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('2', '1', '35649');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('2', '2', '43640');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('2', '3', '13282');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('2', '5', '49410');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('2', '6', '68843');
INSERT INTO merchantproduct(merchantid, productid, cost) VALUES ('2', '7', '46819');


-- INSERT INTO Person --
INSERT INTO Person(name, age, sex) VALUES ('MARY', '20', 'female');
INSERT INTO Person(name, age, sex) VALUES ('PATRICIA', '40', 'female');
INSERT INTO Person(name, age, sex) VALUES ('LINDA', '23', 'female');
INSERT INTO Person(name, age, sex) VALUES ('BARBARA', '48', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ELIZABETH', '48', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JENNIFER', '44', 'female');
INSERT INTO Person(name, age, sex) VALUES ('MARIA', '46', 'female');
INSERT INTO Person(name, age, sex) VALUES ('SUSAN', '44', 'female');
INSERT INTO Person(name, age, sex) VALUES ('MARGARET', '23', 'female');
INSERT INTO Person(name, age, sex) VALUES ('DOROTHY', '46', 'female');
INSERT INTO Person(name, age, sex) VALUES ('LISA', '35', 'female');
INSERT INTO Person(name, age, sex) VALUES ('NANCY', '29', 'female');
INSERT INTO Person(name, age, sex) VALUES ('KAREN', '49', 'female');
INSERT INTO Person(name, age, sex) VALUES ('BETTY', '24', 'female');
INSERT INTO Person(name, age, sex) VALUES ('HELEN', '41', 'female');
INSERT INTO Person(name, age, sex) VALUES ('SANDRA', '44', 'female');
INSERT INTO Person(name, age, sex) VALUES ('DONNA', '22', 'female');
INSERT INTO Person(name, age, sex) VALUES ('CAROL', '47', 'female');
INSERT INTO Person(name, age, sex) VALUES ('RUTH', '21', 'female');
INSERT INTO Person(name, age, sex) VALUES ('SHARON', '46', 'female');
INSERT INTO Person(name, age, sex) VALUES ('MICHELLE', '37', 'female');
INSERT INTO Person(name, age, sex) VALUES ('LAURA', '45', 'female');
INSERT INTO Person(name, age, sex) VALUES ('SARAH', '43', 'female');
INSERT INTO Person(name, age, sex) VALUES ('KIMBERLY', '43', 'female');
INSERT INTO Person(name, age, sex) VALUES ('DEBORAH', '22', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JESSICA', '33', 'female');
INSERT INTO Person(name, age, sex) VALUES ('SHIRLEY', '35', 'female');
INSERT INTO Person(name, age, sex) VALUES ('CYNTHIA', '33', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ANGELA', '35', 'female');
INSERT INTO Person(name, age, sex) VALUES ('MELISSA', '40', 'female');
INSERT INTO Person(name, age, sex) VALUES ('BRENDA', '34', 'female');
INSERT INTO Person(name, age, sex) VALUES ('AMY', '21', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ANNA', '41', 'female');
INSERT INTO Person(name, age, sex) VALUES ('REBECCA', '42', 'female');
INSERT INTO Person(name, age, sex) VALUES ('VIRGINIA', '44', 'female');
INSERT INTO Person(name, age, sex) VALUES ('KATHLEEN', '28', 'female');
INSERT INTO Person(name, age, sex) VALUES ('PAMELA', '33', 'female');
INSERT INTO Person(name, age, sex) VALUES ('MARTHA', '28', 'female');
INSERT INTO Person(name, age, sex) VALUES ('DEBRA', '46', 'female');
INSERT INTO Person(name, age, sex) VALUES ('AMANDA', '29', 'female');
INSERT INTO Person(name, age, sex) VALUES ('STEPHANIE', '43', 'female');
INSERT INTO Person(name, age, sex) VALUES ('CAROLYN', '47', 'female');
INSERT INTO Person(name, age, sex) VALUES ('CHRISTINE', '23', 'female');
INSERT INTO Person(name, age, sex) VALUES ('MARIE', '36', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JANET', '45', 'female');
INSERT INTO Person(name, age, sex) VALUES ('CATHERINE', '26', 'female');
INSERT INTO Person(name, age, sex) VALUES ('FRANCES', '41', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ANN', '49', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JOYCE', '49', 'female');
INSERT INTO Person(name, age, sex) VALUES ('DIANE', '30', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ALICE', '25', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JULIE', '39', 'female');
INSERT INTO Person(name, age, sex) VALUES ('HEATHER', '49', 'female');
INSERT INTO Person(name, age, sex) VALUES ('TERESA', '45', 'female');
INSERT INTO Person(name, age, sex) VALUES ('DORIS', '35', 'female');
INSERT INTO Person(name, age, sex) VALUES ('GLORIA', '48', 'female');
INSERT INTO Person(name, age, sex) VALUES ('EVELYN', '38', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JEAN', '46', 'female');
INSERT INTO Person(name, age, sex) VALUES ('CHERYL', '42', 'female');
INSERT INTO Person(name, age, sex) VALUES ('MILDRED', '46', 'female');
INSERT INTO Person(name, age, sex) VALUES ('KATHERINE', '37', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JOAN', '24', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ASHLEY', '22', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JUDITH', '27', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ROSE', '20', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JANICE', '28', 'female');
INSERT INTO Person(name, age, sex) VALUES ('KELLY', '37', 'female');
INSERT INTO Person(name, age, sex) VALUES ('NICOLE', '37', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JUDY', '30', 'female');
INSERT INTO Person(name, age, sex) VALUES ('CHRISTINA', '32', 'female');
INSERT INTO Person(name, age, sex) VALUES ('KATHY', '44', 'female');
INSERT INTO Person(name, age, sex) VALUES ('THERESA', '21', 'female');
INSERT INTO Person(name, age, sex) VALUES ('BEVERLY', '26', 'female');
INSERT INTO Person(name, age, sex) VALUES ('DENISE', '37', 'female');
INSERT INTO Person(name, age, sex) VALUES ('TAMMY', '43', 'female');
INSERT INTO Person(name, age, sex) VALUES ('IRENE', '27', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JANE', '47', 'female');
INSERT INTO Person(name, age, sex) VALUES ('LORI', '26', 'female');
INSERT INTO Person(name, age, sex) VALUES ('RACHEL', '24', 'female');
INSERT INTO Person(name, age, sex) VALUES ('MARILYN', '23', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ANDREA', '26', 'female');
INSERT INTO Person(name, age, sex) VALUES ('KATHRYN', '44', 'female');
INSERT INTO Person(name, age, sex) VALUES ('LOUISE', '49', 'female');
INSERT INTO Person(name, age, sex) VALUES ('SARA', '24', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ANNE', '23', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JACQUELINE', '44', 'female');
INSERT INTO Person(name, age, sex) VALUES ('WANDA', '44', 'female');
INSERT INTO Person(name, age, sex) VALUES ('BONNIE', '24', 'female');
INSERT INTO Person(name, age, sex) VALUES ('JULIA', '48', 'female');
INSERT INTO Person(name, age, sex) VALUES ('RUBY', '24', 'female');
INSERT INTO Person(name, age, sex) VALUES ('LOIS', '47', 'female');
INSERT INTO Person(name, age, sex) VALUES ('TINA', '28', 'female');
INSERT INTO Person(name, age, sex) VALUES ('PHYLLIS', '48', 'female');
INSERT INTO Person(name, age, sex) VALUES ('NORMA', '25', 'female');
INSERT INTO Person(name, age, sex) VALUES ('PAULA', '36', 'female');
INSERT INTO Person(name, age, sex) VALUES ('DIANA', '24', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ANNIE', '42', 'female');
INSERT INTO Person(name, age, sex) VALUES ('LILLIAN', '43', 'female');
INSERT INTO Person(name, age, sex) VALUES ('EMILY', '37', 'female');
INSERT INTO Person(name, age, sex) VALUES ('ROBIN', '21', 'female');

INSERT INTO Person(name, age, sex) VALUES ('JAMES', '23', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JOHN', '41', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ROBERT', '33', 'male');
INSERT INTO Person(name, age, sex) VALUES ('MICHAEL', '31', 'male');
INSERT INTO Person(name, age, sex) VALUES ('WILLIAM', '42', 'male');
INSERT INTO Person(name, age, sex) VALUES ('DAVID', '41', 'male');
INSERT INTO Person(name, age, sex) VALUES ('RICHARD', '40', 'male');
INSERT INTO Person(name, age, sex) VALUES ('CHARLES', '37', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JOSEPH', '36', 'male');
INSERT INTO Person(name, age, sex) VALUES ('THOMAS', '27', 'male');
INSERT INTO Person(name, age, sex) VALUES ('CHRISTOPHER', '41', 'male');
INSERT INTO Person(name, age, sex) VALUES ('DANIEL', '33', 'male');
INSERT INTO Person(name, age, sex) VALUES ('PAUL', '33', 'male');
INSERT INTO Person(name, age, sex) VALUES ('MARK', '42', 'male');
INSERT INTO Person(name, age, sex) VALUES ('DONALD', '26', 'male');
INSERT INTO Person(name, age, sex) VALUES ('GEORGE', '32', 'male');
INSERT INTO Person(name, age, sex) VALUES ('KENNETH', '50', 'male');
INSERT INTO Person(name, age, sex) VALUES ('STEVEN', '31', 'male');
INSERT INTO Person(name, age, sex) VALUES ('EDWARD', '34', 'male');
INSERT INTO Person(name, age, sex) VALUES ('BRIAN', '30', 'male');
INSERT INTO Person(name, age, sex) VALUES ('RONALD', '34', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ANTHONY', '34', 'male');
INSERT INTO Person(name, age, sex) VALUES ('KEVIN', '31', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JASON', '20', 'male');
INSERT INTO Person(name, age, sex) VALUES ('MATTHEW', '24', 'male');
INSERT INTO Person(name, age, sex) VALUES ('GARY', '35', 'male');
INSERT INTO Person(name, age, sex) VALUES ('TIMOTHY', '31', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JOSE', '25', 'male');
INSERT INTO Person(name, age, sex) VALUES ('LARRY', '32', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JEFFREY', '37', 'male');
INSERT INTO Person(name, age, sex) VALUES ('FRANK', '26', 'male');
INSERT INTO Person(name, age, sex) VALUES ('SCOTT', '33', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ERIC', '28', 'male');
INSERT INTO Person(name, age, sex) VALUES ('STEPHEN', '50', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ANDREW', '24', 'male');
INSERT INTO Person(name, age, sex) VALUES ('RAYMOND', '27', 'male');
INSERT INTO Person(name, age, sex) VALUES ('GREGORY', '45', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JOSHUA', '45', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JERRY', '43', 'male');
INSERT INTO Person(name, age, sex) VALUES ('DENNIS', '35', 'male');
INSERT INTO Person(name, age, sex) VALUES ('WALTER', '41', 'male');
INSERT INTO Person(name, age, sex) VALUES ('PATRICK', '43', 'male');
INSERT INTO Person(name, age, sex) VALUES ('PETER', '45', 'male');
INSERT INTO Person(name, age, sex) VALUES ('HAROLD', '35', 'male');
INSERT INTO Person(name, age, sex) VALUES ('DOUGLAS', '30', 'male');
INSERT INTO Person(name, age, sex) VALUES ('HENRY', '37', 'male');
INSERT INTO Person(name, age, sex) VALUES ('CARL', '32', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ARTHUR', '44', 'male');
INSERT INTO Person(name, age, sex) VALUES ('RYAN', '29', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ROGER', '28', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JOE', '29', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JUAN', '32', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JACK', '40', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ALBERT', '29', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JONATHAN', '45', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JUSTIN', '33', 'male');
INSERT INTO Person(name, age, sex) VALUES ('TERRY', '24', 'male');
INSERT INTO Person(name, age, sex) VALUES ('GERALD', '41', 'male');
INSERT INTO Person(name, age, sex) VALUES ('KEITH', '42', 'male');
INSERT INTO Person(name, age, sex) VALUES ('SAMUEL', '38', 'male');
INSERT INTO Person(name, age, sex) VALUES ('WILLIE', '35', 'male');
INSERT INTO Person(name, age, sex) VALUES ('RALPH', '28', 'male');
INSERT INTO Person(name, age, sex) VALUES ('LAWRENCE', '49', 'male');
INSERT INTO Person(name, age, sex) VALUES ('NICHOLAS', '23', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ROY', '26', 'male');
INSERT INTO Person(name, age, sex) VALUES ('BENJAMIN', '29', 'male');
INSERT INTO Person(name, age, sex) VALUES ('BRUCE', '34', 'male');
INSERT INTO Person(name, age, sex) VALUES ('BRANDON', '33', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ADAM', '48', 'male');
INSERT INTO Person(name, age, sex) VALUES ('HARRY', '42', 'male');
INSERT INTO Person(name, age, sex) VALUES ('FRED', '45', 'male');
INSERT INTO Person(name, age, sex) VALUES ('WAYNE', '45', 'male');
INSERT INTO Person(name, age, sex) VALUES ('BILLY', '41', 'male');
INSERT INTO Person(name, age, sex) VALUES ('STEVE', '35', 'male');
INSERT INTO Person(name, age, sex) VALUES ('LOUIS', '37', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JEREMY', '36', 'male');
INSERT INTO Person(name, age, sex) VALUES ('AARON', '27', 'male');
INSERT INTO Person(name, age, sex) VALUES ('RANDY', '40', 'male');
INSERT INTO Person(name, age, sex) VALUES ('HOWARD', '20', 'male');
INSERT INTO Person(name, age, sex) VALUES ('EUGENE', '44', 'male');
INSERT INTO Person(name, age, sex) VALUES ('CARLOS', '47', 'male');
INSERT INTO Person(name, age, sex) VALUES ('RUSSELL', '25', 'male');
INSERT INTO Person(name, age, sex) VALUES ('BOBBY', '35', 'male');
INSERT INTO Person(name, age, sex) VALUES ('VICTOR', '45', 'male');
INSERT INTO Person(name, age, sex) VALUES ('MARTIN', '36', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ERNEST', '47', 'male');
INSERT INTO Person(name, age, sex) VALUES ('PHILLIP', '22', 'male');
INSERT INTO Person(name, age, sex) VALUES ('TODD', '31', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JESSE', '45', 'male');
INSERT INTO Person(name, age, sex) VALUES ('CRAIG', '21', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ALAN', '28', 'male');
INSERT INTO Person(name, age, sex) VALUES ('SHAWN', '25', 'male');
INSERT INTO Person(name, age, sex) VALUES ('CLARENCE', '20', 'male');
INSERT INTO Person(name, age, sex) VALUES ('SEAN', '22', 'male');
INSERT INTO Person(name, age, sex) VALUES ('PHILIP', '49', 'male');
INSERT INTO Person(name, age, sex) VALUES ('CHRIS', '25', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JOHNNY', '22', 'male');
INSERT INTO Person(name, age, sex) VALUES ('EARL', '32', 'male');
INSERT INTO Person(name, age, sex) VALUES ('JIMMY', '25', 'male');
INSERT INTO Person(name, age, sex) VALUES ('ANTONIO', '21', 'male');


-- INSERT INTO TransactionHistory --
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '3', '73', '2012-06-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '3', '179', '2012-06-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '3', '78', '2012-06-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '2', '187', '2012-06-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '3', '131', '2012-06-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '2', '198', '2012-06-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '4', '138', '2012-06-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '5', '149', '2012-06-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '2', '136', '2012-06-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '3', '176', '2012-06-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('30', '3', '149', '2012-06-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '5', '116', '2012-06-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '1', '105', '2012-06-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '1', '61', '2012-06-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '5', '16', '2012-06-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '1', '127', '2012-06-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '3', '76', '2012-06-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '3', '78', '2012-06-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '3', '127', '2012-06-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '4', '28', '2012-06-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '3', '54', '2012-06-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '4', '153', '2012-06-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '3', '86', '2012-06-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '5', '158', '2012-06-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '3', '34', '2012-06-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '1', '198', '2012-06-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '1', '125', '2012-06-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '1', '121', '2012-06-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '1', '58', '2012-06-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('24', '5', '89', '2012-06-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('69', '4', '124', '2012-06-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('54', '5', '16', '2012-06-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('28', '3', '175', '2012-06-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '3', '18', '2012-06-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '2', '28', '2012-06-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('6', '2', '109', '2012-06-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '1', '77', '2012-06-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '4', '74', '2012-06-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('24', '1', '51', '2012-06-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '1', '48', '2012-06-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '1', '171', '2012-06-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '2', '43', '2012-06-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '4', '22', '2012-06-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('53', '2', '146', '2012-06-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '1', '176', '2012-06-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '4', '101', '2012-07-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '5', '95', '2012-07-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '2', '71', '2012-07-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '4', '119', '2012-07-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '4', '121', '2012-07-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('69', '2', '125', '2012-07-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '3', '185', '2012-07-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '5', '157', '2012-07-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('27', '1', '109', '2012-07-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('54', '4', '7', '2012-07-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '5', '87', '2012-07-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '4', '23', '2012-07-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '5', '19', '2012-07-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '5', '27', '2012-07-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('30', '5', '19', '2012-07-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '4', '85', '2012-07-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '5', '47', '2012-07-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '5', '87', '2012-07-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '5', '133', '2012-07-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '4', '193', '2012-07-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '5', '112', '2012-07-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '5', '42', '2012-07-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '4', '99', '2012-07-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '4', '178', '2012-07-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '1', '174', '2012-07-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('69', '4', '91', '2012-07-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '1', '182', '2012-07-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '2', '75', '2012-07-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '2', '10', '2012-07-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '5', '44', '2012-07-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '3', '75', '2012-07-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '1', '7', '2012-07-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '1', '40', '2012-07-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('35', '1', '74', '2012-07-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '3', '43', '2012-07-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '2', '74', '2012-07-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '5', '160', '2012-07-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '1', '56', '2012-07-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '3', '94', '2012-07-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '2', '60', '2012-07-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '1', '5', '2012-07-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '5', '29', '2012-07-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '3', '138', '2012-07-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '3', '78', '2012-07-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '5', '130', '2012-07-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '3', '45', '2012-07-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '3', '29', '2012-07-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '5', '196', '2012-08-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('16', '3', '175', '2012-08-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '4', '51', '2012-08-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '4', '93', '2012-08-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '3', '65', '2012-08-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '1', '26', '2012-08-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '5', '15', '2012-08-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '2', '9', '2012-08-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '1', '197', '2012-08-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '4', '193', '2012-08-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '5', '107', '2012-08-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '4', '95', '2012-08-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '2', '146', '2012-08-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '4', '183', '2012-08-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '2', '182', '2012-08-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('83', '3', '123', '2012-08-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('35', '5', '49', '2012-08-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '4', '39', '2012-08-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '5', '10', '2012-08-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '1', '181', '2012-08-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '1', '42', '2012-08-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '3', '46', '2012-08-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '3', '67', '2012-08-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '3', '80', '2012-08-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '5', '134', '2012-08-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '5', '47', '2012-08-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '5', '59', '2012-08-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '2', '20', '2012-08-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '2', '77', '2012-08-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '4', '3', '2012-08-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '4', '164', '2012-08-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '2', '57', '2012-08-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '3', '57', '2012-08-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '4', '5', '2012-08-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '5', '29', '2012-08-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '4', '115', '2012-08-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('24', '4', '81', '2012-08-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '3', '41', '2012-08-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '3', '5', '2012-08-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('55', '5', '35', '2012-08-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '5', '78', '2012-08-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '5', '144', '2012-08-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '4', '92', '2012-08-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '1', '159', '2012-08-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '4', '185', '2012-08-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('55', '2', '60', '2012-08-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '4', '197', '2012-09-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '1', '101', '2012-09-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '4', '6', '2012-09-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '5', '105', '2012-09-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '1', '50', '2012-09-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '4', '11', '2012-09-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('59', '4', '187', '2012-09-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('87', '3', '36', '2012-09-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '3', '71', '2012-09-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '3', '82', '2012-09-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '2', '77', '2012-09-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '1', '63', '2012-09-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '2', '117', '2012-09-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '4', '178', '2012-09-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '2', '17', '2012-09-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '4', '114', '2012-09-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('35', '1', '164', '2012-09-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '5', '170', '2012-09-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '3', '33', '2012-09-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '4', '84', '2012-09-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('87', '2', '89', '2012-09-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '4', '106', '2012-09-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '3', '166', '2012-09-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '1', '142', '2012-09-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '5', '194', '2012-09-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '4', '33', '2012-09-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('24', '2', '115', '2012-09-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '2', '185', '2012-09-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '1', '179', '2012-09-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '4', '189', '2012-09-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '3', '85', '2012-09-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '5', '88', '2012-09-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '1', '18', '2012-09-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '5', '121', '2012-09-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '5', '120', '2012-09-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '5', '71', '2012-09-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '2', '153', '2012-09-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '2', '83', '2012-09-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '4', '163', '2012-09-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '1', '86', '2012-09-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '1', '168', '2012-09-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '2', '78', '2012-09-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '1', '124', '2012-09-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '2', '118', '2012-09-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '2', '71', '2012-09-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '4', '6', '2012-10-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '4', '29', '2012-10-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '1', '132', '2012-10-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '4', '116', '2012-10-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '3', '128', '2012-10-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('53', '4', '22', '2012-10-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '5', '17', '2012-10-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '1', '10', '2012-10-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '2', '13', '2012-10-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '5', '142', '2012-10-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '4', '80', '2012-10-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '5', '140', '2012-10-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '2', '52', '2012-10-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '5', '6', '2012-10-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '5', '7', '2012-10-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '1', '49', '2012-10-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '5', '160', '2012-10-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '1', '182', '2012-10-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '2', '11', '2012-10-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '1', '148', '2012-10-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('30', '2', '35', '2012-10-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '4', '9', '2012-10-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '3', '56', '2012-10-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '4', '88', '2012-10-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '4', '87', '2012-10-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '5', '85', '2012-10-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '1', '146', '2012-10-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('59', '3', '81', '2012-10-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '1', '107', '2012-10-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '4', '64', '2012-10-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '1', '121', '2012-10-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '1', '116', '2012-10-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '5', '134', '2012-10-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '1', '124', '2012-10-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '4', '163', '2012-10-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '2', '51', '2012-10-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '2', '145', '2012-10-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '1', '151', '2012-10-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '5', '56', '2012-10-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '2', '66', '2012-10-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '1', '9', '2012-10-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('35', '5', '165', '2012-10-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '4', '186', '2012-10-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '2', '132', '2012-10-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '4', '27', '2012-10-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('69', '2', '131', '2012-10-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '3', '173', '2012-10-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '2', '116', '2012-11-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '2', '144', '2012-11-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '3', '174', '2012-11-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '4', '73', '2012-11-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '5', '181', '2012-11-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('6', '3', '193', '2012-11-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '3', '111', '2012-11-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '2', '29', '2012-11-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '3', '169', '2012-11-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '5', '56', '2012-11-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '3', '38', '2012-11-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '5', '79', '2012-11-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '1', '133', '2012-11-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '4', '132', '2012-11-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '2', '87', '2012-11-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '4', '105', '2012-11-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '4', '8', '2012-11-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '3', '49', '2012-11-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '4', '184', '2012-11-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '3', '88', '2012-11-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('83', '2', '63', '2012-11-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('27', '5', '32', '2012-11-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('24', '5', '177', '2012-11-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '4', '69', '2012-11-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '3', '106', '2012-11-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '5', '121', '2012-11-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '2', '177', '2012-11-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '2', '147', '2012-11-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '4', '53', '2012-11-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '3', '120', '2012-11-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '2', '136', '2012-11-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '2', '96', '2012-11-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '3', '26', '2012-11-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '5', '28', '2012-11-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '3', '80', '2012-11-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '5', '97', '2012-11-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '4', '197', '2012-11-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '2', '124', '2012-11-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '2', '53', '2012-11-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '1', '181', '2012-11-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '1', '195', '2012-11-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '5', '91', '2012-11-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '5', '60', '2012-11-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '3', '49', '2012-11-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '4', '168', '2012-11-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '3', '7', '2012-12-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '1', '37', '2012-12-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '5', '17', '2012-12-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '1', '134', '2012-12-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('50', '4', '163', '2012-12-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '4', '191', '2012-12-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '4', '138', '2012-12-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '1', '95', '2012-12-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '3', '65', '2012-12-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '2', '166', '2012-12-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '2', '120', '2012-12-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '2', '160', '2012-12-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '1', '132', '2012-12-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '2', '76', '2012-12-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '3', '200', '2012-12-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '4', '35', '2012-12-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '5', '114', '2012-12-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '5', '61', '2012-12-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '1', '19', '2012-12-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '3', '68', '2012-12-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '4', '71', '2012-12-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '1', '154', '2012-12-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '4', '38', '2012-12-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '4', '68', '2012-12-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '5', '33', '2012-12-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '4', '153', '2012-12-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '1', '159', '2012-12-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '2', '123', '2012-12-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '4', '76', '2012-12-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '4', '105', '2012-12-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '3', '59', '2012-12-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '2', '18', '2012-12-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '4', '66', '2012-12-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '1', '72', '2012-12-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '1', '13', '2012-12-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '3', '174', '2012-12-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '2', '120', '2012-12-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '4', '195', '2012-12-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('50', '1', '20', '2012-12-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '1', '24', '2012-12-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '4', '24', '2012-12-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '2', '188', '2012-12-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '1', '7', '2012-12-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '2', '156', '2012-12-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '3', '33', '2012-12-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '3', '33', '2012-12-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '2', '100', '2013-01-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('50', '5', '51', '2013-01-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '4', '63', '2013-01-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '3', '118', '2013-01-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '3', '132', '2013-01-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('16', '4', '187', '2013-01-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '5', '53', '2013-01-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '3', '67', '2013-01-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('30', '4', '105', '2013-01-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '1', '156', '2013-01-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '5', '1', '2013-01-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '5', '26', '2013-01-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '3', '167', '2013-01-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '3', '40', '2013-01-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '4', '142', '2013-01-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '2', '197', '2013-01-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '1', '135', '2013-01-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '3', '114', '2013-01-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '1', '166', '2013-01-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '1', '182', '2013-01-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '3', '68', '2013-01-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '2', '167', '2013-01-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '1', '1', '2013-01-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '5', '10', '2013-01-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '1', '22', '2013-01-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '3', '30', '2013-01-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '1', '116', '2013-01-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '1', '24', '2013-01-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '5', '20', '2013-01-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '2', '55', '2013-01-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '4', '37', '2013-01-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '4', '83', '2013-01-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '1', '16', '2013-01-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('24', '2', '94', '2013-01-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '5', '15', '2013-01-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '5', '126', '2013-01-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('6', '5', '163', '2013-01-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '5', '170', '2013-01-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '3', '200', '2013-01-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '2', '77', '2013-01-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '5', '18', '2013-01-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '2', '86', '2013-01-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '1', '68', '2013-01-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '1', '1', '2013-01-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '1', '167', '2013-01-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '2', '140', '2013-01-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '2', '149', '2013-01-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '5', '54', '2013-02-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('83', '5', '50', '2013-02-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '1', '116', '2013-02-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '3', '191', '2013-02-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '5', '190', '2013-02-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '3', '105', '2013-02-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '2', '194', '2013-02-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '5', '145', '2013-02-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '4', '177', '2013-02-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '4', '106', '2013-02-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '4', '35', '2013-02-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '5', '39', '2013-02-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '4', '149', '2013-02-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '1', '20', '2013-02-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('83', '2', '47', '2013-02-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '4', '4', '2013-02-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '2', '19', '2013-02-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '2', '112', '2013-02-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '1', '196', '2013-02-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '4', '36', '2013-02-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '4', '191', '2013-02-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '1', '28', '2013-02-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '1', '45', '2013-02-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '2', '125', '2013-02-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('16', '1', '55', '2013-02-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '5', '6', '2013-02-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '3', '63', '2013-02-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '3', '85', '2013-02-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('59', '1', '109', '2013-02-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '2', '163', '2013-02-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '5', '200', '2013-02-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '5', '160', '2013-02-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '1', '55', '2013-02-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '5', '38', '2013-02-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '1', '73', '2013-02-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('28', '4', '159', '2013-02-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '5', '191', '2013-02-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '5', '119', '2013-02-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '2', '42', '2013-02-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '1', '171', '2013-02-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '3', '52', '2013-02-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '2', '67', '2013-02-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '3', '88', '2013-03-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '3', '159', '2013-03-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '5', '19', '2013-03-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('27', '1', '172', '2013-03-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '5', '112', '2013-03-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '2', '90', '2013-03-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '2', '155', '2013-03-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '4', '60', '2013-03-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '2', '102', '2013-03-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '4', '42', '2013-03-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '4', '163', '2013-03-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '3', '100', '2013-03-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '3', '137', '2013-03-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '3', '26', '2013-03-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '3', '30', '2013-03-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '5', '15', '2013-03-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '1', '165', '2013-03-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '4', '102', '2013-03-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '3', '22', '2013-03-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('54', '4', '86', '2013-03-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '3', '48', '2013-03-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('6', '1', '31', '2013-03-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '2', '197', '2013-03-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '5', '89', '2013-03-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '1', '80', '2013-03-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '4', '156', '2013-03-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '1', '172', '2013-03-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '3', '141', '2013-03-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '1', '140', '2013-03-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '3', '147', '2013-03-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '2', '100', '2013-03-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '5', '68', '2013-03-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('53', '3', '197', '2013-03-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '5', '24', '2013-03-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('27', '4', '108', '2013-03-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '3', '180', '2013-03-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('27', '2', '148', '2013-03-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('83', '5', '89', '2013-03-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '4', '72', '2013-03-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('50', '5', '49', '2013-03-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '1', '175', '2013-03-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '4', '108', '2013-03-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '1', '68', '2013-03-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '1', '146', '2013-03-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '4', '71', '2013-03-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '3', '198', '2013-03-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '3', '5', '2013-04-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '4', '132', '2013-04-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '1', '100', '2013-04-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '3', '57', '2013-04-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('55', '2', '107', '2013-04-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('10', '2', '132', '2013-04-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '1', '5', '2013-04-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('83', '1', '166', '2013-04-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '2', '135', '2013-04-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '1', '17', '2013-04-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '1', '55', '2013-04-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '4', '144', '2013-04-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '3', '196', '2013-04-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '1', '194', '2013-04-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '1', '122', '2013-04-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '1', '100', '2013-04-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '1', '83', '2013-04-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '1', '102', '2013-04-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('28', '2', '111', '2013-04-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('55', '4', '112', '2013-04-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '2', '167', '2013-04-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '5', '196', '2013-04-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '2', '144', '2013-04-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '3', '124', '2013-04-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '3', '190', '2013-04-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '5', '144', '2013-04-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '5', '38', '2013-04-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '5', '109', '2013-04-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '1', '16', '2013-04-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '3', '2', '2013-04-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '3', '143', '2013-04-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '2', '72', '2013-04-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '1', '90', '2013-04-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('30', '2', '92', '2013-04-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '1', '145', '2013-04-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '5', '5', '2013-04-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '2', '75', '2013-04-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '2', '189', '2013-04-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '5', '109', '2013-04-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '3', '124', '2013-04-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '5', '37', '2013-04-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '3', '70', '2013-04-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('7', '5', '92', '2013-04-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('35', '4', '49', '2013-04-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('10', '5', '4', '2013-04-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '3', '68', '2013-05-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('28', '2', '66', '2013-05-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '4', '89', '2013-05-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '5', '86', '2013-05-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('10', '3', '186', '2013-05-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '4', '57', '2013-05-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '2', '29', '2013-05-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '1', '115', '2013-05-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '3', '142', '2013-05-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '3', '43', '2013-05-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '4', '143', '2013-05-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '3', '109', '2013-05-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '1', '51', '2013-05-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '2', '161', '2013-05-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '5', '3', '2013-05-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('59', '3', '108', '2013-05-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '5', '26', '2013-05-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '1', '9', '2013-05-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '1', '78', '2013-05-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '5', '119', '2013-05-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '4', '108', '2013-05-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '3', '52', '2013-05-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '3', '86', '2013-05-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '1', '188', '2013-05-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '4', '128', '2013-05-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '5', '70', '2013-05-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '2', '154', '2013-05-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('35', '4', '82', '2013-05-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '5', '102', '2013-05-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '3', '73', '2013-05-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('54', '5', '11', '2013-05-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '1', '138', '2013-05-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('28', '5', '115', '2013-05-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '4', '173', '2013-05-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '2', '11', '2013-05-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '4', '80', '2013-05-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '1', '73', '2013-05-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '5', '57', '2013-05-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '2', '180', '2013-05-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '3', '90', '2013-05-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '2', '161', '2013-05-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('16', '5', '183', '2013-05-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '3', '179', '2013-05-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '5', '142', '2013-05-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('27', '4', '107', '2013-05-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '4', '96', '2013-05-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('55', '4', '148', '2013-05-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '5', '29', '2013-06-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '2', '130', '2013-06-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '4', '178', '2013-06-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('53', '3', '29', '2013-06-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('55', '2', '188', '2013-06-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '1', '128', '2013-06-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '4', '111', '2013-06-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '2', '125', '2013-06-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '4', '30', '2013-06-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '1', '11', '2013-06-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '4', '35', '2013-06-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '3', '128', '2013-06-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '5', '159', '2013-06-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '2', '40', '2013-06-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '4', '36', '2013-06-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '4', '45', '2013-06-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '1', '121', '2013-06-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '1', '88', '2013-06-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '5', '84', '2013-06-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('57', '4', '132', '2013-06-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('10', '4', '32', '2013-06-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '2', '132', '2013-06-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '2', '187', '2013-06-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '5', '116', '2013-06-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '2', '78', '2013-06-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '5', '69', '2013-06-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('83', '4', '58', '2013-06-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '2', '78', '2013-06-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('55', '3', '158', '2013-06-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '4', '39', '2013-06-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '5', '185', '2013-06-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '5', '107', '2013-06-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '1', '24', '2013-06-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '1', '164', '2013-06-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('21', '1', '109', '2013-06-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '4', '133', '2013-06-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '1', '110', '2013-06-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '1', '68', '2013-06-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '4', '53', '2013-06-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '1', '76', '2013-06-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '1', '31', '2013-06-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '1', '99', '2013-06-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('50', '1', '75', '2013-06-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '2', '37', '2013-06-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '2', '95', '2013-06-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '3', '78', '2013-07-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '2', '160', '2013-07-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '5', '170', '2013-07-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '4', '87', '2013-07-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '1', '96', '2013-07-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '2', '152', '2013-07-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '4', '174', '2013-07-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '4', '60', '2013-07-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '4', '83', '2013-07-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '1', '127', '2013-07-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('59', '3', '37', '2013-07-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '3', '123', '2013-07-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('30', '1', '116', '2013-07-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '3', '59', '2013-07-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('16', '3', '130', '2013-07-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '4', '15', '2013-07-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '2', '9', '2013-07-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '5', '105', '2013-07-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '3', '164', '2013-07-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '4', '88', '2013-07-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '4', '22', '2013-07-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '3', '60', '2013-07-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '3', '163', '2013-07-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '3', '165', '2013-07-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('53', '3', '19', '2013-07-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '1', '27', '2013-07-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '5', '68', '2013-07-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '2', '87', '2013-07-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '4', '169', '2013-07-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '2', '78', '2013-07-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '1', '199', '2013-07-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '3', '153', '2013-07-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '4', '137', '2013-07-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '1', '108', '2013-07-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '2', '192', '2013-07-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '5', '157', '2013-07-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '1', '193', '2013-07-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '5', '114', '2013-07-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '1', '96', '2013-07-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '1', '139', '2013-07-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '5', '40', '2013-07-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '1', '4', '2013-07-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('57', '3', '53', '2013-07-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('50', '2', '96', '2013-07-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '5', '109', '2013-07-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('30', '5', '90', '2013-07-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '4', '118', '2013-08-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '5', '96', '2013-08-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '4', '90', '2013-08-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '5', '23', '2013-08-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '3', '155', '2013-08-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '2', '85', '2013-08-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '2', '97', '2013-08-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '5', '64', '2013-08-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '4', '191', '2013-08-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '4', '196', '2013-08-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '2', '40', '2013-08-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '4', '63', '2013-08-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '5', '30', '2013-08-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '3', '193', '2013-08-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '5', '92', '2013-08-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '3', '154', '2013-08-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '2', '14', '2013-08-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '5', '32', '2013-08-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '1', '104', '2013-08-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '5', '90', '2013-08-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '5', '20', '2013-08-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '4', '126', '2013-08-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '4', '175', '2013-08-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '2', '191', '2013-08-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '3', '138', '2013-08-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '2', '138', '2013-08-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '3', '198', '2013-08-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '4', '97', '2013-08-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '5', '65', '2013-08-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '4', '130', '2013-08-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('50', '2', '36', '2013-08-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '1', '151', '2013-08-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '4', '80', '2013-08-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '4', '43', '2013-08-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '1', '173', '2013-08-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '4', '25', '2013-08-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '5', '98', '2013-08-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '3', '93', '2013-08-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '3', '186', '2013-08-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '3', '105', '2013-08-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '1', '199', '2013-08-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '2', '144', '2013-08-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '1', '101', '2013-08-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '2', '162', '2013-08-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '3', '37', '2013-08-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '5', '125', '2013-08-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '3', '65', '2013-08-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '2', '158', '2013-09-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '1', '134', '2013-09-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '2', '181', '2013-09-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '4', '42', '2013-09-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('54', '4', '172', '2013-09-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '5', '128', '2013-09-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '3', '30', '2013-09-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('87', '2', '7', '2013-09-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '4', '145', '2013-09-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '2', '129', '2013-09-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '4', '23', '2013-09-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '4', '196', '2013-09-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '5', '100', '2013-09-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '1', '125', '2013-09-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '4', '113', '2013-09-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '4', '11', '2013-09-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '4', '177', '2013-09-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '2', '98', '2013-09-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '2', '192', '2013-09-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '2', '168', '2013-09-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '5', '16', '2013-09-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '5', '119', '2013-09-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '3', '172', '2013-09-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '2', '132', '2013-09-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '5', '175', '2013-09-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('24', '1', '193', '2013-09-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '3', '16', '2013-09-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '3', '7', '2013-09-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '5', '63', '2013-09-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '4', '28', '2013-09-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '5', '1', '2013-09-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '1', '164', '2013-09-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '1', '49', '2013-09-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('53', '2', '94', '2013-09-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '5', '64', '2013-09-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '5', '174', '2013-09-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '4', '82', '2013-09-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '5', '85', '2013-09-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '4', '154', '2013-09-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '2', '106', '2013-09-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('6', '5', '110', '2013-09-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '4', '9', '2013-09-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '4', '60', '2013-09-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '5', '126', '2013-09-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '2', '118', '2013-09-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '3', '196', '2013-10-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '4', '124', '2013-10-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '4', '21', '2013-10-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '3', '44', '2013-10-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '5', '170', '2013-10-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '2', '109', '2013-10-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '5', '159', '2013-10-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '3', '111', '2013-10-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '5', '152', '2013-10-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('35', '3', '68', '2013-10-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '4', '6', '2013-10-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('7', '2', '12', '2013-10-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '1', '182', '2013-10-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '5', '46', '2013-10-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '2', '50', '2013-10-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '5', '171', '2013-10-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '3', '70', '2013-10-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '3', '154', '2013-10-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '3', '154', '2013-10-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '1', '92', '2013-10-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '4', '191', '2013-10-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '2', '144', '2013-10-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '5', '8', '2013-10-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '2', '196', '2013-10-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('30', '2', '30', '2013-10-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '2', '143', '2013-10-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '5', '182', '2013-10-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '3', '53', '2013-10-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('7', '1', '121', '2013-10-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '1', '41', '2013-10-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '5', '81', '2013-10-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('27', '3', '161', '2013-10-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '2', '69', '2013-10-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '5', '38', '2013-10-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '4', '8', '2013-10-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '4', '3', '2013-10-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '3', '105', '2013-10-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '1', '55', '2013-10-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '3', '99', '2013-10-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '2', '192', '2013-10-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '4', '21', '2013-10-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '2', '21', '2013-10-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '2', '5', '2013-10-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '5', '128', '2013-10-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '1', '124', '2013-10-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '1', '138', '2013-10-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '5', '18', '2013-11-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('10', '5', '159', '2013-11-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '1', '105', '2013-11-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '2', '40', '2013-11-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '1', '86', '2013-11-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '3', '100', '2013-11-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '3', '16', '2013-11-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('7', '2', '87', '2013-11-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '5', '161', '2013-11-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '3', '97', '2013-11-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('27', '1', '56', '2013-11-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '3', '77', '2013-11-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '1', '183', '2013-11-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('12', '1', '16', '2013-11-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '4', '80', '2013-11-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '5', '103', '2013-11-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '3', '121', '2013-11-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '4', '34', '2013-11-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('77', '3', '64', '2013-11-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '5', '184', '2013-11-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('28', '1', '21', '2013-11-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '4', '119', '2013-11-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '3', '114', '2013-11-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('21', '5', '21', '2013-11-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '4', '16', '2013-11-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '2', '200', '2013-11-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '4', '151', '2013-11-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '2', '12', '2013-11-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '3', '135', '2013-11-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '5', '195', '2013-11-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '5', '134', '2013-11-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '4', '39', '2013-11-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '1', '178', '2013-11-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('83', '1', '151', '2013-11-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '2', '160', '2013-11-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('72', '2', '9', '2013-11-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '5', '113', '2013-11-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '5', '198', '2013-11-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '2', '151', '2013-11-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '2', '148', '2013-11-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '1', '65', '2013-11-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '4', '138', '2013-11-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '1', '36', '2013-11-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '1', '192', '2013-11-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '3', '90', '2013-11-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('10', '4', '123', '2013-12-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '3', '1', '2013-12-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '2', '22', '2013-12-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '3', '34', '2013-12-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '5', '179', '2013-12-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '5', '145', '2013-12-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '5', '134', '2013-12-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '5', '121', '2013-12-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '5', '3', '2013-12-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('16', '1', '12', '2013-12-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '5', '12', '2013-12-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('21', '4', '198', '2013-12-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '3', '1', '2013-12-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '3', '13', '2013-12-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '5', '68', '2013-12-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '4', '128', '2013-12-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '5', '135', '2013-12-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '2', '76', '2013-12-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '1', '45', '2013-12-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '1', '107', '2013-12-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('69', '2', '41', '2013-12-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '3', '142', '2013-12-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '5', '177', '2013-12-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('24', '5', '19', '2013-12-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '1', '3', '2013-12-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '3', '74', '2013-12-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '2', '49', '2013-12-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '3', '79', '2013-12-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('27', '3', '110', '2013-12-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '2', '41', '2013-12-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '2', '189', '2013-12-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('24', '1', '8', '2013-12-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '5', '38', '2013-12-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '4', '8', '2013-12-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '3', '68', '2013-12-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '1', '94', '2013-12-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '1', '31', '2013-12-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '5', '130', '2013-12-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '2', '75', '2013-12-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('76', '3', '66', '2013-12-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '3', '122', '2013-12-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '3', '87', '2013-12-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('3', '5', '34', '2013-12-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('54', '5', '150', '2013-12-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '3', '23', '2013-12-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '3', '108', '2013-12-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('59', '2', '105', '2013-12-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '4', '63', '2014-01-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '1', '11', '2014-01-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '4', '166', '2014-01-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('79', '1', '186', '2014-01-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '4', '75', '2014-01-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '1', '127', '2014-01-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '5', '83', '2014-01-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '2', '198', '2014-01-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('57', '2', '148', '2014-01-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '4', '41', '2014-01-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '3', '195', '2014-01-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '5', '88', '2014-01-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '5', '30', '2014-01-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '1', '73', '2014-01-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '3', '91', '2014-01-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '1', '132', '2014-01-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '1', '4', '2014-01-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '4', '168', '2014-01-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '5', '172', '2014-01-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '3', '161', '2014-01-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '5', '158', '2014-01-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '4', '78', '2014-01-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '5', '24', '2014-01-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '2', '30', '2014-01-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '3', '160', '2014-01-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '3', '188', '2014-01-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '1', '141', '2014-01-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '3', '135', '2014-01-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('7', '2', '191', '2014-01-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '5', '198', '2014-01-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '4', '196', '2014-01-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('53', '1', '92', '2014-01-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '2', '60', '2014-01-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '1', '39', '2014-01-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '4', '192', '2014-01-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '5', '95', '2014-01-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('39', '2', '129', '2014-01-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('87', '1', '130', '2014-01-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '3', '147', '2014-01-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '2', '154', '2014-01-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '5', '188', '2014-01-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('6', '2', '104', '2014-01-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '4', '147', '2014-01-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('81', '5', '158', '2014-01-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '2', '35', '2014-01-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '2', '172', '2014-01-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '1', '147', '2014-02-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '1', '78', '2014-02-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '5', '73', '2014-02-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '4', '95', '2014-02-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '5', '126', '2014-02-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '2', '6', '2014-02-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '2', '29', '2014-02-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('24', '2', '94', '2014-02-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '5', '71', '2014-02-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '1', '162', '2014-02-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('53', '4', '69', '2014-02-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('18', '3', '56', '2014-02-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('86', '1', '62', '2014-02-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '2', '200', '2014-02-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '4', '6', '2014-02-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '5', '98', '2014-02-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('80', '1', '25', '2014-02-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '5', '92', '2014-02-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '1', '163', '2014-02-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('16', '5', '150', '2014-02-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '3', '118', '2014-02-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '1', '71', '2014-02-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '4', '22', '2014-02-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '2', '183', '2014-02-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('29', '2', '109', '2014-02-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '1', '91', '2014-02-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('57', '5', '143', '2014-02-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('54', '3', '12', '2014-02-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '2', '80', '2014-02-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '3', '59', '2014-02-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('71', '1', '93', '2014-02-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '1', '55', '2014-02-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '1', '31', '2014-02-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('50', '4', '6', '2014-02-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '1', '138', '2014-02-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '4', '81', '2014-02-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '5', '91', '2014-02-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('35', '1', '174', '2014-02-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '2', '78', '2014-02-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '2', '123', '2014-02-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '1', '76', '2014-02-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '4', '6', '2014-02-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '1', '195', '2014-03-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '4', '129', '2014-03-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('59', '5', '84', '2014-03-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('58', '2', '110', '2014-03-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '2', '10', '2014-03-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '1', '198', '2014-03-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('59', '3', '43', '2014-03-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '5', '151', '2014-03-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '3', '133', '2014-03-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '2', '128', '2014-03-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('75', '5', '78', '2014-03-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '2', '164', '2014-03-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '5', '166', '2014-03-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '5', '64', '2014-03-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('64', '4', '165', '2014-03-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('35', '1', '99', '2014-03-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('20', '3', '96', '2014-03-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '1', '132', '2014-03-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '2', '37', '2014-03-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '5', '50', '2014-03-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '2', '180', '2014-03-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('46', '4', '51', '2014-03-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '4', '108', '2014-03-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '4', '86', '2014-03-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('17', '1', '15', '2014-03-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '3', '138', '2014-03-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('26', '1', '114', '2014-03-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '5', '108', '2014-03-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '4', '136', '2014-03-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '5', '81', '2014-03-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '1', '68', '2014-03-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('6', '4', '19', '2014-03-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('21', '2', '174', '2014-03-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '3', '188', '2014-03-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('63', '5', '1', '2014-03-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '1', '99', '2014-03-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('78', '5', '70', '2014-03-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('53', '5', '195', '2014-03-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('16', '1', '47', '2014-03-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('4', '2', '65', '2014-03-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '2', '20', '2014-03-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('45', '2', '61', '2014-03-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '1', '173', '2014-03-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('60', '5', '188', '2014-03-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '5', '109', '2014-03-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '3', '81', '2014-03-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('48', '1', '176', '2014-03-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '3', '135', '2014-04-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '5', '29', '2014-04-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '4', '194', '2014-04-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('65', '1', '73', '2014-04-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '2', '26', '2014-04-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('1', '1', '136', '2014-04-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '5', '172', '2014-04-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '5', '180', '2014-04-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '2', '64', '2014-04-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('53', '3', '59', '2014-04-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '5', '11', '2014-04-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('7', '5', '164', '2014-04-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('30', '1', '191', '2014-04-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '2', '23', '2014-04-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '3', '71', '2014-04-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '1', '138', '2014-04-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '4', '136', '2014-04-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '2', '175', '2014-04-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '5', '140', '2014-04-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '3', '116', '2014-04-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '1', '123', '2014-04-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '5', '157', '2014-04-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '4', '66', '2014-04-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '1', '94', '2014-04-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '5', '173', '2014-04-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('11', '4', '8', '2014-04-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('38', '5', '181', '2014-04-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('44', '1', '194', '2014-04-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('85', '1', '89', '2014-04-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '3', '167', '2014-04-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '2', '151', '2014-04-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('23', '2', '50', '2014-04-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '2', '2', '2014-04-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '3', '47', '2014-04-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '4', '182', '2014-04-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('6', '2', '104', '2014-04-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('22', '1', '113', '2014-04-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '3', '132', '2014-04-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '3', '80', '2014-04-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('21', '2', '200', '2014-04-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '4', '163', '2014-04-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('36', '5', '36', '2014-04-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '1', '8', '2014-04-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '2', '199', '2014-04-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '4', '187', '2014-04-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('27', '3', '4', '2014-05-01 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '3', '144', '2014-05-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('66', '3', '181', '2014-05-02 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('55', '3', '188', '2014-05-03 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '3', '200', '2014-05-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '4', '43', '2014-05-04 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('19', '1', '186', '2014-05-05 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('34', '5', '65', '2014-05-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('21', '3', '94', '2014-05-06 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('7', '4', '21', '2014-05-07 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('57', '3', '17', '2014-05-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('83', '4', '110', '2014-05-08 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('67', '4', '123', '2014-05-09 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '5', '27', '2014-05-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('9', '3', '92', '2014-05-10 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('31', '5', '97', '2014-05-11 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('8', '5', '193', '2014-05-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('5', '1', '167', '2014-05-12 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('33', '5', '172', '2014-05-13 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('49', '4', '153', '2014-05-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('13', '1', '192', '2014-05-14 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('82', '4', '2', '2014-05-15 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '5', '200', '2014-05-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('74', '1', '162', '2014-05-16 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('2', '2', '44', '2014-05-17 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('70', '4', '146', '2014-05-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('25', '3', '22', '2014-05-18 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('42', '5', '88', '2014-05-19 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '5', '56', '2014-05-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('73', '4', '91', '2014-05-20 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('84', '5', '92', '2014-05-21 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('56', '2', '7', '2014-05-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('10', '2', '168', '2014-05-22 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('41', '5', '184', '2014-05-23 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '1', '194', '2014-05-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('62', '3', '186', '2014-05-24 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('52', '4', '114', '2014-05-25 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('51', '3', '152', '2014-05-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('68', '1', '160', '2014-05-26 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('37', '3', '59', '2014-05-27 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('47', '3', '89', '2014-05-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('32', '5', '86', '2014-05-28 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('40', '1', '65', '2014-05-29 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('14', '4', '99', '2014-05-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('61', '3', '129', '2014-05-30 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('43', '3', '90', '2014-05-31 00:00:00
');
INSERT INTO TransactionHistory(merchant_product_id, quantity, user_id, transaction_date) VALUES ('15', '4', '47', '2014-06-01 00:00:00
');
