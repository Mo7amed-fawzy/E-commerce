const express = require('express');
const authRouter = express.Router();

// authRouter.get('/user', (req, res) => {
//     res.json({ msg: "M.Fawzy" });
// });

authRouter.post('/api/signup', (req, res) => {
    const { name, email, password } = req.body;
    // Perform signup logic here (e.g., save user to database) send to api
    res.status(201).json({ message: "User created successfully", user: { username } });

});

module.exports = authRouter;
