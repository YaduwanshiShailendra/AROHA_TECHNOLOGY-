/*
##################################################
 Objective                : Sales Analysis Module
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 23-March-2020
##################################################

                Sales Analysis Module
__________                              ________
|CUST     |         ___________         |PROD   |
|---------|         |SALES    |         |-------|
|cust_id  |         |---------|         |pid    |
|cust_name|         |sid      |         |pname  |
|addr     |         |cust_id  |         |price  |
|phone    |         |pid      |         |cost   |
|dob      |         |quantity |         |family |
|city     |         |amount   |         ---------
-----------         |margin   |         
                    |sale_date|         
                    -----------         

Requirement									
Create a code which takes in customer id, product id and sales quantity as inputs. The code is to validate the customer and product id and check if the quantity is a valid number and insert that record into the sales table. The cases the code is to handle is as mentioned below.
- If customer id, product id are valid and if the quantity is more than 0, then insert a record into the sales tables for this transaction.
- If the quantity is less than or equal to 0 then display a message saying invalid quantity
- If the customer id and product id are invalid, then flag a message saying invalid customer and product.
- In case of either only customer id or product id being invalid, then flag a message corresponding to the same id									
									
*/									

select * from customer_detail;
select * from sales;
select * from product;


DECLARE

			V_CUS_ID customer_detail.CUST_ID%TYPE:=&CUSTOMER_NO;
			V_PID PRODUCTDETAILS.PID%TYPE:=&PRODUCTID;
			V_QTY INT:=&ENTER_QTY;
			V_PRICE PRODUCT_DETAIL.PRODUCT_PRICE%TYPE ;
			QTY_EXCP EXCEPTION;
			
		BEGIN

			IF V_QTY<=0
			THEN
			RAISE QTY_EXCP;
			END IF;

			SELECT CUST_ID  INTO V_CUST_ID
			FROM CUSTOMER_DETAIL
			WHERE CUST_ID=V_CUST_ID;


			SELECT product_PRICE  INTO V_PRICE
			FROM PRODUCT
			WHERE PD_ID=V_PID;


			INSERT INTO SALES VALUES(SELECT MAX(SALES_ID) FROM SALES,V_CUST_ID,V_PID,V_QTY,'CASH',SYSDATE);

			EXCEPTION
				
				WHEN QTY_EXCP
				THEN
				DBMS_OUTPUT.PUT_LINE('INVALID QUANTITY');
				
				WHEN NO_DATA_FOUND
				
				THEN

					BEGIN
							SELECT PRODUCT_PRICE  INTO V_PRICE
							FROM PRODUCT_DETAIL
							WHERE PD_ID=V_PID;

							EXCEPTION
							WHEN NO_DATA_FOUND
							THEN					
							IF V_PRICE IS NULL AND V_CUST_ID IS NULL 
							THEN
							DBMS_OUTPUT.PUT_LINE('BOTH PRODUCT ID AND CUSTOMER ID IS INVALID');
							ELSIF V_PRICE IS NULL
							THEN 
							DBMS_OUTPUT.PUT_LINE('PRODUCT ID IS INVALID');
							ELSE 
							DBMS_OUTPUT.DBMS_OUTPUT('INVALID CUSTOMER NO');
							END IF;
					END ;
			END;



