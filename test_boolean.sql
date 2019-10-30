
create table t1 
(Name varchar,
Bum boolean)
partition of Bum for values in (true);

create table bools_t 
(
Name varchar,
bools boolean)
partition of bools for values in (true);
