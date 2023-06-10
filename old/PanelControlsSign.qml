import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.12
import "./js/Funcs.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    anchors.bottom: parent.bottom
    color: 'black'
    border.width: 2
    border.color: 'white'
    state: 'hide'
    property bool enableLoadSign: true
    property alias currentIndex: lv.currentIndex
    Behavior on height{enabled: apps.enableFullAnimation;NumberAnimation{duration:app.msDesDuration;easing.type: Easing.InOutQuad}}
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: r
                x:r.parent.width-r.width
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                x:r.parent.width
            }
        }
    ]
    Behavior on x{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    onStateChanged: {
        if(state==='hide')return
        JS.raiseItem(r)
        //xApp.focus=true
    }
    onXChanged: {
        if(x===0){
            //txtDataSearch.selectAll()
            //txtDataSearch.focus=true
        }
    }
    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        ListView{
            id: lv
            width: r.width
            height: r.height
            anchors.horizontalCenter: parent.horizontalCenter
            delegate: compItemList
            model: lm
            currentIndex: app.currentSignIndex
            clip: true
            onCurrentIndexChanged: {
                //if(currentIndex<0)return
                /*if(!r.enableLoadSign){
                    r.enableLoadSign=true
                    return
                }*/
                //if(currentIndex<12&&panelZonaMes.state==='hide'){
                if(currentIndex<12){
                    let joPar=app.currentJsonSignData.params
                    if(!app.currentJsonSignData.fechas)return
                    let jo=app.currentJsonSignData.fechas['is'+currentIndex]
                    //let s = app.signos[i]+ ' '+jo.d+'/'+jo.m+'/'+jo.a+' '+jo.h+':'+jo.min
                    let d1=new Date(jo.a, jo.m - 1, jo.d, jo.h, jo.min)
                    d1 = d1.setMinutes(d1.getMinutes() + 4)
                    let d2=new Date(d1)
                    let jsonCode='{"params":{"ms":100,"n":"Trópico","d":'+d2.getDate()+',"m":'+parseInt(d2.getMonth() + 1)+',"a":'+d2.getFullYear()+',"h":'+d2.getHours()+',"min":'+d2.getMinutes()+',"gmt":'+joPar.gmt+',"lat":'+joPar.lat+',"lon":'+joPar.lon+',"ciudad":"Ubicación no definida."}}'
                    app.currentData=jsonCode
                    app.fileData=jsonCode
                    JS.runJsonTemp()
                }
            }
        }
    }
    ListModel{
        id: lm
        function addItem(vFileName, vData){
            return {
                fileName: vFileName,
                dato: vData
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            width: lv.width
            height: txtData.contentHeight+app.fs*0.1
            color: index===lv.currentIndex?'white':'black'
            border.width: index===lv.currentIndex?4:2
            border.color: 'white'
            XText {
                id: txtData
                text: dato
                font.pixelSize: app.fs*0.5
                width: parent.width-app.fs
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                color: index===lv.currentIndex?'black':'white'
                anchors.centerIn: parent
            }
        }
    }
    function loadJson(json){
        //lv.currentIndex=-1
        lm.clear()
        let jo
        let o
       for(var i=0;i<12;i++){
           jo=json.fechas['is'+i]
           let s = app.signos[i]+ ' '+jo.d+'/'+jo.m+'/'+jo.a+' '+jo.h+':'+jo.min
           lm.append(lm.addItem('a', s))
       }
       //lv.currentIndex=0
        r.state='show'
        lv.onCurrentIndexChanged()
    }
    function copyPlanetsForPron(json){
        lm.clear()
        let jo
        let o
       for(var i=0;i<12;i++){
           jo=json.fechas['is'+i]
           let s = app.signos[i]+ ' '+jo.d+'/'+jo.m+'/'+jo.a+' '+jo.h+':'+jo.min
           lm.append(lm.addItem('a', s))
       }
       //lv.currentIndex=0
        r.state='show'
    }
}
