import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../"
import "../../../comps" as Comps

import ZoolandBodies.ZoolAsCotaDeg 1.0
import ZoolandBodies.ZoolAsCotaText 1.0

Item{
    id: r
    width: parent.width-(xIcon.width*objData.p)
    height: 1
    anchors.centerIn: parent
    z: !selected?numAstro:15

    property string folderImg: '../../../modules/ZoolandBodies/ZoolAs/imgs_v1'

    property bool isHovered: false

    //property bool isPron: JSON.parse(vars.currentData).params.tipo==='pron'
    property bool isPron: false//JSON.parse(vars.fileData).params.tipo==='pron'
    property int widthRestDec:apps.showDec?sweg.objSignsCircle.w*2:0
    property bool selected: numAstro === vars.currentPlanetIndex//panelDataBodies.currentIndex
    property string astro
    property int fs
    property var objData: ({g:0, m:0,s:0,ih:0,is:0, rsgdeg:0,rsg:0, gdec:0.000})
    property int pos: 1
    property int g: -1
    property int m: -1
    property int ih: -1
    property int is: -1
    property int numAstro: 0

    property string text: sweg.aTexts[numAstro]

    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12,13,14,15,16,17]

    property color colorCuerpo: '#ff3300'

    property int uRot: 0

    property bool isZoomAndPosSeted: false
    //property alias objOointerPlanet: pointerPlanet
    onWidthChanged: tSetWaps.restart()
    onSelectedChanged: {
        if(selected)vars.uSon=''+vars.planetasRes[r.numAstro]+'_'+vars.objSignsNames[r.is]+'_'+objData.ih
        if(selected){
            pointerPlanet.setPointerFs()
            housesCircle.currentHouse=objData.ih
            vars.currentHouseIndex=objData.ih
            vars.currentXAs=r
            setRot()
            setZoomAndPos()
            vars.showPointerXAs=true
        }
    }
    Rectangle{
        id: ejePos
        width: sweg.width*3
        height: 1
        anchors.centerIn: parent
        color: apps.fontColor
        visible: vars.tipo==='dirprim'
    }
    Rectangle{
        id: eje100
        width: r.width
        height: 3
        anchors.centerIn: parent
        color: apps.fontColor
        visible: false//vars.dev
    }
    Rectangle{
        width: r.width*4
        height: 4
        x:0-r.width*2
        anchors.verticalCenter: parent.verticalCenter
        color: apps.xAsLineCenterColor
        visible: r.selected && (apps.showXAsLineCenter || apps.showDec)
    }
    Rectangle{
        id: xIcon
        width: sweg.pz
        height: width
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        color: !apps.xAsShowIcon?(r.selected?apps.backgroundColor:'transparent'):'transparent'
        radius: width*0.5
//        PointerPlanet{
//            id: pointerPlanet
//            is:r.is
//            gdeg: objData.g
//            mdeg: objData.m
//            rsgdeg:objData.rsg
//            ih:objData.ih
//            expand: r.selected
//            iconoSignRot: img.rotation
//            p: r.numAstro
//            opacity: r.selected&&vars.showPointerXAs?1.0:0.0// && JSON.parse(vars.currentData).params.tipo!=='pron'
//            pointerRot:180
//            onPointerRotChanged: {
//                r.uRot=pointerRot
//                //saveRot()
//                //setRot()
//            }
//        }
        MouseArea{
            id: maSig
            property int vClick: 0
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons;
            hoverEnabled: true
            onWheel: {
                //apps.enableFullAnimation=false
                if (wheel.modifiers & Qt.ControlModifier) {
                    if(wheel.angleDelta.y>=0){
                        pointerPlanet.pointerRot+=5
                    }else{
                        pointerPlanet.pointerRot-=5
                    }
                }else if (wheel.modifiers & Qt.ShiftModifier){
                    if(wheel.angleDelta.y>=0){
                        xTextData.rot+=5
                    }else{
                        xTextData.rot-=5
                    }
                    r.isHovered=true
                    tWaitHovered.restart()
                }else{
                    if(wheel.angleDelta.y>=0){
                        //                    if(reSizeAppsFs.fs<vars.fs*2){
                        //                        reSizeAppsFs.fs+=reSizeAppsFs.fs*0.1
                        //                    }else{
                        //                        reSizeAppsFs.fs=vars.fs
                        //                    }
                        pointerPlanet.pointerRot+=45
                    }else{
                        //                    if(reSizeAppsFs.fs>vars.fs){
                        //                        reSizeAppsFs.fs-=reSizeAppsFs.fs*0.1
                        //                    }else{
                        //                        reSizeAppsFs.fs=vars.fs*2
                        //                    }
                        pointerPlanet.pointerRot-=45
                    }
                }
                //reSizeAppsFs.restart()
            }
            onEntered: {
                r.isHovered=true
                vClick=0
                r.parent.cAs=r
            }
            onMouseXChanged:{
                r.isHovered=true
                tWaitHovered.restart()
            }
            onMouseYChanged:{
                r.isHovered=true
                tWaitHovered.restart()
            }
            onExited: {
                tWaitHovered.restart()
                vClick=0
                //r.parent.cAs=r.parent
            }
            onClicked: {
                //apps.sweFs=vars.fs
                if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                    vars.uSonFCMB=''+vars.planetasRes[r.numAstro]+'_'+vars.objSignsNames[r.is]+'_'+objData.ih

                    menuPlanets.isBack=false
                    menuPlanets.currentIndexPlanet=r.numAstro
                    menuPlanets.popup()
                } else if (mouse.button === Qt.LeftButton) {
                    vClick++
                    tClick.restart()
                }
            }
            onDoubleClicked: {
                tClick.stop()
                r.parent.doublePressed(r)
            }
            Timer{
                id: tClick
                running: false
                repeat: false
                interval: 500
                onTriggered: {
                    if(maSig.vClick<=1){
                        if(!r.selected){

                            let msg='Mostrando '+vars.planetasReferencia[r.numAstro]
                            msg+=' en el signo '+vars.signos[r.is]
                            msg+=' en el grado '+r.objData.rsg+' '+r.objData.m+' minutos '+r.objData.s+' segundos. Casa '+r.ih
                            //zoolVoicePlayer.speak(msg, true)
                        }
                        r.parent.pressed(r)
                    }else{
                        r.parent.doublePressed(r)
                    }
                }
            }
        }
        Image {
            id: img
            source: vars.planetasRes[r.numAstro]?r.folderImg+"/"+vars.planetasRes[r.numAstro]+(apps.xAsShowIcon&&r.aIcons.indexOf(r.numAstro)>=0?"_i.png":".svg"):""
            //width: r.parent.parent.objectName==='sweg'?!r.selected?parent.width:parent.width*2:!r.selected?parent.width:parent.width*1.25
            width: parent.width*0.8
            height: width
            rotation: 0-parent.parent.rotation
            antialiasing: true
            anchors.centerIn: parent
            //anchors.horizontalCenterOffset: apps.xAsShowIcon?0-sweg.fs*0.5:0
            Behavior on width {
                enabled: apps.enableFullAnimation;
                NumberAnimation{
                    duration: 350
                    easing.type: Easing.InOutQuad
                }
            }
            Behavior on x {
                enabled: apps.enableFullAnimation;
                NumberAnimation{
                    duration: 350
                    easing.type: Easing.InOutQuad
                }
            }

        }
        ColorOverlay {
            id: co1
            anchors.fill: img
            source: img
            color: !apps.xAsShowIcon?(r.selected?apps.fontColor:apps.xAsColor):'white'
            rotation: img.rotation
            antialiasing: true
            visible: !apps.xAsShowIcon||r.aIcons.indexOf(r.numAstro)<0
        }

        //        Component.onCompleted: {
        //            if(r.numAstro===0){
        //                let comp=Qt.createComponent('./zoolbody/ZoolBodySun.qml')
        //                let obj=comp.createObject(xIcon, {w: xIcon.width*0.5})
        //                img.visible=false
        //                co1.visible=false
        //            }
        //        }
    }
    ZoolAsCotaDeg{
        id: xDegData
        width: xIcon.width*2
        anchors.centerIn: xIcon
        z: xIcon.z-1
        isBack: false
        distancia: img.width
        gdec: objData.gdec
        g: objData.rsg
        m:objData.m
        s:objData.s
        ih:objData.ih
        is:objData.is
        cotaColor: apps.fontColor
        cotaOpacity: 1.0//xIconPlanetSmall.opacity
        //rot: -270
        visible: sweg.listCotasShowing.indexOf(r.numAstro)>=0
        Timer{
            running: true
            repeat: true
            interval: 250
            onTriggered: {
                parent.visible=sweg.listCotasShowing.indexOf(r.numAstro)>=0
            }
        }
    }
    ZoolAsCotaText{
        id: xTextData
        width: xIcon.width*2
        anchors.centerIn: xIcon
        z: xIcon.z-1
        widthObjectAcoted: width*0.25
        isBack: false
        distancia: img.width*3
        text: r.text
        cotaColor: apps.fontColor
        cotaOpacity: 1.0
        opacity: r.isHovered||isPinched?1.0:0.0
        onOpacityChanged: r.text = sweg.aTexts[numAstro]?sweg.aTexts[numAstro]:''
        visible: r.text!==''
        onClicked: r.isHovered=false
    }
    Image {
        id: imgEarth
        source: r.folderImg+"/earth.png"
        width: sweg.width*0.05
        height: width
        rotation: -45
        antialiasing: true
        anchors.centerIn: parent
        visible: r.numAstro===0&&apps.xAsShowIcon
    }
    Rectangle{
        width: r.width*0.5-xIcon.width
        height: vars.fs*0.25
        color: 'transparent'
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        visible: apps.xAsShowIcon
        anchors.leftMargin: xIcon.width*0.5
//        Comps.XSignal{
//            width: parent.width
//            anchors.verticalCenter: parent.verticalCenter
//            height: vars.fs*6
//            numAstro: r.numAstro
//            //visible: r.numAstro===0
//            visible: r.selected
//        }
    }
