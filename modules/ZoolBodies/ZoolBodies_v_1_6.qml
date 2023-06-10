import QtQuick 2.7
import QtQuick.Controls 2.12
import "../../js/Funcs.js" as JS


import ZoolBodies.ZoolPlanetsCircleBack 1.1
import ZoolHousesCircle 1.1
import ZoolHousesCircleBack 1.2
import ZoolBodies.ZoolAspectsView 1.0
import ZoolBodies.ZoolAspectsViewBack 1.0

import ZoolSignCircle 1.0
import ZoolAutoPanZoom 1.0

//import "./comps" as Comps

Item {
    id: r
    width: !app.ev?
               parent.height*apps.sweMargin-app.fs*6:
               //app.fs*30
               housesCircleBack.width-housesCircleBack.extraWidth-fs
    height: width
    //anchors.centerIn: parent
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.horizontalCenterOffset: sweg.fs
    //clip: true
    property bool zoomAndPosCentered: pinchArea.m_x1===0 && pinchArea.m_y1===0 && pinchArea.m_y2===0 && pinchArea.m_x2===0 && pinchArea.m_zoom1===0.5 && pinchArea.m_zoom2===0.5 && pinchArea.m_max===6 && pinchArea.m_min===0.5
    property real xs: scaler.xScale
    property real z1: pinchArea.m_zoom1
    property var uZp

    property int  verticalOffSet: 0//xDataBar.state==='show'?sweg.fs*1.25:0
    property int fs: r.objectName==='sweg'?apps.sweFs*1.5:apps.sweFs*3
    property int w: apps.signCircleWidth//fs
    property bool v: false
    property alias expand: planetsCircle.expand
    property alias objAspsCircle: aspsCircle
    property alias objPlanetsCircle: planetsCircle
    property alias objPlanetsCircleBack: planetsCircleBack
    property alias objHousesCircle: housesCircle
    property alias objHousesCircleBack: housesCircleBack
    property alias objSignsCircle: signCircle
    property alias objAscMcCircle: ascMcCircle
    property alias objEclipseCircle: eclipseCircle

    property alias objZoolAspectsView: panelAspects
    property alias objZoolAspectsViewBack: panelAspectsBack

    property int speedRotation: 1000
    property var aStates: ['ps', 'pc', 'pa']
    property color backgroundColor: enableBackgroundColor?apps.backgroundColor:'transparent'
    property bool enableBackgroundColor: apps.enableBackgroundColor
    property string currentHsys: apps.currentHsys

    property bool enableAnZoomAndPos: true

    property var jsonStandByForBack

    property bool enableLoad: true
    property bool enableLoadBack: true

    //state: apps.swegMod//aStates[0]
    state: aStates[0]
    states: [
        State {//PS
            name: aStates[0]
            PropertyChanges {
                target: r
                //width: app.ev?r.fs*(12 +6):r.fs*(12 +10)
            }
            PropertyChanges {
                target: signCircle
                width: !housesCircleBack.visible?sweg.width-sweg.fs*2:sweg.width-sweg.fs*2-housesCircleBack.extraWidth*2
            }
            PropertyChanges {
                target: planetsCircle
                width: signCircle.width-signCircle.w
            }
        },
        State {//PC
            name: aStates[1]
            PropertyChanges {
                target: r
                //width: app.ev?r.fs*(15 +6):r.fs*(15 +10)
            }
            PropertyChanges {
                target: signCircle
                width: !housesCircleBack.visible?sweg.width-sweg.fs*6:sweg.width-sweg.fs*6-housesCircleBack.extraWidth*2
            }
            PropertyChanges {
                target: planetsCircle
                width: signCircle.width-signCircle.w
            }
        },
        State {//PA
            name: aStates[2]
            PropertyChanges {
                target: r
                //width: app.ev?r.fs*(12 +6):r.fs*(12 +10)
            }
            PropertyChanges {
                target: signCircle
                width: !housesCircleBack.visible?sweg.width-sweg.fs*2:sweg.width-sweg.fs*2-housesCircleBack.extraWidth*2
            }
            PropertyChanges {
                target: planetsCircle
                width: signCircle.width-signCircle.w
            }
        }
    ]

    onStateChanged: {
        //swegz.sweg.state=state
        apps.swegMod=state
    }
    onEnableAnZoomAndPosChanged: {
        tEnableAnZoomAndPos.restart()
    }
    Behavior on opacity{NumberAnimation{duration: 1500}}
    Behavior on verticalOffSet{NumberAnimation{duration: app.msDesDuration}}
    Item{id: xuqp}
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
            PinchArea {
                id: pinchArea
                anchors.fill: parent

                property real m_x1: 0
                property real m_y1: 0
                property real m_y2: 0
                property real m_x2: 0
                property real m_zoom1: 0.5
                property real m_zoom2: 0.5
                property real m_max: 6
                property real m_min: 0.5

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
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
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
                    visible: signCircle.v
                }
                BackgroundImages{id: backgroundImages}
                ZoolHousesCircleBack{//rotation: parseInt(signCircle.rot);//z:signCircle.z+1;
                    id:housesCircleBack
                    height: width
                    anchors.centerIn: signCircle
                    w: r.fs
                    widthAspCircle: aspsCircle.width
                    visible: app.ev
                    //visible: planetsCircleBack.visible
                }
                ZoolHousesCircle{//rotation: parseInt(signCircle.rot);//z:signCircle.z+1;
                    id:housesCircle
                    height: width
                    anchors.centerIn: signCircle
                    //w: r.fs*6
                    widthAspCircle: aspsCircle.width
                    //visible: r.v
                }
                AxisCircle{id: axisCircle}
                NumberLines{}
                ZoolSignCircle{
                    id:signCircle
                    //width: planetsCircle.expand?r.width-r.fs*6+r.fs*2:r.width-r.fs*6
                    anchors.centerIn: parent
                    showBorder: true
                    v:r.v
                    w: r.w
                    onRotChanged: housesCircle.rotation=rot
                    //onShowDecChanged: Qt.quit()
                }
                AspCircleV2{
                    id: aspsCircle
                    rotation: signCircle.rot - 90// + 1
                }
                AscMcCircle{id: ascMcCircle}
                PlanetsCircle{
                    id:planetsCircle
                    height: width
                    anchors.centerIn: parent
                    //showBorder: true
                    //v:r.v
                }
//                PlanetsCircleBack{
//                    id:planetsCircleBack
//                    height: width
//                    anchors.centerIn: parent
//                    visible: app.ev
//                }
                ZoolPlanetsCircleBack{
                    id:planetsCircleBack
                    height: width
                    anchors.centerIn: parent
                    visible: app.ev
                }
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
            }
        }
    }
    ZoolAspectsView{
        id: panelAspects
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: xLatIzq.visible?0:0-xLatIzq.width
        parent: xMed
        visible: r.objectName==='sweg'
    }
    ZoolAspectsViewBack{
        id: panelAspectsBack
        anchors.top: parent.top
        //anchors.topMargin: 0-(r.parent.height-r.height)/2
        parent: xMed
        anchors.left: parent.left
        anchors.leftMargin: xLatIzq.visible?width:width-xLatIzq.width
        transform: Scale{ xScale: -1 }
        rotation: 180
        visible: r.objectName==='sweg'&&planetsCircleBack.visible
    }
    //    Rectangle{
    //        color: 'red'
    //        border.color: 'blue'
    //        border.width: 10
    //        anchors.fill: parent
    //    }
    Rectangle{
        //Este esta en el centro
        visible: false
        opacity: 0.5
        width: r.fs*2//planetsCircle.children[0].fs*0.85+4
        height: width
        color: 'red'
        radius: width*0.5
        border.width: 2
        border.color: 'white'
        anchors.centerIn: parent
    }
    Rectangle{
        anchors.fill: r
        color: 'transparent'
        border.width: 12
        border.color: 'red'
        visible: app.dev
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
            text: app.mod
            font.pixelSize: app.fs
            color: apps.backgroundColor
            anchors.centerIn: parent
        }
    }
    Timer{
        id: tLoadSin
        running: false
        repeat: false
        interval: 2000
        onTriggered: {
            let j=JSON.parse(app.fileData)
            //app.fileDataBack=JSON.stringify(j.paramsBack)
            let njson=JSON.parse('{}')
            njson.params=j.paramsBack
            JS.loadJsonFromParamsBack(njson)
            //loadSweJsonBack(j)
            //log.l(JSON.stringify(j.paramsBack))
            //log.visible=true
            //loadBack(current)
        }
    }
    Timer{
        id: tFirtShow
        running: false
        repeat: false
        interval: 2000
        onTriggered: r.opacity=1.0
    }
    //    Rectangle{
    //        width: app.fs*6
    //        height: width
    //        anchors.centerIn: parent
    //        Text{
    //            id: ihr
    //            font.pixelSize: app.fs*2
    //            anchors.centerIn: parent
    //        }
    //    }
    function load(j){
        //console.log('Ejecutando SweGraphic.load()...')
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
        c+='        //console.log(\'JSON: \'+json)\n'
        c+='        loadSweJson(json)\n'
        c+='        //swegz.sweg.loadSweJson(json)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        console.log(\'sweg.load() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' '+unik.currentFolderPath()+'\')\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'"\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
        app.mod=j.params.tipo
        app.fileData=JSON.stringify(j)
    }
    function loadBack(j){
        //console.log('Ejecutando SweGraphic.load()...')
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
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=apps.currentHsys
        app.currentFechaBack=vd+'/'+vm+'/'+va
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
        c+='        app.ev=true\n'
        c+='        app.objZoolFileExtDataManager.updateList()\n'
        c+='        //swegz.sweg.loadSweJsonBack(json)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\'sweg.loadBack() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'"\'\n'
        c+='    if(apps.showLog){\n'
        c+='        log.ls(cmd, 0, xApp.width)\n'
        c+='    }\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'"\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
        app.mod=j.params.tipo
        app.fileDataBack=JSON.stringify(j)
    }
    function loadSweJson(json){
        //console.log('JSON::: '+json)
        //log.visible=true
        //log.l(JSON.stringify(json))
        var scorrJson=json.replace(/\n/g, '')
        //app.currentJson=JSON.parse(scorrJson)
        aspsCircle.clear()
        zsm.getPanel('ZoolRevolutionList').clear()
        //panelRsList.clear()
        //planetsCircleBack.visible=false
        app.ev=false
        apps.urlBack=''
        panelAspectsBack.visible=false
        app.currentHouseIndex=-1
        app.currentHouseIndexBack=-1
        //sweg.objHousesCircle.currentHouse=-1
        //swegz.sweg.objHousesCircle.currentHouse=-1
        app.currentPlanetIndex=-1
        app.currentHouseIndex=-1

        //console.log('json: '+json)
        var j
        //try {

        //log.l(scorrJson)
        //log.visible=true
        //log.width=xApp.width*0.4
        j=JSON.parse(scorrJson)

        app.currentJson=j
        signCircle.rot=parseFloat(j.ph.h1.gdec).toFixed(2)
        ascMcCircle.loadJson(j)
        housesCircle.loadHouses(j)
        planetsCircle.loadJson(j)
        panelAspects.load(j)
        panelDataBodies.loadJson(j)
        aspsCircle.load(j)
        zoolElementsView.load(j, false)
        eclipseCircle.arrayWg=housesCircle.arrayWg
        eclipseCircle.isEclipse=-1
        r.v=true
        let sabianos=zsm.getPanel('ZoolSabianos')
        sabianos.numSign=app.currentJson.ph.h1.is
        sabianos.numDegree=parseInt(app.currentJson.ph.h1.rsgdeg - 1)
        sabianos.loadData()
        if(apps.sabianosAutoShow){
            //panelSabianos.state='show'
            zsm.currentIndex=1
        }     }
    function loadSweJsonBack(json){
        //console.log('JSON::: '+json)
        app.currentJsonBack=JSON.parse(json)
        //        if(app.dev)
        //            log.lv('ZoolBodies.loadSweJsonBack(json): '+json)
        //            log.lv('ZoolBodies.loadSweJsonBack(json) app.currentJsonBack: '+app.currentJsonBack)
        let scorrJson=json.replace(/\n/g, '')
        //console.log('json: '+json)
        let j=JSON.parse(scorrJson)
        //signCircle.rot=parseInt(j.ph.h1.gdec)
        //planetsCircleBack.rotation=parseFloat(j.ph.h1.gdec).toFixed(2)
        if(r.objectName==='sweg'){
            panelAspectsBack.visible=true
        }
        panelAspectsBack.load(j)
        aspsCircle.add(j)
        if(app.mod!=='rs'){
            //panelElementsBack.load(j)
            zoolElementsView.load(j, true)
            //panelElementsBack.visible=true
            //Qt.quit()
        }else{
            //panelElementsBack.visible=false
        }
        housesCircleBack.loadHouses(j)
        //if(app.mod==='dirprim')housesCircleBack.rotation-=360-housesCircle.rotation
        //if(JSON.parse(app))
        planetsCircleBack.loadJson(j)
        panelDataBodies.loadJsonBack(j)
        //panelDataBodiesV2.loadJson(j)
        app.ev=true
        //centerZoomAndPos()
    }
    function nextState(){
        let currentIndexState=r.aStates.indexOf(r.state)
        if(currentIndexState<r.aStates.length-1){
            currentIndexState++
        }else{
            currentIndexState=0
        }
        r.state=r.aStates[currentIndexState]
        //swegz.sweg.state=r.state
    }
    function centerZoomAndPos(){
        pinchArea.m_x1 = 0
        pinchArea.m_y1 = 0
        pinchArea.m_x2 = 0
        pinchArea.m_y2 = 0
        pinchArea.m_zoom1 = 0.5
        pinchArea.m_zoom2 = 0.5
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
        a.push(parseInt(app.currentXAs.uRot))
        return a
    }
}
