const express = require('express')
const path = require('path')
const fs = require('fs')
const app = express();
const configViewEngine = require('./src/config/viewEngine');
const webRoutes = require('./src/routes/web')


//config template engine
configViewEngine(app);

//khai báo routes
app.use('/', webRoutes);


app.listen(3000, () => {
    console.log('Server running at port 3000...');
})