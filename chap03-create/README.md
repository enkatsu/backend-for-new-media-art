# Chap. 03

## Initializa

```sql
drop table if exists balls;
create table if not exists balls(id integer primary key autoincrement, x real, y real, r real);
insert into balls(x, y, r) values(?, ?, ?);
```

## Store ball API

`POST /balls`

```sql
insert into balls(x, y, r) values (?, ?, ?);
```
