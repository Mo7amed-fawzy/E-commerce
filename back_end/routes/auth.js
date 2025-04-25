const express = require('express');
const User = require('../models/user');
const authRouter = express.Router();
bcryptjs = require('bcryptjs');

// authRouter.get('/user', (req, res) => {
//     res.json({ msg: "M.Fawzy" });
// }); 
// app.use(express.json());
// app.use(authRouter);

authRouter.post('/api/signup', async (req, res) => {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
        return res.status(400).json({ message: 'Please provide name, email, and password' });
    }

    try {
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Hash the password before saving it to the database (before making my modul)
        const hpassword = await bcryptjs.hash(password, 8)


        let user = new User({ name, email, password: hpassword });
        user = await user.save();
        res.status(201).json({ message: 'User created successfully', user });

    } catch (error) {
        console.error('Error during signup:', error);
        res.status(500).json({ message: 'Internal server error' });
    }
});


module.exports = authRouter;
