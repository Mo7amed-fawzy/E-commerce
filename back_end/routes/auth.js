const express = require('express');
const User = require('../models/user');
const myAuth = require('../components/my_auth')
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
   try {
      const { name, email, password, type } = req.body;

      // التحقق اليدوي
      if (!name || !email || !password) {
         return res.status(400).json({ msg: "Please provide name, email, and password." });
      }

      // تحقق من صحة البريد
      const emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$/i;
      if (!emailRegex.test(email)) {
         return res.status(400).json({ msg: "Invalid email format." });
      }

      // تحقق من الطول الأدنى للباسورد
      if (password.length < 6) {
         return res.status(400).json({ msg: "Password must be at least 6 characters." });
      }

      const existingUser = await User.findOne({ email });
      if (existingUser) {
         return res.status(400).json({ msg: "Email already exists." });
      }

      const hPassword = await bcrypt.hash(password, 8);
      let user = new User({ name, email, password: hPassword, type });
      user = await user.save();

      res.json(user);
   } catch (e) {
      res.status(500).json({ msg: "Internal server error." });
   }
});



authRouter.post('/api/signin', async (req, res) => {
   try {
      const { email, password } = req.body;
      const user = await User.findOne({ email });
      if (!user) {
         return res.status(400).json({ msg: "User is not exist !" });
      }
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
         return res.status(400).json({ msg: "Password is not correct !" });
      }

      const token = jwt.sign({ id: user._id }, "passwordKey");
      res.json({ token, ...user._doc });
   }
   catch (e) {
      res.status(500).json({ error: e.message });
   }
});

authRouter.post('/isValidToken', async (req, res) => {
   try {
      const token = req.header('my-souq-auth-token');
      if (!token) return res.json(false);
      const verified = jwt.verify(token, "passwordKey");
      if (!verified) {
         return res.json(false);
      } else {
         const user = await User.findById(verified.id);
         if (!user) {
            return res.json(false);
         } else {
            return res.json(true);
         }
      }
   } catch (e) {
      res.status(500).json({ error: e.message });
   }
});

authRouter.get('/', myAuth, async (req, res) => {

   const user = await User.findById(req.user);
   res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;