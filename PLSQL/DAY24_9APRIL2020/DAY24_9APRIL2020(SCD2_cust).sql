/*
##################################################
Objective                : SCD 2 CUSTOMER TABLE
Author(Creator) Name     : Shailendra Yadav
Developed / Created Date : 09-April-2020
##################################################
*/
CREATE TABLE store (
    cust_id     INT,
    cust_name   VARCHAR(20),
    addr        VARCHAR(20),
    phone       INT,
    email       VARCHAR(20),
    dob         DATE,
    city_id     INT
        REFERENCES city2 ( city_id )
);

CREATE TABLE online (
    cust_id       INT,
    cust_name     VARCHAR(20),
    addr          VARCHAR(20),
    phone         INT,
    email         VARCHAR(20),
    dob           DATE,
    postal_code   INT,
    state         VARCHAR(20)
);

CREATE TABLE cust_scd2 (
    surgid        INT,
    cust_id       INT,
    cust_name     VARCHAR(20),
    addr          VARCHAR(20),
    phone         INT,
    email         VARCHAR(20),
    dob           DATE,
    city_name     VARCHAR(20),
    state         VARCHAR(20),
    postal_code   INT,
    curr_flg      CHAR(1),
    version       INT,
    from_date     DATE,
    to_date       DATE
);

CREATE OR REPLACE PROCEDURE udp_cust_scd2_load AS

BEGIN			

-- insertingg only store data
    INSERT INTO cust_scd2 scd2 (
        surgid,
        cust_id,
        cust_name,
        addr,
        phone,
        email,
        dob,
        city_name
    )
        SELECT
            surgseq.NEXTVAL,
            custseq.NEXTVAL,
            cust_name,
            addr,
            phone,
            email,
            dob,
            city_name,
            1,
            'Y',
            sysdate,
            '31-12-9999'
        FROM
            store   s,
            city2   ct
        WHERE
            s.city_id = ct.city_id
            AND ( cust_name,
                  dob ) NOT IN ( cust_name,
                                 dob FROM cust_scd2)
AND (CUST_NAME,DOB) NOT IN (CUST_NAME,DOB FROM ONLINE);

-- inserting only online data
    INSERT INTO cust_scd2 (
        surgid,
        cust_id,
        cust_name,
        addr,
        phone,
        email,
        dob,
        postal_code,
        state,
        curr_flg,
        version,
        from_date,
        to_date
    )
        SELECT
            surgseq.NEXTVAL,
            custseq.NEXTVAL,
            cust_name,
            addr,
            phone,
            email,
            dob,
            1,
            'Y',
            sysdate,
            '31-12-9999'
        FROM
            online o
WHERE ( cust_name,
        dob ) NOT IN ( cust_name,
                       dob FROM cust_scd2)
AND (CUST_NAME,DOB) NOT IN (
    cust_name,
    dob
FROM store );

--inserting from both online and offline
INSERT INTO cust_scd2 (
    suggid,
    cust_id,
    cust_name,
    addr,
    phone,
    email,
    dob,
    city_name,
    postal_code,
    state
)
    SELECT
        surgseq.NEXTVAL,
        custseq.NEXTVAL,
        st.cust_name,
        st.addr,
        st.phone,
        st.email,
        st.dob,
        st.city_name,
        onl.postal_code,
        onl.state,
        1,
        'Y',
        sysdate,
        '31-12-9999'
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
                city2   ct
            WHERE
                s.city_id = ct.city_id
                AND ( cust_name,
                      dob ) NOT IN (
                    SELECT
                        cust_name,
                        dob
                    FROM
                        cust_scd2
                )
            ORDER BY
                cust_name,
                dob
        ) st,
        (
            SELECT
                cust_name,
                dob,
                postal_code,
                state
            FROM
                online
            WHERE
                ( cust_name,
                  dob ) NOT IN (
                    SELECT
                        cust_name,
                        dob
                    FROM
                        cust_scd2
                )
            ORDER BY
                cust_name,
                dob
        ) onl
    WHERE
        st.cust_name = onl.cust_name
        AND st.dob = onl.dob;

