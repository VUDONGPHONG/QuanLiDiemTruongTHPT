const express= require('express');
const app = express();

const configViewEngine = require('../config/viewEngine')
const connection = require('../config/database')
configViewEngine(app);



const getlogin = (req, res) => {
    const successMessage = req.flash('success');
    const errorMessage = req.flash('error');
    return res.render('login', { successMessage, errorMessage });
};

const postLogin = (req, res) => {
    const { user, password_check } = req.body;

    const query = 'SELECT * FROM Users WHERE username = ? AND password = ?';
    connection.query(query, [user, password_check], (error, results, fields) => {
        if (error) {
            console.error('Lỗi khi đăng nhập:', error);
            return res.status(500).send('Đã xảy ra lỗi khi đăng nhập.');
        }

        if (results.length > 0) {
            req.session.user = results[0]; // Lưu thông tin người dùng vào session
            console.log('User session:', req.session.user); // In ra thông tin của session user
            return res.redirect('/home');
        } else {
            req.flash('error', 'Tên đăng nhập hoặc mật khẩu không đúng.');
            return res.redirect('/login');
        }
    });
};


module.exports = {
    getlogin,
    postLogin
};

    
module.exports = {
 getlogin,
 postLogin
}