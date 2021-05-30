var Api=require('./FSQ.js');
var fs = require('fs');

//function read parametres from json file
function get_parameters(fileName,i){
    var monJson = JSON.parse(fs.readFileSync(fileName, 'utf8'));
    var obj;
    if((monJson.response != undefined)&&(monJson.response['groups'][0].items[i] != undefined)){
    var lat=monJson.response['groups'][0].items[i].venue.location["labeledLatLngs"][0].lat;
    var lan=monJson.response['groups'][0].items[i].venue.location["labeledLatLngs"][0].lng;
    var nom=monJson.response['groups'][0].items[i].venue.name;
    var type=monJson.response['groups'][0].items[i].venue.categories[0].name;
    obj = {
        lat: lat,
        lan: lan,
        nom: nom,
        type: type
    };
}else{
    obj = {
        lat: "",
        lan: "",
        nom: "",
        type: ""
    };
}
    return obj;
}

var json;
function writeF (donnee){ 
    return new Promise((resolve, reject) =>{
    json = JSON.stringify(donnee);
            fs.writeFile('Circuit.json', json ,function(err, result) {
            if(err) console.log('error', err);
            resolve('Circuit.json');
        })
     });
        }
async function start(lat1,lan1,lat2,lan2){
    return new Promise( (resolve, reject) => {
Api.Nearst_Station(lat1,lan1,2).then((file)=>{
    var donnee=[];
    var leng=donnee.length;
    var i,j,k,l,c;
    for (i=0;i<2;i++){
        var obj=get_parameters(file,i);
        let latDep=obj["lat"];
        let lanDep=obj["lan"];
        let nomDep=obj["nom"];
        let typeDep=obj["type"];
        Api.Nearst_Station(lat2,lan2,1).then((file1)=>{
            for(j=0;j<2;j++){
                var obj1=get_parameters(file1,j);
                let latDest=obj1["lat"];
                let lanDest=obj1["lan"];
                let nomDest=obj1["nom"];
                let typeDest=obj1["type"];
                if(typeDep==typeDest){
                    //test s'il deja existe dans fichier circuit
                    donnee.push({nameDep: nomDep , lat: latDep , lan: lanDep});
                    donnee.push({nameDest: nomDest , lat: latDest , lan: lanDest});
                }else{
                    var newLat;
                    var newlan;
                    if(latDep>latDest){
                        newLat=latDep-((latDep-latDest)/2);
                    }else{
                        newLat=lanDest-((latDest-latDep)/2);
                    }
                    if(lanDep>lanDest){
                        newlan=lanDep-((lanDep-lanDest)/2);
                    }else{
                        newlan=lanDest-((lanDest-lanDep)/2);
                    }
                    Api.Nearst_Station(newLat,newlan,3).then((file2)=>{
                        for(k=0;k<2;k++){
                            var obj2 = get_parameters(file2,k);
                            let latInt=obj2["lat"];
                            let lanInt=obj2["lan"];
                            let nomInt=obj2["nom"];
                            let typeInt=obj2["type"];
                            if(typeInt==typeDep){
                                if(typeInt==typeDest){
                                donnee.push({nameDep: nomDep , lat: latDep , lan: lanDep});
                                donnee.push({nameInt: nomInt , lat: latInt , lan: lanInt});
                                donnee.push({nameDest: nomDest , lat: latDest , lan: lanDest});
                                }
                            }else{
                                var newLat,newLat1;
                                var newlan,newlan1;
                            if(latDep>latInt){
                                newLat=latDep-((latDep-latInt)/2);
                                newLat1=latInt-((latInt-latDest)/2);
                            }else{
                                newLat=lanInt-((latInt-latDep)/2);
                                newLat1=lanDest-((latDest-latInt)/2);
                            }
                            if(lanDep>lanInt){
                                newlan=lanDep-((lanDep-lanInt)/2);
                                newlan1=lanInt-((lanInt-lanDest)/2);
                            }else{
                                newlan=lanInt-((lanInt-lanDep)/2);
                                newlan1=lanDest-((lanDest-lanInt)/2);
                            }
                            Api.Nearst_Station(newLat,newlan,4).then((file3)=>{
                                for(l=0;l<2;l++){
                                    var obj3 = get_parameters(file3,l);
                                    let latInt1=obj3["lat"];
                                    let lanInt1=obj3["lan"];
                                    let nomInt1=obj3["nom"];
                                    let typeInt1=obj3["type"]; 
                                    Api.Nearst_Station(newLat1,newlan1,5).then((file4)=>{
                                        for(c=0;c<2;c++){
                                            var obj4 = get_parameters(file4,c);
                                            let latInt2=obj4["lat"];
                                            let lanInt2=obj4["lan"];
                                            let nomInt2=obj4["nom"];
                                            let typeInt2=obj4["type"]; 
                                            if(typeDep==typeInt1){
                                                if(typeInt2==typeDest){
                                                if(typeInt2==typeInt1){
                                                donnee.push({nameDep: nomDep , lat: latDep , lan: lanDep});
                                                donnee.push({nameInt: nomInt1 , lat: latInt1 , lan: lanInt1});
                                                donnee.push({nameInt: nomInt2 , lat: latInt2 , lan: lanInt2});
                                                donnee.push({nameDest: nomDest , lat: latDest , lan: lanDest});
                                            }else if((typeInt1==typeInt)&&(typeInt==typeInt2)){
                                                donnee.push({nameDep: nomDep , lat: latDep , lan: lanDep});
                                                donnee.push({name: nomInt , lat: latInt , lan: lanInt});
                                                donnee.push({name: nomInt1 , lat: latInt1 , lan: lanInt1});
                                                donnee.push({name: nomInt2 , lat: latInt2 , lan: lanInt2});
                                                donnee.push({nameDest: nomDest , lat: latDest , lan: lanDest});
                                            }
                                        }
                                    }
                                        }
                                    })

                                }
                            })
                        }
                        }
                    })

                }
                if((i==2)&&(donnee.length>leng)){    
                    writeF(donnee).then((file)=>{
                        resolve(file);
                    })
                   
                        
                        
                 }
            }
            
        })
}


})
});
}
function dof(lat1,lan1,lat2,lan2){
    return new Promise( (resolve, reject) => {
        start(lat1,lan1,lat2,lan2).then((file)=>{
        resolve(file);

    })
})
}

module.exports.dof=dof;