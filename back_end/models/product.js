const mongoose = require('mongoose');

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
    // ratings: {
    //     type: Number,
    //     default: 0,
    // },
    // numOfReviews: {
    //     type: Number,
    //     default: 0,
    // },
}
)

const product = mongoose.model('product', productSchema);
module.exports = product;