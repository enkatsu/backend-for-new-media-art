const sqlite3 = require('sqlite3')
const db = new sqlite3.Database('./db.sqlite')

db.serialize(() => {
    db.run('drop table if exists balls')
    db.run('create table if not exists balls(id integer primary key autoincrement, x real, y real, r real)')
    for (let i = 0; i < 3; i++) {
        db.run('insert into balls(x, y, r) values(?, ?, ?)', Math.random(), Math.random(), Math.random())
    }    
    db.all('select * from balls', (err, row) => {
        console.log(row)
    })
})

db.close()
