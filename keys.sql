create schema test;

drop table test.products;
drop table test.orders;

delete from test.orders where order_id = '1';
delete from test.products where product_no = '1';

insert into test.products (product_no, name) values ('1', 'Andrey');
insert into test.orders (order_id, name) values ('1', 'order1');

select * from test.orders as o join test.products as p on o.order_id=p.product_no;

CREATE TABLE test.products (
    product_no integer,
    name text,
    PRIMARY key (product_no)
);

CREATE TABLE test.orders (
    order_id integer REFERENCES test.products,
    name text
   );