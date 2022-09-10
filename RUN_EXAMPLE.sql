--NODE1

set serveroutput on

begin 
 hr_dba.rowcount('group1a');
end;
/

begin 
 hr_dba.rowcount('group1a',p_part=>1);
end;
/

begin 
 hr_dba.rowcount('group1b');
end;
/


--NODE2

set serveroutput on

begin 
 hr_dba.rowcount('group2a');
end;
/

begin 
 hr_dba.rowcount('group2a',p_part=>1);
end;
/

begin 
 hr_dba.rowcount('group2b');
end;
/

-----
--check the stats after run
-----
select * from hr_dba.gstats order by start_time;
