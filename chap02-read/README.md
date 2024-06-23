# Chap. 02

## Initializa Database

```sql
drop table if exists balls;
create table if not exists balls(id integer primary key autoincrement, x real, y real, r real);
insert into balls(x, y, r) values(?, ?, ?);
```

## Get all balls API

`GET /balls`

```sql
select * from balls;
```
