import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../"
import "../../../comps" as Comps

import ZoolandMap.ZoolMapBodie 1.0
import ZoolandMap.ZoolMapAsCotaDeg 1.0
import ZoolandMap.ZoolMapAsCotaText 1.0
import ZoolandMap.ZoolMapPointerPlanet 1.0

Item{
    id: r
    //width: parent.width-((zm.planetSize*pos*2))-(zm.planetsMargin*2)//-(zm.planetsMargin*2)
    width: !apps.showDec?
               parent.width-((zm.planetSize*pos*2))
             :
               parent.width-((zm.planetSize*pos*2))-zm.objSignsCircle.w*2
    height: 10
    anchors.centerIn: parent
    z: !selected?numAstro:20

    property string folderImg: '../../../modules/ZoolBodies/ZoolAs/imgs_v1'

    property bool isHovered: false

    //property bool isPron: JSON.parse(app.currentData).params.t==='pron'
    property bool isBack: false
    property bool isPron: false//JSON.parse(app.fileData)?JSON.parse(app.fileData).params.t==='pron':false
    property int widthRestDec:apps.showDec?zm.objSignsCircle.w*2:0
    property bool selected: !isBack?numAstro === zm.currentPlanetIndex:numAstro === zm.currentPlanetIndexBack
    property string astro
    property int fs
    property var objData: ({g:0, m:0,s:0,ih:0,is:0, rsgdeg:0,rsg:0, gdec:0.000})
    property int pos: 1
    property int g: -1
    property int m: -1
    property int ih: -1
    property int is: -1
    property int numAstro: 0

    property string text: zm.aTexts[numAstro]

    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12,13,14,15,16,17]

    property color colorCuerpo: '#ff3300'

    property int uRot: 0

    property bool isZoomAndPosSeted: false
    property alias objOointerPlanet: pointerPlanet
    //property alias img: bodie.objImg
    //property alias img0: bodie.objImg0
    Behavior on rotation{enabled:(app.t==='dirprim' || app.t==='trans');NumberAnimation{duration: 2000}}
    Behavior on width{enabled:(app.t==='dirprim' || app.t==='trans');NumberAnimation{duration: 2000}}
    Behavior on opacity{id:anOp;NumberAnimation{duration: 500}}
    onWidthChanged: {
        h()
        if(app.t!=='trans' && app.t!=='dirprim')return
        zm.resizeAspCircle()
    }
    onRotationChanged: h()
    onGChanged: h()
    onMChanged: h()
    onIhChanged: h()
    onIsChanged: h()
    onSelectedChanged: {
        if(selected)zm.uSon=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
        if(selected){
            //bodie.objOointerPlanet.setPointerFs()
            housesCircle.currentHouse=objData.ih
            zm.currentHouseIndex=objData.ih
            if(!r.isBack){
                app.currentXAs=r
                zm.currentIndexSign=r.is
            }else{
                app.currentXAsBack=r
                zm.currentIndexSignBack=r.is
            }
            setRot()
            setZoomAndPos()
            app.showPointerXAs=true
            //zm.setPos(r.mapToGlobal(0, 0).x, r.mapToGlobal(0, 0).y, zm.objSignsCircle.rotation)


        }
    }
    property int vr: 0
    //Behavior on width{NumberAnimation{duration:1500}}
    function revPos(){
        for(var i=r.vr;i<zm.aBodies.length;i++){
            const objAs=!r.isBack?zm.objPlanetsCircle.getAs(i):zm.objPlanetsCircleBack.getAs(i)
            const l=parseInt(r.objData.gdec)-10
            const h=parseInt(r.objData.gdec)+10
            if(!objAs || !objAs.objData || !objAs.objData.gdec)continue
            const n=objAs.objData.gdec
            if((n > l && n < h)  && i!==numAstro  && i<numAstro){
                r.pos=objAs.pos+1
                break
            }
        }
        r.vr++
    }
    Rectangle{
        id: ejePos
        width: (zm.width-r.width)*0.5
        height: 1
        //anchors.centerIn: parent
        color: apps.houseColor
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.left
        visible: (app.t==='dirprim' || app.t==='trans') && !r.isBack
    }
    Row{
        anchors.verticalCenter: parent.verticalCenter
        anchors.right:  parent.left
        visible: app.dev
        Repeater{
            model: r.pos
            Rectangle{
                width: zm.planetSize
                height: width
                border.width: 2
                border.color: 'red'
                Text{
                    text: r.vr
                    font.pixelSize: parent.width*0.8
                    anchors.centerIn: parent
                }

            }
        }
    }
    Item{
        id: ejePosBack
        width: r.width*0.5
        height: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: zm.planetSize
        visible: (app.t==='dirprim'  || app.t==='trans') && r.isBack
        Rectangle{
            width: r.width
            height: 1
            anchors.top: parent.top
            color: apps.houseColorBack
        }
        Rectangle{
            width: r.width
            height: 1
            anchors.bottom: parent.bottom
            color: apps.houseColorBack
        }
    }
    Rectangle{
        width: r.width*4
        height: 4
        x:0-r.width*2
        anchors.verticalCenter: parent.verticalCenter
        color: apps.xAsLineCenterColor
        visible: r.selected && (apps.showXAsLineCenter || apps.showDec)
    }
    Image {
        id: imgEarth
        source: r.folderImg+"/earth.png"
        width: zm.width*0.05
        height: width
        rotation: -45
        antialiasing: true
        anchors.centerIn: parent
        visible: r.numAstro===0//&&apps.xAsShowIcon
    }
    ZoolMapBodie{
        id: bodie
        numAstro: r.numAstro
        is: r.is
        width: zm.planetSize
        objData: r.objData
        anchors.left: parent.left
        anchors.leftMargin: 0//!r.selected?0:width*0.5
        anchors.verticalCenter: parent.verticalCenter
        isBack: r.isBack
        ZoolMapPointerPlanet{
            id: pointerPlanet
            is:r.is
            gdeg: objData.g
            mdeg: objData.m
            rsgdeg:objData.gdec-(30*is)
            ih:objData.ih
            expand: r.selected
            iconoSignRot: parent.objImg.rotation
            p: r.numAstro
            opacity: r.selected&&app.showPointerXAs?1.0:0.0// && JSON.parse(app.currentData).params.t!=='pron'
            onPointerRotChanged: {
                r.uRot=pointerRot
                //saveRot()
                //setRot()
            }
        }
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
                        if(pointerPlanet.opacity===1.0){
                            pointerPlanet.pointerRot+=5
                        }else{
                            if(zm.planetSize<app.fs*2){
                                zm.planetSize+=app.fs*0.1
                                zm.resizeAspsCircle(r.isBack)
                            }
                        }
                    }else{
                        if(pointerPlanet.opacity===1.0){
                            pointerPlanet.pointerRot-=5
                        }else{
                            if(zm.planetSize>app.fs){
                                zm.planetSize-=app.fs*0.1
                                zm.resizeAspsCircle(r.isBack)
                            }
                        }
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
                        //                    if(reSizeAppsFs.fs<app.fs*2){
                        //                        reSizeAppsFs.fs+=reSizeAppsFs.fs*0.1
                        //                    }else{
                        //                        reSizeAppsFs.fs=app.fs
                        //                    }
                        pointerPlanet.pointerRot+=45
                    }else{
                        //                    if(reSizeAppsFs.fs>app.fs){
                        //                        reSizeAppsFs.fs-=reSizeAppsFs.fs*0.1
                        //                    }else{
                        //                        reSizeAppsFs.fs=app.fs*2
                        //                    }
                        pointerPlanet.pointerRot-=45
                    }
                }
                //reSizeAppsFs.restart()
            }
            onEntered: {
                r.isHovered=true
                zoolMapAsInfoView.text=r.text
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
                zoolMapAsInfoView.text=''
            }
            onClicked: {
                //apps.sweFs=app.fs
                if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                    zm.uSonFCMB=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih

                    menuPlanets.isBack=false
                    menuPlanets.currentIndexPlanet=r.numAstro
                    menuPlanets.currentIndexSign=r.is
                    menuPlanets.currentIndexHouse=r.ih
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
                function rotatePoint(x, y, angle) {
                    // Convertir el ángulo a radianes
                    var radians = angle * Math.PI / 180;

                    // Calcular las coordenadas rotadas
                    var rotatedX = x * Math.cos(radians) - y * Math.sin(radians);
                    var rotatedY = x * Math.sin(radians) + y * Math.cos(radians);

                    return { x: rotatedX, y: rotatedY };
                }   running: false
                repeat: false
                interval: 500
                onTriggered: {
                    if(maSig.vClick<=1){
                        if(!r.selected){
                            let msg='Mostrando '+app.planetasReferencia[r.numAstro]
                            msg+=' en el signo '+app.signos[r.is]
                            msg+=' en el grado '+r.objData.rsg+' '+r.objData.m+' minutos '+r.objData.s+' segundos. Casa '+r.ih
                            zoolVoicePlayer.speak(msg, true)
                        }
                        r.parent.pressed(r)
                    }else{
                        r.parent.doublePressed(r)
                    }
                }
            }
        }
        Rectangle{
            width: parent.width*0.5
            height: width
            color: 'black'
            visible: app.dev
            Text{
                text: r.pos
                font.pixelSize: parent.width-4
                color: 'white'
                anchors.centerIn: parent
            }
        }
    }
    ZoolMapAsCotaDeg{
        id: xDegData
        width: bodie.width*2
        anchors.centerIn: bodie
        z: bodie.z-1
        isBack: r.isBack
        distancia: bodie.width
        gdec: objData.gdec
        g: objData.rsg
        m:objData.m
        s:objData.s
        ih:objData.ih
        is:objData.is
        cotaColor: apps.fontColor
        cotaOpacity: 1.0//xIconPlanetSmall.opacity
        //rot: -270
        visible: !r.isBack?
                     zm.listCotasShowing.indexOf(r.numAstro)>=0
                   :
                     zm.listCotasShowingBack.indexOf(r.numAstro)>=0
        //        Rectangle{
        //            width: 100
        //            height: 100
        //        }
        Timer{
            running: false//true
            repeat: true
            interval: 250
            onTriggered: {
                parent.visible=zm.listCotasShowing.indexOf(r.numAstro)>=0
            }
        }
    }
    ZoolMapAsCotaText{
        id: xTextData
        width: bodie.width*2
        anchors.centerIn: bodie
        z: bodie.z-1
        widthObjectAcoted: width*0.25
        isBack: false
        distancia: bodie.width*3
        text: r.text
        cotaColor: apps.fontColor
        cotaOpacity: 1.0
        opacity: r.isHovered||isPinched?1.0:0.0
        onOpacityChanged: r.text = zm.aTexts[numAstro]?zm.aTexts[numAstro]:''
        visible: false//r.text!==''
        onClicked: r.isHovered=false
    }
    Rectangle{
        width: r.width*0.5-bodie.width
        height: app.fs*0.25
        color: 'transparent'
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        visible: apps.xAsShowIcon
        anchors.leftMargin: bodie.width*0.5

//        Comps.XSignal{
//            width: parent.width
//            anchors.verticalCenter: parent.verticalCenter
//            height: app.fs*6
//            numAstro: r.numAstro
//            //visible: r.numAstro===0
//            visible: r.selected
//        }


    }

