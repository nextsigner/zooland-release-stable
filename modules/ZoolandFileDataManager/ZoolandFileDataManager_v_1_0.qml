import QtQuick 2.0

Item{
    id: r
    property string currentUrl: apps.url
    property var j: ({})
    property var ja: ({})

    //Retorna string con el contenido del archivo actual
    function getData(){
        //if(app.dev)log.lv('zfdm.getData( '+r.currentUrl+' )')
        return unik.getFile(r.currentUrl)
    }
    //Retorna json con el contenido del archivo actual
    function getJson(){
        return JSON.parse(getData())
    }
    //Devuelve booleano verdadero si existen parámetros back.
    function isParamsBack(){
        let b=false
            if(getJson().paramsBack){
                b=true
            }
        return b
    }
    //Retorna json con los parámetros front o back.
    function getJsonParams(isBack){
        let p
        if(isBack){
            p=getJson().paramsBack
        }
        p=getJson().params
        return p
    }
    //Carga archivo
    function loadFile(url){
        let ret=false
        r.currentUrl=url
        if(getData()==='error'){
            if(app.dev)log.lv(' Error de carga de archivo! zfdm.loadFile( '+url+' )')
            return ret
        }
        let j = getJson()
        if(!j){
            if(app.dev)log.lv(' Error carga y formato de archivo! zfdm.loadFile( '+url+' )')
            return ret
        }
        setJsonAbs(j)
        ret=true
        return ret
    }
    //-->Comienza Json Abstracto.
    function setJsonAbs(j){
        let exts=j.exts
        if(!exts){
            j.exts=[]
        }
        r.ja=j
    }
    function getJsonAbs(){
        return r.ja
    }
    function isAbsParamsBack(){
        let b=false
            if(r.ja.paramsBack){
                b=true
            }
        return b
    }
    function getJsonAbsParams(isBack){
        if(!isBack){
            return r.ja.params
        }
        if(isBack && !r.ja.paramsBack) return ({})
        return r.ja.paramsBack
    }
    //<--Finaliza Json Abstracto.


    //-->Administración de archivos
    function mkFileAndLoad(j){
        let r=true
        let mf=mkFile(j)
        if(mf[0]===true){
            if(app.dev)log.lv('mkFileAndLoad(...) app.j.loadJson( '+mf[1]+')')
            app.j.loadJson(mf[1])
            return r
        }else{
            log.lv('Error al crear el archivo: '+mf[1])
            log.lv('El archivo: '+mf[1]+' no se ha cargado.')
            r=false
        }
        return r
    }
    function mkFile(j){
        let r=false
        let s=JSON.stringify(j)
        let fn=(''+app.j.quitarAcentos(j.params.n)).replace(/ /g, '_')
        fn=fn.replace(/\//g, '_')
        fn=fn.replace(/:/g, '_')
        let f=apps.jsonsFolder+'/'+fn+'.json'

        unik.setFile(f, s)
        if(unik.fileExist(f)){
            r=true
            if(apps.enableShareInServer && j.params.shared){
                zsfdm.save(j)
            }
        }
        return [r, f]
    }
    //<--Administración de archivos

    //-->Get Json Data
//    function getJson(){
//        return r.ja
//    }
    function saveJson(json){
        r.ja=json
        let saved = unik.setFile(apps.url, JSON.stringify(r.ja, null, 2))
        if(saved){
            let njson=JSON.stringify(json)
            zm.fileData=njson
            zsm.getPanel('ZoolFileExtDataManager').updateList()
            if(apps.enableShareInServer){
                zsfdm.save(json)
            }
            return true
        }
        return false
    }
    function getParam(p){
        return r.ja.params[''+p]
    }
    function updateParams(params, save){
        let json=zfdm.getJson()
        json.params=params
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        saveJson(json)
    }
    function getExts(){
        return r.ja.exts
    }
    function isExtId(extId){
        let ret=false
        let o=r.ja.exts
        if(!o)return ret
        for(var i=0;i<Object.keys(o).length;i++){
            let json=o[i].params
            if(json.extId===extId){
                ret=true
                break
            }
        }
        return ret
    }
    function addExtData(json){
        if(app.dev)log.lv('zfdm.addExtData( '+JSON.stringify(json, null, 2)+' )')
        let o=r.ja.exts
        if(app.dev)log.lv('r.ja.exts= '+JSON.stringify(o, null, 2)+'')
        if(!o)return
        let nIndex=Object.keys(o).length
        o[nIndex]={}
        o[nIndex]=json
        if(app.dev)log.lv('adding ext data:'+JSON.stringify(r.ja, null, 2))
    }
    function getParamExt(p,i){
        return r.ja.exts[i][''+p]
    }
    function getExtData(extId){
        let ret={}
        let o=r.ja.exts
        for(var i=0;i<Object.keys(o).length;i++){
            let json=o[i].params
            if(json.extId===extId){
                ret=json
                break
            }
        }
        return ret
    }
    function saveExtToJsonFile(extId){
        //let jsonActual=
        let njson={}
        njson.params={}
        njson.params=r.ja.params
        njson.exts=[]
        //njson.exts=
        let o=r.ja.exts
        for(var i=0;i<Object.keys(o).length;i++){
            let json=o[i].params
            if(json.extId===extId || json.ms>=0){
                njson.exts[i]={}
                njson.exts[i].params={}
                njson.exts[i].params=o[i].params
            }
            if(njson.exts[i].params.ms<0){
                let d = new Date(Date.now())
                njson.exts[i].params.ms=d.getTime()
            }
        }
        if(app.dev)log.lv('saveExtToJsonFile( '+extId+'): Nuevo Json: '+JSON.stringify(njson, null, 2))
        let isSaved=unik.setFile(apps.url, JSON.stringify(njson))
        if(isSaved)zsm.getPanel('ZoolFileExtDataManager').updateList()
        return isSaved
    }
    function deleteExtToJsonFile(extId){
        let njson={}
        njson.params={}
        njson.params=r.ja.params
        njson.exts=[]
        let o=r.ja.exts
        if(app.dev)log.lv('o:'+o.toString())
        o=o.filter(Boolean)
        if(app.dev)log.lv('o2:'+o.toString())
        for(var i=0;i<Object.keys(o).length;i++){
            let json=o[i].params
            if(o[i]){
            if(json.extId!==extId){
                njson.exts[i]={}
                njson.exts[i].params={}
                njson.exts[i].params=o[i].params
            }
            }
        }
        njson.exts=njson.exts.filter(Boolean)
        if(app.dev)log.lv('deleteExtToJsonFile( '+extId+'): Nuevo Json: '+JSON.stringify(njson, null, 2))
        let seted=unik.setFile(apps.url, JSON.stringify(njson))
        if(seted)r.ja=njson
        let forReload=extId===zoolDataView.uExtIdLoaded
        if(app.dev)log.lv('deleteExtToJsonFile( '+extId+' )\nzoolDataView.uExtIdLoaded: '+zoolDataView.uExtIdLoaded+'\nforReload: '+forReload)

        let reLoaded=forReload?r.loadFile(apps.url):true
        if(forReload)app.j.loadJson(apps.url)
        let allTaskReady=(seted && reLoaded)?true:false
        return allTaskReady
    }
    //<--Get Json Data
}

