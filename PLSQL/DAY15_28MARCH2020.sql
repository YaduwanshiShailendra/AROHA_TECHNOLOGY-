/*
##################################################
 Objective                : PL/SQL Packages
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 28-March-2020
##################################################
*/


--1. Write a 3 different procedures to handle deposit, Withdraw and Money transfer by passing account_id and Txn_amt to be
--deposited if the txn_type is deposit or amt to be withdraw if the txn_type is Withdrawal . While performing withdraw the 
--minimum balance should be 2000. If it is not, it should not allow you to Withdraw.For money transfer, pass the from_act_id,
--to_act_id and the amt to be transferred.
 
CUSTOMER
ACCOUNT
TRANSACTION
CUST_ID
ACT_ID
TXN_ID
CUST_NAME
CUST_ID
ACT_ID
CUST_ADDR
ACT_OPEN_DATE
TXN_AMT
CUST_CITY
BAL
TXN_TYPE
 
ACT_TYPE
TXN_DATE
 

CREATE TABLE CUSTOMER_PACK (
    CUST_ID     NUMBER(10) PRIMARY KEY,
    CUST_NAME   VARCHAR(20),
    CUST_ADDR   VARCHAR(20),
    CUST_CITY   VARCHAR(20)
);

 
CREATE TABLE ACCOUNTS(ACT_ID NUMBER(10) PRIMARY KEY,ACT_OPEN_DATE DATE,BAL NUMBER(10),
ACT_TYPE VARCHAR(20),CUST_ID NUMBER(10) REFERENCES CUSTOMER_PACK(CUST_ID));

 
CREATE TABLE TXN( TXN_ID NUMBER(10),
    TXN_AMT NUMBER(10),
        TXN_TYPE   VARCHAR(20),
    TXN_DATE   DATE,
    ACT_ID     NUMBER(10)
        REFERENCES ACCOUNTS ( ACT_ID )
);
 
 
INSERT INTO CUSTOMER_PACK VALUES (
    1,
    'yadav',
    'btmlayout',
    'banglore'
);

INSERT INTO CUSTOMER_PACK VALUES (
    2,
    'shaili',
    'mpnagar',
    'banglore'
);

 
INSERT INTO ACCOUNTS VALUES (
    101,
    '18-jan-2019',
    1000,
    'savings',
    1
);

INSERT INTO ACCOUNTS VALUES (
    102,
    '21-feb-2019',
    2000,
    'current',
    1
);

INSERT INTO ACCOUNTS VALUES (
    103,
    '05-mar-2019',
    3000,
    'savings',
    2
);

SELECT
    *
FROM
    CUSTOMER_PACK;

SELECT
    *
FROM
    ACCOUNTS;

SELECT
    *
FROM
    TXN;

 

--##Package Specs
CREATE OR REPLACE PACKAGE PKG_BANK_TXN AS
    PROCEDURE USP_TXN (
        V_AID        NUMBER,
        V_AMOUNT     NUMBER,
        V_TXN_TYPE   VARCHAR
    );

    PROCEDURE USP_TXN1 (
        V_AID        NUMBER,
        V_AMOUNT     NUMBER,
        V_TXN_TYPE   VARCHAR
    );

    PROCEDURE USP_MONEY_TRANS (
        V_FROM_ID   NUMBER,
        V_TO_ID     NUMBER,
        V_AMT       NUMBER
    );

    V_VAR1 NUMBER;
    V_VAR2 NUMBER;
END;

--##Package Body
CREATE OR REPLACE PACKAGE BODY PKG_BANK_TXN AS

    PROCEDURE USP_TXN (
        V_AID        NUMBER,
        V_AMOUNT     NUMBER,
        V_TXN_TYPE   VARCHAR2
    ) AS
        V_BALANCE NUMBER;
    BEGIN
        SELECT
            MAX(TXN_ID) + 1
        INTO V_VAR1
        FROM
            TXN;

        IF V_TXN_TYPE = 'DEPOSIT' THEN
            INSERT INTO TXN VALUES (
                V_VAR1,
                V_AMOUNT,
                V_TXN_TYPE,
                SYSDATE,
                V_AID
            );

            UPDATE ACCOUNTS
            SET
                BAL = BAL + V_AMOUNT
            WHERE
                AID = V_AID;

        END IF;

    END;

    PROCEDURE USP_TXNN (
        V_AID      NUMBER,
        V_AMOUNT   NUMBER,
        V_T_TYPE   VARCHAR2
    ) AS
        V_BAL NUMBER;
    BEGIN
        SELECT
            MAX(TXN_ID) + 1
        INTO V_VAR2
        FROM
            TXN;

        SELECT
            BAL
        INTO V_BAL
        FROM
            ACCOUNTS
        WHERE
            AID = V_AID;

        IF V_BAL - V_AMOUNT <= 2000 AND V_TXN_TYPE = 'WITHDRAW' THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient Funds');
        ELSE
            INSERT INTO TXN VALUES (
                V_VAR2,
                V_AMOUNT,
                V_TXN_TYPE,
                SYSDATE,
                V_AID
            );

            UPDATE ACCOUNTS
            SET
                BAL = BAL - V_AMOUNT
            WHERE
                AID = V_AID;

        END IF;

    END;

  
PROCEDURE USP_MONEY_TRANS (
    V_FROM_ID   NUMBER,
    V_TO_ID     NUMBER,
    V_AMT       NUMBER
) IS
    V_BAL NUMBER;
