set serveroutput on;
--------------------------------------------------------------------------------------------------------------------------------

/*
objective:-create a procedure which takes a date and customer id and pass another argument month_year_inception flag as in input and we need the below mentioned outputs.
Asset value as of purchase, asset value as of today, profit/loss amount
created by:-Arunkumar
created date:-15/06/2020
*/

create or replace procedure udp_profit_loss (invst number,dt date,c varchar2)
as
type r is record (fund number,units number,rate number);
type t is table of r;
type t1 is table of int;
v1 t;
v2 t;
fund t1;
invalid_arg exception;
investor_invalid exception;
yr number;
mt number;
cnt number(5);
su number:=0;
sell number;
begin
yr:=to_char(dt,'yyyy');--take year in argument
 mt:=to_char(dt,'mm');--take month in argument
 ---check the investor id is right or wrong 
  select count(*) into cnt from investor where investor_id=invst ; 
  if cnt=0 then
   raise investor_invalid;--investor id is wrong exception will arise
  end if;
  select commodity_id bulk collect into fund from commodities;  
  --iterate one by one fund_id
  begin
   for k in 1..fund.count loop 
     if lower(c)='m'
       then
       select t.commodity_id,t.units,e.exchange_rate bulk collect into v1
         from txn_info t right OUTER join exchange_inf e on e.exchange_dt_id=t.txn_dt_id join  ref_calender r on r.yearnum=txn_dt_id
          where t.txn_type='buy' and t.investor_id= invst and t.commodity_id=fund(k) and r.year=yr and r.month_nbr=mt
            order by e.exchange_dt_id;
       select t.commodity_id,t.units,e.exchange_rate bulk collect into v2
          from txn_info t right OUTER join exchange_inf e on e.exchange_dt_id=t.txn_dt_id join  ref_calender r on r.yearnum=txn_dt_id
            where txn_type='sell'and t.investor_id= invst and t.commodity_id=fund(k) and r.year=yr and r.month_nbr=mt
             order by e.exchange_dt_id;
  elsif lower(c)='y'
  then
  select t.commodity_id,t.units,e.exchange_rate bulk collect into v1
    from txn_info t right OUTER join exchange_inf e on e.exchange_dt_id=t.txn_dt_id join  ref_calender r on r.yearnum=txn_dt_id
       where txn_type='buy' and t.investor_id= invst and r.year=yr and t.commodity_id=fund(k)
        order by e.exchange_dt_id;
  select t.commodity_id,t.units,e.exchange_rate bulk collect into v2
     from txn_info t right OUTER join exchange_inf e on e.exchange_dt_id=t.txn_dt_id join  ref_calender r on r.yearnum=txn_dt_id
       where txn_type='sell'and t.investor_id= invst and r.year=yr and t.commodity_id=fund(k)
       order by e.exchange_dt_id;
  else
     raise invalid_arg;
  end if;
  
  for i in 1..v2.count
  loop
   sell:=v2(i).units;
     for j in 1..v1.count
     loop
       if sell=v1(j).units
        then
         su:=su+(v2(i).rate-v1(j).rate)*v1(j).units;
          v1.delete(j);
          exit;
       elsif sell<v1(j).units
        then
          su:=su+(v2(i).rate-v1(j).rate)*sell;
           v1(j).units:=v1(j).units-sell;
            exit;
        else
          sell:=sell-v1(j).units;
          su:=su+(v2(i).rate-v1(j).rate)*v1(j).units;          
       end if;
    end loop;
            
  end loop;
  
 end loop;
 end;
 if su>0
 then
     dbms_output.put_line('total profit is '||su);
  else
       dbms_output.put_line('total loss is '||(su*-1));
 end if ;
exception
when invalid_arg then
  dbms_output.put_line('invalid third argument');
when investor_invalid then
  dbms_output.put_line('investor id invalid ');
when others then 
   dbms_output.put_line('try again');
end;


exec udp_profit_loss(8,sysdate,'y');





select * from investor;
select * from commodities;
select * from txn_info;
select * from exchange_inf;

select t. commodity_id,t.units,e.exchange_rate,r.dt from txn_info t right OUTER join exchange_inf e on e.exchange_dt_id=t.txn_dt_id join  ref_calender r on r.yearnum=txn_dt_id
where txn_type='buy'and investor_id=8 and r.year=2020 and r.month_nbr=6
order by e.exchange_dt_id;

select t. commodity_id,t.units,e.exchange_rate from txn_info t right OUTER join exchange_inf e on e.exchange_dt_id=t.txn_dt_id where txn_type='sell'
order by e.exchange_dt_id;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------