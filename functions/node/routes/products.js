const express = require('express')
const router = express.Router()
const Product = require('../models/product')

//get all products
router.get('/', async (req, res) => {

    const allProducts = await Product.find();

    res.status(200).json(allProducts);

});
router.post('/add', async (req, res) => {

    const product = new Product({
        artist: req.body.artist,
        price: req.body.price,
        type: req.body.type,
        urls: req.body.urls,
        description: req.body.description,

    });

    try {
        const newProduct = await product.save();
        res.status(200).json(newProduct);
    } catch (error) {
        res.status(400).json({
            message: error.message
        });
    }

});

router.patch('/update', async (req, res) =>  {

});
//get one
///:id means parameter
// router.get('/:id', (req, res) =>{
//     try {
//         var id = req.params.id
//     } catch (error) {

//     }

// });
//create a product

// router.post('/', (req, res) => {

// });
// //update product

// //delete product
// router.delete('/:id', (req, res) => {

// });


//export a module
module.exports = router