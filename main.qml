import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.0
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.12

//import unik.UnikQProcess 1.0
import unik.Unik 1.0

import "./js/Funcs_v2.js" as JS
import "./comps" as Comps

//Default Modules
import comps.ZoolAppSettings 1.0
import ZoolSectionsManager 1.1
import ZoolMainWindow 1.0
//import ZoolTopMenuBar 1.0
import ZoolText 1.0
import ZoolDataBar 3.1
import ZoolDataView 1.1
import ZoolLogView 1.0

//import ZoolFileDataManager 1.0
import web.ZoolandServerFileDataManager 1.0
import ZoolBodies 1.9
//import ZoolBodiesGuiTools 1.0

import ZoolControlsTime 1.0


import ZoolandDataBodies 1.0
import ZoolElementsBack 1.0
import ZoolElementsView 1.0

import comps.Zbg 1.0
import ZoolBottomToolBar 1.0
import comps.ZoolHostEditor 1.0
//import comps.ZoolPanelNotifications 1.0
//import web.ZoolWebStatusManager 1.0
//import comps.MinymaClient 1.0

//import ZoolMediaLive 1.1
//import ZoolVoicePlayer 1.0
//import ZoolDataEditor 1.0
//import ZoolVideoPlayer 1.0
import ZoolInfoDataView 1.0
//import ZoolBottomBar 1.0




