/*
##################################################
 Objective                : SCD 1 CUSTOMER TABLE
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 08-April-2020
##################################################
*/


CREATE TABLE store (
    cust_id     INT,
    cust_name   VARCHAR(30),
    addr        VARCHAR(30),
    phone       INT,
    email       VARCHAR(30),
    dob         DATE,
    city_id     INT
        REFERENCES city2 ( city_id )
);

CREATE TABLE online (
    cust_id       INT,
    cust_name     VARCHAR(30),
    addr          VARCHAR(30),
    phone         INT,
    email         VARCHAR(30),
    dob           DATE,
    postal_code   INT,
    state         VARCHAR(30)
);

CREATE TABLE udp_cust_scd1 (
    cust_id       INT,
    cust_name     VARCHAR(30),
    addr          VARCHAR(30),
    phone         INT,
    email         VARCHAR(30),
    dob           DATE,
    city_name     VARCHAR(30),
    state         VARCHAR(30),
    postal_code   INT
);

CREATE OR REPLACE PROCEDURE udp_cust_scd1_load AS

BEGIN

--inserting both online and offline cust record
    INSERT INTO cust_scd1 c_scd
        SELECT
            custseq.NEXTVAL,
            s.cust_name,
            s.addr,
            s.phone,
            s.email,
            s.dob,
            c.city_name,
            o.postal_code,
            s.state
        FROM
            (
                SELECT
                    cust_name,
                    addr,
                    phone,
                    email,
                    dob,
                    city_name
                FROM
                    store   s,
                    city    c
                WHERE
                    s.city_id = c.city_id
                ORDER BY
                    cust_name,
                    dob
            ) s,
            (
                SELECT
                    cust_name,
                    addr,
                    phone,
                    email,
                    dob,
                    postal_code,
                    state
                FROM
                    online
                ORDER BY
                    cust_name,
                    dob
            ) o
        WHERE
            s.cust_name = o.cust_name
            AND s.dob = o.dob
            AND ( s.cust_name,
                  s.dob ) NOT IN (
                SELECT
                    cust_name,
                    dob
                FROM
                    cust_scd1
            );
 	
		
-- inserting records of offline customer form store 

    INSERT INTO cust_scd1
        SELECT
            custseq.NEXTVAL,
            s.cust_name,
            s.addr,
            s.phone,
            s.email,
            s.dob,
            city_name,
            NULL,
            NULL
        FROM
            (
                SELECT
                    cust_name,
                    addr,
                    phone,
                    email,
                    dob,
                    postal_code,
                    state
                FROM
                    store   ss,
                    city2   c
                WHERE
                    ss.city_id = c.city_id
            ) s
        WHERE
            ( s.cust_name,
              s.dob ) NOT IN (
                SELECT
                    cust_name,
                    dob
                FROM
                    cust_scd1
            )
            AND ( o.cust_name,
                  o.dob ) NOT IN (
                SELECT
                    cust_name,
                    dob
                FROM
                    store
            );
		
--inserting the records of only online customer

    INSERT INTO cust_scd1
        SELECT
            custseq.NEXTVAL,
            cust_name,
            addr,
            phone,
            email,
            dob,
            NULL,
            postal_code,
            state
        FROM
            (
                SELECT
                    cust_name,
                    addr,
                    phone,
                    email,
                    dob,
                    postal_code,
                    state
                FROM
                    online
            ) o
        WHERE
            ( o.cust_name,
              o.dob ) NOT IN (
                SELECT
                    cust_name,
                    dob
                FROM
                    cust_scd1
            )
            AND ( o.cust_name,
                  o.dob ) NOT IN (
                SELECT
                    cust_name,
                    dob
                FROM
                    store
            );

