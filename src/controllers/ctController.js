const path = require('path')
const connection = require('../config/database')
const fs = require('fs')

const getcontact = (req,res) =>{
           return res.render('contact',{
            user: req.session.user
           })
        }

const getcontactSubmit = ((req, res) => { 
    fs.appendFileSync(path.resolve('src/data/comments.txt'),
`
------------------
NAME: ${req.body.name}
EMAIL: ${req.body.email}
CLASS: ${req.body.class}
COMMENT: ${req.body.comment}`);
    
    res.send('ok')
})

module.exports = {
    getcontact,
    getcontactSubmit
}