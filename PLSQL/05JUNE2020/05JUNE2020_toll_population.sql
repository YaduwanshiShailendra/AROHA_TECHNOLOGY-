/*
##################################################
 Objective                : PL/SQL stored procedure-
                             1. Write a stored procedure to populate the target tables.
                               
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 05-June-2020
##################################################
*/

select * from toll_src;
/

CREATE TABLE toll_src (
    id               NUMBER(38),
    vehicle_no       VARCHAR2(26),
    vehicle_type     NUMBER(38),
    toll_type        VARCHAR2(26),
    toll_exmp_flag   VARCHAR2(26),
    amount           NUMBER(38)
);
/


INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (1, 'KA 01 5698', 10, 'single', 'NO', 300);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (2, 'DL 03 2345', 11, 'single', 'YES', 0);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (3, 'UP 23 2304', 13, 'single', 'NO', 350);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (4, 'UK 03 5037', 1, 'single', 'NO', 30);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (5, 'PU 12 7634', 9, 'daily', 'NO', 90);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (6, 'AN 04 4678', 8, 'single', 'YES', 0);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (7, 'MP 08 1284', 16, 'single', 'NO', 500);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (8, 'DL 09 5566', 6, 'monthly', 'NO', 230);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (9, 'AP 04 4678', 12, 'single', 'NO', 400);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (10, 'MP 08 1535', 3, 'daily', 'NO', 120);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (11, 'DL 09 9827', 19, 'monthly', 'YES', 0);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (12, 'CT 12 4676', 14, 'monthly', 'NO', 1400);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (13, 'AS 08 1289', 2, 'yearly', 'NO', 3000);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (14, 'DL 09 5598', 19, 'yearly', 'NO', 2000);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (15, 'UP 03 4689', 7, 'single', 'NO', 120);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (16, 'MP 08 1807', 17, 'single', 'NO', 950);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (17, 'DL 09 5981', 15, 'daily', 'NO', 550);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (18, 'UK 04 4893', 3, 'monthly', 'YES', 0);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (19, 'MP 08 1118', 4, 'monthly', 'NO', 1200);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (20, 'BR 02 5544', 5, 'yearly', 'NO', 7000);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (21, 'CT 08 4322', 17, 'daily', 'NO', 100);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (22, 'KA 08 1789', 10, 'single', 'NO', 300);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (23, 'UP 08 5981', 5, 'monthly', 'NO', 734);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (24, 'MP 04 1094', 8, 'single', 'NO', 120);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (25, 'CT 08 1790', 11, 'daily', 'NO', 200);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (26, 'KL 11 8772', 2, 'daily', 'NO', 50);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (27, 'CS 04 4895', 9, 'single', 'YES', 0);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (28, 'BR 08 1291', 20, 'daily', 'NO', 900);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (29, 'LD 09 5833', 16, 'single', 'NO', 300);

INSERT INTO toll_src (ID, VEHICLE_NO, VEHICLE_TYPE, TOLL_TYPE, TOLL_EXMP_FLAG, AMOUNT) 
VALUES (30, 'AS 04 4896', 12, 'daily', 'NO', 800);
/
-- Import Data into table toll_src from file C:\Users\DELL_XPS\Downloads\toll_data_analysis.xlsx . Task successful and sent to worksheet.

CREATE TABLE toll_tgt (
    id_tgt          NUMBER(38),
    vehicle_type    NUMBER(38),
    no_of_vehicle   NUMBER(38),
    total_amt       NUMBER(38),
    avg_amt         NUMBER(38)
);
/

select * from toll_tgt;
/

select * from toll_src;
/

CREATE SEQUENCE toll_id START WITH 101 INCREMENT BY 1;
/


CREATE OR REPLACE PROCEDURE sp_toll_tgt AS
BEGIN MERGE INTO toll_tgt y
USING (
          SELECT
--              toll_id.NEXTVAL,
              vehicle_type,
              COUNT(vehicle_type) OVER(group by vehicle_type) v_no_of_vehicle,
              SUM(amount) OVER(group by vehicle_type) v_total_amt,
              AVG(amount) OVER(group by vehicle_type) v_avg_amt
          FROM
              toll_src
              
              group by vehicle_type
      )
z ON ( y.vehicle_type = z.vehicle_type )
WHEN MATCHED THEN UPDATE
SET y.vehicle_type = z.vehicle_type,
    y.no_of_vehicle = v_no_of_vehicle,
    y.total_amt = v_total_amt,
    y.avg_amt = v_avg_amt
    
    WHEN NOT MATCHED THEN INSERT (
    y.id_tgt,
    y.vehicle_type,
    y.no_of_vehicle,
    y.total_amt,
    y.avg_amt ) 
VALUES
        (
    toll_id.nextval,
    z.vehicle_type,
    z.v_no_of_vehicle,
    z.v_total_amt,
    z.v_avg_amt
); 

END;
/


EXEC sp_toll_tgt;
/


