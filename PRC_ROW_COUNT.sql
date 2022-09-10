CREATE OR REPLACE procedure hr_dba.rowcount(p_group in varchar2, p_part in number default 0) AUTHID CURRENT_USER is

 v_tgtcount number(16) := 0;
 v_srccount number(16) := 0;
 v_sqlstmt0 varchar2(1000);
 v_sqlstmt1 varchar2(1000);
 v_begin    date;
 v_end      date;

 v_schema   varchar2(50):='HR';
 v_where    varchar2(4000):='1=1';
 v_parallel varchar2(50):='PARALLEL(8)';
 v_stmt_str   VARCHAR2(4000);
 TYPE CurTyp  IS REF CURSOR;
 v_cursor     CurTyp;
 v_table_name varchar2(50); 


begin

if p_group='group1a' and p_part=0 then 
 v_parallel:='PARALLEL(8)';
 v_where:='name=''TB_ACTIVITY''';

elsif  p_group='group1a' and p_part=1 then 
 v_parallel:='PARALLEL(8)';
 v_where:='name!=''TB_ACTIVITY''';

elsif  p_group='group1b' and p_part=0 then 
 v_parallel:='PARALLEL(8)';
 v_where:='1=1';

elsif p_group='group2a' and p_part=0 then 
 v_parallel:='PARALLEL(8)';
 v_where:='name in (''TB_REC'',''TB_LINK'')';

elsif p_group='group2a' and p_part=1 then 
 v_parallel:='PARALLEL(8)';
 v_where:='name not in (''TB_REC'',''TB_LINK'')';

elsif  p_group='group2b' and p_part=0 then 
 v_parallel:='PARALLEL(8)';
 v_where:='1=1';

else
 raise_application_error(-20001,'Parameter error!');
end if;


 v_stmt_str:='select name from hr_dba.'||p_group||' where '||v_where;

 
 OPEN v_cursor FOR v_stmt_str;

 LOOP
    FETCH v_cursor INTO v_table_name;
    EXIT WHEN v_cursor%NOTFOUND;

    v_begin:=sysdate;

    v_sqlstmt0 := 'select /*+ '||v_parallel||' */ count(*) from HR.'||v_table_name;

    execute immediate v_sqlstmt0 into v_tgtcount;

    v_end:=sysdate;


    v_sqlstmt1 := 'insert into hr_dba.gstats (schemaname,tablename,start_time,end_time,groupn,partn,row_cnt_target) values ('''||v_schema||''','''||v_table_name||''','''||v_begin||''','''||v_end||''','''||p_group|| ''','''||p_part|| ''','|| v_tgtcount ||' )' ;

    execute immediate v_sqlstmt1;

    commit;

 END LOOP;

 CLOSE v_cursor;

exception
  when others
  then
   raise_application_error(-20001,sqlerrm);
end;