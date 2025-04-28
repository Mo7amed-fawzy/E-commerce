const jwt = require('jsonwebtoken');

const myAuth = async (req, res, next) => {
    try {
        const token = req.headers['my-Souq-auth-token']?.split(' ')[1];
        if (!token) {
            return res.status(401).json({ message: 'Unauthorized' });
        }


        const verified = jwt.verify(token, 'myKey');
        if (!verified) {
            return res.status(401).json({ message: 'Unauthorized' });
        }
        req.user = verified.id;
        req.token = token;
        next();
    } catch (error) {
        return res.status(401).json({ message: 'Unauthorized' });
    }
};

module.exports = myAuth;