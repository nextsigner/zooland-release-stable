import QtQuick 2.7
import QtQuick.Controls 2.12
import "../../js/Funcs.js" as JS
import "../../comps" as Comps

Rectangle {
    id: r
    width: parent.width
    height: tResizeText.running?uH:rowData.height+rowData.height*0.5
    color: apps.backgroundColor
    //border.width: 1
    //border.color: apps.fontColor
    property string titleData//: txtCurrentData.text
    property string stringMiddleSeparator: 'VN'
    property url uItemGrabber
    //property alias currentDateText: txtCurrentDate.text
    //property alias currentGmtText: txtCurrentGmt.text
    property bool showTimes: false
    property int fs: app.fs*0.5
    property var at: []
    property int uH: r.fs
    state: 'hide'
    states:[
        State {
            name: "show"
            PropertyChanges {
                target: r
                y:0
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                y:0-r.height
            }
        }
    ]
    Behavior on y{NumberAnimation{duration:app.msDesDuration;easing.type: Easing.InOutQuad}}
    onStateChanged: {
        //if(state==='show')tHide.restart()
    }
    onAtChanged: {
        rep.model=at
        r.fs=app.fs*0.5
        tResizeText.restart()
    }
    onHeightChanged: uH=height
    Timer{
        id: tResizeText
        running: false
        repeat: true
        interval: 50
        onTriggered: {
            if(row.width>r.width-app.fs){
                r.fs=r.fs-1
            }else{
                stop()
                r.grabToImage(function(result) {
                    //result.saveToFile(folder+"/"+imgFileName);
                    r.uItemGrabber=result.url
                });
            }
            //log.l('fs: '+r.fs)
        }
    }

    Timer{
        id: tHide
        running: false
        repeat: false
        interval: 15*1000
        //onTriggered: r.state='hide'
    }
    Row{
        id: row
        spacing: app.fs*0.15
        y:(parent.height-height)/2
        //x: app.fs*0.25
        anchors.horizontalCenter: parent.horizontalCenter//!app.ev?parent.horizontalCenter:undefined
        Rectangle{
            id: circuloSave
            width: app.fs*0.5
            height: width
            radius: width*0.5
            color: app.fileData===app.currentData?'gray':'red'
            border.width: 2
            border.color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            y:(parent.height-height)/2
            visible:  !app.ev
            MouseArea{
                anchors.fill: parent
                enabled: app.titleData!==app.currentData
                onClicked: {
                    JS.saveJson()
                }
            }
        }
        Row{
            id: rowData
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
            Repeater{
                id: rep
                Rectangle{
                    visible: txtRow.text.indexOf(':</b>-1')<0||txtRow.text.indexOf(':</b>0')<0
                    //width: modelData==='@'?1:(txtRow.text.indexOf(':</b>-1')>=0||txtRow.text.indexOf(':</b>0')>=0?1:txtRow.contentWidth+app.fs*0.3)
                    width: txtRow.contentWidth+app.fs*0.3
                    height: txtRow.contentHeight+app.fs*0.3
                    color: apps.backgroundColor
                    border.width: modelData==='@'?0:1
                    border.color: apps.fontColor
                    radius: app.fs*0.1
                    MouseArea{
                        anchors.fill: parent
                        //enabled: app.titleData!==app.currentData
                        onClicked: {
                            if(index===0){
                                nomEditor.visible=true
                            }
                            if(index===6||index===7){
                                latLonEditor.visible=true
                            }
                        }
                    }
                    Rectangle{
                        id: bgCell
                        anchors.fill: parent
                        color: apps.backgroundColor
                        radius: parent.radius
                        border.width: modelData==='@'?0:1
                        border.color: apps.fontColor
                    }
                    Text{
                        id: txtRow
                        text: modelData!=='@'?modelData:r.stringMiddleSeparator//.replace(/_/g, ' ')
                        font.pixelSize: r.fs
                        color: apps.fontColor
                        //visible: modelData!=='@' && parent.width>2
                        anchors.centerIn: parent
                        //                        Timer{
                        //                            running: true
                        //                            repeat: true
                        //                            interval: 3000
                        //                            onTriggered: {
                        //                                log.ls('['+txtRow.text+']', 0, xApp.width*0.2)
                        //                            }
                        //                        }
                    }
                    //Component.onCompleted: r.height=height+height*0.2
                    Rectangle{
                        width: r.width*2
                        height: r.height
                        color: apps.houseColor
                        z:parent.z-3
                        visible: index===0 && app.ev//(app.mod==='sin' || app.mod==='rs')
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.right
                        anchors.leftMargin: 0-r.width
                    }
                    Rectangle{
                        width: r.width*2
                        height: r.height
                        color: apps.houseColorBack
                        z:parent.z-3
                        visible: modelData==='@' && index!==0 && app.ev
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.right
                        anchors.leftMargin: rowData.children.length>=8?0-rowData.children[8].width*0.5:0
                    }
                }
            }
        }
    }
    Comps.XTimes{
        id: xTimes
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.5
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: yPos
        visible:  false//!app.ev || JSON.parse(app.currentData).params.tipo==='pron'
    }

    //Editor Nombre
    Rectangle{
        id: nomEditor
        anchors.fill: r
        color: apps.backgroundColor
        visible: false
        onVisibleChanged: {
            if(visible){
                tiNom.t.text=app.currentNom
                tiNom.t.focus=true
                tiNom.t.selectAll()
            }
        }
        Row{
            spacing: app.fs*0.25
            anchors.centerIn: parent
            Text{
                text: '<b>Nombre de Archivo: </b>'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.verticalCenter: parent.verticalCenter
            }
            Comps.XTextInput{
                id: tiNom
                t.font.pixelSize: app.fs*0.65
                t.text: 'Nombre'
                width: app.fs*10
                onPressed: saveNom()
                anchors.verticalCenter: parent.verticalCenter
            }
            Button{
                text:'Cancelar'
                anchors.verticalCenter: parent.verticalCenter
                onClicked: nomEditor.visible=false
            }
            Button{
                text:'Cambiar Nombre'
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    saveNom()
                }
                Timer{
                    running: nomEditor.visible
                    repeat: true
                    interval: 250
                    onTriggered: {
                        if(apps.jsonsFolder+'/'+tiNom.t.text.replace(/ /g, '_')+'.json' !== apps.url){
                            parent.visible=true
                        }else{
                            parent.visible=false
                        }
                    }
                }
            }
        }
    }

    //Editor Nombre
    Rectangle{
        id: latLonEditor
        anchors.fill: r
        color: apps.backgroundColor
        visible: false
        onVisibleChanged: {
            if(visible){
                tiLat.t.text=app.currentLat
                tiLon.t.text=app.currentLon
                tiLat.t.focus=true
                tiLat.t.selectAll()
            }
        }
        Row{
            spacing: app.fs*0.25
            anchors.centerIn: parent
            Text{
                text: '<b>Latitud: </b>'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.verticalCenter: parent.verticalCenter
            }
            Comps.XTextInput{
                id: tiLat
                t.font.pixelSize: app.fs*0.65
                t.text: 'lat...?'
                width: app.fs*5
                onPressed: saveLatLon()
                anchors.verticalCenter: parent.verticalCenter
            }
            Text{
                text: '<b>Longitud: </b>'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.verticalCenter: parent.verticalCenter
            }
            Comps.XTextInput{
                id: tiLon
                t.font.pixelSize: app.fs*0.65
                t.text: 'lon...?'
                width: app.fs*5
                onPressed: saveLatLon()
                anchors.verticalCenter: parent.verticalCenter
            }
            Button{
                text:'Cancelar'
                anchors.verticalCenter: parent.verticalCenter
                onClicked: latLonEditor.visible=false
            }
            Button{
                text:'Cambiar Coordenadas'
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    saveLatLon()
                }
                Timer{
                    running: nomEditor.visible
                    repeat: true
                    interval: 250
                    onTriggered: {
                        //                        if(apps.jsonsFolder+'/'+tiNom.t.text.replace(/ /g, '_')+'.json' !== apps.url){
                        //                            parent.visible=true
                        //                        }else{
                        //                            parent.visible=false
                        //                        }
                    }
                }
            }
        }
    }

    function saveNom(){
        let fn=apps.url
        let nfn=apps.jsonsFolder+'/'+tiNom.t.text.replace(/ /g, '_')+'.json'
        let json = app.currentData
        let jsonData=JSON.parse(app.currentData)
        jsonData.params.n=tiNom.t.text
        app.currentData=JSON.stringify(jsonData)
        //log.l('Actual url: '+apps.url)
        //log.l('Nueva url: '+nfn)
        //log.l('documentsPath: '+documentsPath)
        //log.l('apps.jsonsFolder: '+apps.jsonsFolder)
        //log.visible=true
        JS.saveJsonAs(nfn)
        nomEditor.visible=false
    }
    function saveLatLon(){
        //let fn=apps.url
        //let nfn=apps.jsonsFolder+'/'+tiNom.t.text.replace(/ /g, '_')+'.json'
        //let json = app.currentData
        let jsonData=JSON.parse(app.currentData)
        jsonData.params.lat=tiLat.t.text
        jsonData.params.lon=tiLon.t.text
        app.currentData=JSON.stringify(jsonData)
        //log.l('Actual url: '+apps.url)
        //log.l('Nueva url: '+nfn)
        //log.l('documentsPath: '+documentsPath)
        //log.l('apps.jsonsFolder: '+apps.jsonsFolder)
        //log.visible=true
        JS.saveJson()
        latLonEditor.visible=false
    }
}