//    Comps.XCircleSignal{
//        id: xCircleSignal
//        width: vars.fs*16
//        height: width
//        anchors.centerIn: xIcon
//        visible: vars.dev && r.selected && !r.isZoomAndPosSeted && JSON.parse(vars.currentData).params.tipo!=='pron'
//    }
    Timer{
        running: !r.isZoomAndPosSeted && r.selected
        repeat: true
        interval: 1000
        onTriggered: setZoomAndPos()
    }
    Timer{
        id: tWaitHovered
        running: false
        repeat: false
        interval: 5000
        onTriggered: {
            r.isHovered=false
        }
    }
    Timer{
        id: tSetWaps
        running: false
        repeat: false
        interval: 250
        onTriggered: {
            if(r.numAstro===vars.planetasRes.length-1){
                //sweg.tsw.restart()
                //sweg.setWaps(false, r.width)
            }
        }
    }
    function rot(d){
        if(d){
            pointerPlanet.pointerRot+=5
        }else{
            pointerPlanet.pointerRot-=5
        }
        saveRot(parseInt(pointerPlanet.pointerRot))
    }
    function saveRot(rot){
        let json=zfdm.getJson()
        if(!json.rots){
            json.rots={}
        }
        json.rots['rc'+r.numAstro]=rot
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }

    //Rot
    function setRot(){
        if(!r.isPron){
            let json=JSON.parse(vars.fileData)
            if(json.rots&&json.rots['rc'+r.numAstro]){
                r.uRot=json.rots['rc'+r.numAstro]
                pointerPlanet.pointerRot=r.uRot
            }
        }else{
            pointerPlanet.pointerRot=180
        }
    }
    function restoreRot(){
        pointerPlanet.pointerRot=r.uRot
    }

    //Zoom And Pos
    function saveZoomAndPos(){
        let json=zfdm.getJson()
        if(!json[vars.stringRes+'zoompos']){
            json[vars.stringRes+'zoompos']={}
        }
        json[vars.stringRes+'zoompos']['zpc'+r.numAstro]=sweg.getZoomAndPos()
        if(vars.dev){
            //log.ls('xAs'+r.numAstro+': saveZoomAndPos()'+JSON.stringify(json, null, 2), 0, log.width)
            log.ls('json['+vars.stringRes+'zoompos][zpc'+r.numAstro+']=sweg.getZoomAndPos()'+JSON.stringify(json[vars.stringRes+'zoompos']['zpc'+r.numAstro], null, 2), 0, log.width)
        }
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }
    function setZoomAndPos(){
        let json=JSON.parse(vars.fileData)
        if(json[vars.stringRes+'zoompos']&&json[vars.stringRes+'zoompos']['zpc'+r.numAstro]){
            sweg.setZoomAndPos(json[vars.stringRes+'zoompos']['zpc'+r.numAstro])
            r.isZoomAndPosSeted=true
        }else{
            r.isZoomAndPosSeted=false
        }
    }
}
