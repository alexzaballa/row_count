CREATE TABLE hr_dba.gstats
(
  SCHEMANAME      VARCHAR2(128),
  TABLENAME       VARCHAR2(128),
  START_TIME      date,
  END_TIME        date,
  ROW_CNT_TARGET  NUMBER,
  GROUPN          VARCHAR2(20 BYTE),
  PARTN           NUMBER
)
TABLESPACE USERS;


CREATE TABLE hr_dba.GROUP1A
(
  NAME  VARCHAR2(128)
)
TABLESPACE USERS;


CREATE TABLE hr_dba.GROUP1B
(
  NAME  VARCHAR2(128)
)
TABLESPACE USERS;


CREATE TABLE hr_dba.GROUP2A
(
  NAME  VARCHAR2(128)
)
TABLESPACE USERS;


CREATE TABLE hr_dba.GROUP2B
(
  NAME  VARCHAR2(128)
)
TABLESPACE USERS;


-----
--add your table list here
--if you have rac, you can balance by table size and run on each node
-----

insert into hr_dba.GROUP1A values('TB_ACTIVITY');
insert into hr_dba.GROUP1A values('TB_ACTIVITY2');
insert into hr_dba.GROUP1A values('TB_ACTIVITY3');
commit;

insert into hr_dba.GROUP1B values('TB_START');
commit;

insert into hr_dba.GROUP2A values('TB_REC');
insert into hr_dba.GROUP2A values('TB_REC2');
insert into hr_dba.GROUP2A values('TB_REC3');
commit;

insert into hr_dba.GROUP2A values('TB_LINK');
insert into hr_dba.GROUP2A values('TB_LINK2');
insert into hr_dba.GROUP2A values('TB_LINK3');
commit;

insert into hr_dba.GROUP2B values('TB_OMEGA');
commit;