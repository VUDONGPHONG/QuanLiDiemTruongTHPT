const path = require('path');
const express = require('express');
const flash = require('connect-flash');
const session = require('express-session');

const configViewEngine = (app) => {
    app.set('views', path.join('./src', 'views'));
    app.set('view engine', 'ejs');
    app.use(express.urlencoded({ extended: false }));
    app.use(express.json());
    app.use(express.static(path.join('./src', 'public')));
    app.use(session({
        secret: 'secret',
        resave: false,
        saveUninitialized: true
    }));
    app.use(flash());
};

module.exports = configViewEngine;
