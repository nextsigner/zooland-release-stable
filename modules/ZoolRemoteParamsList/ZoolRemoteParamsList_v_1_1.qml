import QtQuick 2.0
import comps.Zbg 1.0
import ZoolRemoteParamsList.ZoolRemoteOptionList 1.0

Rectangle {
    id: r
    objectName: 'list'
    color: 'white'
    width: parent.width
    height: parent.height
    clip: true
    property alias ol: zrol
    property alias itemIndex: lv.currentIndex

    property string prevZFocus: ''

    visible: zsm.aPanelsIds.indexOf(vars.j.qmltypeof(r))===zsm.currentIndex
    onFocusChanged: {
        if(!focus && !zrol.focus)zrol.visible=false
    }
    Zbg{}
    ListView{
        id: lv
        spacing: vars.fs*0.1
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
            width: lv.width-vars.fs*0.5
            height: txt1.contentHeight
            color: selected?apps.fontColor:apps.backgroundColor
            border.width: 1
            border.color: !selected?apps.fontColor:apps.backgroundColor
            radius: vars.fs*0.15
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
                text: JSON.parse(JSON.stringify(params)).params.n.replace(/_/g, ' ')
                width: parent.width-vars.fs
                font.pixelSize: vars.fs
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                color: !selected?apps.fontColor:apps.backgroundColor
            }
        }
    }
    ZoolRemoteOptionList{
        id: zrol
        visible: false
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
        zsm.aPanelsIds.push(vars.j.qmltypeof(r))
        zsm.aPanelesTits.push('ZoolRemoteParamsList')
        //zsfdm.getZoolandParamsList()
        vars.ci=r
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
            //console.log(vars.j.getParamsNow(0))
//            let sParams=vars.j.getParamsNow(apps.userLat, apps.userLon, apps.userAlt, apps.userGmt, apps.userCity)
//            zpn.addNot('sParams: '+JSON.stringify(sParams, null, 2), false, 20000)
            //zpn.addNot('1 apps.userCity: '+apps.userCity, false, 20000)
            zsfdm.loadParamsFromString(JSON.stringify(vars.j.getParamsNow(apps.userLat, apps.userLon, apps.userAlt, apps.userGmt, apps.userCity)))
            return
        }
        if(lv.currentIndex>1){
            zrol.load(lm.get(lv.currentIndex).params)
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
