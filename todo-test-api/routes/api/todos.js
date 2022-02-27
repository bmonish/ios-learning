const express = require("express");
const router = express.Router();
const { check, validationResult } = require("express-validator");
const Todo = require("../../models/Todo");

router.get("/", (req, res) => res.send("Todos route"));

router.get("/all", async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  try {
    const todos = await Todo.find();
    res.json({ results: todos });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

router.get("/:todoId", async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  try {
    const todo = await Todo.findOne({
      _id: req.params.todoId,
    });

    if (!todo) return res.status(400).json({ msg: "Todo not found" });

    res.json(todo);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server-error");
  }
});

router.delete("/:todoId", async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  try {
    const todo = await Todo.deleteOne({ _id: req.params.todoId });

    res.json("Deleted");
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server-error");
  }
});

router.patch("/:todoId", async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  try {
    const { title, notes } = req.body;
    await Todo.findOneAndUpdate({ _id: req.params.todoId }, { title, notes });

    const todo = await Todo.find({ _id: req.params.todoId });
    res.json(todo);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server-error");
  }
});

router.post("/", async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { title, notes } = req.body;

  try {
    const todo = new Todo({
      title,
      notes,
    });

    await todo.save();

    res.json({ title, notes });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server-error");
  }
});

module.exports = router;
