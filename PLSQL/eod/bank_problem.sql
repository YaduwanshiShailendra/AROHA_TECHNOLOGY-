insert into customer_bk(cust_id,customer_name) values(1001,'Shailendra');
/
CREATE TABLE customer_bk (
    cust_id         INT PRIMARY KEY,
    customer_name   VARCHAR(30),
    addr            VARCHAR(30),
    phone           INT,
    dob             DATE,
    city            VARCHAR(20),
    state_nm        VARCHAR(20),
    country         VARCHAR(20)
);
/
CREATE TABLE account1 (
    acnt_id         INT PRIMARY KEY,
    cust_id         INT
        REFERENCES customer_bk ( cust_id ),
    act_type        VARCHAR(20),
    balance         INT,
    act_open_date   DATE,
    act_status      VARCHAR(20)
);
/
insert into account1(acnt_id,cust_id) values(2222,1001);
/
CREATE TABLE transaction (
    txn_id     INT PRIMARY KEY,
    acnt_id    INT
        REFERENCES account1 ( acnt_id ),
    amount     INT,
    txn_date   DATE,
    txn_type   VARCHAR(20)
);/

CREATE TABLE period_dm (
    period_id      INT PRIMARY KEY,
    period_date    DATE,
    month_no       INT,
    month_desc     VARCHAR(20),
    qtr            INT,
    year_dt        INT,
    holiday_flag   VARCHAR(2)
);
/	
CREATE TABLE dd_eod_balance (
    id          INT PRIMARY KEY,
    cust_id     INT
        REFERENCES customer_bk ( cust_id ),
    acnt_id     INT
        REFERENCES account1 ( acnt_id ),
    period_id   INT
        REFERENCES period_dm ( period_id ),
    balance     INT
);
/

drop table dd_eod_balance;

insert into dd_eod_balance values(1,1001,2222,20200401,40000);
insert into dd_eod_balance values(2,1001,2222,20200402,30000);
insert into dd_eod_balance values(3,1001,2222,20200403,30000);
insert into dd_eod_balance values(4,1001,2222,20200406,30000);
insert into dd_eod_balance values(5,1001,2222,20200407,50000);
insert into dd_eod_balance values(6,1001,2222,20200408,60000);
insert into dd_eod_balance values(7,1001,2222,20200409,70000);
insert into dd_eod_balance values(8,1001,2222,20200410,90000);
insert into dd_eod_balance values(9,1001,2222,20200413,30000);
insert into dd_eod_balance values(10,1001,2222,20200414,30000);
insert into dd_eod_balance values(11,1001,2222,20200415,30000);
insert into dd_eod_balance values(12,1001,2222,20200416,30000);
insert into dd_eod_balance values(13,1001,2222,20200417,30000);
insert into dd_eod_balance values(14,1001,2222,20200420,30000);
insert into dd_eod_balance values(15,1001,2222,20200421,30000);
insert into dd_eod_balance values(16,1001,2222,20200422,30000);
insert into dd_eod_balance values(17,1001,2222,20200423,30000);
insert into dd_eod_balance values(18,1001,2222,20200424,40000);
insert into dd_eod_balance values(19,1001,2222,20200427,40000);
insert into dd_eod_balance values(20,1001,2222,20200428,40000);
insert into dd_eod_balance values(21,1001,2222,20200429,40000);
insert into dd_eod_balance values(22,1001,2222,20200430,60000);

		
CREATE SEQUENCE seq_eod START WITH 1 INCREMENT BY 1 MINVALUE 0 MAXVALUE 10000 CYCLE;
/


CREATE OR REPLACE PROCEDURE period_insert (
    insert_year DATE
) AS

    strt_dt          DATE := trunc(insert_year, 'yyyy');
    end_dt           DATE := add_months(strt_dt, 12) - 1;
    period_id_v      INT;
    month_desc_v     VARCHAR(20);
    month_no_v       INT;
    qtr_v            INT;
    year_v           INT;
    holiday_flag_v   VARCHAR(1);
BEGIN
    WHILE strt_dt <= end_dt LOOP
        SELECT
            to_char(strt_dt, 'YYYY')
            || to_char(strt_dt, 'MM')
            || to_char(strt_dt, 'DD')
        INTO period_id_v
        FROM
            dual;

        month_no_v := to_char(strt_dt, 'mm');
        month_desc_v := to_char(strt_dt, 'mon');
        qtr_v := to_char(strt_dt, 'q');
        year_v := to_char(strt_dt, 'yyyy');
        holiday_flag_v :=
            CASE
                WHEN to_char(strt_dt, 'dy') IN (
                    'sun',
                    'sat'
                ) THEN
                    'Y'
                ELSE 'N'
            END;

        INSERT INTO period_dm VALUES (
            period_id_v,
            strt_dt,
            month_no_v,
            month_desc_v,
            qtr_v,
            year_v,
            holiday_flag_v
        );

        strt_dt := strt_dt + 1;
    END LOOP;
END;
/
EXEC period_insert('12-02-2020');
/
    
SELECT
    *
FROM
    period_dm;
/

CREATE OR REPLACE PROCEDURE udp_insert_eod_bal AS
    flag          CHAR(1);
    period_id_v   INT;
BEGIN
    SELECT
        period_id,
        holiday_flag
    INTO
        period_id_v,
        flag
    FROM
        period_dm
    WHERE
        period_date = sysdate;

    IF flag = 'N' THEN
        INSERT INTO dd_eod_balance
            SELECT
                seq_eod.NEXTVAL,
                c.cust_id,
                c.acnt_id,
                period_id_v,
                c.balance
            FROM
                (
                    SELECT
                        cust_id,
                        acnt_id,
                        balance
                    FROM
                        account
                ) c;

    END IF;

END;
/

CREATE OR REPLACE PROCEDURE monthly_statement (
    month_v       INT,
    year_v        INT,
    customer_id   INT
) AS

    min_period_id   INT;
    max_period_id   INT;
    TYPE t_rec IS RECORD (
        id          INT,
        cust_id     INT,
        acnt_id     INT,
        period_id   INT,
        balance     INT
    );
    TYPE v_t IS
        TABLE OF t_rec;
    v_statement     v_t;
BEGIN
    SELECT
        MAX(period_id),
        MIN(period_id)
    INTO
        max_period_id,
        min_period_id
    FROM
        period_dm
    WHERE
        to_char(period_date, 'mm') = month_v
        AND to_char(period_date, 'yyyy') = year_v
        AND holiday_flag = 'n';

    SELECT
        *
    BULK COLLECT
    INTO v_statement
    FROM
        dd_eod_balance
    WHERE
        period_id BETWEEN min_period_id AND max_period_id
        AND cust_id = customer_id;

    FOR i IN 1..v_statement.last LOOP dbms_output.put_line(v_statement(i).id
                                                           || ' '
                                                           || v_statement(i).cust_id
                                                           || ' '
                                                           || v_statement(i).acnt_id
                                                           || ' '
                                                           || v_statement(i).period_id
                                                           || ' '
                                                           || v_statement(i).balance);
    END LOOP;

END;
/
-------------------------------------------------------
