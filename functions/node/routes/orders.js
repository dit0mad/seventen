const express = require('express')
const router = express.Router()
const Order = require('../models/order')

//get all products
router.get('/', async (req, res) => {

    const orderById = await Order.findOne();

    res.status(200).json(orderById);

});

router.post('/add', async (req, res) => {


    const order = new Order({
        customerID: req.body.customerid,
        orders: req.body.orders,
    });

    try {
        const newOrder = await product.save();
        res.status(200).json(newOrder);
    } catch (error) {
        res.status(400).json({
            message: error.message
        });
    }

});

module.exports = router