import QtQuick 2.0

Item{
    id: r
    property string host

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
        const encoded = encodeURI(url);
        console.log('Url saveZoolParams: '+encoded)
        app.j.getRD(""+encoded+"", saveZoolParams)
    }


    //--> Get Zooland Data
    QtObject{
        id: objGetZoolandData
        property var promesaParams
        function setData(data, isData){
            if(vars.dev){
                //zpn.addNot('objGetZoolandData.setData.data: '+data, true, 1000)
            }
            if(isData){
                let j=JSON.parse(data)
                if(j.isData){
                    sweg.loadSweJson(JSON.stringify(j.data, null, 2), objGetZoolandData.promesaParams)
                    //zoolMap.loadSweJson(JSON.stringify(j.data, null, 2))
                }else{
                    vars.j.showMsgDialog('Zool Informa Error!', 'Los datos no han sido guardados.', j.error)
                }

            }else{
                //vars.j.showMsgDialog('Zool Informa', 'Los datos no se han cargado los datos del servidor Zool-Server. Host: '+r.host.replace(/\n/g, ''), 'El servidor no está encendido o está fallando la conexión a internet.')
                zpn.addNot('Zool Informa: Los datos no se han cargado del servidor Zool-Server. Revisar si el Host: '+r.host.replace(/\n/g, '')+' está encendido.', true, 15000)
            }
        }
    }
    function getZoolandData(j){
        objGetZoolandData.promesaParams=j
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
        const encoded = encodeURI(url);
        vars.j.getRD(""+url+"", objGetZoolandData)
        if(vars.dev){
            zpn.addNot('Url objGetZoolandData: '+url, true, 1000)
        }
        console.log('Url: '+url)
    }
    //<-- Get Zooland Data

    //--> Get Zooland Data Back
    QtObject{
        id: objGetZoolandDataBack
        property var promesaParams
        function setData(data, isData){
            if(isData){
                let j=JSON.parse(data)
                if(j.isData){
                    sweg.loadSweJsonBack(JSON.stringify(j.data, null, 2), objGetZoolandDataBack.promesaParams)
                }else{
                    app.j.showMsgDialog('Zool Informa Error!', 'Los datos no han sido guardados.', j.error)
                }

            }else{
                vars.j.showMsgDialog('Zool Informa', 'Los datos no se han cargado los datos del servidor Zool-Server.\nHost: '+r.host.replace(/\n/g, ''), 'El servidor no está encendido o está fallando la conexión a internet.')
                //zpn.addNot('Zool Informa: Los datos no se han cargado los datos del servidor Zool-Server.\nHost: '+r.host, 'El servidor no está encendido o está fallando la conexión a internet.', true, 30000)
            }
        }
    }
    function getZoolandDataBack(j){
        objGetZoolandDataBack.promesaParams=j
        vars.cParamsBack=JSON.stringify(j)
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
        const encoded = encodeURI(url);
        console.log('Url objGetZoolandDataBack: '+encoded)
        vars.j.getRD(""+url+"", objGetZoolandDataBack)
        if(vars.dev){
            zpn.addNot('Url objGetZoolandDataBack: '+url, true, 5000)
        }
        console.log('Url Back: '+url)
    }
    //<-- Get Zooland Data Back


    //--> Get Data Params List
    QtObject{
        id: setZoolandParamsList
        function setData(data, isData){
            if(isData){
                let j=JSON.parse(data)
                //log.lv('setZoolandParamsLis(): '+JSON.stringify(j))
                //zpn.addNot('sdadsa3333', false, 0)
                zsm.getPanel('ZoolRemoteParamsList').load(j)
            }
        }
    }
    function getZoolandParamsList(){
        let msReq=new Date(Date.now()).getTime()
        let url=r.host+':8100'
        url+='/zool/getZoolandParamsList'
        url+='?adminId='+apps.zoolUser+'&r='+msReq
        const encoded = encodeURI(url);
        console.log('Url getZoolandParamsList: '+url)
        //zpn.addNot('Url: '+url, false, 0)
        vars.j.getRD(""+url+"", setZoolandParamsList)
    }
    //<-- Get Data Params List

    //--> Get Zooland Data  Rev Sol
    QtObject{
        id: objGetZoolandDataRevSol
        property bool load
        function setData(data, isData){
            if(vars.dev){
                //zpn.addNot('objGetZoolandData.setData.data: '+data, true, 1000)
            }
            if(isData){
                let j=JSON.parse(data)
                if(j.isData){
                    //zpn.addNot('Rs Data: '+JSON.stringify(j.data))
                    if(!objGetZoolandDataRevSol.load){
                        zpn.addNot('<b>Ascendente de la Revolución Solar</b><br>de '+sweg.mmEdadRs+' años: '+vars.signos[j.data.rsone.ph.h1.is]+'<br><b>Fecha y Hora:</b> '+j.data.rsone.ph.params.sdgmt, true, 15000)
                    }else{
                        let j=JSON.parse(data)
                        let m0=j.data.rsone.ph.params.sdgmt.split(' ')
                        let mf=m0[0].split('/')
                        let vd=mf[0]
                        let vm=mf[1]
                        let va=mf[2]
                        let mh=m0[1].split(':')
                        let vh=mh[0]
                        let vmin=mh[1]
                        zpn.addNot('vd: '+vd+' vm: '+vm+' va: '+va+' vh: '+vh+' vmin: '+vmin, true, 15000)
                        let nj=JSON.parse(vars.cParams)
                        nj.params.d=vd
                        nj.params.m=vm
                        nj.params.a=va
                        nj.params.h=vh
                        nj.params.min=vmin
                        zpn.addNot('nvd: '+nj.params.d, true, 15000)
                        //return
                        getZoolandDataBack(nj)
                    }
                    //console.log(JSON.stringify(j.data, null, 2))
                    //sweg.loadSweJson(JSON.stringify(j.data, null, 2), objGetZoolandData.promesaParams)
                }else{
                    vars.j.showMsgDialog('Zool Informa Error!', 'Los datos de Revolución Solar no han sido cargados correctamente.', j.error)
                    //zpn.addNot('Zool Informa Error!', 'Los datos de Revolución Solar no han sido cargados correctamente: Error'+j.error, true, 30000)
                }

            }else{
                vars.j.showMsgDialog('Zool Informa', 'Los datos no se han cargado los datos del servidor Zool-Server.\nHost: '+r.host.replace(/\n/g, ''), 'El servidor no está encendido o está fallando la conexión a internet.')
                //zpn.addNot('Zool Informa: Los datos no se han cargado los datos del servidor Zool-Server.\nHost: '+r.host, 'El servidor no está encendido o está fallando la conexión a internet.', true, 30000)
            }
        }
    }
    function getZoolandDataRevSol(edad, load){
        //objGetZoolandData.promesaParams=j
        let j=JSON.parse(vars.cParams)
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
        let url=r.host+':8100'
        url+='/zool/getZoolDataRevSol'
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

        url+='&absGradosSol='+vars.currentAbsolutoGradoSolar
        url+='&relMinutosSol='+vars.currentMinutoSolar
        url+='&relSegundosSol='+vars.currentSegundoSolar
        url+='&edad='+edad

        url+='&ms='+ms
        url+='&adminId='+apps.zoolUserId
        url+='&msReq='+msReq
        url=url.replace(/\n/g, '')
        //curl "http://192.168.1.52:8100/zool/getZoolDataRevSol?d=20&m=6&a=1975&h=23&min=4&gmt=-3&lat=-35.4752134&lon=-69.585934&absGradosSol=89&relMinutosSol=6&relSegundosSol=22&edad=48"
        const encoded = encodeURI(url);
        objGetZoolandDataRevSol.load=load
        vars.j.getRD(""+url+"", objGetZoolandDataRevSol)
        if(vars.dev){
            zpn.addNot('Url objGetZoolandDataRevSol: '+url.split('&').join(' &'), true, 15000)
        }
        console.log('Url: '+url)
    }
    //<-- Get Zooland Data Rev Sol


    Component.onCompleted: {
        let fp=Qt.platform.os==='linux'?unik.getPath(5)+'/host':unik.getPath(4)+'/host'
        fp=fp.replace(/\n/g, '')
        let h=unik.getFile(fp)//.replace(/ /g, '').replace(/\n/g, '')
        h=h.replace(/\n/g, '')
        if(h==='error'){
            zpn.addNot('Host Error.', true, 5000)
            h='http://vps-3937361-x.dattaweb.com'
        }

        if(h==='' || h.lenght < 5){
            h='http://zool.loca.lt'
        }
        if(!vars.dev){
            r.host=h
        }else{
            r.host=h
            //r.host='http://localhost'
        }
        zpn.addNot('Host: '+r.host, true, 25000)
        let sj='{"params":{"tipo":"vn","ms":1633701422850,"n":"Ricardo","d":20,"m":6,"a":1975,"h":23,"min":4,"gmt":-3,"lat":-35.4752134,"lon":-69.585934, "alt": 0, "ciudad":"Malargue Mendoza Argentina","msmod":1681568075071}}'
        vars.cParams=sj
        loadParamsFromString(sj)
    }
    function loadParamsFromString(s){        {
            getZoolandData(JSON.parse(s))
        }
    }
    function loadParamsFromStringBack(s){        {
            getZoolandDataBack(JSON.parse(s))
        }
    }
}

