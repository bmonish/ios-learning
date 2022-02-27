const mongoose = require("mongoose");

const TodoSchema = new mongoose.Schema({
  title: {
    type: String,
  },
  notes: {
    type: String,
  },
});

module.exports = Todo = mongoose.model("todo", TodoSchema);