//    Comps.XCircleSignal{
//        id: xCircleSignal
//        width: app.fs*16
//        height: width
//        anchors.centerIn: bodie
//        visible: app.dev && r.selected && !r.isZoomAndPosSeted && JSON.parse(zm.currentData).params.t!=='pron'
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
        id: tOpacity
        running: r.opacity!==1.0
        repeat: true
        interval: 1000
        onTriggered: {
            anOp.enabled=true
            r.opacity=1.0
        }
    }

    Timer{
        running: r.vr<zm.aBodies.length
        repeat: true
        interval: 100
        onTriggered: {
            if(numAstro>=1){
                revPos()
            }
        }
        onRunningChanged: {
            if(!running && numAstro===zm.aBodies.length-1){
                zm.resizeAspsCircle(r.isBack)
                zm.hideTapa()
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
        if(!r.isPron && !zm.pointerRotToCenter){
            let json=JSON.parse(zm.fileData)
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
        let itemName=app.stringRes+'zoompos'
        if(r.isBack){
            itemName+='Back'
        }
        let json=zfdm.getJson()
        if(!json[itemName]){
            json[itemName]={}
        }
        json[itemName]['zpc'+r.numAstro]=zm.getZoomAndPos()
        if(app.dev){
            log.lv('xAs'+r.numAstro+': saveZoomAndPos()'+JSON.stringify(json, null, 2))
            log.lv('json['+itemName+'][zpc'+r.numAstro+']=sweg.getZoomAndPos()'+JSON.stringify(json[itemName+'']['zpc'+r.numAstro], null, 2))
        }
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }
    function setZoomAndPos(){
        let itemName=app.stringRes+'zoompos'
        if(r.isBack){
            itemName+='Back'
        }
        //let json=JSON.parse(zm.fileData)
        let json=zfdm.getJsonAbs()
        if(json[itemName]&&json[itemName]['zpc'+r.numAstro]){
            zm.setZoomAndPos(json[itemName]['zpc'+r.numAstro])
            r.isZoomAndPosSeted=true
        }else{
            r.isZoomAndPosSeted=false
        }
    }
    function h(){
        anOp.enabled=false
        r.opacity=0.0
        tOpacity.restart()
    }
}
