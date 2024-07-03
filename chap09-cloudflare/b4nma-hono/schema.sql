drop table if exists balls;
create table if not exists balls(id integer primary key autoincrement, x real, y real, r real);
insert into balls(x, y, r) values(0.5, 0.6, 0.9);
insert into balls(x, y, r) values(0.2, 0.3, 0.8);
insert into balls(x, y, r) values(0.2, 0.7, 0.99);
