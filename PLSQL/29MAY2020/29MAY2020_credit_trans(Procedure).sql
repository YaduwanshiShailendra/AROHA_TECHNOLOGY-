/*
##################################################
 Objective                : PL/SQL stored procedure 
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 29-May-2020
##################################################
*/

/*
**************************************************************************************************************************
Questions:******
1.	Create a stored procedure to insert a record into customer table
2.	Create a stored procedure to insert credit_card table
3.	Create a stored procedure to insert a record into credit_txn
4.	Create a function which gives me total pending amount as of now for a credit card
5.	Create  stored procedure to insert bills for the credit cards where the bill_day_of_month is todays date of the month
**************************************************************************************************************************
*/


CREATE TABLE credit_card_customer (
    cust_id        INT PRIMARY KEY,
    cust_nm        VARCHAR(200),
    cust_dob       DATE,
    cust_address   VARCHAR(200),
    cust_city      VARCHAR(200),
    cust_state     VARCHAR(200),
    cust_country   VARCHAR(200)
);
/

CREATE TABLE credit_card (
    cc_id                  INT PRIMARY KEY,
    cust_id                INT
        REFERENCES credit_card_customer ( cust_id ),
    cc_issued_date         DATE,
    cc_bill_day_of_month   DATE,
    cc_type                VARCHAR(30),
    cc_limit               INT,
    cc_charge_flag         VARCHAR(15),
    cc_amount_charge       INT
);
/

CREATE TABLE credit_txn (
    cc_txn_id     INT PRIMARY KEY,
    cc_txn_dt     DATE,
    cc_id         INT
        REFERENCES credit_card ( cc_id ),
    cc_txn_type   VARCHAR(15),
    amount        INT
)
/

CREATE TABLE cc_bill (
    cc_b_id            INT PRIMARY KEY,
    cc_id              INT
        REFERENCES credit_card ( cc_id ),
    cc_bill_date       DATE,
    cc_bill_due_date   DATE,
    cc_bill_amount     INT
);
/

CREATE TABLE cc_payment (
    cc_p_id             INT PRIMARY KEY,
    cc_id               INT
        REFERENCES credit_card ( cc_id ),
    cc_b_id             INT
        REFERENCES cc_bill ( cc_b_id ),
    cc_payment_dt       DATE,
    cc_paid_amount      INT,
    cc_pending_amount   INT
);
/


SELECT
    *
FROM
    credit_card_customer;

SELECT
    *
FROM
    credit_card;

SELECT
    *
FROM
    credit_txn;

SELECT
    *
FROM
    cc_bill;

SELECT
    *
FROM
    cc_payment;

  
        
        
        
 ************************************************************-
 
CREATE SEQUENCE seq_txn START WITH 1 MINVALUE 1 MAXVALUE 1000;
/

CREATE OR REPLACE PROCEDURE credit_acc_txn (
    p_cust_id        INT,
    p_cust_nm        VARCHAR,
    p_cust_dob       DATE,
    p_cust_add       VARCHAR,
    p_cust_city      VARCHAR,
    p_cust_state     VARCHAR,
    p_cust_country   VARCHAR
) AS
BEGIN
    INSERT INTO credit_card_customer (
        cust_id,
        cust_nm,
        cust_dob,
        cust_address,
        cust_city,
        cust_state,
        cust_country
    ) VALUES (
        p_cust_id,
        p_cust_nm,
        p_cust_dob,
        p_cust_add,
        p_cust_city,
        p_cust_state,
        p_cust_country
    );

    COMMIT;
END;
/

EXEC credit_acc_txn(1, 'shaili', '21-mar-1990', 'BTM LAYOUT', 'Bangalore',
               'Karnataka', 'India');

EXEC credit_acc_txn(2, 'sid', '01-jan-1991', 'JP nagar', 'Bangalore',
               'Karnataka', 'India');
/

CREATE OR REPLACE PROCEDURE credit_card_txn (
    p_cust_id                INT,
    p_cc_issued_date         DATE,
    p_cc_bill_day_of_month   DATE,
    p_cc_type                VARCHAR,
    p_cc_limit               INT,
    p_cc_charge_flag         VARCHAR,
    p_cc_amount_charge       INT
) AS
BEGIN
    INSERT INTO credit_card VALUES (
        seq_txn.NEXTVAL,
        p_cust_id,
        p_cc_issued_date,
        p_cc_bill_day_of_month,
        p_cc_type,
        p_cc_limit,
        p_cc_charge_flag,
        p_cc_amount_charge
    );

    COMMIT;
