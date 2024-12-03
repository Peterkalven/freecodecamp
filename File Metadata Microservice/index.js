const express = require("express"),
  cors = require("cors"),
  multer = require("multer"), 
  // require and use "multer"... https://www.npmjs.com/package/multer
  upload = multer({ dest: "uploads/" });


const app = express();

app.use(cors());
app.use("/public", express.static(process.cwd() + "/public"));

app.get("/", (req, res) => {
  res.sendFile(process.cwd() + "/views/index.html");
});

app.get("/hello", (req, res) => {
  res.json({ greetings: "Hello, API" });
});

app.post("/api/fileanalyse", upload.single("upfile"), (req, res, next) => {

  if (!req.file.originalname) {
    return res.send("Something went wrong");
  }
  const { originalname, mimetype, size } = req.file;
  const fileMetaData = { name: originalname, type: mimetype, size };
  next();
  return res.send(fileMetaData);
});

app.listen(process.env.PORT || 3000, () => {
  console.log("Node.js listening ...");
});
