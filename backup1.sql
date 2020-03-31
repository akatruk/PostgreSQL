--  новая таблица school
create table 
school(
    school_id serial,
    school_number int NOT null,
    PRIMARY KEY (school_id));

-- наполняем уникальными школами таблицу school
INSERT INTO school (school_number)
SELECT distinct id_school
FROM public.users_roles
where id_school is not null
group by id_school

-- 

SELECT ur.id as role_id, ur.ID_SCHOOL as organization_ids FROM users_roles ur WHERE ur.ID_SCHOOL IS NOT NULL;

107	16	STUDENT
6575	100	TEACHER
9414		BUYER
2312 200    TEACHER
SELECT id, id_school, role_name
FROM public.users_roles limit 100;

select ur.* from users us
join users_role_mapping urm
on us.id = urm.user_id
join users_roles_permissions ur
on urm.role_id=ur.id 
where us.username = '00000000007'

select ur.* from users us
join users_role_mapping urm
on us.id = urm.user_id
join users_roles ur
on urm.role_id=ur.id 
where us.username = '00000000007'

select max (us.username), count (ur.role_name) as co, max (ur.role_name) 
from users us
join users_role_mapping urm
on us.id = urm.user_id
join users_roles ur
on urm.role_id=ur.id
group by us.username, ur.role_name
having count (ur.role_name) > 1

CREATE table users_role_new
as select max (ur.id) id, max (ur.id_school) id_school, count (ur.role_name) co, max (ur.role_name) role_name, max (us.username) username
from users us
join users_role_mapping urm
on us.id = urm.user_id
join users_roles ur
on urm.role_id=ur.id
group by us.username, ur.role_name

CREATE TABLE role_organization_ids AS SELECT ur.id as role_id, ur.ID_SCHOOL as organization_ids FROM users_roles ur WHERE ur.ID_SCHOOL IS NOT NULL;

ALTER TABLE users_roles RENAME TO users_roles_permissions;
ALTER TABLE users_role_new RENAME TO users_roles;
ALTER TABLE users_roles drop ID_SCHOOL;

select count (*) from users_roles ur
select count (*) from users_roles_permissions ur
select count (*) from users_role_mapping

delete
from users_role_mapping
where user_id in (select m.role_id
from users_role_mapping m
left join users_roles ur
on ur.id = m.role_id
where ur.id is null)


select * 
from users_role_mapping 
where role_id between 2623 and 2631
