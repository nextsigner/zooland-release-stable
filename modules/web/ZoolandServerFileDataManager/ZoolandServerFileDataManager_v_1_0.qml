import QtQuick 2.0

Item{
    id: r
    property string host

    //property string host: app.dev?'http://zooldev.loca.lt':apps.host
    //property string host: apps.host

    //property string host: 'http://vps-3339713-x.dattaweb.com'
    //property string host: 'http://localhost'

    QtObject{
        id: saveZoolParams
        function setData(data, isData){
            if(app.dev){
                //log.lv('getUserAndSet:\n'+JSON.stringify(JSON.parse(data), null, 2))
            }
            if(isData){
                let j=JSON.parse(data)
                if(j.isRec){
                    if(app.dev){
                        //log.lv('New remote params, id: '+j.params._id)
                    }
                    app.j.showMsgDialog('Zool Informa', 'Los datos se han guardado.', 'Una copia del archivo '+app.currentNom+' ha sido respaldado en el servidor de Zool.')
                }else{
                    app.j.showMsgDialog('Zool Informa Error!', 'Los datos no han sido guardados.', j.msg)
                }

            }else{
                //app.j.showMsgDialog('Zool Informa', 'Los datos no se han guardado en el servidor.', 'No se ha copia del archivo '+app.currentNom+'. No ha sido respaldado en el servidor de Zool.\nPosiblemente usted no esté conectado a internet o el servidor de Zool no se encuentra disponible en estos momentos.')
            }
        }
    }
    function save(j){
        let t=j.params.tipo
        let hsys=j.params.hsys
        let n=j.params.n.replace(/ /g, '%20')
        let d=j.params.d
        let m=j.params.m
        let a=j.params.a
        let h=j.params.h
        let min=j.params.min
        let gmt=j.params.gmt
        let lat=j.params.lat
        let lon=j.params.lon
        let alt=j.params.alt
        let ciudad=j.params.ciudad.replace(/ /g, '%20')
        let ms=j.params.ms
        let msReq=new Date(Date.now()).getTime()
        //let url=apps.host
        let url=r.host+':8100'
        url+='/zool/saveZoolParams'
        url+='?n='+n
        url+='&d='+d
        url+='&m='+m
        url+='&a='+a
        url+='&h='+h
        url+='&min='+min
        url+='&gmt='+gmt
        url+='&lat='+lat
        url+='&lon='+lon
        url+='&alt='+alt
        url+='&ciudad='+ciudad
        url+='&ms='+ms
        url+='&adminId='+apps.zoolUserId
        url+='&msReq='+msReq
        console.log('Url  saveZoolParams: '+url)
        app.j.getRD(url, saveZoolParams)
    }
    QtObject{
        id: objGetZoolandData
        function setData(data, isData){
            if(isData){
                let j=JSON.parse(data)
                if(j.isData){
                    sweg.loadSweJson(JSON.stringify(j.data, null, 2))
                    //zoolDataView.load(app.fileData)
                    //log.lv(JSON.stringify(j.data, null, 2))
                }else{
                    app.j.showMsgDialog('Zool Informa Error!', 'Los datos no han sido guardados.', j.error)
                }

            }else{
                app.j.showMsgDialog('Zool Informa', 'Los datos no se han cargado los datos del servidor Zool-Server.\nHost: '+r.host, 'El servidor no está encendido o está fallando la conexión a internet.')
            }
        }
    }
    function getZoolandData(j){
        sweg.load(j)
        app.fileData=JSON.stringify(j)
        let t=j.params.tipo
        let hsys=j.params.hsys
        let n=j.params.n.replace(/ /g, '%20')
        let d=j.params.d
        let m=j.params.m
        let a=j.params.a
        let h=j.params.h
        let min=j.params.min
        let gmt=j.params.gmt
        let lat=j.params.lat
        let lon=j.params.lon
        let alt=j.params.alt
        let ciudad=j.params.ciudad.replace(/ /g, '%20')
        let ms=j.params.ms
        let msReq=new Date(Date.now()).getTime()
        //let url=apps.host
        //let url='http://zool.loca.lt'
        //let url=r.host
        let url=r.host+':8100'
        url+='/zool/getZoolData'
        url+='?n='+n
        url+='&d='+d
        url+='&m='+m
        url+='&a='+a
        url+='&h='+h
        url+='&min='+min
        url+='&gmt='+gmt
        url+='&lat='+lat
        url+='&lon='+lon
        url+='&alt='+alt
        url+='&ciudad='+ciudad
        url+='&ms='+ms
        url+='&adminId='+apps.zoolUserId
        url+='&msReq='+msReq
        console.log('Url objGetZoolandData: '+url)
        app.j.getRD(url, objGetZoolandData)
    }


    //--> Get Data Params List
    QtObject{
        id: setZoolandParamsList
        function setData(data, isData){
            //Qt.quit()
            if(app.dev){
                //log.lv('setZoolandParamsList:\n'+JSON.stringify(JSON.parse(data), null, 2))
                //console.log('setZoolandParamsList data: '+data)
            }
            if(isData){
                let j=JSON.parse(data)
                //log.lv('setZoolandParamsLis(): '+JSON.stringify(j))
                zsm.getPanel('ZoolRemoteParamsList').load(j)
            }
        }
    }
    function getZoolandParamsList(){
        let msReq=new Date(Date.now()).getTime()
        //let url=apps.host
        //let url=r.host
        let url=r.host+':8100'
        url+='/zool/getZoolandParamsList'
        url+='?adminId='+apps.zoolUser+'&r='+msReq
        app.j.getRD(url, setZoolandParamsList)
    }
    //<-- Get Data Params List



    Component.onCompleted: {
        let fp=unik.getPath(4)+'/host'
        let h=unik.getFile(fp)//.replace(/ /g, '').replace(/\n/g, '')
        if(h==='' || h.lenght < 3){
            h='http://zool.loca.lt'
        }
        r.host=h
        let sj='{"params":{"tipo":"vn","ms":1633701422850,"n":"Ricardo","d":20,"m":6,"a":1975,"h":23,"min":4,"gmt":-3,"lat":-35.4752134,"lon":-69.585934,"ciudad":"Malargue Mendoza Argentina","msmod":1681568075071}}'
        loadParamsFromString(sj)
    }
    function loadParamsFromString(s){        {
                let j=JSON.parse(s)
                //ñalskdfjñla
                //log.lv('getZoolandData(j)...')
                let aL=[]
                aL.push(''+j.params.n)
                aL.push(''+j.params.d+'/'+j.params.m+'/'+j.params.a)
                aL.push(''+j.params.h+':'+j.params.min+'hs')
                aL.push('<b>GMT:</b> '+j.params.gmt)
                aL.push('<b>Ubicación:</b> '+j.params.ciudad)
                aL.push('<b>Lat:</b> '+parseFloat(j.params.lat).toFixed(2))
                aL.push('<b>Lon:</b> '+parseFloat(j.params.lon).toFixed(2))
                aL.push('<b>Alt:</b> '+j.params.alt)
                let tipo=j.tipo
                let strSep=''
                if(tipo==='vn'){
                    strSep='Carta Natal'
                }
                if(tipo==='sin'){
                    strSep='Sinastría'
                }
                if(tipo==='rs')strSep='Rev. Solar '+va
                if(tipo==='trans')strSep='Tránsitos'
                if(tipo==='dirprim')strSep='Dir. Primarias'
                zoolDataView.setDataView(strSep, aL, [])
                getZoolandData(j)
            }
    }
}

