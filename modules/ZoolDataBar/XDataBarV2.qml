import QtQuick 2.7
import QtQuick.Controls 2.12
import "Funcs.js" as JS
import "./comps" as Comps

Rectangle {
    id: r
    width: parent.width
    height: app.fs*4
    //height: rowData0.height>rowData1.height?rowData1.height+app.fs*0.25:rowData1.height+app.fs*0.25
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    property string titleData//: txtCurrentData.text
    //property alias currentDateText: txtCurrentDate.text
    //property alias currentGmtText: txtCurrentGmt.text
    property bool showTimes: false
    property int fs: app.fs*0.5
    property var at: []
    property int uH: r.fs
    property string stringMiddleSeparator: 'Sinastría'
    property int fs0: app.fs*0.5
    property int fs1: app.fs*0.5
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
        updataAt()
    }
    onHeightChanged: uH=height



    Timer{
        id: tHide
        running: false
        repeat: false
        interval: 15*1000
        //onTriggered: r.state='hide'
    }
    Row{
        id: rowBg
        anchors.centerIn: parent
        visible: app.mod==='sin' || app.mod==='rs'
        Rectangle{
            width: r.width
            height: r.height
            color: apps.houseColor
            anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle{
            width: r.width
            height: r.height
            color: apps.houseColorBack
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Item{
        id: xSaveRects
        width: app.fs*0.5
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: (parent.height-width)*0.5
        z:row.z+1
        Rectangle{
            id: circuloSave
            width: app.fs*0.5
            height: width
            radius: width*0.5
            color: app.fileData===app.currentData?'gray':'red'
            border.width: 2
            border.color: apps.fontColor
            //anchors.verticalCenter: parent.verticalCenter
            //y:(parent.height-height)/2
            anchors.centerIn: parent
            visible:  !app.ev
            parent: xSaveRects
            MouseArea{
                anchors.fill: parent
                enabled: app.titleData!==app.currentData
                onClicked: {
                    JS.saveJson()
                }
            }
        }
        Rectangle{
            id: circuloSaveEV
            width: app.fs*0.5
            height: width
            //radius: width*0.5
            color: saved?'gray':'red'
            border.width: 2
            border.color: apps.fontColor
            anchors.centerIn: parent
            //y:(parent.height-height)/2
            visible:  app.ev// && app.tipo!=='rs' && app.tipo!=='sin'
            //parent: xSaveRects
            property bool saved: false
            Timer{
                id: tCheckBackIsSaved
                running: parent.visible
                repeat: true
                interval: 1000
                onTriggered: {
                    //app.fileData===app.currentData
                    let json=JSON.parse(app.fileData)
                    if(!json.paramsBack){
                        parent.saved=false
                    }else{
                        parent.saved=true
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                enabled: app.titleData!==app.currentData
                onClicked: {
                    JS.saveJsonBack()
                }
            }
        }
    }
    Row{
        id: rowVN
        spacing: app.fs*0.15
        anchors.centerIn: parent
        //visible: app.mod==='vn'
        Rectangle{
            id: xTextMiddleVN
            width: txtRowMiddleVN.contentWidth+app.fs*0.5
            height: txtRowMiddleVN.contentHeight+app.fs*0.3
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            radius: app.fs*0.1
            anchors.verticalCenter: parent.verticalCenter
            clip: true
            Text{
                id: txtRowMiddleVN
                text: r.stringMiddleSeparator
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.centerIn: parent
            }
        }

        Row{
            id: rowDataVN
            spacing: 4
           //width: r.width*0.5-xTextMiddleVN.width*0.5-rowData0.spacing-app.fs*2
            anchors.verticalCenter: parent.verticalCenter
            onWidthChanged: {

                //                    if(r.at.length>=9){
                //                        xLoading.visible=true
                //                        xLoading.opacity=1.0
                //                    }

            }

        }

    }
    Row{
        id: row
        spacing: app.fs*0.15
        anchors.centerIn: parent
        visible: app.mod==='sin' || app.mod==='rs'
        Item{
            width: 1
            height: r.height
            Flow{
                id: rowData0
                spacing: 4
                width: r.width*0.5-xTextMiddle.width*0.5-rowData0.spacing-app.fs*2
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                layoutDirection: Qt.RightToLeft
                onWidthChanged: {

                    //                    if(r.at.length>=9){
                    //                        xLoading.visible=true
                    //                        xLoading.opacity=1.0
                    //                    }

                }

            }
        }
        Rectangle{
            id: xTextMiddle
            width: txtRowMiddle.contentWidth+app.fs*0.5
            height: txtRowMiddle.contentHeight+app.fs*0.3
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            radius: app.fs*0.1
            anchors.verticalCenter: parent.verticalCenter
            clip: true
            Text{
                id: txtRowMiddle
                text: r.stringMiddleSeparator
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.centerIn: parent
            }
        }
        Item{
            width: 1
            height: r.height
            Flow{
                id: rowData1
                spacing: 4
                width: r.width*0.5-xTextMiddle.width*0.5-rowData0.spacing-app.fs*2
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                layoutDirection: Qt.LeftToRight
                onWidthChanged: {

                    //                    if(r.at.length>=9){
                    //                        xLoading.visible=true
                    //                        xLoading.opacity=1.0
                    //                    }

                }

            }
        }
    }
//    Rectangle{
//        anchors.fill: rowData
//        color: 'red'
//        border.color: 'yellow'
//        border.width: 4
//        visible: false
//    }
    Component{
        id: cellAt
        Rectangle{
            property var modelData
            property int index
            property int numFlow
            z: modelData==='@'?-100:index
            width: txtRow.contentWidth+app.fs*0.5
            height: txtRow.contentHeight+app.fs*0.3
            color: apps.backgroundColor
            border.width: modelData==='@'?0:1
            border.color: apps.fontColor
            radius: app.fs*0.1
            //anchors.verticalCenter: parent.verticalCenter
            clip: true
            //            MouseArea{
            //                anchors.fill: parent
            //                //enabled: app.titleData!==app.currentData
            //                onClicked: {
            //                    if(index===0){
            //                        nomEditor.visible=true
            //                    }
            //                    if(index===6||index===7){
            //                        latLonEditor.visible=true
            //                    }
            //                }
            //            }

            Text{
                id: txtRow
                text: modelData
                //text: index>1&&(''+modelData).length>15?(''+modelData).substring(0, 15):modelData
                font.pixelSize: numFlow===0?r.fs0:r.fs1
                color: apps.fontColor
                anchors.centerIn: parent
            }
            //            Text{
            //                text: numFlow
            //                font.pixelSize: 25
            //                color: 'red'
            //                anchors.centerIn: parent
            //            }
            Timer{
                running: index===5 && parent.y===0 && (app.mod==='sin' || app.mod==='rs')
                repeat: true
                interval: 200
                onTriggered: {
                    if(numFlow===0){
                        rowData0.width=rowData0.width-10
                    }
                    if(numFlow===1){
                        rowData1.width=rowData1.width-10
                    }
                }
            }
            //Component.onCompleted: r.height=height+height*0.2
            Rectangle{
                width: r.width*2
                height: r.height
                color: apps.houseColor
                visible: false
                //visible: modelData==='@'&&index===0
                //visible: modelData==='@'//&&index===6
                //visible: modelData!=='@'&&index===7
                anchors.verticalCenter: parent.verticalCenter
                //anchors.right: parent.right
                anchors.left: parent.right
                anchors.leftMargin: 0-r.width
            }
            Rectangle{
                width: r.width*2
                height: r.height
                color: apps.houseColorBack
                visible: false
                //visible: modelData==='@'&&index!==0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.right
            }
            Component.onCompleted: {
//                if(index===tLoadAt.nAt.length && r.at.length>=9){
//                    tResizeText.start()
//                }
            }
        }
    }
    Component{
        id: cellAtVN
        Rectangle{
            property var modelData
            property int index
            width: txtRowVN.contentWidth+app.fs*0.5
            height: txtRowVN.contentHeight+app.fs*0.3
            color: apps.backgroundColor
            border.width: modelData==='@'?0:1
            border.color: apps.fontColor
            radius: app.fs*0.1
            //anchors.verticalCenter: parent.verticalCenter
            clip: true


            Text{
                id: txtRowVN
                text: modelData
                //text: index>1&&(''+modelData).length>15?(''+modelData).substring(0, 15):modelData
                font.pixelSize: 50//numFlow===0?r.fs0:r.fs1
                color: apps.fontColor
                anchors.centerIn: parent
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

    function updataAt(){
        rowData0.width= r.width*0.5-xTextMiddle.width*0.5-rowData0.spacing-app.fs*2
        rowData1.width= r.width*0.5-xTextMiddle.width*0.5-rowData0.spacing-app.fs*2
        for(var i=0;i<rowData0.children.length;i++){
            rowData0.children[i].destroy(1)
        }
        for(var i=0;i<rowData1.children.length;i++){
            rowData1.children[i].destroy(1)
        }
        for(var i=0;i<rowDataVN.children.length;i++){
            rowDataVN.children[i].destroy(1)
        }
        let sbreak=false
        let ni=0
        for(i=0;i<r.at.length;i++){
            if(at[i]==='@'){
                sbreak=true
                ni=0
                continue
            }
            let obj
            let objVN
            if(!sbreak){
                //log.ls('0 cell '+i+': '+at[i], 0, 500)
                if(at.indexOf('@')<0){
                    obj=cellAt.createObject(rowData1, {numFlow: 1, modelData: at[i], index: ni})
                }else{
                    obj=cellAt.createObject(rowData0, {numFlow: 0, modelData: at[i], index: ni})
                    objVN=cellAtVN.createObject(rowDataVN, {numFlow: 2, modelData: at[i], index: ni})
                }
            }else{
                //log.ls('1 cell '+i+': '+at[i], 0, 500)
                //obj=cellAt.createObject(rowData1, {numFlow: 1, modelData: at[i], index: ni})
                obj=cellAt.createObject(rowDataVN, {numFlow: 2, modelData: at[i], index: ni})
            }
            ni++
            //let obj=cellAt.createObject(rowData, {modelData: at[i], index: i})
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
