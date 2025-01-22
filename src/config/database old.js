
const mysql = require('mysql2');
const database = require('mime-db');
//test connection
const connection = mysql.createConnection({
    host:'localhost',
    port: 3307,
    user:'root',
    password:'123456',
    database:'hoidanit'
});

// const connection = mysql.createPool({
//     host:'localhost',
//     port: 3307,
//     user:'root',
//     password:'123456',
//     database:'hoidanit',
//     waitForConnections: true,
//      connectionLimit: 10,
//      queueLimit: 0
// });

module.exports = connection;
