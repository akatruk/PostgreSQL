
create table t1 
(
ID int not null,
name varchar (50) not null
)

insert into t1 (ID, Name) values ('1', 'Andrey')
insert into t1 (ID, Name) values ('2', 'Sergey')


create table t2
(
ID int not null,
name varchar (50) not null
)

create or replace function ttt1()
returns trigger as
$$
begin
	insert into t2 (ID, Name) values (new.id, new.Name);

return new;
end;
$$
language 'plpgsql';

create trigger ttt2
after insert on t1
for each row
execute procedure ttt1();

select * from t2;

