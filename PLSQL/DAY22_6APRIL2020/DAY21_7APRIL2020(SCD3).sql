/*
##################################################
 Objective                : PRODUCT SCD3 
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 07-April-2020
##################################################
*/

SET SERVEROUTPUT ON;

-- CATAGORY TABLE CREATION
CREATE TABLE cat (
    cat_id     INT PRIMARY KEY,
    cat_desc   VARCHAR(40)
);


INSERT INTO cat VALUES (
    1,
    'ELECTRONICS'
);

INSERT INTO cat VALUES (
    2,
    'HOME NEEDS'
);

INSERT INTO cat VALUES (
    3,
    'FURNISHING'
);

INSERT INTO cat VALUES (
    4,
    'UTILITY'
);
--SUB CATEGORY TABLE CREATION
CREATE TABLE sub_cat (
    sub_cat_id   INT PRIMARY KEY,
    sub_desc     VARCHAR(30),
    cat_id       INT
        REFERENCES cat ( cat_id )
);

INSERT INTO sub_cat VALUES (
    1,
    'CAMERA',
    1
);

INSERT INTO sub_cat VALUES (
    2,
    'MOBILE',
    1
);

INSERT INTO sub_cat VALUES (
    3,
    'FRIDGE',
    1
);

INSERT INTO sub_cat VALUES (
    4,
    'DISH WASHER',
    2
);

INSERT INTO sub_cat VALUES (
    5,
    'WAHSING MACHINE',
    2
);

INSERT INTO sub_cat VALUES (
    6,
    'WALL UNIT ',
    3
);

INSERT INTO sub_cat VALUES (
    7,
    'DINING TABLE',
    3
);

INSERT INTO sub_cat VALUES (
    8,
    'INDUCTION',
    4
);

INSERT INTO sub_cat VALUES (
    9,
    'MIXTURE',
    4
);


--PRODUCT TABLE CREATION

CREATE TABLE product (
    prod_id       INT PRIMARY KEY,
    prod_name     VARCHAR(30),
    launch_date   DATE,
    price         INT,
    prod_cost     INT,
    sub_cat_id    INT
        REFERENCES sub_cat ( sub_cat_id )
);


SELECT
    *
FROM
    product;

INSERT INTO product VALUES (
    6,
    'I PODS',
    '28-09-2019',
    24000,
    10000,
    3
);

INSERT INTO product VALUES (
    1,
    'DELL LAPTOP',
    '24-02-2019',
    80000,
    80000,
    2
);

INSERT INTO product VALUES (
    2,
    'GALAXY NOTE 10',
    '08-02-2018',
    45000,
    30000,
    1
);

INSERT INTO product VALUES (
    14,
    'WONDERCHEF ',
    '11-03-2020',
    22000,
    20000,
    9
);

INSERT INTO product VALUES (
    3,
    'MAC BOOK PRO',
    '28-09-2016',
    150000,
    120000,
    2
);

INSERT INTO product VALUES (
    4,
    'ALIENWARE',
    '10-05-2017',
    250000,
    220000,
    2
);

INSERT INTO product VALUES (
    5,
    'SONY HEADPHONE',
    '25-10-2020',
    15000,
    18000,
    3
);

INSERT INTO product VALUES (
    7,
    'SAMSUNG',
    '20-01-2020',
    55000,
    40000,
    4
);

INSERT INTO product VALUES (
    9,
    'WASHER',
    '23-06-2019',
    33000,
    25000,
    5
);

INSERT INTO product VALUES (
    12,
    'MONTANA 6 SEATER',
    '22-09-2019',
    25000,
    10000,
    7
);

INSERT INTO product VALUES (
    13,
    'INDUCTION',
    '06-11-2018',
    7000,
    7000,
    8
);

INSERT INTO product VALUES (
    10,
    'WASH',
    '11-09-2019',
    45000,
    30000,
    5
);

INSERT INTO product VALUES (
    11,
    'IBM ITELEGIE',
    '12-02-2020',
    65000,
    50000,
    5
);

INSERT INTO product VALUES (
    8,
    'BLUESTAR',
    '03-12-2019',
    65000,
    50000,
    4
);


--CRAETING THE MODEL OF PRODUCT DIM TABLE OF SCD 3 TYPE .

