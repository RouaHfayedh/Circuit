const express=require('express');
const app=express();
var bodyParser = require('body-parser');
var read=require('./Read.js');
var fs = require('fs');
var monJson;


app.use([bodyParser.urlencoded({extended : true}), express.json()])


app.get('/',(req,res,next)=>{
    res.json({'Message':'Success !'});
});

app.post('/',(req,res,next)=>{
    let fileJson;
    var lat1=req.body.lat1;
    var lan1=req.body.lan1;
    var lat2=req.body.lat2;
    var lan2=req.body.lan2;
    read.dof(lat1,lan1,lat2,lan2).then((file)=>{
    fileJson = JSON.parse(fs.readFileSync(file, 'utf8'));
    res.json(fileJson);
    });
})
var port=process.env.PORT || 3000;
app.listen(port,()=>{
    console.log('it is working');
});