UPDATE online o
SET
    phone = (
        SELECT
            phone
        FROM
            store s
        WHERE
            s.cust_name = o.cust_name
            AND s.dob = o.dob
    ),
    addr = (
        SELECT
            addr
        FROM
            store s
        WHERE
            s.cust_name = o.cust_name
            AND s.dob = o.dob
    ),
    email = (
        SELECT
            email
        FROM
            store s
        WHERE
            s.cust_name = o.cust_name
            AND s.dob = o.dob
    ),
    state =
        CASE
            WHEN state <> (
                SELECT
                    state_name
                FROM
                    store   s,
                    city    c,
                    store   st
                WHERE
                    s.city_id = c.city_id
                    AND c.state_id = st.state_id
                    AND s.cust_name = o.cust_name
                    AND s.dob = o.dob
            ) THEN
                (
                    SELECT
                        state_name
                    FROM
                        store   s,
                        city    c,
                        store   st
                    WHERE
                        s.city_id = c.city_id
                        AND c.state_id = st.state_id
                        AND s.cust_name = o.cust_name
                        AND s.dob = o.dob
                )
            ELSE
                state
        END	
			POSTAL_CODE=CASE WHEN
			 (SELECT CITY_NAME FROM CUST_SCD1 C WHERE C.cust_name=O.CUST_NAME AND C.DOB=O.DOB)=
			 (SELECT CITY_NAME FROM STORE S,CITY2 C WHERE S.CITY_ID=C.CITY_ID AND S.CUST_ID=O.CUST_NAME AND S.DOB=C.DOB)
			  THEN POSTAL_CODE ELSE NULL END

		WHERE (O.CUST_NAME,O.DOB) IN (SELECT CUST_NAME,DOB FROM STORE);

		update CUST_SCD1 C_SCD
		set phone= (SELECT phone from store S where s.cust_name=C_SCD.CUST_NAME AND S.DOB=C_SCD.DOB),
			ADDR=(SELECT ADDR from store S where s.cust_name=C_SCD.CUST_NAME AND S.DOB=C_SCD.DOB),
			EMAIL=(SELECT EMAIL from store S where s.cust_name=C_SCD.CUST_NAME AND S.DOB=C_SCD.DOB),
			CITY_NAME=(SELECT CITY_NAME from store S, CITY2 C  where S.CITY_ID=C.CITY_ID 
						AND s.cust_name=C_SCD.CUST_NAME AND S.DOB=C_SCD.DOB)
		WHERE(C_SCD.CUST_NAME,C_SCD.DOB) IN ( SELECT CUST_NAME,DOB FROM STORE S,CITY2 C
											 where  S.CITY_ID=C.CITY_ID
											 C_SCD.PHONE<>phone
											 OR  SCD.ADDR<>ADDR
											 OR C_SCD.EMAIL<>EMAIL
											 OR C_SCD.CUST_NAME<>CITY_NAME);
		

		udpate cust_scd1 c_scd
		SET phone =(SELECT PHONE FROM ONLINE O WHERE O.CUST_NAME.C_SCD.CUST_NAME AND O.DOB=C_SCD.DOB),
			EMAIL=(SELECT EMAIL FROM ONLINE O WHERE O.CUST_NAME.C_SCD.CUST_NAME AND O.DOB=C_SCD.DOB),
			ADDR=(SELECT ADDR FROM ONLINE O WHERE O.CUST_NAME.C_SCD.CUST_NAME AND O.DOB=C_SCD.DOB),
			POSTAL_CODE=(SELECT POSTAL_CODE FROM ONLINE O WHERE O.CUST_NAME.C_SCD.CUST_NAME AND O.DOB=C_SCD.DOB),
			STATE=(SELECT STATE FROM ONLINE O WHERE o.cust_name.c_scd.cust_name AND o.dob = c_scd.dob )
WHERE
    ( cust_name,
      dob ) IN (
        SELECT
            cust_name,
            dob
        FROM
            online
        WHERE
            c_scd.phone <> phone
            OR c_scd.email <> email
               OR c_scd.addr <> addr
                  OR c_scd.postal_code <> postal_code
                     OR c_scd.state <> state
    );

END;
/