import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../../comps" as Comps

Item{
    id: r
    width: apps.xAsShowIcon?
               /*Mostrando Imagen*/
               (parent.width-(r.fs*objData.p)-sweg.objSignsCircle.w-(!apps.showNumberLines?0:r.fs*2)-widthRestDec):
               /*Mostrando Símbolo de Planeta*/
               (parent.width-(r.fs*objData.p)-sweg.objSignsCircle.w-(!apps.showNumberLines?0:r.fs*2)-widthRestDec)
    height: 1
    anchors.centerIn: parent
    z: !selected?numAstro:15
    property int widthRestDec:apps.showDec?sweg.objSignsCircle.w*2:0
    property bool selected: numAstro === app.currentPlanetIndex//panelDataBodies.currentIndex
    property string astro
    property int is
    property int fs
    property var objData: ({g:0, m:0,ih:0,rsgdeg:0,rsg:0, retro:0})
    property int pos: 1
    property int g: -1
    property int m: -1
    property int numAstro: 0

    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12]

    property color colorCuerpo: '#ff3300'

    property int uRot: 0

    property bool isZoomAndPosSeted: false

    state: sweg.state
    states: [
        State {
            name: sweg.aStates[0]
            PropertyChanges {
                target: r
                colorCuerpo: '#ffffff'
            }
//            PropertyChanges {
//                target: xIcon
//                width: r.fs*0.85
//            }
        },
        State {
            name: sweg.aStates[1]
            PropertyChanges {
                target: r
                colorCuerpo: '#000000'
            }
//            PropertyChanges {
//                target: xIcon
//                width: r.fs*0.5
//            }
        },
        State {
            name: sweg.aStates[2]
            PropertyChanges {
                target: r
                colorCuerpo: '#ffffff'
            }
//            PropertyChanges {
//                target: xIcon
//                width: r.fs*0.5
//            }
        }
    ]
    onSelectedChanged: {
        if(selected)app.uSon=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
        if(selected){
            pointerPlanet.setPointerFs()
            housesCircle.currentHouse=objData.ih
            app.currentXAs=r
            setRot()
            setZoomAndPos()
            app.showPointerXAs=true
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
    Rectangle{
        id: xIcon
        //width: !selected?r.fs*0.85:r.fs*1.4
        width: !apps.xAsShowIcon||r.aIcons.indexOf(r.numAstro)<0?(!app.ev?r.fs*0.85:r.fs*0.425):(!app.ev?r.fs*2:r.fs)
        height: width
        anchors.left: parent.left
        //anchors.leftMargin: !r.selected?0:width*0.5
        //anchors.horizontalCenterOffset: apps.xAsShowIcon?0-sweg.fs*0.5:0
        anchors.verticalCenter: parent.verticalCenter
        color: !apps.xAsShowIcon?(r.selected?apps.backgroundColor:'transparent'):'transparent'
        radius: width*0.5
        PointerPlanet{
            id: pointerPlanet
            is:r.is
            gdeg: objData.g
            mdeg: objData.m
            rsgdeg:objData.rsg
            ih:objData.ih
            expand: r.selected
            iconoSignRot: img.rotation
            p: r.numAstro
            opacity: r.selected&&app.showPointerXAs?1.0:0.0 && JSON.parse(app.currentData).params.tipo!=='pron'
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
                            pointerPlanet.pointerRot+=5
                    }else{
                            pointerPlanet.pointerRot-=5
                    }
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
                vClick=0
                r.parent.cAs=r
            }
            onExited: {
                vClick=0
                //r.parent.cAs=r.parent
            }
            onClicked: {
                //apps.sweFs=app.fs
                if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                    app.uSonFCMB=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
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
                        r.parent.pressed(r)
                    }else{
                        r.parent.doublePressed(r)
                    }
                }
            }
        }
        Image {
            id: img
            source: app.planetasRes[r.numAstro]?"../../resources/imgs/planetas/"+app.planetasRes[r.numAstro]+(apps.xAsShowIcon&&r.aIcons.indexOf(r.numAstro)>=0?"_i.png":".svg"):""
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
    Image {
        id: imgEarth
        source: "../../resources/imgs/planetas/earth.png"
        width: sweg.width*0.05
        height: width
        rotation: -45
        antialiasing: true
        anchors.centerIn: parent
        visible: r.numAstro===0&&apps.xAsShowIcon
    }
    Rectangle{
        width: r.width*0.5-xIcon.width
        height: app.fs*0.25
        color: 'transparent'
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        visible: apps.xAsShowIcon
        anchors.leftMargin: xIcon.width*0.5
        Comps.XSignal{
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            height: app.fs*6
            numAstro: r.numAstro
            //visible: r.numAstro===0
            visible: r.selected
        }
    }
    Comps.XCircleSignal{
        id: xCircleSignal
        width: app.fs*16
        height: width
        anchors.centerIn: xIcon
        visible: r.selected && !r.isZoomAndPosSeted && JSON.parse(app.currentData).params.tipo!=='pron'
    }
    Timer{
        running: !r.isZoomAndPosSeted && r.selected
        repeat: true
        interval: 1000
        onTriggered: setZoomAndPos()
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
        let json=JSON.parse(app.fileData)
        if(!json.rots){
            json.rots={}
        }
        json.rots['rc'+r.numAstro]=rot
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        let njson=JSON.stringify(json)
        app.fileData=njson
        app.currentData=app.fileData
        unik.setFile(apps.url.replace('file://', ''), JSON.stringify(json))
    }

    //Rot
    function setRot(){
        let json=JSON.parse(app.fileData)
        if(json.rots&&json.rots['rc'+r.numAstro]){
            r.uRot=json.rots['rc'+r.numAstro]
            pointerPlanet.pointerRot=r.uRot
        }
    }
    function restoreRot(){
        pointerPlanet.pointerRot=r.uRot
    }

    //Zoom And Pos
    function saveZoomAndPos(){
        let json=JSON.parse(app.fileData)
        if(!json[app.stringRes+'zoompos']){
            json[app.stringRes+'zoompos']={}
        }
        json[app.stringRes+'zoompos']['zpc'+r.numAstro]=sweg.getZoomAndPos()
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        let njson=JSON.stringify(json)
        app.fileData=njson
        app.currentData=app.fileData
        unik.setFile(apps.url.replace('file://', ''), JSON.stringify(json))
    }
    function setZoomAndPos(){
        let json=JSON.parse(app.fileData)
        if(json[app.stringRes+'zoompos']&&json[app.stringRes+'zoompos']['zpc'+r.numAstro]){
            sweg.setZoomAndPos(json[app.stringRes+'zoompos']['zpc'+r.numAstro])
            r.isZoomAndPosSeted=true
        }else{
            r.isZoomAndPosSeted=false
        }
    }
}
