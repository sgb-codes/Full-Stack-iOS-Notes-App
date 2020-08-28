const express = require('express')
const mongoose = require('mongoose')
var app = express()
var Data = require('./noteSchema')

mongoose.connect("mongodb://localhost/newDB")

mongoose.connection.once("open", () => {

    console.log("Connected to DB!")

}).on("error", (error) => {

    console.log("Failed to connect " + error)

})

// Create A Note
// POST Request
app.post("/create", (req, res) => {

    var note = new Data ({

        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")
    })

    note.save().then(() => {

        if (note.isNew == false) {

            console.log("Saved data!")
            res.send("Saved data!")

        } else {
            console.log("Failed to save data")
        }
    })

})

// Fetch All Notes
// GET Request
app.get("/fetch", (req, res) => {

    Data.find({}).then((DBitems) => {

        res.send(DBitems)

    })
})

// DELETE A NOTE
// POST Request
app.post("/delete", (req, res) => {
    Data.findOneAndRemove({
        _id: req.get("id")
    }, (err) => {
        console.log("Failed " + err)
    })

    res.send("Deleted!")
})

// UPDATE A NOTE
// POST Request
app.post("/update", (req, res) => {
    Data.findOneAndUpdate({
        _id: req.get("id")
    }, {
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")

    }, (err) => {
        console.log("Failed to update" + err)

    })

    res.send("Updated!")
})


// To get to server http://192.168.0.16:8081/create
var server = app.listen(8081, "192.168.0.16", () => {

    console.log("Server is running!")
})



