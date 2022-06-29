const mongoose = require('mongoose')



//new class
const productSchema = new mongoose.Schema({
    artist:{
        type: String,
    },
    price:{
        type: Number,
    },
    type:{
        type: String,
    },
    urls:{
        type: Array,
    },
    description:{
        type: String,
    },
})

module.exports = mongoose.model('Product', productSchema);