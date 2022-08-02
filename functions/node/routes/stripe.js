const express = require('express')
const router = express.Router()
const functions = require("firebase-functions");
const stripe = require('stripe')(functions.config().stripe.testkey);


router.post('/', async (req, res) => {

    //use existing cusomter id. else create new

    var customer;

    if (req.body.customerID == 'null') {
        customer = await stripe.customers.create();

    }
    else {
        customer = await stripe.customers.retrieve(
            req.body.customerID
        );

    }
    const ephemeralKey = await stripe.ephemeralKeys.create(

        { customer: customer.id },
        { apiVersion: '2020-08-27' }
    );

    const paymentIntent = await stripe.paymentIntents.create({
        amount: req.body.amount,
        currency: 'usd',
        customer: customer.id,
        automatic_payment_methods: {
            enabled: true,
        },
    },
        function (err, paymentIntent) {
            if (err != null) {
                res.json({
                    error: err
                })
            }
            else {
                res.json({
                    paymentIntent: paymentIntent.client_secret,
                    ephemeralKey: ephemeralKey.secret,
                    customer: customer.id,
                })
            }
        }
    )

});

module.exports = router