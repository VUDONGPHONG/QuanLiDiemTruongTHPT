
const gettracuu = (req,res) =>{
           return res.render('tracuu',{
            user: req.session.user
           })
        }
    
module.exports = {
    gettracuu
}