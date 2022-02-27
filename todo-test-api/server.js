const express = require("express");
const connectDB = require("./config/db");

const app = express();

connectDB();

app.use(express.json({extended: false}))

app.get("/", (req, res) => res.send("API running"));

app.use("/api/todos", require("./routes/api/todos"));

const PORT = 8080;

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));