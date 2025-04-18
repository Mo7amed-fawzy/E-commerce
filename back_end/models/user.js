const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^\S+@\S+\.\S+$/;
                return value.match(re);
            },
            message: 'Invalid email format',
        },
    },
    password: {
        type: String,
        required: true,
    },
    address: {
        type: String,
        default: null,
        trim: true,
    },
    phone: {
        default: null,
        type: String,

    },
    type: {
        default: 'user',
        type: String,
    }
});
// after create schema create a model from it
const User = mongoose.model('User', userSchema);
module.exports = User;