BEGIN SELECT
          BAL
      INTO V_BAL
      FROM
          ACCOUNTS
      WHERE
          AID = V_FROM_ID;IF V_BAL >= 2000 THEN START
    TRANSACTION;
    UPDATE ACCOUNTS
    SET
        BAL = BAL - 2000
    WHERE
        AID = V_FROM_ID;

    UPDATE ACCOUNTS
    SET
        BAL = BAL + 2000
    WHERE
        AID = V_TO_ID;

    COMMIT;
END IF;
END;END;
 
--2.  Write a package which includes 3 procedures and 2 functions, one procedure to add the employee,
--Another procedure to delete the emp by passing empno, the next procedure to list all the emps present, one function
--to return the no. of employees by passing the job and one private function to list the total no. of employees and call 
--that private function in the third procedure.


--###Package Specs

CREATE OR REPLACE PACKAGE PKG_EMPS AS
    PROCEDURE USP_ADD_EMP (
        V_NM         VARCHAR2,
        V_JOB        VARCHAR2,
        V_MGR        INT,
        V_HIREDATE   DATE,
        V_SAL        NUMBER,
        V_COMM       INT,
        V_DEPTNO     INT
    );

    PROCEDURE USP_DEL_EMP (
        V_EMPNO NUMBER
    );

    PROCEDURE USP_SHOW_EMP;

    FUNCTION UDF_EMPCOUNT (
        V_JOB VARCHAR2
    ) RETURN INT;

    VP_COUNT NUMBER;
    VP_COUNT2 NUMBER;
    VF_COUNT NUMBER;
END;
--####Package Body

CREATE OR REPLACE PACKAGE BODY PKG_EMPS
AS PROCEDURE USP_ADD_EMP (
    V_NM         VARCHAR2,
    V_JOB        VARCHAR2,
    V_MGR        INT,
    V_HIREDATE   DATE,
    V_SAL        NUMBER,
    V_COMM       INT,
    V_DEPTNO     INT
) IS BEGIN SELECT
               MAX(EMPNO) + 1
           INTO VP_COUNT
           FROM
               EMP;
INSERT
    INTO EMP
VALUES ( V_NM VARCHAR2, V_JOB VARCHAR2, V_MGR INT, V_HIREDATE DATE, V_SAL NUMBER, V_COMM INT,
V_DEPTNO INT ); END;
    PROCEDURE USP_DEL_EMP (
        V_EMPNO NUMBER
    ) IS
    BEGIN
        SELECT
            COUNT(*)
        INTO VP_COUNT2
        FROM
            EMP
        WHERE
            EMPNO = V_EMPNO;

        IF VP_COUNT2 > 0 THEN
            DELETE FROM EMP
            WHERE
                EMPNO = V_EMPNO;

        ELSE
            DBMS_OUTPUT.PUT_LINE('NO EMPLOYEES');
        END IF;

    END;


    PROCEDURE USP_SHOW_EMP IS
        CURSOR C IS
        ( SELECT
            *
        FROM
            EMP
        );

    BEGIN
        DBMS_OUTPUT.PUT_LINE('EMPNO'
                             || 'ENAME'
                             || 'SAL');
        FOR I IN C LOOP DBMS_OUTPUT.PUT_LINE(I.EMPNO
                                             || ' '
                                             || I.ENAME
                                             || ' '
                                             || I.SAL);
        END LOOP;

    END;

    FUNCTION UDF_EMPCOUNT (
        V_JOB VARCHAR2
    ) RETURN INT AS
    BEGIN
        SELECT
            COUNT(*)
        INTO VF_COUNT
        FROM
            EMP
        WHERE
            JOB = V_JOB;

        IF VF_COUNT > 0 THEN
            RETURN VF_COUNT;
        ELSE
            RETURN 0;
        END IF;
    END;

    FUNCTION UDF_COUNT RETURN INT IS
        VF_COUNT2 NUMBER;
    BEGIN
        SELECT
            COUNT(*)
        INTO VF_COUNT2
        FROM
            EMP;

        RETURN VF_COUNT2;
    END;

 
--4. Write a package by declaring 2 procedures and 2 functions with the same name.(This concept shows Procedure and function
--overloading in packages which is not possible outside the package)
 
--Procedure 1: Sp_overload_p1(p_cust_id int,p_cust_nm varchar2)
--Procedure 2: Sp_overload_p1(p_cust_id int)
--Function 1: sf_overload_f1(p_prod_id int) return varchar
--Function 2 : sf_overload_f1(p_prod_id int) return int


CREATE OR REPLACE PACKAGE PKG_OVERLOADING IS
    PROCEDURE SP_OVERLOAD_P1 (
        V_CUST_ID     INT,
        V_CUST_NAME   VARCHAR2
    );

    PROCEDURE SP_OVERLOAD_P1 (
        V_CUST_ID INT
    );

    FUNCTION SF_OVERLOAD_F1 (
        V_PROD_ID INT
    ) RETURN VARCHAR2;

    FUNCTION SF_OVERLOAD_F1 (
        V_PROD_ID INT
    ) RETURN INT;

END;


--7.Can we create bodiless package?

--YES WE CAN CREATE BODILESS PACKAGES.

CREATE OR REPLACE PACKAGE PKG_BODILESS

--###specification
 IS
    PROCEDURE USP_EMP (
        P_EMPNO   IN   NUMBER,
        P_ENAME   IN   VARCHAR,
        P_SAL     IN   VARCHAR
    );

END;
--10.What is the data dictionary to display the number of packages created in the db?

SELECT
    *
FROM
    USER_OBJECTS
WHERE
    OBJECT_TYPE = 'package';
