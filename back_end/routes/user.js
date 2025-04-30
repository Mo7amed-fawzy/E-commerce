const express = require('express')
const userRouter = express.Router();
const myAuth = require('../components/my_auth.js');
const { Product } = require('../models/product');
const User = require('../models/user');

userRouter.post('/api/add-to-cart', myAuth, async (req, res) => {
    try {
        const { id, qty } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);
        if (user.cart.lengh == 0) {
            const cartSchema = {
                product,
                qty: Number(qty)
            }
            User.cart.push(cartSchema);
            // user = await User.save();
        } else {
            let isFound = false;
            for (let i = 0; i < User.cart.length; i++) {
                if (user.cart[i].product._id.equals(product._id))
                // this is object id (product's id)
                {
                    user.cart[i].qty += Number(qty);
                    isFound = true;
                    break;
                }
                // if (isFound) break
            }
            if (!isFound) {
                const cartSchema = {
                    product,
                    qty: Number(qty)
                }
                User.cart.push(cartSchema);
            }
        }
        user = await User.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message || ' Internal server error' });
    }
});

userRouter.delete('/api/remove-to-cart/:id', myAuth, async (req, res) => {
    try {
        const id = req.params.id;
        const user = await User.findById(req.user);

        for (let i = 0; i < user.cart.length; i++) {

            if (user.cart[i].product._id.equals(id)) {
                if (user.cart[i].qty > 1) {
                    user.cart[i].qty -= 1;
                }
                else {
                    user.cart.splice(i, 1);
                    // if qty = 1 remove this item from list (user.cart.splice(i, 1);)
                }
                break;
            }
        }
        user = await user.save();
        res.json(user);
    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }
}),

    module.exports = userRouter
