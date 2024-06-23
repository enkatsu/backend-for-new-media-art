const sqlite3 = require('sqlite3')
const db = new sqlite3.Database('./db.sqlite')

db.serialize(() => {
    db.run('drop table if exists lines')
    db.run('create table if not exists lines(id integer primary key autoincrement)')
    db.run('drop table if exists points')
    db.run('create table if not exists points(id integer primary key autoincrement, line_id integer, x real, y real)')
})

db.close()
