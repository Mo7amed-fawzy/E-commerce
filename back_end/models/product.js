const mongoose = require('mongoose');
const reqtingSchema = require('./rate');

const productSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true
    },
    description: {
        type: String,
        required: true,
        trim: true
    },
    images: [
        {
            type: String,
            required: true,
        }
    ],
    price: {
        type: Number,
        required: true,
    },
    qty: {
        type: Number,
        required: true,
    },
    category: {
        type: String,
        required: true,
        trim: true
    },
    rating: [reqtingSchema]
});


// sold: {
//     type: Number,
//     default: 0,
// },
// color: {
//     type: String,
//     required: true,
// },
// brand: {
//     type: String,
//     required: true,
// },
// numOfReviews: {
//     type: Number,
//     default: 0,
// },

// products[i] > qty

const Product = mongoose.model('Product', productSchema);
module.exports = { Product, productSchema };

// need use product as model and sckema like rating using it as a sckema (right as a model)