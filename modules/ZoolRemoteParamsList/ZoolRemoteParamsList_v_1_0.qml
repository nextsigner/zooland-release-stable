import QtQuick 2.0
import comps.Zbg 1.0

Rectangle {
    id: r
    objectName: 'list'
    color: 'white'
    width: parent.width
    height: parent.height
    clip: true
    property alias itemIndex: lv.currentIndex

    property string prevZFocus: ''

    visible: zsm.aPanelsIds.indexOf(app.j.qmltypeof(r))===zsm.currentIndex

    Zbg{}
    ListView{
        id: lv
        spacing: app.fs*0.1
        anchors.fill: parent
        delegate: compItem
        model: lm
        ListModel{
            id: lm
            function addItem(p){
                return{
                    params:p
                }
            }
        }

    }
    Component{
        id: compItem
        Rectangle{
            id: xItem
            width: lv.width-app.fs*0.5
            height: txt1.contentHeight
            color: selected?apps.fontColor:apps.backgroundColor
            border.width: 1
            border.color: !selected?apps.fontColor:apps.backgroundColor
            radius: app.fs*0.15
            anchors.horizontalCenter: parent.horizontalCenter
            property bool selected: lv.currentIndex===index
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lv.currentIndex=index
                    r.toEnter()
                }
            }
            Text{
                id: txt1
                text: JSON.parse(JSON.stringify(params)).params.n
                width: parent.width-app.fs
                font.pixelSize: app.fs
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                color: !selected?apps.fontColor:apps.backgroundColor
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
            running: app.ci===r
            repeat: true
            interval: 500
            onTriggered: parent.visible=!parent.visible
        }
    }

    Timer{
        id: tShow
        running: true
        repeat: false        
        interval: 1000
        onTriggered: {
            zsm.currentIndex=0
            zsfdm.getZoolandParamsList()
        }
    }
    Component.onCompleted: {
        let p=JSON.parse('{"params":{"n":"Cargar"}}')
        lm.append(lm.addItem(p))
        p=JSON.parse('{"params":{"n":"Ahora"}}')
        lm.append(lm.addItem(p))
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('ZoolRemoteParamsList')
        //zsfdm.getZoolandParamsList()
        app.ci=r
        //toEnter()
    }
    function load(j){
        lm.clear()
        let p=JSON.parse('{"params":{"n":"Actualizar"}}')
        lm.append(lm.addItem(p))
        p=JSON.parse('{"params":{"n":"Ahora"}}')
        lm.append(lm.addItem(p))
        for(var i=0; i< j.data.length; i++){
            //let
            //log.lv('j.data: '+JSON.stringify(j.data[i], null, 2))
            p=j.data[i]
            //log.lv('j.data.params: '+JSON.stringify(j.data[i], null, 2))
            lm.append(lm.addItem(p))
        }
    }
    //Funciones de Mando
    /*
    function toEnter(){

    }
    function toLeft(){

    }
    function toRight(){

    }
    function toDown(){

    }
    function toUp(){

    }
    */
    function toEnter(){
        if(lv.currentIndex===0){
            zsfdm.getZoolandParamsList()
            return
        }
        if(lv.currentIndex===1){
            //console.log(app.j.getParamsNow(0))
            zsfdm.loadParamsFromString(JSON.stringify(app.j.getParamsNow(0)))
            return
        }
        if(lv.currentIndex>1){

            let sp=JSON.stringify(lm.get(lv.currentIndex).params)
            zsfdm.loadParamsFromString(sp)
            return
        }
    }
    function toLeft(){

    }
    function toRight(){

    }
    function toDown(){
        if(lv.currentIndex<lm.count-1){
            lv.currentIndex++
        }else{
            lv.currentIndex=0
        }
    }
    function toUp(){
        if(lv.currentIndex>0){
            lv.currentIndex--
        }else{
            lv.currentIndex=lm.count-1
        }
    }
}
