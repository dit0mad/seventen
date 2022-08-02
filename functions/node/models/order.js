const mongoose = require('mongoose')



//new class
const orderSchema = new mongoose.Schema({
    customerID: {
        type: String,
    },
    orders: {
        type: Array,
    },
    
})

module.exports = mongoose.model('Orders', orderSchema);