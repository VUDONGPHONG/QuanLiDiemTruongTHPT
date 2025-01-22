
const loginMiddleware = (req, res, next) => {
    if (req.session && req.session.user) {
        return next(); // Người dùng đã đăng nhập, cho phép tiếp tục
    } else {
        return res.redirect('/login'); // Người dùng chưa đăng nhập, chuyển hướng tới trang đăng nhập
    }
};

// src/middleware/roleMiddleware.js

const roleMiddleware = (requiredRole) => {
    return (req, res, next) => {
        if (req.session.user && req.session.user.role === requiredRole) {
            return next(); // Người dùng có vai trò phù hợp, cho phép tiếp tục
        } else {
            return res.status(403).send('Bạn không có quyền truy cập vào trang này.'); // Người dùng không có vai trò phù hợp
        }
    };
};

module.exports = {
    roleMiddleware,
    loginMiddleware
};