import QtQuick 2.7
import QtQuick.Controls 2.0
import QtMultimedia 5.12
import Qt.labs.settings 1.1
import "Funcs.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    //color: 'black'
    //visible: false
    border.width: 2
    border.color: 'white'
    property alias currentIndex: lv.currentIndex
    property alias listModel: lm
    property string currentCity: ''
    property string uTit: '<b>Horóscopo Mensual</b>'
    property real currentLat: 0.000
    property real currentLon: 0.000
    property int currentGmt: -0
    property string currentIdZona: ''
    property int svIndex: sv.currentIndex
    property int itemIndex: -1
    visible: itemIndex===sv.currentIndex
    onSvIndexChanged: {
        if(svIndex!==itemIndex){
            detener()
            return
        }
        if(svIndex===itemIndex){
            iniciar()
            //JS.raiseItem(r)
            return
        }
    }
    Behavior on height{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Settings{
        id: s
        fileName: 'zm.cfg'
        property int currentYear: -1
        property int currentMonth: -1
        property int currentQ: -1
    }

    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id:xTit
            width: lv.width
            height: app.fs*1.5
            color: 'black'
            border.width: 2
            border.color: txtLabelTit.focus?'red':'white'
            anchors.horizontalCenter: parent.horizontalCenter
            XText {
                id: txtLabelTit
                text: r.uTit
                font.pixelSize: app.fs*0.5
                width: parent.width-app.fs
                wrapMode: Text.WordWrap
                color: 'white'
                //focus: true
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onDoubleClicked: {
                    if(lm.count===0){
                        loadZonas()
                    }else{
                        mp.play()
                    }
                }
            }
        }
        GridView{
            id: lv
            width: r.width//*lm.count
            height: r.height-xTit.height
            //anchors.horizontalCenter: parent.horizontalCenter
            delegate: compItemList
            model: lm
            //orientation: ListView.Horizontal
            cacheBuffer: 10
            displayMarginBeginning: cacheBuffer*app.fs*3
            clip: true
            cellWidth: r.width
            cellHeight: lv.height
            Behavior on contentY{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
            onCurrentIndexChanged: {
                //contentY=0-lv.itemAtIndex(currentIndex).y//+r.height//+lv.itemAtIndex(currentIndex).height//-r.height//*0.5
            }
        }
    }
    ListModel{
        id: lm
        function addItem(vJson){
            return {
                json: vJson
            }
        }
    }
    Component{
        id: compItemList
        XZm{
            height: lv.height
            onTaskFinished: {
                if(itemIndex<lm.count-1){
                    lv.currentIndex++
                }else{
                    lv.currentIndex=0
                }
            }
        }
    }
    Item{id: xuqp}
    Component.onCompleted: {
        loadZonas()
    }
    function setCurrentTime(q, m, y){
        s.currentQ=q
        s.currentMonth=m
        s.currentYear=y
        for(var i=0; i<lm.count;i++){
            if(lv.itemAtIndex(i).selected){
                lv.itemAtIndex(i).loadJsonTask()
                break
            }
        }

        //No puede funcionar sin primero obtener las fechas de RS para q m y de zona.
        /*let fileName='./jsons/hm/zonas.json'
        let fileData=unik.getFile(fileName)
        //console.log('json zonas: '+fileData)
        let j=JSON.parse(fileData)
        var arrayZonas=[]
        var arrayLats=[]
        var arrayLons=[]
        var arrayGmts=[]
        for(var i=0;i<Object.keys(j.zonas).length;i++){
            //console.log('1: '+j['zonas']['z'+parseInt(i+1)]['id'])
            arrayZonas.push(j['zonas']['z'+parseInt(i+1)]['id'])
            arrayLats.push(j['zonas']['z'+parseInt(i+1)]['lat'])
            arrayLons.push(j['zonas']['z'+parseInt(i+1)]['lon'])
            arrayGmts.push(j['zonas']['z'+parseInt(i+1)]['gmt'])
        }
        for(i=0;i<arrayZonas.length;i++){
            //arrayZonas.push(j['zonas']['z'+parseInt(i+1)])

            for(var i2=0;i2<12;i2++){
                makePronJsonFiles(arrayZonas[i], i2, q, m, y, arrayLats[i], arrayLons[i], arrayGmts[i])
            }
        }*/
    }
    function loadZonas(){
        //panelControlsSign.currentIndex=5
        lm.clear()
        let fileName='./jsons/hm/zonas.json'
        let fileData=unik.getFile(fileName)
        //console.log('json zonas: '+fileData)
        let j=JSON.parse(fileData)
        for(var i=0;i<Object.keys(j.zonas).length;i++){
            lm.append(lm.addItem(j['zonas']['z'+parseInt(i+1)]))            
        }
    }
    function mkJsonsZonas(){
        //panelControlsSign.currentIndex=5
        lm.clear()
        let fileName='./jsons/hm/zonas.json'
        let fileData=unik.getFile(fileName)
        //console.log('json zonas: '+fileData)
        let j=JSON.parse(fileData)
        for(var i=0;i<Object.keys(j.zonas).length;i++){
            //lm.append(lm.addItem(j['zonas']['z'+parseInt(i+1)]))
        }
    }
    function makePronJsonFiles(zona, ns, q, m, y, lat, lon, gmt){
        let name=''+zona+'_'+app.signos[ns]+' '+q+'_'+m+'_'+y
        let fileNamePathJsonPl='./jsons/hm/'+zona+'/q'+q+'_'+m+'_'+y+'.json'
        let fileName=name.replace(/ /g, '_')+'.json'
        let dms=new Date(Date.now())
        let fileNamePath='./jsons/'+fileName
        let jsonCode='{"params":{"tipo":"pl", "fileNamePath": "'+fileNamePathJsonPl+'", "ms":'+dms.getTime()+',"n":"'+name+'","d":'+q+',"m":'+m+',"a":'+y+',"h":'+0+',"min":'+0+',"gmt":'+gmt+',"lat":'+lat+',"lon":'+lon+',"ciudad":"'+zona+'"}}'
        if(!unik.fileExist(fileNamePath)){
            unik.setFile(fileNamePath, jsonCode)
            //console.log('1: '+fileNamePath)
            //unik.speak('Grabando...')
        }else{
            //console.log('2: '+fileNamePath)
        }
    }
    function pause(){
        if(lv.itemAtIndex(lv.currentIndex).pauded){
            lv.itemAtIndex(lv.currentIndex).pause()
        }else{
            lv.itemAtIndex(lv.currentIndex).play()
        }
    }
    function play(){
        lv.itemAtIndex(lv.currentIndex).play()
    }
    function stop(){
        lv.itemAtIndex(lv.currentIndex).stop()
    }
    function iniciar(){
        lv.itemAtIndex(0).loadJsonTask()
    }
    function detener(){
        if(lv.count>=1){
            lv.itemAtIndex(0).detener()
            r.currentIndex=0
        }
    }
}
