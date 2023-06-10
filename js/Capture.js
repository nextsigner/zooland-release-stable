function captureSweg(){
    let d = new Date(Date.now())
    let dia=d.getDate()
    let mes=d.getMonth()+1
    let anio=d.getFullYear()
    let hora=d.getHours()
    let minuto=d.getMinutes()
    let sCapDate='Fecha de Captura\n'+dia+'/'+mes+'/'+anio+' '+hora+':'+minuto
    capDate.text=sCapDate

    let isDev=app.dev
    app.dev=false
    app.capturing=true
    let m0=apps.url.split('/')
    let folderName=m0[m0.length-1].replace('.json', '')
    let folder=apps.jsonsFolder+'/caps/'+folderName
    if(!unik.folderExist(folder)){
        unik.mkdir(folder)
    }
    let imgFileName='cap_'
    if(app.currentPlanetIndex>=0&&app.currentPlanetIndex<20){
        let json=app.currentJson
        let p=app.planetas[app.currentPlanetIndex]
        let s=json.pc['c'+app.currentPlanetIndex].is
        let h=json.pc['c'+app.currentPlanetIndex].ih

        imgFileName+=p+'_en_'
        imgFileName+='_'+app.signos[s]
        imgFileName+='_en_casa_'+parseInt(h + 1)
    }else if(app.currentPlanetIndex===20){
        imgFileName+='_ascendente'
    }else if(app.currentPlanetIndex===16){
        imgFileName+='_medio_cielo'
    }else{
        imgFileName+='_carta'
    }
    imgFileName+='.png'
    //log.l('Nombre de archivo de imagen: '+imgFileName)
    xSwe1.grabToImage(function(result) {
        result.saveToFile(folder+"/"+imgFileName);
        app.capturing=false
        app.dev=isDev
    });
}

function captureSwegBack(){
    let isDev=app.dev
    app.capturing=true
    let m0=apps.url.split('/')
    let folderName=m0[m0.length-1].replace('.json', '')
    let folder=apps.jsonsFolder+'/caps/'+folderName
    if(!unik.folderExist(folder)){
        unik.mkdir(folder)
    }
    let imgFileName='cap_'+app.mod+'_'
    if(app.currentPlanetIndexBack>=0&&app.currentPlanetIndexBack<20){
        let json=app.currentJson
        let p=app.planetas[app.currentPlanetIndexBack]
        let s=json.pc['c'+app.currentPlanetIndexBack].is
        let h=json.pc['c'+app.currentPlanetIndexBack].ih

        imgFileName+=p+'_en_'
        imgFileName+='_'+app.signos[s]
        imgFileName+='_en_casa_'+parseInt(h + 1)
    }else if(app.currentPlanetIndex===20){
        imgFileName+='_ascendente'
    }else if(app.currentPlanetIndex===16){
        imgFileName+='_medio_cielo'
    }else{
        imgFileName+='_carta'
    }
    imgFileName+='.png'
    //log.l('Nombre de archivo de imagen: '+imgFileName)
    xSwe1.grabToImage(function(result) {
        result.saveToFile(folder+"/"+imgFileName);
        //app.capturing=false
        app.dev=isDev
    });
}
