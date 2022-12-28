// Imports from packages
const express = require('express');
const mongoose = require('mongoose');


// Imports from other files
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin.js");
const productRouter = require("./routes/product.js");
const userRouter = require("./routes/user.js");
const { eventNames } = require('./models/user');

// Initialize
const app = express();
const PORT = process.env.PORT || 3000;
const DB = "mongodb+srv://faith:wantsomefood@cluster0.zk9jv1f.mongodb.net/?retryWrites=true&w=majority"

// Middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connections
mongoose.connect(DB).then(() => {
    console.log("Connection successful");
})
.catch((e) => {
    console.log(e);
});

// Listen for connections
app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});  