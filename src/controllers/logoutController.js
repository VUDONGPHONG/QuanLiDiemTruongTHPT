
const logout = (req, res) => {
    // Xóa thông tin phiên đăng nhập
    req.session.destroy((err) => {
        if (err) {
            console.error('Lỗi khi đăng xuất:', err);
            return res.status(500).send('Đã xảy ra lỗi khi đăng xuất.');
        }
        // Chuyển hướng người dùng về trang đăng nhập hoặc trang chính
        return res.redirect('/login'); // Thay '/login' bằng URL của trang đăng nhập hoặc trang chính
    });
};

module.exports = {
    logout
};