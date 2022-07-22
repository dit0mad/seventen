const dotenv = require("dotenv");
const functions = require("firebase-functions");
const express = require("express");
const app = express();      //instance
const mongoose = require("mongoose") ;
const productRouter = require("./node/routes/products");
const stripeRouter = require("./node/routes/stripe");



dotenv.config();
app.use("/products", productRouter);
app.use("/stripe", stripeRouter);

mongoose.connect(process.env.MONGODB, 
    { 
        useNewUrlParser:true ,
        useUnifiedTopology: true,
    });


const connection = mongoose.connection;      //connection reference
connection.on("error", (error) => console.error(error));
connection.once("open", () => console.log("connected to db"));



exports.seventen = functions.https.onRequest(app);




//app.listen(8080, () => console.log("listening"));