END;
/

EXEC credit_card_txn(1, '01-mar-2018', '23-mar-2018', 'student', 28000,
                'Y', 5000);

EXEC credit_card_txn(2, '01-jan-2018', '27-jan-2018', 'Premium', 78000,
                'Y', 9000);

SELECT
    *
FROM
    credit_card;


CREATE OR REPLACE PROCEDURE credit_t_txn (
    p_cust_id       INT,
    p_cc_txn_dt     DATE,
    p_cc_txn_type   VARCHAR,
    p_amount        INT
) AS
    p_cc_id INT;
BEGIN
    SELECT
        cc_id
    INTO p_cc_id
    FROM
        credit_card
    WHERE
        cust_id = p_cust_id;

    INSERT INTO credit_txn VALUES (
        seq_txn.NEXTVAL,
        p_cc_txn_dt,
        p_cc_id,
        p_cc_txn_type,
        p_amount
    );

    COMMIT;
END;
/

EXEC credit_t_txn(1, '01-mar-2020', 'Purchase', 4500);

EXEC credit_t_txn(2, '06-apr-2020', 'refund', 7800);

EXEC credit_t_txn(1, '07-mar_2020', 'Purchase', 3200);

EXEC credit_t_txn(1, '09-apr_2020', 'Purchase', 3000);

EXEC credit_t_txn(1, '09-apr_2020', 'Refund', 2000);

EXEC credit_t_txn(2, '09-may-2020', 'Purchase', 8800);

EXEC credit_t_txn(2, '25-may-2020', 'Purchase', 7800);

SELECT
    *
FROM
    credit_txn;

SELECT
    *
FROM
    credit_card;

TRUNCATE TABLE credit_txn;

ALTER TABLE
UPDATE credit_card
SET
    cc_bill_day_of_month = '28-may-2020'
WHERE
    cc_id = 3;
**************


CREATE OR REPLACE PROCEDURE credit_card_bill (
    day_of_month INT
) AS
    v_cc_id      INT;
    v_due_date   DATE;
    v_amt        INT;
    v_cust_id    INT;
BEGIN
    SELECT
        to_date(to_char(cc_bill_day_of_month, 'dd-mon-yy')),
        cc_id,
        cust_id
    INTO
        v_due_date,
        v_cc_id,
        v_cust_id
    FROM
        credit_card
    WHERE
        to_char(cc_bill_day_of_month, 'dd') = day_of_month;

    SELECT
        SUM(amount)
    INTO v_amt
    FROM
        credit_txn    a,
        credit_card   b
    WHERE
        a.cc_id = b.cc_id
        AND b.cust_id = v_cust_id
        AND a.cc_txn_type = 'Purchase'
        AND to_char(cc_bill_day_of_month, 'dd') = day_of_month;

    v_due_date := ( v_due_date ) + 12;
    INSERT INTO cc_bill VALUES (
        seq_txn.NEXTVAL,
        v_cc_id,
        sysdate,
        v_due_date,
        v_amt
    );

END;
/

EXEC credit_card_bill(28);

TRUNCATE TABLE cc_bill;

SELECT
    *
FROM
    cc_bill;

SELECT
    to_char(sysdate, 'dd-mm-yy')
FROM
    dual;

SELECT
    to_date(to_char(sysdate, 'dd-mon-yy'))
FROM
    dual;

SELECT
    SUM(amount)
FROM
    credit_txn    a,
    credit_card   b
WHERE
    a.cc_id = b.cc_id
    AND b.cust_id = 2
    AND a.cc_txn_type = 'Purchase'
    AND to_char(cc_bill_day_of_month, 'dd') = 28;


SELECT
    to_char(cc_bill_day_of_month, 'dd-mm-yy'),
    cc_id,
    cust_id
FROM
    credit_card
WHERE
    to_char(cc_bill_day_of_month, 'dd') = 28;

SELECT
    SUM(amount)
FROM
    credit_txn    a,
    credit_card   b
WHERE
    a.cc_id = b.cc_id
    AND b.cust_id = 2
    AND a.cc_txn_type = 'Purchase'
    AND to_char(cc_bill_day_of_month, 'dd') = 28;

