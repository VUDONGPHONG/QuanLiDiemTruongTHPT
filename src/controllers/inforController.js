


const getinfor = (req,res) =>{
           return res.render('infor',{
                user: req.session.user
           })
        }
    
module.exports = {
 getinfor
}