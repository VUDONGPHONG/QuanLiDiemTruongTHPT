const path = require('path')
const connection = require('../config/database')

let Users = [];

// const getHomepage = (req,res) =>{
//             res.sendFile(path.resolve('./src/html/home.html'))
//         }
    
const getHomepage = (req,res) =>{
           return res.render('home',{
            user: req.session.user 
           })
        }
    

const test = (req,res) =>{
    connection.query(
        'SELECT * FROM Users',
        function (err, results, fields) {
         Users = results;
            console.log(">>>result get home = ",results); // results contains rows returned by server
            console.log(" >> check users: ", Users)
            res.send(JSON.stringify(Users))
        }
      );
    }

module.exports = {
    getHomepage,
    test
}