-- update 
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
(SELECT CITY_NAME FROM cust_scd2 C WHERE C.cust_name=O.CUST_NAME AND C.DOB=O.DOB  AND CURR_FLG='Y')=
(SELECT CITY_NAME FROM STORE S,CITY2 C WHERE S.CITY_ID=C.CITY_ID AND S.CUST_ID=O.CUST_NAME AND S.DOB=O.DOB)
THEN POSTAL_CODE ELSE NULL END

WHERE ( cust_name, dob )
IN

( SELECT
    cust_name,
    dob
FROM
    store s
WHERE
    s.cust_name = o.cust_name
    AND s.dob = o.dob
        AND s.phone <> o.phone
            OR s.email <> o.email
               OR s.addr <> o.addr
);

--inserting new records
    INSERT INTO cust_scd2 (
        suggid,
        cust_id,
        cust_name,
        addr,
        phone,
        email,
        dob,
        city_name,
        curr_flg,
        version,
        from_date,
        to_date
    )
        SELECT
            surrseq.NEXTVAL,
            (
                SELECT
                    cust_id
                FROM
                    cust_scd2 scd
                WHERE
                    scd.cust_name = s.cust_name
                    AND scd.dob = s.dob
            ),
            cust_name,
            addr,
            phone,
            email,
            dob,
            city_name,
            (
                SELECT
                    version + 1
                FROM
                    cust_scd2 c2
                WHERE
                    c2.cust_name = s.cust_name
                    AND c2.dob = s.dob
                    AND curr_flg = 'Y'
            ),
            'Y',
            sysdate,
            '31-12-9999'
        FROM
            store   s,
            city2   ct
        WHERE
            s.city_id = ct.city_id
            AND ( cust_name,
                  dob ) IN ( cust_name,
                             dob FROM cust_scd2)
AND  (CUST_NAME,DOB) NOT IN (
    cust_name,
    dob
FROM online )
AND s.addr <> (
    SELECT
        addr
    FROM
        cust_scd2 scd
    WHERE
        scd.cust_name = s.cust_name
        AND scd.dob = s.dob
            AND curr_flg = 'Y'
)
    OR s.phone <> (
    SELECT
        phone
    FROM
        cust_scd2 scd
    WHERE
        scd.cust_name = s.cust_name
        AND scd.dob = s.dob
            AND curr_flg = 'Y'
)
       OR s.email <> (
    SELECT
        email
    FROM
        cust_scd2 scd
    WHERE
        scd.cust_name = s.cust_name
        AND scd.dob = s.dob
            AND curr_flg = 'Y'
)
          OR s.city_name <> (
    SELECT
        city_name
    FROM
        cust_scd2 scd
    WHERE
        scd.cust_name = s.cust_name
        AND scd.dob = s.dob
            AND curr_flg = 'Y'
);

-- inserting when change detection
INSERT INTO cust_scd2 (
    surgid,
    cust_id,
    cust_name,
    phone,
    email,
    dob,
    postal_code,
    state,
    curr_flg,
    version,
    from_date.to_date
)
    SELECT
        surgseq.NEXTVAL,
        (
            SELECT
                cust_id
            FROM
                cust_scd2 scd
            WHERE
                scd.cust_name = o.cust_name
                AND scd.dob = o.dob
        ),
        cust_name,
        phone,
        email,
        dob,
        postal_code,
        state,
        'Y',
        (
            SELECT
                version + 1
            FROM
                cust_scd2 c
            WHERE
                c.cust_name = o.cust_name
                AND c.dob = o.dob
                AND curr_flg = 'Y'
        ),
        sysdate,
        '31-12-9999'
    FROM
        online o
    WHERE
        ( cust_name,
          dob ) IN (
            SELECT
                cust_name,
                dob
            FROM
                cust_scd2
        )
        AND ( cust_name,
              dob ) NOT IN (
            SELECT
                cust_name,
                dob
            FROM
                store
        );

