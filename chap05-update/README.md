# Chap. 05

## Initializa

```sql
drop table if exists balls;
create table if not exists balls(id integer primary key autoincrement, x real, y real, r real);
insert into balls(x, y, r) values(?, ?, ?);
```

## Update ball position API

`PUT /balls/:id`

```sql
update balls set x = ?, y = ? where id = ?;
```
