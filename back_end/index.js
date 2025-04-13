const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth.js');

const DBC = 'mongodb+srv://m07amed1st:ONTTBzKysUIpIi5k@cluster0.yh53t7d.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';

const port = 3020

const app = express();

app.use(authRouter);
// app.use(express.json());


mongoose.connect(DBC).then(() => {
    console.log('MongoDB connected successfully!');
}).catch((err) => {
    console.log(err);
});

app.listen(port, "0.0.0.0", () => {
    console.log('its working on port ' + port + '...');
});


// app.get('/hellow_world', (req, res) => { res.send('Hello World!') });
// const bodyParser = require('body-parser');
// app.use(bodyParser.json());
// const cors = require('cors');