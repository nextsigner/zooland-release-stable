import QtQuick 2.7
import QtQuick.Controls 2.12
import "../../js/Funcs.js" as JS


import ZoolMap.ZoolMapSignCircle 1.1
import ZoolMap.ZoolMapHousesCircle 1.0
import ZoolMap.ZoolMapPlanetsCircle 1.1
import ZoolMap.ZoolMapAspsCircle 1.0
import ZoolMap.ZoolMapAspsView 1.0
import ZoolMap.ZoolMapAspsViewBack 1.0
import ZoolMap.ZoolMapAsInfoView 1.0
import ZoolElementsView 1.0

import ZoolMap.ZoolMapNakshatraView 1.0


Item{
    id: r
    height: parent.height-app.fs*0.25
    width: height
    anchors.centerIn: parent
    anchors.horizontalCenterOffset: 0-r.width*0.5
    anchors.verticalCenterOffset: 0-r.width*0.5

    property alias objTapa: tapa
    property alias objSignsCircle: signCircle
    property alias objHousesCircle: housesCircle
    property alias objHousesCircleBack: housesCircleBack
    property alias objPlanetsCircle: planetsCircle
    property alias objPlanetsCircleBack: planetsCircleBack
    property alias objAspsCircle: aspsCircle
    property alias objZoolAspectsView: panelAspects
    property alias objZoolAspectsViewBack: panelAspectsBack
    property alias objAsInfoView: zoolMapAsInfoView
    property alias zev: zoolElementsView


    property bool showZonas: true

    property bool isDataDiff: false
    property bool ev: false
    property int zodiacBandWidth: !r.ev?app.fs:app.fs*0.75
    property int housesNumWidth: !r.ev?app.fs:app.fs*0.75
    property int housesNumMargin: app.fs*0.25
    property int fs: app.fs
    property var aSigns: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property var aSignsLowerStyle: ['aries', 'tauro', 'geminis', 'cancer', 'leo', 'virgo', 'libra', 'escorpio', 'sagitario', 'capricornio', 'acuario', 'piscis']
    property var aBodies: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    property var aBodiesFiles: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property int planetSize: !r.ev?app.fs*1.5:app.fs
    property int planetsPadding: app.fs*8
    property int planetsMargin: app.fs*0.15
    property int aspsCircleWidth: 100
    property int planetsBackBandWidth: 100

    property int planetsAreaWidth: 100
    property int planetsAreaWidthBack: 100
    property string folderImg: unik.getPath(5)+'/modules/ZoolBodies/ZoolAs/imgs_v1'

    property color backgroundColor: enableBackgroundColor?apps.backgroundColor:'transparent'
    property bool enableBackgroundColor: apps.enableBackgroundColor
    property int currentPlanetIndex: -1
    property int currentPlanetIndexBack: -1

    property int currentHouseIndex: -1
    property int currentHouseIndexBack: -1

    property int currentSignIndex: 0

    property int uAscDegreeTotal: -1
    property int uAscDegree: -1
    property int uMcDegree: -1

    property string fileData: ''
    property string fileDataBack: ''
    property string currentData: ''
    property string currentDataBack: ''
    property var currentJson
    property var currentJsonBack

    property date currentDate
    property date currentDateBack
    property string currentNom: ''
    property string currentNomBack: ''
    property string currentFecha: ''
    property string currentFechaBack: ''
    property string currentLugar: ''
    property string currentLugarBack: ''
    property int currentAbsolutoGradoSolar: -1
    property int currentAbsolutoGradoSolarBack: -1
    property int currentGradoSolar: -1
    property int currentGradoSolarBack: -1
    property int currentRotationxAsSol: -1
    property int currentRotationxAsSolBack: -1
    property int currentMinutoSolar: -1
    property int currentMinutoSolarBack: -1
    property int currentSegundoSolar: -1
    property int currentSegundoSolarBack: -1
    property real currentGmt: 0
    property real currentGmtBack: 0
    property real currentLon
    property real currentLonBack
    property real currentLat
    property real currentLatBack
    property real currentAlt: 0
    property real currentAltBack: 0

    property int currentIndexSign: -1
    property int currentIndexSignBack: -1
    property string currentNakshatra: ''
    property string currentNakshatraBack: ''
    property string currentHsys: apps.currentHsys

    property string uSon: ''
    property string uSonFCMB: ''
    property string uSonBack: ''

    property string uCuerpoAsp: ''

    property bool enableAnZoomAndPos: true
    property bool capturing: false

    property var listCotasShowing: []
    property var listCotasShowingBack: []

    property bool enableLoad: true
    property bool enableLoadBack: true

    property real dirPrimRot: 0.00

    property int ejeTipoCurrentIndex: -2
    property bool automatic: false
    property bool safeTapa: false
    property bool pointerRotToCenter: false

    //-->ZoomAndPan
    property bool zoomAndPosCentered: pinchArea.m_x1===0 && pinchArea.m_y1===0 && pinchArea.m_y2===0 && pinchArea.m_x2===0 && pinchArea.m_zoom1===0.5 && pinchArea.m_zoom2===0.5 && pinchArea.m_max===6 && pinchArea.m_min===0.5
    property real xs: scaler.xScale
    property real z1: pinchArea.m_zoom1
    property var uZp
    //<--ZoomAndPan

    //-->Theme
    property color bodieColor: apps.fontColor
    property color bodieColorBack: apps.fontColor
    property color bodieBgColor: 'transparent'
    property color bodieBgColorBack: 'transparent'
    property int bodieBgBorderWidth: 0
    property int bodieBgBorderWidthBack: 0
    property color bodieBgBorderColor: "white"
    property color bodieBgBorderColorBack: "white"
    property color houseLineColor: 'white'
    property color houseLineColorBack: '#00ff00'
    property bool showSignsCircleColors: true
    property color iconSignColor: "white"
    property color borderSignColor: "white"
    property int borderSignCircleWidth: 2
    //<--Theme

    property var aTexts: []
    property alias rectXBackItems: xBackItems
    onVisibleChanged: {
        if(visible){
            centerZoomAndPos()
            //return
            let filePath='/home/ns/gd/Zool/Natalia_S._Pintos.json'
            loadFromFile(filePath, 'sin', true)
        }
    }
    onAutomaticChanged: {
        if(automatic){
            tAutoMaticPlanets.currentJsonData=zm.currentData
        }else{
            centerZoomAndPos()
        }
    }
    onCurrentPlanetIndexChanged: {
        zoolDataBodies.currentIndex=currentPlanetIndex
        if(currentPlanetIndex>=0){
            zm.currentPlanetIndexBack=-1
            zm.currentHouseIndexBack=-1
        }
        if(sspEnabled){
            if(currentPlanetIndex>=-1&&currentPlanetIndex<10){
                app.ip.opacity=1.0
                app.ip.children[0].ssp.setPlanet(currentPlanetIndex)
            }else{
                app.ip.opacity=0.0
            }
        }
        //zoolDataBodies.currentIndex=currentPlanetIndex
        if(currentPlanetIndex>14){
            /*if(currentPlanetIndex===20){
                sweg.objHousesCircle.currentHouse=1
                swegz.sweg.objHousesCircle.currentHouse=1
            }
            if(currentPlanetIndex===16){
                sweg.objHousesCircle.currentHouse=10
                swegz.sweg.objHousesCircle.currentHouse=10
            }*/
        }
    }
    onCurrentPlanetIndexBackChanged: {
        zoolDataBodies.currentIndexBack=currentPlanetIndexBack
        /*if(currentPlanetIndexBack>=0){
            zm.currentPlanetIndex=-1
            zm.currentHouseIndex=-1
        }*/
    }
    onCurrentGmtChanged: {
        if(zm.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmt
        tReload.restart()
    }
    /*onCurrentGmtBackChanged: {
        //if(app.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmtBack
        tReloadBack.restart()
    }*/
    onCurrentDateChanged: {
        controlsTime.setTime(currentDate)
        //if(app.currentData===''||app.setFromFile)return
        //xDataBar.state='show'
        let a=currentDate.getFullYear()
        let m=currentDate.getMonth()
        let d=currentDate.getDate()
        let h=currentDate.getHours()
        let min=currentDate.getMinutes()
        //xDataBar.currentDateText=d+'/'+parseInt(m + 1)+'/'+a+' '+h+':'+min
        //xDataBar.currentGmtText=''+currentGmt
        tReload.restart()
    }
//    onCurrentDateBackChanged: {
//        controlsTimeBack.setTime(currentDateBack)
//        if(app.t==='trans'){
//            JS.loadTransFromTime(app.currentDateBack)
//        }
//        //xDataBar.state='show'
//        let a=currentDateBack.getFullYear()
//        let m=currentDateBack.getMonth()
//        let d=currentDateBack.getDate()
//        let h=currentDateBack.getHours()
//        let min=currentDateBack.getMinutes()
//        tReloadBack.restart()
//    }
    onDirPrimRotChanged: {
        if(app.t==='dirprim'){
            planetsCircleBack.rotation=planetsCircle.rotation-dirPrimRot
            housesCircleBack.rotation=360-dirPrimRot
        }
    }
    onEnableAnZoomAndPosChanged: {
        tEnableAnZoomAndPos.restart()
    }
    Behavior on opacity{NumberAnimation{duration: 1500}}
//    Rectangle{
//        anchors.fill: parent
//        color: 'yellow'
//    }
    Item{id:xuqp}
    Item{
        id: xBackItems
        width: 100
        height: 100
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: r.width*0.5
        anchors.verticalCenterOffset: r.height*0.5
        ZoolMapAspsView{
            id: panelAspects
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: xLatIzq.visible?0:0-xLatIzq.width
            parent: xMed
            //visible: false
            //visible: r.objectName==='sweg'
        }
        ZoolMapAspsViewBack{
            id: panelAspectsBack
            anchors.top: parent.top
            //anchors.topMargin: 0-(r.parent.height-r.height)/2
            parent: xMed
            anchors.left: parent.left
            anchors.leftMargin: xLatIzq.visible?width:width-xLatIzq.width
            transform: Scale{ xScale: -1 }
            rotation: 180
            visible: planetsCircleBack.visible
        }
    }
    Flickable{
        id: flick
        anchors.fill: parent
        Rectangle {
            id: rect
            border.width: 0
            width: Math.max(xSweg.width, flick.width)*2
            height: Math.max(xSweg.height, flick.height)*2
            border.color: '#ff8833'
            color: 'transparent'
            antialiasing: true
            //x:(parent.width-width)/2
            transform: Scale {
                id: scaler
                origin.x: pinchArea.m_x2
                origin.y: pinchArea.m_y2
                xScale: pinchArea.m_zoom2
                yScale: pinchArea.m_zoom2
                Behavior on origin.x{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
                Behavior on origin.y{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
                Behavior on xScale{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
                Behavior on yScale{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            }
            Behavior on x{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            Behavior on y{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            Timer{
                id: tReload
                running: false
                repeat: false
                interval: 100
                onTriggered: {
                    //app.j.setNewTimeJsonFileData(zm.currentDate)
                    //app.j.runJsonTemp()
                    let j=getCurrentParamsWithNewTime(zm.currentDate)
                    //log.lv('NJ:'+JSON.stringify(j, null, 2))
                    r.safeTapa=true
                    r.load(j)
                }
            }
            Timer{
                id: tReloadBack
                running: false
                repeat: false
                interval: 100
                onTriggered: {
                    app.j.setNewTimeJsonFileDataBack(zm.currentDateBack)
                    app.j.runJsonTempBack()
                }
            }
            Timer{
                id: tUpdateGUI
                running: true
                repeat: true
                interval: 1000
                onTriggered: {
                    revIsDataDiff()
                    housesCircle.wbgc=planetsCircle.getMinAsWidth()*0.5//-r.planetSize*2
                    housesCircleBack.wbgc=signCircle.width//ai.width
                    //zm.objPlanetsCircle.vw=zm.objAspsCircle.width
                    if(app.t==='dirprim')housesCircleBack.width=ae.width
                    //log.lv('R:'+JSON.stringify(currentJson.pc.c0.gdec, null, 2))
                    //imgEarth.rotation=360-signCircle.rotation//currentJson.pc.c0.gdec--45
                }
            }
            PinchArea {
                id: pinchArea
                anchors.fill: parent

                property real m_x1: 0
                property real m_y1: 0
                property real m_y2: 0
                property real m_x2: 0
                property real m_zoom1: 1.0
                property real m_zoom2: 1.0
                property real m_max: 6
                property real m_min: 1.0

                onPinchStarted: {
                    console.log("Pinch Started")
                    m_x1 = scaler.origin.x
                    m_y1 = scaler.origin.y
                    m_x2 = pinch.startCenter.x
                    m_y2 = pinch.startCenter.y
                    rect.x = rect.x + (pinchArea.m_x1-pinchArea.m_x2)*(1-pinchArea.m_zoom1)
                    rect.y = rect.y + (pinchArea.m_y1-pinchArea.m_y2)*(1-pinchArea.m_zoom1)
                }
                onPinchUpdated: {
                    console.log("Pinch Updated")
                    m_zoom1 = scaler.xScale
                    var dz = pinch.scale-pinch.previousScale
                    var newZoom = m_zoom1+dz
                    if (newZoom <= m_max && newZoom >= m_min) {
                        m_zoom2 = newZoom
                    }
                }
                Timer{
                    id: tEnableAnZoomAndPos
                    running: false
                    repeat: false
                    interval: 1500
                    onTriggered: r.enableAnZoomAndPos=true
                }
                Rectangle{
                    width: parent.width*3
                    height: width
                    color: 'transparent'
                    anchors.centerIn: parent
//                    MouseArea{
//                        anchors.fill: parent
//                        onClicked: {

//                        }
//                        onDoubleClicked: centerZoomAndPos()
//                        Rectangle{
//                            anchors.fill: parent
//                            color: '#FF8833'
//                            visible: false
//                        }
//                    }
                }
                MouseArea {
                    //z:parent.z-1
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: rect
                    drag.filterChildren: true
                    onWheel: {
                        r.enableAnZoomAndPos=false
                        pinchArea.m_x1 = scaler.origin.x
                        pinchArea.m_y1 = scaler.origin.y
                        pinchArea.m_zoom1 = scaler.xScale
                        pinchArea.m_x2 = mouseX
                        pinchArea.m_y2 = mouseY

                        var newZoom
                        if (wheel.angleDelta.y > 0) {
                            newZoom = pinchArea.m_zoom1+0.1
                            if (newZoom <= pinchArea.m_max) {
                                pinchArea.m_zoom2 = newZoom
                            } else {
                                pinchArea.m_zoom2 = pinchArea.m_max
                            }
                        } else {
                            newZoom = pinchArea.m_zoom1-0.1
                            if (newZoom >= pinchArea.m_min) {
                                pinchArea.m_zoom2 = newZoom
                            } else {
                                pinchArea.m_zoom2 = pinchArea.m_min
                            }
                        }
                        rect.x = rect.x + (pinchArea.m_x1-pinchArea.m_x2)*(1-pinchArea.m_zoom1)
                        rect.y = rect.y + (pinchArea.m_y1-pinchArea.m_y2)*(1-pinchArea.m_zoom1)
                        //console.debug(rect.width+" -- "+rect.height+"--"+rect.scale)
                    }
                    Rectangle{
                        anchors.fill: parent
                        color: '#FF8833'
                        visible: false
                    }
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        //z: parent.z-1
                        onClicked: {
                            //log.lv('Ser pos:'+mouseX+' '+mouseY)
                            //zm.setPos(mouseX, mouseY, 0)
                            apps.zFocus='xMed'
                            if (mouse.button === Qt.RightButton) {

                                menuRuedaZodiacal.uX=mouseX
                                menuRuedaZodiacal.uY=mouseY
                                menuRuedaZodiacal.isBack=false
                                menuRuedaZodiacal.popup()
                            }
                        }
                        onDoubleClicked: {
                            centerZoomAndPos()
                        }
                    }

                }
            }
            Item{
                id: xSweg
                width: r.width//*0.25
                height: width
                anchors.centerIn: parent
                //anchors.horizontalCenterOffset: xSweg.width*0.5
                Rectangle{
                    id: bg
                    width: parent.width*10
                    height: width
                    color: backgroundColor
                    //visible: signCircle.v
                }
                //BackgroundImages{id: backgroundImages}
                ZoolMapAspsCircle{id: aspsCircle;width:ca.width; rotation: signCircle.rot - 90}
                Rectangle{
                    id: xz
                    anchors.fill: parent
                    color: 'transparent'
                    visible: false
                    Circle{
                        id: cc
                        d: zm.objAspsCircle.width
                        c: '#FF8833' //Esto se vera únicamente si el item de id:xz es visible.
                    }
                    Circle{
                        id:ae
                        d: r.ev?r.width:0
                        c: 'transparent'
                        property int w: 100
                    }
                    Circle{
                        id: ai
                        d: !r.ev?r.width:ae.width-ae.w*2
                        c: 'transparent'
                        //opacity: 0.5
                        property int w: 10
                        Circle{
                            id:bgAi
                            anchors.fill: parent
                            color: r.bodieBgColor
                        }
                        Circle{
                            id: ca
                            d: signCircle.width-(signCircle.w*2)-parent.w
                            color: 'transparent'//apps.backgroundColor
                        }
                    }
                }

                //ZoolMapHousesCircle{id: housesCircle; width: ai.width; z:ai.z+1}
                ZoolMapHousesCircle{id: housesCircleBack; width: ai.width; isBack: true}
                ZoolMapSignCircle{id: signCircle; width: ai.width-r.housesNumWidth*2-r.housesNumMargin*2;}
                Rectangle{
                    id:bgPCB
                    width: planetsCircleBack.width
                    height: width
                    color: 'transparent'//r.bodieBgColorBack
                    radius: width*0.5
                    anchors.centerIn: parent
                    ZoolMapPlanetsCircle{id: planetsCircleBack; width: ae.width-r.housesNumWidth*2-r.housesNumMargin*2; z:ai.z+5; isBack: true; visible: r.ev}
                }
                Rectangle{
                    id:bgPC
                    width: signCircle.width
                    height: width
                    color: 'transparent'//r.bodieBgColor
                    radius: width*0.5
                    anchors.centerIn: parent
                    ZoolMapHousesCircle{id: housesCircle; width: ai.width; wbgc: ca.d}
                    ZoolMapPlanetsCircle{id: planetsCircle; width: signCircle.width-signCircle.w*2; z: ai.z+4;}
                }

                //NumberLines{visible:true}
                ZoolMapNakshatraView{id: nakshatraView; width: ca.width; z: aspsCircle.z+1}
                Rectangle{
                    id: capaFront
                    width: parent.width
                    height: width
                    color: 'transparent'
                    border.width: 10
                    border.color: 'red'
                    visible: false
                    Rectangle{
                        id: ejeAbstractBodie
                        width: parent.width
                        height: 1
                        anchors.centerIn: parent
                        rotation: -30
                        Rectangle{
                            width: r.planetSize
                            height: width
                            radius: width*0.5
                            color: 'blue'
                            anchors.verticalCenter: parent.verticalCenter
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    //var globalCoordinates = parent.mapToGlobal(parent.x-parent.width*0.5, parent.y-parent.height*0.5)
                                    //var mouseP = Qt.point();
                                    //var mapped =
                                    var globalCoordinates = parent.mapToItem(capaFront, parent.x, parent.y);
                                        let s="X: " + globalCoordinates.x + " y: " + globalCoordinates.y
                                    let nx= globalCoordinates.x+25
                                    let ny= globalCoordinates.y-25
                                    s+='\nnx:'+nx+'\nny:'+ny
                                    zm.objAsInfoView.text=s
                                    zm.setPos(nx, ny, ejeAbstractBodie.rotation)
                                }
                            }
                        }
                    }
                }
                /*
                EclipseCircle{
                    id: eclipseCircle
                    width: housesCircle.width
                    height: width
                }
                Rectangle{
                    width: 3
                    height: r.height*2
                    color: apps.fontColor
                    anchors.centerIn: parent
                    visible: app.showCenterLine
                }
                Rectangle{
                    width: r.height*2
                    height: 3
                    color: apps.fontColor
                    anchors.centerIn: parent
                    visible: app.showCenterLine
                }
                ZoolAutoPanZoom{id:zoolAutoPanZoom}
                */
            }
        }
    }
    Item{
        id: xFrontItems
        anchors.fill: xBackItems
        Rectangle{
            anchors.fill: parent
            color: 'black'
            visible: zev.zoom===5.0
        }
        ZoolElementsView{id: zoolElementsView}
    }
    ZoolMapAsInfoView{
        id: zoolMapAsInfoView
        width: xLatDer.width
        anchors.bottom: parent.bottom
        parent: xLatDer
    }
    Rectangle{
        width: txtMod.contentWidth+app.fs
        height: txtMod.contentHeight+app.fs
        color: apps.fontColor
        anchors.centerIn: parent
        anchors.verticalCenterOffset: app.fs*3
        visible: app.dev
        Text{
            id: txtMod
            text: app.t+r.ejeTipoCurrentIndex
            font.pixelSize: app.fs
            color: apps.backgroundColor
            anchors.centerIn: parent
        }
    }

    Rectangle{
        id: tapa
        width: r.width*4
        height: width
        color: apps.backgroundColor
        anchors.centerIn: parent
        visible: false
        onOpacityChanged:{
            if(opacity===0.0){
                visible=false
                opacity=1.0
            }
        }
        Behavior on opacity{NumberAnimation{duration: 1000}}
    }
    Timer{
        id: tAutoMaticPlanets
        running: r.automatic
        repeat: true
        interval: 10000
        property string currentJsonData: ''
        onTriggered: {
//            if(tAutoMaticPlanets.currentJsonData!==zm.currentData){
//                //tAutoMaticPlanets.stop()
//                //return
//            }
            if(zm.currentPlanetIndex<21){
                zm.currentPlanetIndex++
            }else{
                zm.currentPlanetIndex=-1
                zm.currentHouseIndex=-1
            }
        }
    }
    Component.onCompleted: {
        if(!apps)return
        setTheme(apps.apps.zmCurrenThemeIndex)
    }

    function setTheme(i){
        //Set ZoolMap Theme
        let jd=unik.getFile('./modules/ZoolMap/themes.json')
        let t=JSON.parse(jd).themes[i]
        //log.lv('Themes: '+JSON.stringify(j.themes[0], null, 2))
        r.bodieColor=t.bodieColor
        r.bodieColorBack=t.bodieColorBack
        r.bodieBgColor=t.bodieBgColor
        r.bodieBgColorBack=t.bodieBgColorBack
        r.bodieBgBorderWidth=t.bodieBgBorderWidth
        r.bodieBgBorderWidthBack=t.bodieBgBorderWidthBack
        r.bodieBgBorderColor=t.bodieBgBorderColor
        r.bodieBgBorderColorBack=t.bodieBgBorderColorBack
        r.houseLineColor=t.houseLineColor
        r.houseLineColorBack=t.houseLineColorBack
        r.showSignsCircleColors=t.showSignsCircleColors
        r.iconSignColor=t.iconSignColor
        r.borderSignColor=t.borderSignColor
        r.borderSignCircleWidth=t.borderSignCircleWidth
        //log.lv('Themes r.bodieColor: '+r.bodieColor)
    }

    //-->Load Data
    function load(j){
        //console.log('Ejecutando SweGraphic.load()...')
        r.dirPrimRot=0

        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let vd=j.params.d
        let vm=j.params.m
        let va=j.params.a
        let vh=j.params.h
        let vmin=j.params.min
        let vgmt=j.params.gmt
        let vlon=j.params.lon
        let vlat=j.params.lat
        let valt=0.0
        if(j.params.alt){
            valt=j.params.alt
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=j.params.hsys?j.params.hsys:apps.currentHsys
        if(j.params.hsys)hsys=j.params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        if(!r.enableLoad)return\n'
        c+='        let json=(\'\'+logData)\n'
        c+='        //log.lv(\'JSON: \'+json)\n'
        c+='        loadSweJson(json)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        console.log(\'zm.load() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' '+unik.currentFolderPath()+' '+valt+'\')\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'" '+valt+'\')\n'
        //c+='        Qt.quit()\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
        app.t=j.params.t
        r.fileData=JSON.stringify(j)
    }
    function loadBack(j){
        //console.log('Ejecutando SweGraphic.load()...')
        r.dirPrimRot=0
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let params
        params=j.params

        let vd=params.d
        let vm=params.m
        let va=params.a
        let vh=params.h
        let vmin=params.min
        let vgmt=params.gmt
        let vlon=params.lon
        let vlat=params.lat
        let valt=0.0
        if(params.alt){
            valt=params.alt
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=apps.currentHsys
        r.currentFechaBack=vd+'/'+vm+'/'+va
        if(params.hsys)hsys=params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        //c+='        if(!r.enableLoadBack)return\n'
        c+='        let json=(\'\'+logData)\n'
        //c+='        log.lv(\'JSON Back: \'+json)\n'
        //c+='        console.log(\'JSON Back: \'+json)\n'
        c+='        loadSweJsonBack(json)\n'
        c+='        r.ev=true\n'
        c+='        app.objZoolFileExtDataManager.updateList()\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\'zm.loadBack() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'" '+valt+'\'\n'
        c+='    if(apps.showLog){\n'
        c+='        log.ls(cmd, 0, xApp.width)\n'
        c+='    }\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'" '+valt+'\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
        if(j.params.t){
            app.t=j.params.t
        }else{
            app.t=j.params.t
        }
        r.fileDataBack=JSON.stringify(j)
    }
    function loadBackFromArgs(nom, vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, vCiudad, edad, tipo, hsys, ms, vAtRigth) {
        zm.ev=false
        let d=new Date(Date.now())
        let numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh),
                            parseInt(vmin))
        let stringEdad=(''+edad).indexOf('NaN')<0?edad:''

        let extId='id'
        extId+='_'+vd
        extId+='_'+vm
        extId+='_'+va
        extId+='_'+vh
        extId+='_'+vmin
        extId+='_'+vgmt
        extId+='_'+vlat
        extId+='_'+vlon
        extId+='_'+valt
        extId+='_'+tipo
        extId+='_'+hsys

        let js='{"params":{"t":"'+tipo+'","ms":'+ms+',"n":"'+nom+'","d":'+vd+',"m":'+vm+',"a":'+va+',"h":'+vh+',"min":'+vmin+',"gmt":'+vgmt+',"lat":'+vlat+',"lon":'+vlon+',"alt":'+valt+',"c":"'+vCiudad+'", "hsys":"'+hsys+'", "extId":"'+extId+'"}}'
        //if(true)log.lv('Json loadBackFromArg(): '+JSON.stringify(JSON.parse(js)))
        //if(app.dev)log.lv('Json fallado: loadBack( '+nom+',  '+vd+',  '+vm+',  '+va+',  '+vh+',  '+vmin+',  '+vgmt+',  '+vlat+',  '+vlon+',  '+valt+',  '+vCiudad+',  '+edad+',  '+tipo+',  '+hsys+',  '+ms+',  '+vAtRigth+')')

        //if(app.dev)log.lv('Json fallado: loadBack(...) json: '+js)

        let json=JSON.parse(js)

        let extIdExist=zfdm.isExtId(extId)
        if(app.dev && extIdExist)log.lv('ExtId ya existe. extIdExist='+extIdExist)
        let isExtIdInAExtsIds=app.aExtsIds.indexOf(extId)>=0?true:false
        if(app.dev && isExtIdInAExtsIds)log.lv('ExtId ya estan en aExtsIds. isExtIdInAExtsIds='+isExtIdInAExtsIds)
        if(!extIdExist && !isExtIdInAExtsIds){
            zfdm.addExtData(json)
            zm.loadBack(json)
        }else{
            if(app.dev)log.lv('ExtId ya existe.')
            let extJson={}
            extJson.params=zfdm.getExtData(extId)
            if(app.dev)log.lv('Cargando ExtData...\n'+JSON.stringify(extJson, null, 2))
            zm.loadBack(extJson)
        }
        let aL=zoolDataView.atLeft
        let aR=vAtRigth
        if(vAtRigth===[]){
            if(tipo==='sin'){
                aR.push('<b>'+nom+'</b>')
                aL.reverse()
            }
            if(tipo==='rs')aR.push(edad)
            aR.push(''+vd+'/'+vm+'/'+va)
            aR.push(''+vh+':'+vmin+'hs')
            aR.push('<b>GMT:</b> '+vgmt)
            aR.push('<b>Ubicación:</b> '+vCiudad)
            aR.push('<b>Lat:</b> '+parseFloat(vlat).toFixed(2))
            aR.push('<b>Lon:</b> '+parseFloat(vlon).toFixed(2))
            aR.push('<b>Alt:</b> '+valt)
        }
        let strSep=''
        if(tipo==='sin'){
            strSep='Sinastría'
        }
        if(tipo==='rs')strSep='Rev. Solar '+va
        if(tipo==='trans')strSep='Tránsitos'
        if(tipo==='dirprim')strSep='Dir. Primarias'
        zoolDataView.setDataView(strSep, aL, aR)
        zoolDataView.uExtIdLoaded=extId
        zm.ev=true
    }
    function loadSweJson(json){
        //console.log('JSON::: '+json)
        //log.visible=true
        //log.l(JSON.stringify(json))
        if(!r.safeTapa){
            tapa.visible=true
            tapa.opacity=1.0
        }
        var scorrJson=json.replace(/\n/g, '')
        //app.currentJson=JSON.parse(scorrJson)
        aspsCircle.clear()
        //zsm.getPanel('ZoolRevolutionList').clear()
        //panelRsList.clear()
        //planetsCircleBack.visible=false
        r.ev=false
        apps.urlBack=''
        //panelAspectsBack.visible=false
        r.currentPlanetIndex=-1
        r.currentPlanetIndexBack=-1
        r.currentHouseIndex=-1
        r.currentHouseIndexBack=-1
        r.currentPlanetIndex=-1
        r.currentHouseIndex=-1

        //console.log('json: '+json)
        var j
        //try {

        //log.l(scorrJson)
        //log.visible=true
        //log.width=xApp.width*0.4
        j=JSON.parse(scorrJson)

        //r.aTexts[] reset
        let nATexts=[]
        for(var i=0;i<Object.keys(j.pc).length;i++){
            nATexts.push('')
        }
        r.aTexts=nATexts

        r.currentJson=j
        //-->ZoolMap
        signCircle.rot=parseFloat(j.ph.h1.gdec).toFixed(2)
        housesCircle.loadHouses(j)
        planetsCircle.loadJson(j)
        aspsCircle.load(j)
        //ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        ai.width=r.width
        zoolDataBodies.loadJson(j)
        zoolElementsView.load(j, false)
        panelAspects.load(j)
        //log.lv('Nakshatra length:'+nakshatraView.aNakshatra.length)
        //log.lv('Nakshatra index:'+nakshatraView.getIndexNakshatra(j.pc.c1.gdec))
        //log.lv('Nakshatra:'+nakshatraView.getNakshatraName(nakshatraView.getIndexNakshatra(j.pc.c1.gdec)))
        r.currentNakshatra=nakshatraView.getNakshatraName(nakshatraView.getIndexNakshatra(j.pc.c1.gdec))

        //resizeAspsCircle()
        //zm.setPos(r.mapToGlobal(0, 0).x, r.mapToGlobal(0, 0).y, zm.objSignsCircle.rotation)
        zm.setPos(0, 0, 0)

        let o1=j.ph['h1']
        //r.isAsc=o1.is
        //r.gdegAsc=o1.rsgdeg
        //r.mdegAsc=o1.mdeg
        zm.uAscDegree=parseInt(o1.rsgdeg)
        o1=j.ph['h10']
        zm.uMcDegree=parseInt(o1.rsgdeg)
        //<--ZoolMap

        //ascMcCircle.loadJson(j)


        //dinHousesCircle.loadHouses(j)





        //eclipseCircle.arrayWg=housesCircle.arrayWg
        //eclipseCircle.isEclipse=-1
        //r.v=true
        /*let sabianos=zsm.getPanel('ZoolSabianos')
        sabianos.numSign=app.currentJson.ph.h1.is
        sabianos.numDegree=parseInt(app.currentJson.ph.h1.rsgdeg - 1)
        sabianos.loadData()
        if(apps.sabianosAutoShow){
            //panelSabianos.state='show'
            zsm.currentIndex=1
        }*/
    }
    function loadSweJsonBack(json){
        if(!app.t==='dirprim' || r.safeTapa){
            tapa.visible=true
            tapa.opacity=1.0
        }

        zm.currentJsonBack=JSON.parse(json)
        //log.lv('zm.currentJsonBack='+JSON.stringify(zm.currentJsonBack, null, 2))
        //        if(app.dev)
        //            log.lv('ZoolBodies.loadSweJsonBack(json): '+json)
        //            log.lv('ZoolBodies.loadSweJsonBack(json) app.currentJsonBack: '+app.currentJsonBack)
        let scorrJson=json.replace(/\n/g, '')
        //console.log('json: '+json)
        let j=JSON.parse(scorrJson)
        //signCircle.rot=parseInt(j.ph.h1.gdec)
        //planetsCircleBack.rotation=parseFloat(j.ph.h1.gdec).toFixed(2)
        /*if(r.objectName==='sweg'){
            panelAspectsBack.visible=true
        }
        panelAspectsBack.load(j)
        aspsCircle.add(j)
        if(app.t!=='rs'){
            //panelElementsBack.load(j)
            zoolElementsView.load(j, true)
            //panelElementsBack.visible=true
            //Qt.quit()
        }else{
            //panelElementsBack.visible=false
        }*/

        //-->ZoolMap
        housesCircleBack.loadHouses(j)
        planetsCircleBack.loadJson(j)

        housesCircleBack.width=ae.width
        //ai.width=planetsCircleBack.getMinAsWidth()-r.planetSize*2
        //signCircle.width=ai.width
        //planetsCircle.width=ai.width
        ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        zoolDataBodies.loadJsonBack(j)
        r.currentNakshatraBack=nakshatraView.getNakshatraName(nakshatraView.getIndexNakshatra(j.pc.c1.gdec))
        //resizeAspsCircle()
        //<--ZoolMap

        //dinHousesCircleBack.loadHouses(j)

        //if(app.t==='dirprim')housesCircleBack.rotation-=360-housesCircle.rotation
        //if(JSON.parse(app))

        //        if(app.t==='dirprim'){
        //            log.lv('is dirprim')
        //        }

        //panelDataBodiesV2.loadJson(j)

        //app.backIsSaved=isSaved
        //if(app.dev)log.lv('sweg.loadSweJsonBack() isSaved: '+isSaved)
        r.ev=true
        if(app.t!=='dirprim')centerZoomAndPos()
    }
    function loadFromFile(filePath, tipo, isBack){
        tapa.visible=true
        tapa.opacity=1.0
        let jsonFileData=unik.getFile(filePath)
        let j=JSON.parse(jsonFileData).params
        let t=tipo
        let hsys=j.hsys?j.hsys:apps.currentHsys
        let nom=j.n
        let d=j.d
        let m=j.m
        let a=j.a
        let h=j.h
        let min=j.min
        let gmt=j.gmt
        let lat=j.lat
        let lon=j.lon
        let alt=j.alt?j.alt:0
        let c=j.c
        let e='1000'
        let aR=[]
        app.t=tipo
        let ms
        if(!j.ms){
            let date=new Date(Date.now())
            ms=date.getTime()
        }
        let msmod
        if(!j.msmod){
            msmod=ms
        }else{
            msmod=j.msmod
        }

        let p=zm.getParamsFromArgs(nom, d, m, a, h, min, gmt, lat, lon, alt, c, 'dirprim', hsys, ms, msmod)
        if(!isBack){
            r.load(p)
        }else{
            r.loadBack(p)
        }

        //r.loadBackFromArgs(nom, d, m, a, h, min, gmt, lat, lon, alt, ciudad, e, t, hsys, -1, aR)
    }
    function loadNow(isExt){
        let d=new Date(Date.now())
        let currentUserHours=d.getHours()
        let diffHours=d.getUTCHours()
        let currentGmtUser=0
        if(currentUserHours>diffHours){
            currentGmtUser=parseFloat(currentUserHours-diffHours)
        }else{
            currentGmtUser=parseFloat(0-(diffHours+currentUserHours)).toFixed(1)
        }
        //log.ls('currentGmtUser: '+currentGmtUser, 0, xLatIzq.width)
        let dia=d.getDate()
        let mes=d.getMonth()+1
        let anio=d.getFullYear()
        let hora=d.getHours()
        let minutos=d.getMinutes()
        let nom="Tránsitos de "+dia+'/'+mes+'/'+anio+' '+hora+':'+minutos
        loadFromArgs(d.getDate(), parseInt(d.getMonth() +1),d.getFullYear(), d.getHours(), d.getMinutes(), currentGmtUser,0.0,0.0,6, nom, "United Kingdom", "vn", isExt)
    }
    function loadFromArgs(d, m, a, h, min, gmt, lat, lon, alt, nom, ciudad, tipo, isExt){
        let dataMs=new Date(Date.now())
        let j='{"params":{"t":"'+tipo+'","ms":'+dataMs.getTime()+',"n":"'+nom+'","d":'+d+',"m":'+m+',"a":'+a+',"h":'+h+',"min":'+min+',"gmt":'+gmt+',"lat":'+lat+',"lon":'+lon+',"alt":'+alt+',"c":"'+ciudad+'"}}'
        if(!isExt){
            load(JSON.parse(j))
        }else{
            loadBack(JSON.parse(j))
            //r.ev=true
        }
        zm.ev=isExt
    }
    function loadFromJson(j, isExt, save){
        if(save){
            let mf=zfdm.mkFileAndLoad(JSON.parse(j))
            return
        }
        if(!isExt){
            load(JSON.parse(j))
        }else{
            loadBack(JSON.parse(j))
        }
    }
    function getParamsFromArgs(n, d, m, a, h, min, gmt, lat, lon, alt, c, t, s, ms){
        let j={}
        j.params={}
        j.params.n=n
        j.params.d=d
        j.params.m=m
        j.params.a=a
        j.params.h=h
        j.params.min=min
        j.params.gmt=gmt
        j.params.lat=lat
        j.params.lon=lon
        j.params.alt=alt
        j.params.c=c
        j.params.t=t
        j.params.s=s
        j.params.ms=ms
        //log.lv('getParamsFromArgs() j.params.c: '+j.params.c)
        //log.lv('getParamsFromArgs(): '+JSON.stringify(j))
        return j
    }
    function getCurrentParamsWithNewTime(date){
        let jsonFromAbs=zfdm.getJsonAbs()
        let d=new Date(date)
        let j={}
        j.params={}
        j.params.n=jsonFromAbs.params.n
        j.params.d=d.getDate()
        j.params.m=d.getMonth() + 1
        j.params.a=d.getFullYear()
        j.params.h=d.getHours()
        j.params.min=d.getMinutes()
        j.params.gmt=jsonFromAbs.params.gmt
        j.params.lat=jsonFromAbs.params.lat
        j.params.lon=jsonFromAbs.params.lon
        j.params.alt=jsonFromAbs.params.alt
        j.params.c=jsonFromAbs.params.c
        j.params.t=jsonFromAbs.params.t
        j.params.s=jsonFromAbs.params.s
        return j
    }
    function getZiData(bodieIndex, signIndex, houseIndex){
            let b=zm.aBodiesFiles[bodieIndex]
            let s=zm.aSignsLowerStyle[signIndex]
            let h=parseInt(houseIndex)
            let c=''
            c+='import QtQuick 2.0\n'
            c+='import unik.UnikQProcess 1.0\n'
            c+='import QtQuick.Window 2.0\n'
            //c+='Item{\n'
            c+='UnikQProcess{\n'
            c+='    onLogDataChanged:{\n'
            //c+='        log.lv("D:"+logData)\n'
            c+='        let t=(""+(""+logData).split("</h1>")[0]).replace("<h1>", "")\n'
            c+='        zm.mkWindowDataView(t, logData, Screen.width*0.5-app.fs*10, Screen.height*0.5-xApp.height*0.25, app.fs*20, xApp.height*0.5, app, app.fs*0.75)\n'
            c+='        destroy()\n'
            c+='    }\n'
            c+='    Component.onCompleted:{\n'
            c+='        let b=("'+b+'").toLowerCase()\n'
            c+='        let s="'+s+'"\n'
            c+='        let h="casa_'+h+'"\n'
            c+='        let ss=b+"_en_"+s\n'
            c+='        if(app.dev)log.lv("Buscando datos de:"+b+" en "+s+" "+ss)\n'
            c+='        let cmd="/home/ns/nsp/zool-release/modules/ZoolMap/ZoolMapData/getData.sh /home/ns/nsp/zool-release/modules/ZoolMap/ZoolMapData/"+b+".json "+b+" "+s+" "+h+""\n'
            c+='        if(app.dev)log.lv("CMD:"+cmd)\n'
            c+='        console.log("CMD:"+cmd)\n'
            c+='        run(cmd)\n'
            c+='    }\n'
            c+='}\n'
            //c+='}\n'
            let obj=Qt.createQmlObject(c, xuqps, 'nioqmlcode')
    }
    function getZiDataNum(num, gen, show){
        let bashScriptPath=unik.getPath(5)+'/modules/ZoolMap/ZoolMapData/getDataNum.sh'
        let jsonFilePath=unik.getPath(5)+'/modules/ZoolMap/ZoolMapData/numerologia_segunda_persona_masc.json'
        if(gen==='fem')jsonFilePath=unik.getPath(5)+'/modules/ZoolMap/ZoolMapData/numerologia_segunda_persona_fem.json'
        let c=''
        c+='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='import QtQuick.Window 2.0\n'
        //c+='Item{\n'
        c+='UnikQProcess{\n'
        c+='    onLogDataChanged:{\n'
        //c+='        log.lv("D:"+logData)\n'
        c+='        let t=(""+(""+logData).split("</h1>")[0]).replace("<h1>", "")\n'
        if(show){
        c+='        zm.mkWindowDataView(t, logData, Screen.width*0.5-app.fs*10, Screen.height*0.5-xApp.height*0.25, app.fs*20, xApp.height*0.5, app, app.fs*0.75)\n'
        }else{
            c+='        zm.mkItemDataView(logData, 0, 0, xLatDer.width, xLatDer.height, xLatDer, app.fs*0.75)\n'
        }
        c+='        destroy()\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        if(app.dev)log.lv("Buscando datos de:'+num+'")\n'
        c+='        let cmd="'+bashScriptPath+' '+jsonFilePath+' '+num+'"\n'
        c+='        if(app.dev)log.lv("CMD:"+cmd)\n'
        c+='        console.log("CMD:"+cmd)\n'
        c+='        run(cmd)\n'
        c+='    }\n'
        c+='}\n'
        //c+='}\n'
        let obj=Qt.createQmlObject(c, xuqps, 'nioqmlcode')
        ///getDataNum.sh /home/ns/nsp/zool-release/modules/ZoolMap/ZoolMapData/numerologia_segunda_persona_fem.json 1

    }
    //<--Load Data

    //-->Make Dinamically
    function mkWindowDataView(title, data, x, y, width, height, parent, fs){
        let c=''
        c+='import QtQuick 2.0\n'
        c+='import comps.WindowDataView 1.0\n'
        c+='WindowDataView{\n'
        c+='    id: w\n'
        c+='    Component.onCompleted:{\n'
        c+='        let d="'+data+'"\n'
        c+='        w.title="'+title+'"\n'
        c+='        w.x="'+x+'"\n'
        c+='        w.y="'+y+'"\n'
        c+='        w.width="'+width+'"\n'
        c+='        w.height="'+height+'"\n'
        c+='        w.fs="'+fs+'"\n'
        c+='        w.text=d\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, parent, 'mkWindowDataViewCode')
    }
    function mkItemDataView(data, x, y, width, height, parent, fs){
        let c=''
        c+='import QtQuick 2.0\n'
        c+='import comps.ItemDataView 1.0\n'
        c+='ItemDataView{\n'
        c+='    id: w\n'
        c+='    Component.onCompleted:{\n'
        c+='        let d="'+data+'"\n'
        c+='        w.x="'+x+'"\n'
        c+='        w.y="'+y+'"\n'
        c+='        w.width="'+width+'"\n'
        c+='        w.height="'+height+'"\n'
        c+='        w.fs="'+fs+'"\n'
        c+='        w.text=d\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, parent, 'mkItemDataViewCode')
    }
    //<--Make Dinamically

    function resizeAspsCircle(isBack){
        if(!isBack){
            if(apps.showDec){
                //log.lv('1 resizeAspsCircle('+isBack+') apps.showDec: '+apps.showDec)
                ca.d=planetsCircle.getMinAsWidth()-r.planetSize//*2
            }else{
                //log.lv('2 resizeAspsCircle('+isBack+') apps.showDec: '+apps.showDec)
                ca.d=planetsCircle.getMinAsWidth()-r.planetSize-r.objSignsCircle.w*2
            }
        }
        if(isBack && r.ev){
            ai.width=planetsCircleBack.getMinAsWidth()-r.planetSize*2
            ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        }
    }
    function resizeAspCircle(){
        if(r.ev){
            ai.width=planetsCircleBack.getMinAsWidth()-r.planetSize*2
            ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        }else{
            ai.width=r.width
        }
    }
    function hideTapa(){
        tapa.opacity=0.0
        r.safeTapa=false
    }
    function revIsDataDiff(){
        let j0=zfdm.getJsonAbsParams()
        let j1=zm.currentJson.params
        let sj1='s_'+j1.d+'_'+j1.m+'_'+j1.a+'_'+j1.h+'_'+j1.min+'_'+j1.gmt+'_'+j1.lat+'_'+j1.lon+'_'+j1.alt
        let sj0='s_'+j0.d+'_'+j0.m+'_'+j0.a+'_'+j0.h+'_'+j0.min+'_'+j0.gmt+'_'+j0.lat+'_'+j0.lon+'_'+j0.alt
        r.isDataDiff=sj0!==sj1
        return r.isDataDiff
    }
    //-->ZoomAndPan
    function centerZoomAndPos(){
        pinchArea.m_x1 = 0
        pinchArea.m_y1 = 0
        pinchArea.m_x2 = 0
        pinchArea.m_y2 = 0
        pinchArea.m_zoom1 = 1.0
        pinchArea.m_zoom2 = 1.0
        rect.x = 0
        rect.y = 0
    }
    function zoomTo(z){
        centerZoomAndPos()
        pinchArea.m_zoom1 = z
        pinchArea.m_zoom2 = z
    }
    function setZoomAndPos(zp){
        r.uZp=zp
        pinchArea.m_x1 = zp[0]
        pinchArea.m_y1 = zp[1]
        pinchArea.m_x2 = zp[2]
        pinchArea.m_y2 = zp[3]
        pinchArea.m_zoom1 = zp[4]
        pinchArea.m_zoom2 = zp[5]
        rect.x = zp[6]
        rect.y = zp[7]
        if(zp[8]){
            app.currentXAs.objOointerPlanet.pointerRot=zp[8]
        }
    }
    function getZoomAndPos(){
        let a = []
        a.push(parseFloat(pinchArea.m_x1).toFixed(2))
        a.push(parseFloat(pinchArea.m_y1).toFixed(2))
        a.push(parseFloat(pinchArea.m_x2).toFixed(2))
        a.push(parseFloat(pinchArea.m_y2).toFixed(2))
        a.push(parseFloat(pinchArea.m_zoom1).toFixed(2))
        a.push(parseFloat(pinchArea.m_zoom2).toFixed(2))
        a.push(parseInt(rect.x))
        a.push(parseInt(rect.y))
        if(zm.currentXAs){
            a.push(parseInt(zm.currentXAs.uRot))
        }else{
            a.push(0)
        }
        return a
    }
    function setPos(x, y, angle){
        var originalX = x;
        var originalY = y;

        // Ángulo de rotación del rectángulo contenedor
        var rotationAngle = angle//parent.rotation;

        // Calcular las coordenadas del punto después de la rotación
        var rotatedPoint = getCoordsRotatedPoint(originalX, originalY, rotationAngle);

        //console.log('Coordenadas rotadas:', rotatedPoint.x+' '+rotatedPoint.y);
        mr(rotatedPoint.x, rotatedPoint.y);
    }
    function getCoordsRotatedPoint(x, y, angle) {
        // Convertir el ángulo a radianes
        var radians = angle * Math.PI / 180;

        // Calcular las coordenadas rotadas
        var rotatedX = x * Math.cos(radians) - y * Math.sin(radians);
        var rotatedY = x * Math.sin(radians) + y * Math.cos(radians);

        return { x: rotatedX, y: rotatedY };
    }
    function saveZoomAndPosHouse(house, isExt){
        let json=zfdm.getJsonAbs()
        if(!json[app.stringRes+'zoompos']){
            json[app.stringRes+'zoompos']={}
        }
        let sNomItem=''+app.stringRes+'zoompos'
        if(isExt)sNomItem+='Back'
        json[sNomItem]['h'+house]=r.getZoomAndPos()
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        let njson=JSON.stringify(json, null, 2)
        log.lv('json: '+njson)
        //zm.fileData=njson
        //zm.currentData=njson
        unik.setFile(apps.url.replace('file://', ''), njson)
    }
    //Función para el desarrollo de el posicionamiento automático.
    function mr(x, y) {
        let c='import QtQuick 2.12\n'
        c+='Rectangle {\n'
        c+='    color: "red"\n'
        c+='    Timer{\n'
        c+='        running:true; repeat:false;interval:5000\n'
        c+='        onTriggered: parent.destroy()\n'
        c+='    }\n'
        c+='}\n'
        var d = Qt.createQmlObject(c, capaFront);
        d.width=50
        d.height=50
        d.border.width=4
        d.border.color='yellow'
        d.x = x-25;
        d.y = y-25;
    }
    //<--ZoomAndPan

    function resetGlobalVars(){
        r.ev=false
        r.currentPlanetIndex=-1
        r.currentPlanetIndexBack=-1
        r.currentHouseIndex=-1
        r.currentHouseIndexBack=-1
        r.currentSignIndex= 0
        r.currentNom= ''
        r.currentNomBack= ''
        r.currentFecha= ''
        r.currentFechaBack= ''
        r.currentGradoSolar= -1
        r.currentGradoSolarBack= -1
        r.currentMinutoSolar= -1
        r.currentMinutoSolarBack= -1
        r.currentSegundoSolar= -1
        r.currentSegundoSolarBack= -1
        r.currentGmt= 0.0
        r.currentGmtBack= 0.0
        r.currentLon= 0.0
        r.currentLonBack= 0.0
        r.currentLat= 0.0
        r.currentLatBack= 0.0
        r.uSon=''
        r.uSonBack=''
        apps.showAspPanelBack=false
        apps.urlBack=''
        apps.showAspPanelBack=false
        apps.showAspCircleBack=false
    }
    function getEdad(d, m, a, h, min) {
        let hoy = new Date(Date.now())
        let fechaNacimiento = new Date(a, m, d, h, min)
        fechaNacimiento=fechaNacimiento.setMonth(fechaNacimiento.getMonth() - 1)
        let fechaNacimiento2 = new Date(fechaNacimiento)
        let edad = hoy.getFullYear() - fechaNacimiento2.getFullYear()
        let diferenciaMeses = hoy.getMonth() - fechaNacimiento2.getMonth()
        if(diferenciaMeses < 0 ||(diferenciaMeses === 0 && hoy.getDate() < fechaNacimiento2.getDate())){
            edad--
        }
        return edad
    }
    function getEdadRS(d, m, a, h, min) {
        let hoy = app.currentDate//new Date(Date.now())
        let fechaNacimiento = new Date(a, m, d, h, min)
        fechaNacimiento=fechaNacimiento.setMonth(fechaNacimiento.getMonth() - 1)
        let fechaNacimiento2 = new Date(fechaNacimiento)
        let edad = hoy.getFullYear() - fechaNacimiento2.getFullYear()
        let diferenciaMeses = hoy.getMonth() - fechaNacimiento2.getMonth()
        if(diferenciaMeses < 0 ||(diferenciaMeses === 0 && hoy.getDate() < fechaNacimiento2.getDate())){
            edad--
        }
        return edad
    }
    function getAPD(isBack){
        return !isBack?planetsCircle.getAPD():planetsCircleBack.getAPD()
    }
    function getIndexSign(gdec){
        let index=0
        let g=0.0
        for(var i=0;i<12+5;i++){
            g = g + 30.00
            if (g > parseFloat(gdec)){
                break
            }
            index = index + 1
        }
        return index
    }
    function getIndexHouse(gdec, isBack){
        let json=!isBack?zm.currentJson:zm.currentJsonBack
        let index=0
        let g=0.0
        for(var i=0;i<12;i++){
            let iseg=json.ph['h'+parseInt(i+1)].gdec
            let fseg
            if(i!==11){
                fseg=json.ph['h'+parseInt(i+2)].gdec
            }else{
                fseg=json.ph['h1'].gdec
            }
            if(fseg<iseg)fseg=fseg+360
            if(gdec>=iseg && gdec<=fseg){
                index=i
                break
            }
        }
        return index
    }
    function convertDDToDMS(D, lng) {
      return {
        dir: D < 0 ? (lng ? "W" : "S") : lng ? "E" : "N",
        deg: 0 | (D < 0 ? (D = -D) : D),
        min: 0 | (((D += 1e-9) % 1) * 60),
        sec: (0 | (((D * 60) % 1) * 6000)) / 100,
      };
    }
    function getDDToDMS(D) {
      return {
        deg: 0 | (D < 0 ? (D = -D) : D),
        min: 0 | (((D += 1e-9) % 1) * 60),
        sec: (0 | (((D * 60) % 1) * 6000)) / 100,
      };
    }
    function getAspType(g1, g2, showLog, index, indexb, pInt, pExt){
        let ret=-1

        //Prepare Grado de Margen de Conjunción
        let gmcon1=parseFloat(g2 - 0.25)
        let gmcon2=parseFloat(g2 + 0.25)
        //Conjunción
        if(g1 >= gmcon1 && g1 <= gmcon2 ){
            ret=0
            return ret
        }

        //Prepare Grado de Oposición
        let gop=parseFloat( parseFloat(g1) + 180.00)
        if(gop>=360.00)gop=parseFloat(360.00-gop)
        if(gop<0)gop=Math.abs(gop)
        //if(showLog)log.lv('g1:'+g1+'\ngop: '+gop)
        //Oposición
        if(g1 >= gop-0.25 && g1 <= gop+0.25 ){
            ret=1
            return ret
        }

        //Prepare Grado de Cuadratura
        let gcu=parseFloat( parseFloat(g1) + 90.00)
        if(gcu>=360.00)gcu=parseFloat(360.00-gcu)
        if(gcu<0)gcu=Math.abs(gcu)
        let gmcua1=parseFloat(gcu - 0.25)
        let gmcua2=parseFloat(gcu + 0.25)

        let gcu2=parseFloat( parseFloat(g1) - 90.00)
        if(gcu2>=360.00)gcu2=parseFloat(360.00-gcu2)
        if(gcu2<0)gcu2=Math.abs(gcu2)
        let gmcua3=parseFloat(gcu2 - 0.25)
        let gmcua4=parseFloat(gcu2 + 0.25)
        //if(showLog && indexb === 6 && pInt==='Sol')log.lv('pInt '+pInt+':'+g1+'\npExt '+pExt+': g2:'+g2+' gcu: '+gcu+'\ngmcua1: '+gmcua1+'\ngmcua2: '+gmcua2)
        //Cuadratura
        if((g2 >= gmcua1 && g2 <= gmcua2) || (g2 >= gmcua3 && g2 <= gmcua4)){
            ret=2
            return ret
        }
        return ret
    }
}
