const express= require('express');
const app = express();
const configViewEngine = require('../config/viewEngine')
const connection = require('../config/database')
configViewEngine(app);


 const postCreateUser = (req, res) => {
     const { Cr_user, Cr_mail, password, confirmPassword, role } = req.body;
            
            // Kiểm tra xem mật khẩu xác nhận có khớp không
            if (password !== confirmPassword) {
                return res.status(400).send('Mật khẩu xác nhận không khớp.');
            }
        
            // Kiểm tra xem tài khoản đã tồn tại trong hệ thống hay chưa
            const checkUserQuery = 'SELECT * FROM Users WHERE username = ?';
            connection.query(checkUserQuery, [Cr_user], (error, results, fields) =>{
                if (error) {
                    console.error('Lỗi khi kiểm tra tài khoản:', error);
                    return res.status(500).send('Đã xảy ra lỗi khi kiểm tra tài khoản.');
                }
                if (results.length > 0) {
                    return res.status(400).send('Tài khoản đã tồn tại trong hệ thống.');
                }

               // kiểm tra gmail trong hệ thống
               const checkemailquery = 'SELECT * FROM Users WHERE email = ?';
                connection.query(checkemailquery,[Cr_mail], (error, results, fields) => {
                    if (error) {
                        console.error('Lỗi khi kiểm tra mail:', error);
                        return res.status(500).send('Đã xảy ra lỗi khi kiểm tra mail.');
                    }
                    if (results.length > 0) {
                        return res.status(400).send('mail đã tồn tại.');
                    }});

                // Thêm người dùng mới vào cơ sở dữ liệu nếu không có tài khoản trùng lặp
                const insertUserQuery = 'INSERT INTO Users (username, email, password, role) VALUES (?, ?, ?, ?)';
                connection.query(insertUserQuery, [Cr_user, Cr_mail, password, role], (error, results, fields) => {
                    if (error) {
                        console.error('Lỗi khi thêm người dùng mới:', error);
                        return res.status(500).send('Đã xảy ra lỗi khi đăng ký. Vui lòng thử lại sau.');
                    }
            
                    req.flash('success', 'Đăng ký thành công!');
                    res.redirect('/login');
                });
            });
        };
        
        
    
module.exports = {
 postCreateUser
}