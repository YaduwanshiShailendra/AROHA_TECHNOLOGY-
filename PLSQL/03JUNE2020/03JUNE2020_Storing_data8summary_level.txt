/*
##################################################
 Objective                : PL/SQL stored procedure-
                             1. Write a trigger to populate the crt_date automatically when any process inserts record into store_sales table.
                             2. Write a stored procedure to populate the  store summary based on the above store_sales table. 
                               We gave the sample records for the same. 
                               You have to consider any product which is other than ‘TV’ and ‘DVD’ as others.
                               
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 03-June-2020
##################################################
*/


CREATE TABLE store_sales (
    store      VARCHAR(20),
    product    VARCHAR(20),
    sales      NUMBER,
    crt_date   DATE
);
/

CREATE TABLE store_summary (
    store           VARCHAR(20),
    tv_avg_sales    NUMERIC,
    dvd_avg_sales   NUMERIC,
    others          NUMERIC
);
/

select sysdate from dual;
/

-- 1. Write a trigger to populate the crt_date automatically when any process inserts record into store_sales table.

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER trig_crt_dt BEFORE
    INSERT ON store_sales
    FOR EACH ROW
BEGIN
    IF :new.crt_date IS NULL THEN
        :new.crt_date := sysdate;
    END IF;
END;
/ 


insert into store_sales(store,product,sales) values('s1','tv',456);
insert into store_sales(store,product,sales)  values('s1','tv',654);
insert into store_sales (store,product,sales) values('s2','tv',849);
insert into store_sales (store,product,sales) values('s2','tv',345);
insert into store_sales (store,product,sales) values('s2','mouse',45);
insert into store_sales (store,product,sales) values('s2','dvd',213);
/

select * from store_sales;
/


--
--2. Write a stored procedure to populate the  store summary based on the above store_sales table. 
--   We gave the sample records for the same. 
--   You have to consider any product which is other than ‘TV’ and ‘DVD’ as others.
            
CREATE OR REPLACE PROCEDURE sp_summary AS
BEGIN
    INSERT INTO store_summary
        ( SELECT
            store,
            SUM(
                CASE
                    WHEN product = 'tv' THEN sales
                    ELSE 0
                END
            ) / (
                CASE
                    WHEN ( COUNT( CASE
                                      WHEN product = 'tv' THEN 1
                                      ELSE NULL
                                  END
                                ) 
                         ) = 0 THEN 1
                    ELSE
                        COUNT( CASE
                                    WHEN product = 'tv' THEN 1
                                    ELSE NULL
                               END
                              )
                END
                ) tv_avg_sales,
            SUM(
                CASE
                    WHEN product = 'dvd' THEN sales
                    ELSE 0
                END
            ) / (
                CASE
                    WHEN ( COUNT(
                                 CASE
                                     WHEN product = 'dvd' THEN 1
                                     ELSE NULL
                                 END
                                ) 
                          ) = 0 THEN 1
                    ELSE
                        COUNT(
                              CASE
                                  WHEN product = 'dvd' THEN 1
                                  ELSE NULL
                              END
                             )
                END
            ) dvd_avg_sales,
            SUM(
                CASE
                    WHEN product NOT IN('dvd', 'tv') 
                    THEN sales
                    ELSE 0
                END
               ) / (
                    CASE
                        WHEN ( COUNT(
                                     CASE
                                         WHEN product NOT IN('dvd', 'tv') THEN 1
                                         ELSE NULL
                                     END
                                    ) 
                              ) = 0 THEN 1
                        ELSE
                            COUNT(
                                  CASE
                                      WHEN product NOT IN('dvd', 'tv') THEN 1
                                      ELSE NULL
                                  END
                                 )
                    END
                  ) others_avg_sales
          FROM store_sales
          GROUP BY store
        );

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error!!  Try again');
END;
/

EXEC sp_summary;
/

select * from store_summary;
/