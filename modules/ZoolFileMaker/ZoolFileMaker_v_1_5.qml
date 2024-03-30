import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import ZoolControlsTime 1.1
import ZoolTextInput 1.0
//import "../../comps" as Comps
//import "../../js/Funcs.js" as JS

import ZoolText 1.0
import ZoolButton 1.2
import comps.Zbg 1.0
//import ZoolMando 1.0

Rectangle {
    id: r
    objectName: 'fileMaker'
    color: 'white'
    width: parent.width
    height: parent.height
    clip: true
    visible: vars.ci===r
    Zbg{}
    property real lat:-100.00
    property real lon:-100.00
    property int alt:0

    property real ulat:-100.00
    property real ulon:-100.00

    property string uFileNameLoaded: ''

    property string uCS: 'Ninguna'
    onFocusChanged: {
        //if(!focus && !zrol.focus)zrol.visible=false
    }
    onVisibleChanged: {

        if(visible){
            //vars.ci=r
            tiNombre.t.focus=true
        }else{
            tiNombre.t.focus=false
            tiCiudad.t.focus=false
            botCrear
            .focus=false
        }

        //if(visible)zoolVoicePlayer.speak('Sección para crear archivos.', true)
    }
    Settings{
        id: settings
        fileName: 'zoolFileMaker.cfg'
        property bool showModuleVersion: false
        property bool inputCoords: false
    }
    Flickable{
        id: flk
        width: r.width
        height: r.height
        contentWidth: r.width
        contentHeight: col.height+vars.fs*3
        clip: true
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: col
            spacing: vars.fs*0.75
            anchors.horizontalCenter: parent.horizontalCenter
            Item{width: 1; height: vars.fs*0.15}
            ZoolTextInput{
                id: tiNombre
                width: r.width-vars.fs*0.5
                t.font.pixelSize: vars.fs*0.65
                anchors.horizontalCenter: parent.horizontalCenter
                //KeyNavigation.tab: controlTimeFecha
                t.maximumLength: 30
                borderColor:apps.fontColor
                borderRadius: vars.fs*0.25
                padding: vars.fs*0.25
                horizontalAlignment: TextInput.AlignLeft
                onEnterPressed: {
                    controlTimeFecha.focus=true
                    controlTimeFecha.cFocus=0
                }
                Text {
                    text: 'Nombre'
                    font.pixelSize: vars.fs*0.5
                    color: 'white'
                    //anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                }
                Rectangle{
                    anchors.fill: parent
                    opacity: 0.65
                    visible: app.ci===parent
                }
            }
            Item{width: 1; height: vars.fs*0.15}
            Row{
                spacing: vars.fs*0.1
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolControlsTime{
                    id: controlTimeFecha
                    gmt: 0
                    //KeyNavigation.tab: tiCiudad.t
                    setAppTime: false
                    fs: vars.fs
                    onCurrentDateChanged: {
                        //log.l('PanelVN CurrenDate: '+currentDate.toString())
                        //log.visible=true
                        //log.x=xApp.width*0.2
                    }
                    Text {
                        text: 'Fecha'
                        font.pixelSize: vars.fs*0.5
                        color: 'white'
                        anchors.bottom: parent.top
                    }
                }
            }
            Item{width: 1; height: vars.fs*0.15}
            ZoolTextInput{
                id: tiCiudad
                width: tiNombre.width
                t.font.pixelSize: vars.fs*0.65;
                //KeyNavigation.tab: settings.inputCoords?tiLat.t:(botCrear.visible&&botCrear.opacity===1.0?botCrear:botClear)
                t.maximumLength: 50
                borderColor:apps.fontColor
                borderRadius: vars.fs*0.25
                padding: vars.fs*0.25
                horizontalAlignment: TextInput.AlignLeft
                onTextChanged: {
                    tSearch.restart()
                    t.color='white'
                }
                Text {
                    text: 'Lugar, ciudad, provincia,\nregión y/o país de nacimiento'
                    font.pixelSize: vars.fs*0.5
                    color: 'white'
                    anchors.bottom: parent.top
                }
                Timer{
                    id: tSearch
                    running: false
                    repeat: false
                    interval: 2000
                    onTriggered: {
                        getZoolandCoords(parent.t.text)
                    }
                }
            }
            Row{
                spacing: vars.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: 'Ingresar coordenadas\nmanualmente'
                    font.pixelSize: vars.fs*0.5
                    color: apps.fontColor
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    checked: settings.inputCoords
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged: settings.inputCoords=checked
                }
            }
            Column{
                id: colTiLonLat
                anchors.horizontalCenter: parent.horizontalCenter
                visible: settings.inputCoords

                Row{
                    spacing: vars.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    ZoolTextInput{
                        id: tiLat
                        //width: r.width*0.5-vars.fs*0.5
                        //width: r.width*0.15-vars.fs*0.5
                        w: r.width*0.4-vars.fs*0.5
                        t.font.pixelSize: vars.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                        //KeyNavigation.tab: tiLon.t
                        t.maximumLength: 10
                        t.validator: RegExpValidator {
                            regExp: RegExp(/^(\+|\-)?0*(?:(?!999\.9\d*$)\d{0,3}(?:\.\d*)?|999\.0*)$/)
                        }
                        borderColor:apps.fontColor
                        borderRadius: vars.fs*0.25
                        padding: vars.fs*0.25
                        horizontalAlignment: TextInput.AlignLeft
                        property bool valid: false
                        Timer{
                            running: r.visible && settings.inputCoords
                            repeat: true
                            interval: 100
                            onTriggered: {
                                parent.valid=parent.t.text===''?false:(parseFloat(parent.t.text)>=-180.00 && parseFloat(parent.t.text)<=180.00)
                                if(parent.valid){
                                    r.ulat=parseFloat(parent.t.text)
                                }else{
                                    r.ulat=-1
                                }
                            }
                        }
                        Rectangle{
                            width: parent.width+border.width*2
                            height: parent.height+border.width*2
                            anchors.centerIn: parent
                            color: 'transparent'
                            border.width: 4
                            border.color: 'red'
                            visible: parent.t.text===''?false:!parent.valid
                        }
                        onEnterPressed: {
                            //controlTimeFecha.focus=true
                            //controlTimeFecha.cFocus=0
                        }
                        Text {
                            text: 'Latitud'
                            font.pixelSize: vars.fs*0.5
                            color: 'white'
                            //anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                        }
                    }
                    ZoolTextInput{
                        id: tiLon
                        //width: r.width*0.15-vars.fs*0.5
                        w: r.width*0.4-vars.fs*0.5
                        t.font.pixelSize: vars.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                        //KeyNavigation.tab: botCrear.visible&&botCrear.opacity===1.0?botCrear:botClear
                        t.maximumLength: 10
                        t.validator: RegExpValidator {
                            regExp: RegExp(/^(\+|\-)?0*(?:(?!999\.9\d*$)\d{0,3}(?:\.\d*)?|999\.0*)$/)
                        }
                        borderColor:apps.fontColor
                        borderRadius: vars.fs*0.25
                        padding: vars.fs*0.25
                        horizontalAlignment: TextInput.AlignLeft
                        property bool valid: false
                        Timer{
                            running: r.visible && settings.inputCoords
                            repeat: true
                            interval: 100
                            onTriggered: {
                                parent.valid=parent.t.text===''?false:(parseFloat(parent.t.text)>=-180.00 && parseFloat(parent.t.text)<=180.00)
                                if(parent.valid){
                                    r.ulon=parseFloat(parent.t.text)
                                }else{
                                    r.ulon=-1
                                }
                            }
                        }
                        Rectangle{
                            width: parent.width+border.width*2
                            height: parent.height+border.width*2
                            anchors.centerIn: parent
                            color: 'transparent'
                            border.width: 4
                            border.color: 'red'
                            visible: parent.t.text===''?false:!parent.valid
                        }
                        //onPressed: {
                        onEnterPressed: {
                            //controlTimeFecha.focus=true
                            //controlTimeFecha.cFocus=0
                        }
                        Text {
                            text: 'Longitud'
                            font.pixelSize: vars.fs*0.5
                            color: 'white'
                            //anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                        }
                    }
                }
                Item{width: 1; height: vars.fs*0.5;visible: settings.inputCoords}
                Text{
                    text: tiLat.t.text===''&&tiLon.t.text===''?'Escribir las coordenadas geográficas.':
                                                                (
                                                                    tiLat.valid && tiLon.valid?
                                                                        'Estas coordenadas son válidas.':
                                                                        'Las coordenadas no son correctas'
                                                                    )
                    font.pixelSize: vars.fs*0.5
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: settings.inputCoords
                }
            }
            Column{
                id: colLatLon
                spacing: vars.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                visible: r.lat===r.ulat&&r.lon===r.ulon
                Text{
                    id: uCiudadSerch
                    text: '<b>'+r.uCS+'</b>'
                    width: r.width-txtCoords.contentWidth-parent.spacing*2
                    wrapMode: Text.WordWrap
                    font.pixelSize: vars.fs*0.5
                    color: 'white'
                    opacity: r.lat!==-100.00?1.0:0.0
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text{
                    id: txtCoords
                    text: '<b>Lat:</b>'+parseFloat(r.lat).toFixed(2)+' <b>Lon:</b>'+parseFloat(r.lon).toFixed(2)
                    font.pixelSize: vars.fs*0.5
                    color: 'white'
                    opacity: r.lon!==-100.00?1.0:0.0
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Column{
                visible: !colLatLon.visible
                //height: !visible?0:vars.fs*3
                spacing: vars.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: 'Error: Corregir el nombre de ubicación'
                    font.pixelSize: vars.fs*0.25
                    color: 'white'
                    visible: r.ulat===-1&&r.ulon===-1
                }
                Text{
                    text: 'Lat:'+r.ulat
                    font.pixelSize: vars.fs*0.5
                    color: 'white'
                    opacity: r.ulat!==-100.00?1.0:0.0
                }
                Text{
                    text: 'Lon:'+r.ulon
                    font.pixelSize: vars.fs*0.5
                    color: 'white'
                    opacity: r.ulon!==-100.00?1.0:0.0
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: vars.fs*0.25
//                Button{
//                    id: botClear
//                    text: 'Limpiar'
//                    font.pixelSize: vars.fs*0.5
//                    opacity:  r.lat!==-100.00||r.lon!==-100.00||tiNombre.text!==''||tiCiudad.text!==''?1.0:0.0
//                    enabled: opacity===1.0
//                    onClicked: {
//                        clear()
//                    }
//                }
                Button{
                    id: botCrear
                    text: 'Crear'
                    font.pixelSize: vars.fs*0.5
                    //KeyNavigation.tab: tiNombre.t
                    visible: r.ulat!==-1&&r.ulon!==-1&&tiNombre.text!==''&&tiCiudad.text!==''
                    onClicked: {
                        runEnter(1)
                    }
                    Rectangle{
                        anchors.fill: parent
                        color: 'transparent'
                        border.width: 2
                        border.color: 'red'
                        visible: false
                        Timer{
                            running: parent.parent.focus
                            repeat: true
                            interval: 500
                            onRunningChanged: {
                                if(!running)parent.visible=false
                            }
                            onTriggered: parent.visible=!parent.visible
                        }
                    }
                    Timer{
                        running: r.state==='show'
                        repeat: true
                        interval: 1000
                        onTriggered: {
                            let nom=tiNombre.t.text.replace(/ /g, '_')
                            let fileName=apps.jsonsFolder+'/'+nom+'.json'
                            if(unik.fileExist(fileName)){
                                r.uFileNameLoaded=tiNombre.text
                                let jsonFileData=unik.getFile(fileName)
                                let j=JSON.parse(jsonFileData)
                                let dia=''+j.params.d
                                if(parseInt(dia)<=9){
                                    dia='0'+dia
                                }
                                let mes=''+j.params.m
                                if(parseInt(mes)<=9){
                                    mes='0'+mes
                                }
                                let hora=''+j.params.h
                                if(parseInt(hora)<=9){
                                    hora='0'+hora
                                }
                                let minuto=''+j.params.min
                                if(parseInt(minuto)<=9){
                                    minuto='0'+minuto
                                }
                                let nt=new Date(parseInt(j.params.a), parseInt(mes - 1), parseInt(dia), parseInt(hora), parseInt(minuto))
                                controlTimeFecha.currentDate=nt
                                controlTimeFecha.gmt=j.params.gmt
                                if(tiCiudad.text.replace(/ /g, '')===''){
                                    tiCiudad.text=j.params.ciudad
                                }
                                r.lat=j.params.lat
                                r.lon=j.params.lon
                                r.ulat=j.params.lat
                                r.ulon=j.params.lon
                                let vd=parseInt(tiFecha1.t.text)
                                let vm=parseInt(tiFecha2.t.text)
                                let vh=parseInt(tiHora1.t.text)
                                let vmin=parseInt(tiHora2.t.text)
                                let vgmt=controlTimeFecha.gmt//tiGMT.t.text
                                let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')
                                if(j.params.d!==vd||j.params.m!==vm||j.params.a!==va||j.params.h!==vh||j.params.min!==vmin||r.lat!==r.ulat||r.lon!==r.ulon){
                                    botCrear.text='Modificar'
                                }else{
                                    botCrear.text='[Crear]'
                                }
                            }else{
                                botCrear.text='Crear'
                            }
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        anchors.fill: parent
        color: 'transparent'
        border.width: 2
        border.color: 'red'
        visible: false
        Timer{
            running: vars.ci===r
            repeat: true
            interval: 500
            onRunningChanged: {
                if(!running)parent.visible=false
            }
            onTriggered: parent.visible=!parent.visible
        }
    }

//    Item{
//        width: r.parent.width
//        height: 1
//        anchors.centerIn: parent
//        ZoolMando{
//            id: zoolMando1
//            width: vars.fs*8
//            height: width
//            num:1
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.left: parent.left
//            onLeft:{
//                runLeft(num)
//            }
//            onRight:{
//                runRight(num)
//            }
//            onUp:{
//                app.up()
//            }
//            onDown:{
//                runDown(num)
//            }
//            onEnter:{
//                runEnter(num)
//            }
//        }
//        ZoolMando{
//            id: zoolMando2
//            width: vars.fs*8
//            height: width
//            num:2
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.right: parent.right
//            onLeft:{
//                runLeft(num)
//            }
//            onRight:{
//                runRight(num)
//            }
//            onUp:{
//                runUp(num)
//            }
//            onDown:{
//                runDown(num)
//            }
//            onEnter:{
//                runEnter(num)
//            }
//        }
//    }

    //--> Get Data  Coords
    QtObject{
        id: setZoolandCoords
        function setData(data, isData){
            if(isData){
                let j=JSON.parse(data)
                log.lv('setZoolandCoords(): '+JSON.stringify(j, null, 2))
                r.lat=j.data.coords.lat
                r.lon=j.data.coords.lon
                r.ulat=r.lat
                r.ulon=r.lon
                if(r.lat===-1&&r.lon===-1){
                    uCiudadSerch.text='No hay coordenadas para\n'+j.ciudad
                }else{
                    uCiudadSerch.text=j.ciudad
                }
                log.lv('setZoolandCoords() r.lat: '+r.lat)
                log.lv('setZoolandCoords() r.lon: '+r.lon)
                //zsm.getPanel('ZoolRemoteParamsList').load(j)
            }else{
                uCiudadSerch.text='Error al buscar\ncoordenadas de '+tiCiudad.text
                log.lv('setZoolandCoords(): No hay data! host: '+zsfdm.host)
            }
        }
    }
    function getZoolandCoords(ciudad){
        let msReq=new Date(Date.now()).getTime()
        //let url=apps.host
        let url=zsfdm.host+':8100'
        //let url='http://localhost:8100'
        url+='/zool/getZoolandCoords'
        url+='?ciudad='+ciudad+'&r='+msReq
        url=url.replace(/\n/g, '')
        url=url.replace(/\r/g, '')
        url=url.replace(/ /g, '%20')
        log.lv('url: '+url)
        vars.j.getRD(""+url+"", setZoolandCoords)
    }
    //<-- Get Data Coords

    //--> Save Zooland Params
    QtObject{
        id: saveZoolParams
        function setData(data, isData){
            //if(app.dev){
                //log.lv('saveZoolParams:\n'+JSON.stringify(JSON.parse(data), null, 2))
            log.lv('saveZoolParams isData:'+isData)
            //}
            if(isData){
                let j=JSON.parse(data)
                if(j.isRec){
                    if(app.dev){
                        log.lv('New remote params, id: '+j.params._id)
                    }
                    //vars.j.showMsgDialog('Zool Informa', 'Los datos se han guardado.', 'Una copia del archivo '+app.currentNom+' ha sido respaldado en el servidor de Zool.')
                    zpn.addNot('Se ha creado el archivo '+tiNombre.t.text+' en el servidor.', true, 10000)

                }else{
                    //vars.j.showMsgDialog('Zool Informa Error!', 'Los datos no han sido guardados.', j.msg)
                    zpn.addNot('No se ha creado el archivo '+tiNombre.t.text+' en el servidor.', true, 10000)
                }

            }else{
                //app.j.showMsgDialog('Zool Informa', 'Los datos no se han guardado en el servidor.', 'No se ha copia del archivo '+app.currentNom+'. No ha sido respaldado en el servidor de Zool.\nPosiblemente usted no esté conectado a internet o el servidor de Zool no se encuentra disponible en estos momentos.')
            }
        }
    }
    Component.onCompleted:{
        //zsm.aPanelsIds.push(vars.j.qmltypeof(r))
        //zsm.aPanelesTits.push('ZoolFileMaker')
    }
    function sendNewParams(){
        let ms=new Date(Date.now()).getTime()
        let n=tiNombre.text
        let d=controlTimeFecha.dia
        let m=controlTimeFecha.mes
        let a=controlTimeFecha.anio
        let h=controlTimeFecha.hora
        let min=controlTimeFecha.minuto
        let gmt=controlTimeFecha.gmt
        let lat=r.lat
        let lon=r.lon
        let alt=r.alt
        let ciudad=tiCiudad.text

        //let url=apps.host
        //let url=zsfdm.host
        let url=zsfdm.host+':8100'
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
        url+='&adminId='+apps.zoolUser
        url+='&msReq='+ms
        url+='&msmod='+ms
        url+='&tipo=vn'
        url=url.replace(/\n/g, '')
        url=url.replace(/\r/g, '')
        url=url.replace(/ /g, '%20')
        console.log('Url  saveZoolParams: '+url)
        vars.j.getRD(""+url+"", saveZoolParams)
    }
    //<-- Save Zooland Params


    function clear(){
        r.ulat=-100
        r.ulon=-100
        tiNombre.t.text=''
        tiFecha1.t.text=''
        tiFecha2.t.text=''
        tiFecha3.t.text=''
        //tiHora1.t.text=''
        tiHora2.t.text=''
        tiCiudad.t.text=''
        tiGMT.t.text=''
    }
    function toEnter(){
        if(tiNombre.t.focus){
            controlTimeFecha.focus=true
            return
        }
        if(controlTimeFecha.focus){
            tiCiudad.t.focus=true
            return
        }
        if(tiCiudad.t.focus){
            if(tiCiudad.t.text!==''){
                getZoolandCoords(tiCiudad.t.text)
            }else{
                tiNombre.t.focus=true
            }
            return
        }
        if(botCrear.focus){
            runEnter(1)
            return
        }
    }
    function toRight(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toRight()
        }
    }
    function toLeft(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toLeft()
        }
    }
    function toUp(){
        if(tiNombre.t.focus){
            if(tiNombre.t.text!=='' && tiCiudad.t.text!==''){
                botCrear.focus=true
            }else{
                tiCiudad.t.focus=true
            }
        }else if(controlTimeFecha.focus){
            //tiNombre.t.focus=true
            controlTimeFecha.toUp()
        }else if(tiCiudad.t.focus){
            controlTimeFecha.focus=true
        }else{
            tiCiudad.t.focus=true
        }
        if(!controlTimeFecha.focus){
            controlTimeFecha.currentIndex=-1
        }
    }
    function toDown(){
        if(tiNombre.t.focus){
            controlTimeFecha.focus=true
        }else if(controlTimeFecha.focus){
            controlTimeFecha.toDown()
            //tiCiudad.t.focus=true
        }else if(tiCiudad.t.focus){
            if(tiNombre.t.text!=='' && tiCiudad.t.text!==''){
                botCrear.focus=true
            }else{
                tiNombre.t.focus=true
            }
        }else{
            tiNombre.t.focus=true
        }
        if(!controlTimeFecha.focus){
            controlTimeFecha.currentIndex=-1
        }
    }
    function setInitFocus(){
        tiNombre.t.selectAll()
        tiNombre.t.focus=true
    }

    function runEnter(num){
        if(num===1){
            sendNewParams()
        }
    }
    function runLeft(num){
        if(num===1){
            controlTimeFecha.currentIndex=-1
            if(tiNombre.t.focus){
                //controlTimeFecha.focus=true
                tiCiudad.t.focus=true
                return
            }
            if(controlTimeFecha.focus){
                //tiCiudad.t.focus=true
                tiNombre.t.focus=true
                return
            }
            if(tiCiudad.t.focus){
                //tiNombre.t.focus=true
                controlTimeFecha.focus=true
                return
            }
            tiNombre.t.focus=true
            return
        }

        if(num===2){
            controlTimeFecha.toLeft()
        }

    }
    function runRight(num){
        if(num===1){
            controlTimeFecha.currentIndex=-1
            if(tiNombre.t.focus){
                controlTimeFecha.focus=true
                return
            }
            if(controlTimeFecha.focus){
                tiCiudad.t.focus=true
                return
            }
            if(tiCiudad.t.focus){
                tiNombre.t.focus=true
                return
            }
            tiNombre.t.focus=true
            return
        }
        if(num===2){
            controlTimeFecha.toRight()
        }
    }
    function runUp(num){
        if(num===1){

            return
        }

        if(num===2){
            controlTimeFecha.toUp()
            return
        }

    }
    function runDown(num){
        if(num===2){
            controlTimeFecha.toDown()
            return
        }
    }
}
