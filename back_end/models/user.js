const mongoose = require('mongoose');
const { productSchema } = require('./product');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: 'your email is not vaild !',
        }
    },
    password: {
        required: true,
        type: String,
    },
    address: {
        defult: '',
        type: String,
        trim: true
    },
    type: {
        type: String,
        default: 'user',
    },
    cart: [
        {
            product: productSchema,
            qty: {
                type: Number,
                required: true,
            }
        }
    ]

    // cart: {
    //     type: Array,
    //     default: [],
    // },
    // wishlist: {
    //     type: Array,
    //     default: [],
    // },
    // orders: {
    //     type: Array,
    //     default: [],
    // },
    // isBlocked: {
    //     type: Boolean,
    //     default: false,
    // },
    // refreshToken: {
    //     type: String,
    //     default: null,
    // },
    // otp: {
    //     type: String,
    //     default: null,
    // },
    // otp_expiry: {
    //     type: Date,
    //     default: null,
    // },
    // verified: {
    //     type: Boolean,
    //     default: false,
    // },
});
// after create schema create a model from it
const User = mongoose.model('User', userSchema);
module.exports = User;
