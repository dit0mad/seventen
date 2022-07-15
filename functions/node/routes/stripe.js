const express = require('express')
const router = express.Router()


router.post('/', async (req, res) => {

    const paymentIntent = await stripe.paymentIntents.create({
        amount: req.body.amount,
        currency: 'usd',
    },
        function (err, paymentIntent) {
            if (err != null) {
                res.json({
                    error: err
                })
            }
            else {
                res.json({
                    paymentIntent: paymentIntent.client_secret
                })
            }
        }
    )

});

module.exports = router