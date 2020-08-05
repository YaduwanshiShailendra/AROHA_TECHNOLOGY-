/*
##################################################
 Objective                : TO CREATE A PROCEDURE TO SHOW THE AVERAGE BALANCE OF THE CUSTOMER BY TAKING 
                            THE ACOUNT NO, MONTH AND YEAR AND AND DISPLAY THE ENDING BALANCE
                            AND AVERAGE BALANCE OF EH GIVERN ACOUNT NO. 
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 18-May-2020
##################################################
*/

CREATE OR REPLACE PROCEDURE udp_avg_and_ending_bal (
    account_no    INT,
    month_v      INT,
    year_v       INT
) AS
    max_period_id     INT;
    min_period_date   DATE;
    max_period_date   DATE;
    avg_balance       INT;
    ending_balance    INT;
    no_of_days        INT;
BEGIN
    SELECT
        MAX(period_id)
    INTO max_period_id
    FROM
        period_dm
    WHERE
        to_char(period_date, 'mm') = month_v
        AND to_char(period_date, 'yyyy') = year_v
        AND holiday_flag = 'N';

    SELECT
        MAX(period_date),
        MIN(period_date),
        COUNT(period_date)
    INTO
        max_period_date,
        min_period_date,
        no_of_days
    FROM
        period_dm
    WHERE
        to_char(period_date, 'mm') = month_v
        AND to_char(period_date, 'yyyy') = year_v;

    SELECT
        balance
    INTO ending_balance
    FROM
        dd_eod_balance
    WHERE
        period_id = max_period_id;

    SELECT
        SUM(
            CASE
                WHEN to_char(period_date, 'dy') NOT IN(
                    'sat', 'sun'
                ) THEN
                    balance
                WHEN to_char(period_date, 'dy') = 'sat'   THEN
                    (
                        SELECT
                            balance
                        FROM
                            dd_eod_balance
                        WHERE
                            period_id = pd.period_id - 1
                    )
                WHEN to_char(period_date, 'dy') = 'sun'   THEN
                    (
                        SELECT
                            balance
                        FROM
                            dd_eod_balance
                        WHERE
                            period_id = pd.period_id - 2
                    )
            END
        ) / no_of_days
    INTO avg_balance
    FROM
        period_dm        pd,
        dd_eod_balance   dd
    WHERE
        pd.period_id = dd.period_id (+)
        AND period_date BETWEEN min_period_date AND max_period_date;

    dbms_output.put_line('acnt no'
                         || ' '
                         || 'avg_balance'
                         || ' '
                         || 'ending_balance');

    dbms_output.put_line(account_no
                         || '    '
                         || avg_balance
                         || '         '
                         || ending_balance);

END;
/

EXEC udp_avg_and_ending_bal(2222, 04, 2020);