ZoolMainWindow{
    id: app
    visible: true


    //Código que falló en la Tv de Mario
    /*
    visibility: "Maximized"
    width: Screen.width
    height: Screen.height
    minimumWidth: Screen.desktopAvailableWidth-app.fs*4
    minimumHeight: Screen.desktopAvailableHeight-app.fs*4
    */

    //Código nuevo para probar
    visibility: Qt.platform.os==='android'?"FullScreen":"Maximized"
    width: 1920
    height: 1080




    color: apps.enableBackgroundColor?apps.backgroundColor:'black'
    //title: argtitle && argtitle.length>1?argtitle:'Zool '+version
    title:'Zooland'

    //Zooland VarsonCom
    property var ci: xApp


    property bool dev: Qt.application.arguments.indexOf('-dev')>=0
    property string version: '0.0.-1'
    property string sweBodiesPythonFile: 'astrologica_swe_v2.py'
    property var j: JS

    property string mainLocation: ''
    //property string pythonLocation: Qt.platform.os==='linux'?'python3':pythonLocationSeted?'"'+pythonLocationSeted+'"':'"'+unik.getPath(4)+'/Python/python.exe'+'"'

    property string pythonLocation: ''

    property int fs: apps.fs//Qt.platform.os==='linux'?width*0.02:width*0.02
    property string stringRes: 'Screen'+Screen.width+'x'+Screen.height
    property string url
    property string mod: 'vn'

    property bool backIsSaved: false

    property var objInFullWin
    property bool capturing: false

    property bool showCenterLine: false
    property bool enableAn: false
    property int msDesDuration: 500

    property var minymaClient
    property var objZoolFileExtDataManager
    property var aExtsIds: []

    property string fileData: ''
    property string fileDataBack: ''
    property string currentData: ''
    property string currentDataBack: ''
    property var currentJson
    property var currentJsonBack
    property bool setFromFile: false

    //Para analizar signos y ascendentes por región
    property int currentIndexSignData: 0
    property var currentJsonSignData: ''

    property int currentPlanetIndex: -1
    property int currentPlanetIndexBack: -1

    property int currentHouseIndex: -1
    property int currentHouseIndexBack: -1

    property int currentSignIndex: 0

    property date currentDate
    property string currentNom: ''
    property string currentFecha: ''
    property string currentLugar: ''
    property int currentAbsolutoGradoSolar: -1
    property int currentGradoSolar: -1
    property int currentRotationxAsSol: -1
    property int currentMinutoSolar: -1
    property int currentSegundoSolar: -1
    property real currentGmt: 0
    property real currentLon//: 0.0
    property real currentLat//: 0.0
    property real currentAlt: 0

    property date currentDateBack
    property string currentNomBack: ''
    property string currentFechaBack: ''
    property string currentLugarBack: ''
    property int currentAbsolutoGradoSolarBack: -1
    property int currentGradoSolarBack: -1
    property int currentMinutoSolarBack: -1
    property int currentSegundoSolarBack: -1
    property real currentGmtBack: 0
    property real currentLonBack: 0.0
    property real currentLatBack: 0.0


    property bool lock: false
    property string uSon: ''
    property string uSonFCMB: ''
    property string uSonBack: ''

    property string uCuerpoAsp: ''

    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    //property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith']
    property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    //property var planetasArchivos: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'asc', 'mc']
    property var planetasArchivos: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta', 'asc', 'mc']
    property var planetasReferencia: ['el sol', 'la luna', 'el planeta mercurio', 'el planeta venus', 'el planeta marte', 'el planeta jupiter', 'el planeta saturno', 'el planeta urano', 'el planeta neptuno', 'pluton', 'el nodo norte', 'el nodo sur', 'el asteroide quiron', 'la luna blanca selena', 'la luna negra lilith', 'el ascendente', 'el medio cielo']
    property var planetasRes: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'n', 's', 'hiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var signColors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property var meses: ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']

    //Asp Astrolog Search
    property var planetasAS: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte']
    //property var planetasResAS: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'North Node']

    property var arbolGenealogico: ['Raíz', 'Portal', 'Ala', 'Integrador']

    //property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'G', 'M']
    property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'M']
    //property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Gauquelin', 'Morinus']
    property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Morinus']
    /*
                ‘P’     Placidus
                ‘K’     Koch
                ‘O’     Porphyrius
                ‘R’     Regiomontanus
                ‘C’     Campanus
                ‘A’ or ‘E’     Equal (cusp 1 is Ascendant)
                ‘V’     Vehlow equal (Asc. in middle of house 1)
                ‘X’     axial rotation system
                ‘H’     azimuthal or horizontal system
                ‘T’     Polich/Page (“topocentric” system)
                ‘B’     Alcabitus
                ‘G’     Gauquelin sectors
                ‘M’     Morinus
*/

    property int uAscDegreeTotal: -1
    property int uAscDegree: -1
    property int uMcDegree: -1
    //property string stringRes: "Res"+Screen.width+"x"+Screen.height

    property var cmd
    property bool ev: false //Exterior Visible

    //XAs
    property var currentXAs
    property bool showPointerXAs: true
    property var currentXAsBack
    property bool showPointerXAsBack: true

    property bool sspEnabled: false

    property var aParams: ['{"params":{"tipo":"vn","ms":1633701422850,"n":"Ricardo", "d":20,"m":6,"a":1975,"h":23,"min":4,"gmt":-3,"lat":-35.4752134,"lon":-69.585934,"ciudad":"Malargue Mendoza Argentina","msmod":1681568075071}}', '{"params":{"tipo":"vn","ms":1622602994892,"n":"Natalia S. Pintos", "d":8, "m":9, "a":1980, "h":17,"min":0, "gmt":-3, "lat":-34.769249, "lon":-58.6480318, "ciudad":"Gonzalez Catán Buenos Aires Argentina", "msmod":1680626575611}}', '{"params":{"tipo":"vn","ms":1622602707398,"n":"Nico","d":3,"m":11,"a":2000,"h":1,"min":45,"gmt":-3,"lat":-34.7047876,"lon":-58.5861609,"ciudad":"Isidro Casanova Buenos Aires Argentina","msmod":1680658423514}}', '{"params":{"tipo":"vn","ms":1657287434162,"n":"Hugo_13-45hs","d":1,"m":11,"a":1963,"h":13,"min":45,"gmt":-3,"lat":-34.6075682,"lon":-58.4370894,"ciudad":"Ciudad de Buenos Aires Argentina","msmod":1657287598347}}', '{"params":{"tipo":"vn","ms":1684454531469,"n":"Mario_Eduardo_Pizarro","d":3,"m":1,"a":1972,"h":9,"min":30,"gmt":-3,"lat":-34.6075682,"lon":-58.4370894,"alt":0,"ciudad":"Ciudad de Buenos Aires Argentina","hsys":"P","shared":false,"extId":"id_3_1_1972_9_30_-3_-34.6075682_-58.4370894_0_vn_P"}}']

    onClosing:Qt.quit()

    onCurrentPlanetIndexChanged: {
        zoolDataBodies.currentIndex=currentPlanetIndex
        if(currentPlanetIndex>=0){
            app.currentPlanetIndexBack=-1
            app.currentHouseIndexBack=-1
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
        if(currentPlanetIndexBack>=0){
            app.currentPlanetIndex=-1
            app.currentHouseIndex=-1
        }
    }
    onCurrentGmtChanged: {
        if(app.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmt
        //tReload.restart()
    }
    onCurrentGmtBackChanged: {
        //if(app.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmtBack
        //tReloadBack.restart()
    }
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
        //tReload.restart()
    }
    onCurrentDateBackChanged: {
        controlsTimeBack.setTime(currentDateBack)
        if(app.mod==='trans'){
            JS.loadTransFromTime(app.currentDateBack)
        }
        //xDataBar.state='show'
        let a=currentDateBack.getFullYear()
        let m=currentDateBack.getMonth()
        let d=currentDateBack.getDate()
        let h=currentDateBack.getHours()
        let min=currentDateBack.getMinutes()
        //tReloadBack.restart()
    }

    FontLoader {name: "fa-brands-400";source: "./fonts/fa-brands-400.ttf";}
    FontLoader {name: "FontAwesome";source: "./fonts/fontawesome-webfont.ttf";}
    FontLoader {name: "ArialMdm";source: "./fonts/ArialMdm.ttf";}
    FontLoader {name: "TypeWriter";source: "./fonts/typewriter.ttf";}
    Unik{
        id: unik
        onUkStdChanged: {
            let std=ukStd
            std=std.replace(/&quot;/g, '"')
            log.lv(std)
        }
        Component.onCompleted: {
            unik.setEngine(engine)
        }
    }
    ZoolAppSettings{id: apps}
    ZoolandServerFileDataManager{id: zsfdm}
    Item{
        id: xApp
        anchors.fill: parent
        Rectangle{
            id: xSwe1
            //width: xApp.width-xLatIzq.width-xLatDer.width
            width: sweg.width
            height: xApp.height-zoolDataView.height
            color: apps.backgroundColor
            //color: 'red'
            //border.width: 10
            border.color: 'white'
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: xLatIzq.visible?0:0-xLatIzq.width*0.5
            anchors.bottom: parent.bottom
            clip: xLatIzq.visible
            ZoolBodies{id: sweg;objectName: 'sweg'}            
        }

        Rectangle{
            id: xMsgProcDatos
            width: txtPD.contentWidth+app.fs
            height: app.fs*4
            color: 'black'
            border.width: 2
            border.color: 'white'
            visible: false
            anchors.centerIn: parent
            ZoolText {
                id: txtPD
                text: 'Procesando datos...'
                //font.pixelSize: app.fs
                //color: 'white'
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: parent.visible=false
            }
        }
        //Keys.onDownPressed: Qt.quit()
    }
    Item{
        id: capa101
        anchors.fill: xApp
        ZoolDataView{id: zoolDataView;}
        Row{
            anchors.top: zoolDataView.bottom
            anchors.bottom: parent.top
            Rectangle{
                id: xLatIzq
                width: xApp.width*0.2
                height: parent.parent.height-zoolDataView.height
                color: apps.backgroundColor
                visible: apps.showLatIzq
                ZoolSectionsManager{id: zsm}
                Rectangle{
                    width: parent.width
                    height: 3
                    color: 'red'
                    anchors.bottom: parent.bottom
                    visible: apps.zFocus==='xLatIzq'
                }
            }
            Item{
                width: xLatIzq.width;
                height: 1;
                visible: !xLatIzq.visible


            }
            Item{
                id: xMed
                width: xApp.width-xLatIzq.width-xLatDer.width
                height: xApp.height-zoolDataView.height
                //Zbg{}
                ZoolElementsView{id: zoolElementsView}
                //ExtId
                Rectangle{}
                Text{
                    text: '<b>Versión: '+unik.getFile('version')+'</b><br /><b>Host: </b>'+apps.host
                    font.pixelSize: app.fs*0.45
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text{
                    text: '<b>uExtId: '+zoolDataView.uExtIdLoaded+'</b>'
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: app.dev
                }
                Item{
                    id: xControlsTime
                    width: controlsTime.width
                    height: controlsTime.height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    property bool showCT: false
                    MouseArea{
                        anchors.fill: parent
                        onClicked: xControlsTime.showCT=!xControlsTime.showCT
                    }
                    Item{
                        id:xIconClock
                        width: app.fs
                        height: width
                        //anchors.horizontalCenter: parent.horizontalCenter
                        anchors.right: parent.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: app.fs*0.1
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                xControlsTime.showCT=!xControlsTime.showCT
                                xControlsTimeBack.showCT=false
                            }
                        }
                        Text{
                            id:ccinit
                            text:'\uf017'
                            font.family: 'FontAwesome'
                            font.pixelSize: app.fs*0.75
                            color: apps.houseColor
                            anchors.centerIn: parent
                        }
                    }
                    //Comps.ControlsTime{
                    ZoolControlsTime{
                        id: controlsTime
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: h
                        property int h: parent.showCT?0:0-height
                        setAppTime: true
                        onGmtChanged: app.currentGmt=gmt
                        Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                    }

                }
                Item{
                    id: xControlsTimeBack
                    width: controlsTimeBack.width
                    height: controlsTimeBack.height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: app.ev
                    property bool showCT: false
                    MouseArea{
                        anchors.fill: parent
                        onClicked: xControlsTimeBack.showCT=!xControlsTimeBack.showCT
                    }
                    Item{
                        id:xIconClockBack
                        width: app.fs
                        height: width
                        //anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.horizontalCenterOffset: width+app.fs*0.5
                        anchors.left: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: app.fs*0.1
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                xControlsTimeBack.showCT=!xControlsTimeBack.showCT
                                xControlsTime.showCT=false
                            }
                        }
                        Text{
                            id:ccinitBack
                            text:'\uf017'
                            font.family: 'FontAwesome'
                            font.pixelSize: app.fs*0.75
                            color: apps.houseColorBack//apps.fontColor
                            anchors.centerIn: parent
                        }
                    }
                    Comps.ControlsTime{
                        id: controlsTimeBack
                        isBack: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: h
                        property int h: parent.showCT?0:0-height
                        setAppTime: true
                        onGmtChanged: app.currentGmtBack=gmt
                        Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 3
                    color: 'red'
                    anchors.bottom: parent.bottom
                    visible: apps.zFocus==='xMed'
                }
            }
            Item{
                id: xLatDer
                width: xApp.width*0.2
                height: xMed.height

                //Chat{id: chat; z: onTop?panelPronEdit.z+1:panelControlsSign.z-1}
                //PanelControlsSign{id: panelControlsSign}
                ZoolandDataBodies{id: zoolDataBodies}
                //PanelPronEdit{id: panelPronEdit;}
                //ZoolVoicePlayer{id: zoolVoicePlayer}
                Rectangle{
                    width: parent.width
                    height: 3
                    color: 'red'
                    anchors.bottom: parent.bottom
                    visible: apps.zFocus==='xLatDer'
                }
                //ZoolPanelNotifications{id: zpn}
            }
        }
        ZoolInfoDataView{id: xInfoData}
    }
    ZoolLogView{id: log}
    Timer{
        id: tAutoMaticPlanets
        running: false
        repeat: true
        interval: 10000
        property string currentJsonData: ''
        onTriggered: {
            if(tAutoMaticPlanets.currentJsonData!==app.currentData){
                //tAutoMaticPlanets.stop()
                //return
            }
            if(app.currentPlanetIndex<21){
                app.currentPlanetIndex++
            }else{
                app.currentPlanetIndex=-1
                app.currentHouseIndex=-1
            }
        }
    }
    ZoolBottomToolBar{id: zbtb}
    ZoolHostEditor{id: zhe}
    //Comps.MenuPlanets{id: menuPlanets}
    //ZoolMenuCtxZodiacBack{id: menuRuedaZodiacal}
    //ZoolMenuPlanetsCtxAsc{id: menuPlanetsCtxAsc}
    //ZoolMediaLive{id: zoolMediaLive;parent: zoolDataBodies}

    //Este esta en el centro
    Rectangle{
        id: centroideXMed
        visible: app.dev
        width: 6
        height: width
        color: 'transparent'
        border.width: 1
        border.color: apps.fontColor
        anchors.centerIn: parent
    }

    //Linea vertical medio
    Rectangle{
        width: 2
        height: xApp.height*2
        anchors.centerIn: parent
        visible: app.dev
    }
    //    Timer{
    //        id: tLoadModules
    //        running: false
    //        repeat: false
    //        interval: 5000
    //        onTriggered: JS.loadModules()
    //    }
    Component.onCompleted: {
        //app.j.showMsgDialog('Zool Informa', 'Numero de Versión del Paquete', 'Número: '+unik.getFile('version'))
        JS.setFs()

        //Check is dev with the arg -dev
        if(Qt.application.arguments.indexOf('-dev')>=0){
            app.dev=true
        }

        if(true){
            let compMinyma=Qt.createComponent('./modules/comps/MinymaClient/MinymaClient.qml')
            let objMinyma=compMinyma.createObject(app, {loginUserName: 'zooland', host: 'ws://192.168.1.51', port: 12345})
            objMinyma.newMessageForMe.connect(function(from, data) {
                if(data==='now'){
                    minymaClient.sendData(minymaClient.loginUserName, from, 'Ahora!')
                }
                if(data==='windowToWindow'){
                    app.flags=Qt.Window
                }
                if(data==='windowToTool'){
                    app.flags=Qt.Tool
                }

                //To zoolMediaLive
                if(data==='zoolMediaLive.loadBodiesNow()'){
                    zoolMediaLive.loadBodiesNow()
                }
                if(data==='zoolMediaLive.play()'){
                    zoolMediaLive.play()
                }
                if(data==='zoolMediaLive.pause()'){
                    zoolMediaLive.pause()
                }
                if(data==='zoolMediaLive.stop()'){
                    zoolMediaLive.stop()
                }
                if(data==='zoolMediaLive.previous()'){
                    zoolMediaLive.previous()
                }
                if(data==='zoolMediaLive.next()'){
                    zoolMediaLive.next()
                }
            });
            objMinyma.onNewMessage.connect(function(from, to, data) {
                //Aqui se puede poner un bloque de código
                //para procesar todos los datos que procesa MinymaServer.
            });
            app.minymaClient=objMinyma
        }




        if(app.dev){
            log.ls('\nRunning as Dev', 0, xLatIzq.width)
            //log.ls('\nVersion:\n'+version, log.x,
            log.ls('\nunik.currentFolderPath():\n'+unik.currentFolderPath(), log.x, log.width)
            log.ls('\nunik.getPath(4):\n'+unik.getPath(4), log.x, log.width)
            log.ls('\napps.jsonsFolder:\n'+apps.jsonsFolder, log.x, log.width)
            log.ls('\nDocumentPath:\n'+documentsPath, log.x, log.width)
        }

        app.mainLocation=unik.getPath(5)
        if(Qt.platform.os==='windows'){
            app.mainLocation="\""+app.mainLocation+"\""
        }
        console.log('app.mainLocation: '+app.mainLocation)
        //console.log('documentsPath: '+documentsPath)
        console.log('Init app.url: '+app.url)

    }
}
