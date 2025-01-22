const express = require('express');
const router = express.Router();
const path = require('path')
const fs = require('fs')
const {getHomepage,test} = require('../controllers/homeController')
const {gettracuu} = require('../controllers/tracuuController');
const { getinfor } = require('../controllers/inforController');
const { getcontact, getcontactSubmit } = require('../controllers/ctController');
const { getlogin, postLogin} = require('../controllers/loginController');
const { postCreateUser } = require('../controllers/register');
const {loginMiddleware, roleMiddleware} = require('../middleware/mainMiddleware');
const { logout } = require('../controllers/logoutController');
//router.Method('/route',handler)

router.get('/home',loginMiddleware,getHomepage);
router.get('/test',loginMiddleware,test);
router.get('/tracuu',loginMiddleware, gettracuu);
router.get('/contact',loginMiddleware, getcontact);
router.get('/infor', loginMiddleware,roleMiddleware('admin'),getinfor);
router.get(['/login','/'],getlogin);
router.post('/create-user',postCreateUser)
router.post('/contact-submit', getcontactSubmit)
router.post('/check_login',postLogin)
router.get('/logout', logout)
 
// static file
// css, js,img home
router.get('/public/home.js', (req, res) => {
    res.header('Content-Type: text/javascript')
    res.sendFile(path.resolve('./src/public/home.js'))
})

router.get('/public/home.css', (req, res) => {
    res.header('Content-Type: text/css')
    res.sendFile(path.resolve('./src/public/home.css'))
})

router.get('/public/OIP.jpg', (req, res) => {
    res.header('Content-Type: image/jpg')
    res.sendFile(path.resolve('./src/public/OIP.jpg'))
})

// css, js, img tra cuu
router.get('/public/tracuu.js', (req, res) => {
    res.header('Content-Type: text/javascript')
    res.sendFile(path.resolve('./src/public/tracuu.js'))
})

router.get('/public/tracuu.css', (req, res) => {
    res.header('Content-Type: text/css')
    res.sendFile(path.resolve('./src/public/tracuu.css'))
})

//css, js, img contact
router.get('/public/contact.js', (req, res) => {
    res.header('Content-Type: text/javascript')
    res.sendFile(path.resolve('./src/public/contact.js'))
})

router.get('/public/contact.css', (req, res) => {
    res.header('Content-Type: text/css')
    res.sendFile(path.resolve('./src/public/contact.css'))
})

//css, js , img infor
router.get('/public/infor.js', (req, res) => {
    res.header('Content-Type: text/javascript')
    res.sendFile(path.resolve('./src/public/infor.js'))
})

router.get('/public/infor.css', (req, res) => {
    res.header('Content-Type: text/css')
    res.sendFile(path.resolve('./src/public/infor.css'))
})

//css, js , img login
router.get('/public/login.js', (req, res) => {
    res.header('Content-Type: text/javascript')
    res.sendFile(path.resolve('./src/public/login.js'))
})

router.get('/public/login.css', (req, res) => {
    res.header('Content-Type: text/css')
    res.sendFile(path.resolve('./src/public/login.css'))
})

router.get('/public/login.webp', (req, res) => {
    res.header('Content-Type: image/webp')
    res.sendFile(path.resolve('./src/public/login.webp'))
})


module.exports = router;