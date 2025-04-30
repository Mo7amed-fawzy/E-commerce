// const https = require('https');
// const fs = require('fs');

const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth.js');
const adminRouter = require('./routes/admin.js');
const productRouter = require('./routes/product.js');
const userRouter = require('./routes/user.js');

// const https = require('https');)

const DBC = 'mongodb+srv://m07amed1st:ONTTBzKysUIpIi5k@cluster0.yh53t7d.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';
const port = 3020

const app = express();

// // استخدام شهادة SSL (تأكد من المسار الصحيح)
// const options = {
//     key: fs.readFileSync('path/to/your/private-key.pem'),
//     cert: fs.readFileSync('path/to/your/certificate.pem')
// };

// بحول من الصيغه اللى جاى من اليوزر ل JSON
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
// app.use(express.json());


mongoose.connect(DBC).then(() => {
    console.log('MongoDB connected successfully!');
}).catch((err) => {
    console.log(err);
});

app.listen(port, "0.0.0.0", () => {
    console.log('its working on port ' + port + '...');
});


// // تشغيل الخادم باستخدام HTTPS
// https.createServer(options, app).listen(port, () => {
//     console.log('Server running on https://localhost:' + port);
// });

// app.get('/hellow_world', (req, res) => { res.send('Hello World!') });
// const bodyParser = require('body-parser');
// app.use(bodyParser.json());
// const cors = require('cors');