AND o.phone <> (
    SELECT
        phone
    FROM
        cust_scd2 scd
    WHERE
        scd.cust_name = s.cust_name
        AND scd.dob = s.dob
            AND curr_flg = 'Y'
)
    OR email <> (
    SELECT
        email
    FROM
        cust_scd2 scd
    WHERE
        scd.cust_name = s.cust_name
        AND scd.dob = s.dob
            AND curr_flg = 'Y'
)
       OR postal_code <> (
    SELECT
        postal_code
    FROM
        cust_scd2 scd
    WHERE
        scd.cust_name = s.cust_name
        AND scd.dob = s.dob
            AND curr_flg = 'Y'
)
          OR state <> (
    SELECT
        state
    FROM
        cust_scd2 scd
    WHERE
        scd.cust_name = s.cust_name
        AND scd.dob = s.dob
            AND curr_flg = 'Y'
);

--inserting common record for change detection
    INSERT INTO cust_scd2 (
        suggid,
        cust_id,
        cust_name,
        addr,
        phone,
        email,
        dob,
        city_name,
        postal_code,
        state
    )
        SELECT
            surgseq.NEXTVAL,
            (
                SELECT
                    cust_id
                FROM
                    cust_scd2 scd
                WHERE
                    scd.cust_name = st.cust_name
                    AND scd.dob = st.dob
            ),
            st.cust_name,
            st.addr,
            st.phone,
            st.email,
            st.dob,
            st.city_name,
            postal_code,
            state,
            (
                SELECT
                    version + 1
                FROM
                    cust_scd2 c
                WHERE
                    c.cust_name = st.cust_name
                    AND c.dob = st.dob
                    AND curr_flg = 'Y'
            ),
            'Y',
            sysdate,
            '31-12-9999'
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
                    city2   ct
                WHERE
                    s.city_id = ct.city_id
                    AND ( cust_name,
                          dob ) IN (
                        SELECT
                            cust_name,
                            dob
                        FROM
                            cust_scd2
                    )
                ORDER BY
                    cust_name,
                    dob
            ) st,
            (
                SELECT
                    cust_name,
                    dob,
                    postal_code,
                    state
                FROM
                    online
                WHERE
                    ( cust_name,
                      dob ) IN (
                        SELECT
                            cust_name,
                            dob
                        FROM
                            cust_scd2
                    )
                ORDER BY
                    cust_name,
                    dob
            ) onl
        WHERE
            st.cust_name = onl.cust_name
            AND st.dob = onl.dob
            AND st.phone <> (
                SELECT
                    phone
                FROM
                    cust_scd2 s
                WHERE
                    st.cust_name = s.cust_name
                    AND s.dob = st.dob
                    AND curr_flg = 'Y'
            )
            OR st.email <> (
                SELECT
                    email
                FROM
                    cust_scd2 s
                WHERE
                    st.cust_name = s.cust_name
                    AND s.dob = st.dob
                    AND curr_flg = 'Y'
            )
            OR st.addr <> (
                SELECT
                    addr
                FROM
                    cust_scd2 s
                WHERE
                    st.cust_name = s.cust_name
                    AND s.dob = st.dob
                    AND curr_flg = 'Y'
            )
            OR st.city_name <> (
                SELECT
                    city_name
                FROM
                    cust_scd2 s
                WHERE
                    st.cust_name = s.cust_name
                    AND s.dob = st.dob
                    AND curr_flg = 'Y'
            )
            OR onl.postal_code <> (
                SELECT
                    postal_code
                FROM
                    cust_scd2 s
                WHERE
                    onl.cust_name = s.cust_name
                    AND s.dob = st.dob
                    AND curr_flg = 'Y'
            )
            OR onl.state <> (
                SELECT
                    state
                FROM
                    cust_scd2 s
                WHERE
                    onl.cust_name = s.cust_name
                    AND s.dob = st.dob
                    AND curr_flg = 'Y'
            )


--inserting the flag y for current year and n for previous year
UPDATE cust_scd2 c1
SET
    curr_flg = 'N'
to_date = sysdate
WHERE
version = (
        SELECT
            MAX(version) - 1
        FROM
            cust_scd2 c2
        WHERE
            c2.cust_id = c1.cust_id
    ); 
END;
/