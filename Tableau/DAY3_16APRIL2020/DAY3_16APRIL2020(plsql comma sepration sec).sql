/*
##################################################
 Objective                : PL/SQL scenario
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 24-March-2020
##################################################

Question:
solve the scenario where you pass all city names separated by a comma as an input into your code and print the names one after the other.

Eg:
i/p: Bangalore, Chennai, Delhi, Mumbai

o/p:
Bangalore
Chennai
Delhi
Mumbai
*/


WITH data AS (
    SELECT
        'Bangalore, Chennai, Delhi, Mumbai' str
    FROM
        dual
)
SELECT
    TRIM(regexp_substr(str, '[^,]+', 1, level)) str
FROM
    data
CONNECT BY
    instr(str, ',', 1, level - 1) > 0
/



--creating type
CREATE OR REPLACE TYPE test_type AS
    TABLE OF VARCHAR2(100)
/


--creating the function for comma sepration
CREATE OR REPLACE FUNCTION comma_to_table (
    p_list IN VARCHAR2
) RETURN test_type AS

    l_string        VARCHAR2(32767) := p_list || ',';
    l_comma_index   PLS_INTEGER;
    l_index         PLS_INTEGER := 1;
    l_tab           test_type := test_type();
BEGIN
    LOOP
        l_comma_index := instr(l_string, ',', l_index);
        EXIT WHEN l_comma_index = 0;
        l_tab.extend;
        l_tab(l_tab.count) := trim(substr(l_string, l_index, l_comma_index - l_index));

        l_index := l_comma_index + 1;
    END LOOP;

    RETURN l_tab;
END comma_to_table;
/


SELECT
    *
FROM
    TABLE ( comma_to_table('Bangalore, Chennai, Delhi, Mumbai') )
/