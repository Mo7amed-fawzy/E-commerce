const express = require('express');
const adminRouter = express.Router();
const admin = require('../components/my_admin');
const { Product } = require('../models/product');
const Order = require('../models/order');

adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const { name, description, images, price, qty, category } = req.body;
        let product = new Product({
            name, description, images, price, qty, category
        });
        product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
adminRouter.delete('/admin/delete-products', admin, async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        //product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});



adminRouter.get('/api/all-orders-admin', admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        res.json(orders);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});



adminRouter.post('/admin/update-order-status', admin, async (req, res) => {
    try {
        const { id, status } = req.body;
        let order = await Order.findById(id);
        if (!order) {
            return res.status(404).json({ error: "Order not found" });
        }

        order.status = status;
        console.log("$$$$$$$$$$$$$$$$");
        order = await order.save();
        res.json(order);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = adminRouter;