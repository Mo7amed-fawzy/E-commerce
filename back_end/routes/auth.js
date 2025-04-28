const express = require('express');
const User = require('../models/user');
const authRouter = express.Router();
bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const myAuth = require('../components/my_auth');

// authRouter.get('/user', (req, res) => {
//     res.json({ msg: "M.Fawzy" });
// }); 
// app.use(express.json());
// app.use(authRouter);

authRouter.post('/api/signup', async (req, res) => {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
        return res.status(400).json({ msg1: 'Please provide name, email, and password' });
    }

    try {
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg2: 'and Back-End Message is :User already exists' });
        }

        // Hash the password before saving it to the database (before making my modul)
        const hpassword = await bcryptjs.hash(password, 8)


        let user = new User({ name, email, password: hpassword });
        user = await user.save();
        res.status(201).json({ msgSuc: 'User created successfully', user });

    } catch (error) {
        console.error('Error during signup:', error);
        // res.status(500).json({ error: 'Internal server error' });
        res.status(500).json({ error: 'Email : your email is not valid' });
    }
});


authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ failLogMsg: '(Email) user is not exist ! ' });
        }
        const isMatch = await bcryptjs.compare(password, user.password, (err, result) => {
            // if (err) {
            //     return res.status(500).json({ error: 'Password is not correct' });
            // }
            // if (result) {
            //     return res.status(200).json({ sucmsg: 'Login successful', user: User });
            // } else {
            //     return res.status(401).json({ failLogMsg: 'Invalid password' });
            // }
            if (isMatch) {
                return res.status(200).json({ sucmsg: 'Login successful', user: user });
            }

            const token = jwt.sign({ id: user._id }, "myKey");
            res.json({
                token,
                ...user._doc, // Spread the user document to include all fields in the response
                //or
                // user: {
                //     id: User._id,
                //     name: User.name,
                //     email: User.email,
                //     address: User.address,
                //     phone: User.phone,
                //     type: User.type
                // }
            });
        });
    } catch (error) {
        console.error('Error during signin:', error);
        res.status(500).json({ error: 'Internal server error' });
    };
});


authRouter.post('/isvalidtoken', async (req, res) => {
    try {
        const token = req.header('my-Souq-auth-token');
        if (!token) {
            return res.status(401).json({ error: 'Token is required' });
        }
        const verifyToken = jwt.verify(token, "myKey");
        if (!verifyToken) {
            return res.status(401).json({ error: 'Invalid token' });
        } else {
            const user = await User.findById(verifyToken.id);
            if (!user) {
                return res.status(404).json({ error: 'User not found' });
            } else {
                return res.status(200).json(true);

                //     {
                //     msg: 'Token is valid',
                //     user: {
                //         id: user._id,
                //         name: user.name,
                //         email: user.email,
                //         address: user.address,
                //         phone: user.phone,
                //         type: user.type
                //     }
                // }
            }

        }
    } catch (error) {
        console.error('Error during token validation:', error);
        res.status(500).json({
            error: 'Internal server error'
        });
    }
});

authRouter.get('/', myAuth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});
module.exports = authRouter;
