const express = require('express');
const port = 3020

const app = express();
app.listen(port, () => {

    console.log('its working on port ' + port + '...');
});


app.get('/hellow_world', (req, res) => { res.send('Hello World!') });
// const bodyParser = require('body-parser');
// app.use(bodyParser.json());
// const cors = require('cors');