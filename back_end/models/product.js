const mongoose = require('mongoose');
const ratingSchema = require('./rate.js');

const productSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    description: {
        type: String,
        required: true,
        trim: true,
    },
    images: {
        type: Array,
        required: true,
    },
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
    },
    ratings: [ratingSchema],
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
}
)

const product = mongoose.model('product', productSchema);
module.exports = product;