CREATE TABLE prod_scd (
    prod_id       INT PRIMARY KEY,
    prod_name     VARCHAR(20),
    launch_date   DATE,
    curr_price    INT,
    prev_price    INT,
    curr_cost     INT,
    prev_cost     INT,
    sub_desc      VARCHAR(20),
    cat_desc      VARCHAR(20)
);


--CREATING PROCEDURE TO LOAD THE DATA FROM THE SOURCE TABLE TO THE DIM TABLE OF PRODUCT..

CREATE OR REPLACE PROCEDURE udp_load_prod_cut_scd AS
BEGIN
		--INSERITNG THE PRODUCT WHICH ARE NEW AND NOT IN PRODUCT DIM..
    INSERT INTO prod_scd p_scd
        SELECT
            prod_id,
            prod_name,
            launch_date,
            price,
            NULL,
            pcost,
            NULL,
            sub_desc,
            cat_desc
        FROM
            product   p,
            sub_cat   sc,
            cat       c
        WHERE
            p.sub_cat_id = sc.sub_cat_id
            AND sc.cat_id = c.cat_id
            AND prod_id NOT IN (
                SELECT
                    prod_id
                FROM
                    prod_scd
            );

		

    UPDATE prod_scd p_scd
    SET
        prev_price =
            CASE
                WHEN p_scd.curr_price = (
                    SELECT
                        price
                    FROM
                        product p_src
                    WHERE
                        p_src.prod_id = p_scd.prod_id
                ) THEN
                    prev_price
                ELSE
                    curr_price
            END, 
        curr_price =
            CASE
                WHEN curr_price <> (
                    SELECT
                        price
                    FROM
                        product p_src
                    WHERE
                        p_scd.prod_id = p_src.prod_id
                ) THEN
                    (
                        SELECT
                            price
                        FROM
                            product p_src
                        WHERE
                            p_scd.prod_id = p_src.prod_id
                    )
                ELSE
                    curr_price
            END,  
        prev_cost =
            CASE
                WHEN curr_cost = (
                    SELECT
                        pcost
                    FROM
                        product p_src
                    WHERE
                        p_scd.prod_id = p_src.prod_id
                ) THEN
                    prev_cost
                ELSE
                    curr_cost
            END,  
        curr_cost =
            CASE
                WHEN curr_cost <> (
                    SELECT
                        pcost
                    FROM
                        product p_src
                    WHERE
                        p_scd.prod_id = p_src.prod_id
                ) THEN
                    (
                        SELECT
                            pcost
                        FROM
                            product p_src
                        WHERE
                            p_scd.prod_id = p_src.prod_id
                    )
                ELSE
                    curr_cost
            END
					   
    WHERE
        prod_id IN (
            SELECT
                prod_id
            FROM
                product p_src
            WHERE
                p_scd.curr_price <> p_src.price
                OR p_scd.curr_cost <> p_src.pcost
        );
						

END;
/

EXEC udp_load_prod_cut_scd;


--						


SELECT
    *
FROM
    product;

SELECT
    *
FROM
    sub_cat;

SELECT
    *
FROM
    prod_scd;

UPDATE product
SET
    price = 31000
WHERE
    prod_id = 1;

EXEC udp_load_prod_cut_scd;

SELECT
    *
FROM
    prod_scd;

UPDATE product
SET
    pcost = 20000
WHERE
    prod_id = 1;

EXEC udp_load_prod_cut_scd;

SELECT
    *
FROM
    prod_scd;

SELECT
    *
FROM
    prod_scd;

SELECT
    *
FROM
    product;
    
    
---------------------------------------------------------------------------
UPDATE product
SET
    price = 42000
WHERE
    prod_id = 1;

UPDATE product
SET
    price = 76000
WHERE
    prod_id = 2;

UPDATE product
SET
    price = 90000
WHERE
    prod_id = 3;

EXEC udp_load_prod_cut_scd;

SELECT
    *
FROM
    product;

SELECT
    *
FROM
    sub_cat;

SELECT
    *
FROM
    prod_scd;

UPDATE product
SET
    price = 49000
WHERE
    prod_id = 1;

UPDATE product
SET
    pcost = 37000
WHERE
    prod_id = 1;

EXEC udp_load_prod_cut_scd;

SELECT
    *
FROM
    prod_scd;
    
    
    