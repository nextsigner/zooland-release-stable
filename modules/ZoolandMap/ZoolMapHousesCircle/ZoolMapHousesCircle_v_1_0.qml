import QtQuick 2.0
import ZoolText 1.0
import ZoolandMap.ZoolMapPointerHouse 1.0

Item {
    id: r
    width: app.fs*10//!isBack?signCircle.width+app.fs:(sweg.parent.height*apps.sweMargin)+extraWidth//((sweg.parent.height*(apps.sweMargin))+app.fs)
    height: width
    anchors.centerIn: parent//signCircle
    visible: isBack?zm.ev:true
    rotation: !isBack?0:0-zm.dirPrimRot
    property bool isBack: false
    property int extraWidth: 0
    property int currentHouse: !isBack?zm.objHousesCircle.currentHouse:zm.objHousesCircleBack.currentHouse
    property int houseShowSelectadIndex: -1
    property int w: zm.fs//*3
    property int wb: 1//sweg.fs*0.15
    property int f: 0
    property bool v: false
    property var arrayWg: []
    property string extraObjectName: ''
    property var swegParent//: value
    property int widthAspCircle: 10
    property var aWs: []
    property int c: 0
    property int wbgc: 300
    property var aTipoEjes: ['Eje de<br><b>ENCUENTRO</b>', 'Eje de<br><b>POSESIONES</b>', 'Eje de<br><b>PENSAMIENTO</b>', 'Eje de la<br><b>INDIVIDUACIÓN</b>', 'Eje de<br><b>RELACIONES</b>', 'Eje de<br><b>EXISTENCIA</b>','Eje de<br><b>ENCUENTRO</b>', 'Eje de<br><b>POSESIONES</b>', 'Eje de<br><b>PENSAMIENTO</b>', 'Eje de la<br><b>INDIVIDUACIÓN</b>', 'Eje de<br><b>RELACIONES</b>', 'Eje de<br><b>EXISTENCIA</b>']
    property var aTipoEjesCasas:['Entre Casas<br>1 y 7', 'Entre Casas<br>2 y 8', 'Entre Casas<br>3 y 9', 'Entre Casas<br>4 y 10', 'Entre Casas<br>5 y 11', 'Entre Casas<br>6 y 12', 'Entre Casas<br>1 y 7', 'Entre Casas<br>2 y 8', 'Entre Casas<br>3 y 9', 'Entre Casas<br>4 y 10', 'Entre Casas<br>5 y 11', 'Entre Casas<br>6 y 12']
    Rectangle{
        anchors.fill: parent
        color: 'green'
        border.width: 2
        border.color: 'white'
        radius: width*0.5
        visible: false//r.isBack
    }
    Rectangle{
        width: r.width-(zm.housesNumWidth*2)-(zm.housesNumMargin*2)
        height: width
        color: 'transparent'
        border.width: 1//apps.houseLineWidth
        border.color: zm.houseLineColorBack
        radius: width*0.5
        visible: r.isBack
        anchors.centerIn: parent
    }
    Rectangle{
        id: vacioDeCentro
        width: zm.objAspsCircle.width
        height: width
        color: 'transparent'
        border.width: 1
        border.color: apps.fontColor
        radius: width*0.5
        anchors.centerIn: parent
    }
    Item{
        id: dha//xDinamicHouserArcs
        anchors.fill: r
        property real fr: 0.00 //FakeRotation
    }

    Component{
        id: compArc
        Rectangle{
            id: item
            width: r.width-zm.housesNumWidth*2
            height: 10
            color: 'transparent'
            border.width: 0
            border.color: 'white'
            anchors.centerIn: parent
            property int ih: -1
            property real wg: 0.000
            property string ejeTipoText: 'Eje Tipo Text Indefinido.'
            property bool selected: false
            property int is: -1
            property int rsdeg: -1
            property int gdec: -1
            property int gdeg: -1
            property int mdeg: -1
            property int sdeg: -1
            Repeater{
                model: item.ih===r.currentHouse?wg:0
                //model: 10
                Rectangle{
                    width: !r.isBack?parent.width-(r.w*2):parent.width
                    height: 5
                    color: 'transparent'
                    rotation: 0-(0+index)
                    anchors.centerIn: parent
                    LinePoints{
                        width: parent.width-centro.width//*0.5+app.fs*2
                        height: parent.height
                        c: !r.isBack?apps.houseColor:apps.houseColorBack
                    }
                }
            }
            Rectangle{
                width: (parent.width*0.5)-vacioDeCentro.width*0.5
                height: apps.houseLineWidth
                color: app.t==='dirprim'?'transparent':(!isBack?zm.houseLineColor:zm.houseLineColorBack)//apps.fontColor
                border.width: app.t==='dirprim'?1:0
                border.color: !isBack?zm.houseLineColor:zm.houseLineColorBack
                anchors.verticalCenter: parent.verticalCenter
                Rectangle{
                    //width: !app.ev?app.fs*1.5:app.fs
                    width: zm.housesNumWidth//!app.ev?app.fs*1.5:app.fs
                    height: width
                    radius: width*0.5
                    color: r.isBack?zm.bodieBgColor:zm.bodieBgColorBack//'transparent'
                    border.width: 1//apps.houseLineWidth
                    border.color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.left
                    anchors.rightMargin: 0//app.fs*14
                    rotation: 360-parent.parent.rotation+(!r.isBack?0:zm.dirPrimRot)
                    Text{
                        text: '<b>'+item.ih+'</b>'
                        font.pixelSize: parent.width*0.6//!app.ev?app.fs*0.8:app.fs*0.75
                        color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        anchors.centerIn: parent
                    }
                    Text{
                        text: '<b>Asc</b>'
                        font.pixelSize: parent.width*0.4
                        color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                        visible: item.ih===1
                    }
                    Text{
                        id: tAsc1
                        text: '<b>'+zm.aSigns[item.is]+'</b>'
                        font.pixelSize: parent.width*0.4
                        color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        anchors.right: parent.right
                        anchors.top: parent.bottom
                        visible: item.ih===1
                    }
                    Text{
                        id: tAsc2
                        text: '<b>°'+parseInt(item.gdeg-(30*item.is))+' \''+item.mdeg+'</b>'
                        font.pixelSize: parent.width*0.4
                        color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        anchors.right: parent.right
                        anchors.top: tAsc1.bottom
                        visible: item.ih===1
                    }
                    Text{
                        text: '<b>Desc</b>'
                        font.pixelSize: parent.width*0.4
                        color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                        visible: item.ih===7
                    }
                    Text{
                        id: tDesc1
                        text: '<b>'+zm.aSigns[item.is]+'</b>'
                        font.pixelSize: parent.width*0.4
                        color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        visible: item.ih===7
                    }
                    Text{
                        id: tDesc2
                        text: '<b>°'+parseInt(item.gdeg-(30*item.is))+' \''+item.mdeg+'</b>'
                        font.pixelSize: parent.width*0.4
                        color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        anchors.left: parent.left
                        anchors.top: tDesc1.bottom
                        horizontalAlignment: Text.AlignRight
                        visible: item.ih===7
                    }
                    Text{
                        text: '<b>Fc</b>'
                        font.pixelSize: parent.width*0.4
                        color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        anchors.right: parent.left
                        anchors.rightMargin: parent.width*0.2
                        anchors.verticalCenter: parent.verticalCenter
                        visible: item.ih===4
                    }
                    Column{
                        anchors.left: parent.right
                        anchors.leftMargin: parent.width*0.2
                        anchors.verticalCenter: parent.verticalCenter
                        visible: item.ih===4
                        Text{
                            id: tFc1
                            text: '<b>'+zm.aSigns[item.is]+'</b>'
                            font.pixelSize: parent.parent.width*0.4
                            color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        }
                        Text{
                            id: tFc2
                            text: '<b>°'+parseInt(item.gdeg-(30*item.is))+' \''+item.mdeg+'</b>'
                            font.pixelSize: parent.parent.width*0.4
                            color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        }
                    }
                    Text{
                        text: '<b>Mc</b>'
                        font.pixelSize: parent.width*0.4
                        color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        anchors.right: parent.left
                        anchors.rightMargin: parent.width*0.2
                        anchors.verticalCenter: parent.verticalCenter
                        visible: item.ih===10
                    }
                    Column{
                        anchors.left: parent.right
                        anchors.leftMargin: parent.width*0.2
                        anchors.verticalCenter: parent.verticalCenter
                        visible: item.ih===10
                        Text{
                            id: tMc1
                            text: '<b>'+zm.aSigns[item.is]+'</b>'
                            font.pixelSize: parent.parent.width*0.4
                            color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        }
                        Text{
                            id: tMc2
                            text: '<b>°'+parseInt(item.gdeg-(30*item.is))+' \''+item.mdeg+'</b>'
                            font.pixelSize: parent.parent.width*0.4
                            color: !isBack?zm.houseLineColor:zm.houseLineColorBack//apps.fontColor
                        }
                    }
                    ZoolMapPointerHouse{
                        id: pointerHouse
                        is: item.is
                        gdeg: item.gdeg
                        mdeg: item.mdeg
                        rsgdeg:item.gdeg-(30*is)
                        ih:item.ih
                        isBack: r.isBack
                        visible: item.selected
                    }
                    MouseArea{
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onWheel: {
                            //apps.enableFullAnimation=false
                            if (wheel.modifiers & Qt.ControlModifier) {
                                if(wheel.angleDelta.y>=0){
                                    pointerHouse.pointerRot+=5
                                }else{
                                    pointerHouse.pointerRot-=5
                                }
                            }else{
                                if(wheel.angleDelta.y>=0){
                                    pointerHouse.pointerRot+=45
                                }else{
                                    pointerHouse.pointerRot-=45
                                }
                            }
                            //reSizeAppsFs.restart()
                        }
                        onClicked: {
                            if(mouse.button === Qt.LeftButton && mouse.modifiers & Qt.ControlModifier) {
                                item.selected=!item.selected
                                setCurrentHouseIndex(item)
                            }else if(mouse.button === Qt.RightButton){
                                //log.lv('House Botón Derecho house: '+item.ih)
                                menuCtxHouses.isBack=r.isBack
                                menuCtxHouses.currentIndexHouse=item.ih
                                menuCtxHouses.popup()
                            }else{
                                //setCurrentHouseIndex(item)
                                //log.lv('House Botón Derecho.')
                            }
                            //log.lv('r.currentHouse: '+r.currentHouse)
                        }
//                        onDoubleClicked: {
//                            log.lv('House: '+item.ih)
//                            //saveZoomAndPosHouse(house)
//                        }
                        /*Rectangle{
                            anchors.fill: parent
                            color: 'red'
                            visible: parent.enabled
                        }*/
                    }
                }

                Text{
                    text:'<b>'+item.wg+'</b>'
                    font.pixelSize: 20
                    color: 'red'
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    visible: false
                }
            }
            Rectangle{
                id: centro
                width: zm.objAspsCircle.width
                height: width
                color: '#333'
                radius: width*0.5
                border.width: 1
                border.color: apps.fontColor
                anchors.centerIn: parent
                opacity: 0.0
            }
            Rectangle{
                id: ec
                width: r.width+app.fs//*2
                height: xEjeTipo1.visible?3:0
                color: apps.fontColor//'yellow'//'transparent'
                //anchors.centerIn: r
                rotation: 0-item.wg/2
                //visible:c>5
                visible:zm.ejeTipoCurrentIndex!==-2 && (zm.ejeTipoCurrentIndex===item.ih-1 || zm.ejeTipoCurrentIndex===item.ih-1-6 || zm.ejeTipoCurrentIndex===-1)
                //visible:item.ih===1
                anchors.centerIn: parent

                property int fs: app.fs*0.75
                property color c1: toogleColor?apps.fontColor:apps.backgroundColor
                property color c2: !toogleColor?apps.fontColor:apps.backgroundColor
                property bool selected: false
                property bool toogleColor: false
                Timer{
                    running: parent.visible && zm.ejeTipoCurrentIndex>=-1 && ec.selected
                    repeat: true
                    interval: 500
                    onTriggered: {
                        ec.toogleColor=!ec.toogleColor
                    }
                }
                Rectangle{
                    id: xEjeTipo1
                    //width: txtTipoEje1.contentWidth+app.fs//*0.5
                    width: txtTipoEje1.rotation===0?txtTipoEje1.contentWidth+app.fs:txtTipoEje11.contentWidth+app.fs//*0.5
                    height: colTxt1.height+app.fs*0.25
                    color: parent.c1
                    border.color: apps.fontColor
                    border.width: 3
                    radius: app.fs*0.25
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 0-width//-app.fs
                    clip: true
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            ec.selected=!ec.selected
                            ec.toogleColor=false
                        }
                    }
                    Column{
                        id: colTxt1
                        spacing: app.fs*0.1
                        anchors.centerIn: parent
                        rotation: item.ih>3 && item.ih<10?180:0
                        Text{
                            id: txtTipoEje1
                            text: rotation===0?r.aTipoEjes[item.ih - 1]:r.aTipoEjesCasas[item.ih - 1]
                            //text: item.ih<=6?r.aTipoEjes[item.ih - 1]:'Casas '+parseInt(item.ih - 1)+' y '+parseInt(item.ih + 6)
                            color: ec.c2
                            font.pixelSize: ec.fs
                            horizontalAlignment: Text.AlignHCenter
                            //rotation: item.ih===4 || item.ih===3 || item.ih===2?180:0
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            id: txtTipoEje11
                            //text: 'Casas '+parseInt(r.c + 1)+' y '+parseInt(r.c + 7)
                            text: rotation===180?r.aTipoEjes[item.ih - 1]:r.aTipoEjesCasas[item.ih - 1]
                            color: ec.c2
                            font.pixelSize: ec.fs;
                            horizontalAlignment: Text.AlignHCenter
                            textFormat: Text.RichText
                            //rotation: item.ih===4 || item.ih===3 || item.ih===2?180:0
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }



                Rectangle{
                    visible: false
                    width: zm.fs
                    height: width
                    //x:(r.w-width)/2
                    border.width: 2
                    border.color: 'white'
                    radius: width*0.5
                    color: 'red'//r.colors[r.c]
                    anchors.verticalCenter: parent.verticalCenter
                    rotation: 90-r.rotation-parent.rotation
                    antialiasing: true
                    ZoolText {
                        text: '<b>'+parseFloat(r.wg).toFixed(2)+'</b>'
                        font.pixelSize: parent.width*0.3
                        anchors.centerIn: parent
                        color: 'white'
                        rotation: 270+ec.rotation
                    }
                }
            }
        }
    }
    //Probando/Visualizando rotación
    //    Rectangle{
    //        width: r.width
    //        height: 2
    //        anchors.centerIn: parent
    //        color: '#ff8833'
    //    }



    Text{
        text: 'RHC:'+r.rotation
        font.pixelSize: 40
        color: 'blue'
        //x: 300
        visible: false
    }
    function loadHouses(jsonData) {
        var i=0
        //xArcsBack.rotation=360-jsonData.ph.h1.gdec+signCircle.rot//+1
        //log.lv('jsonData.ph.h1: '+JSON.stringify(jsonData.ph.h1))
        dha.rotation=0
        for(i=0;i<dha.children.length;i++){
            dha.children[i].destroy(0)
        }
        for(i=0;i<12;i++){
            if(i===0){
                zm.uAscDegreeTotal=jsonData.ph.h1.gdec
            }
            let wg=0.05
            let g1=0
            let g2=0
            if(i!==11){
                g1=360-jsonData.ph['h'+parseInt(i + 1)].gdec
                g2=360-jsonData.ph['h'+parseInt(i + 2)].gdec
                wg=g1-g2
            }else{
                g1=360-jsonData.ph['h'+parseInt(i + 1)].gdec
                g2=360-jsonData.ph['h'+parseInt(0 + 1)].gdec
                wg=g1-g2
            }
            if(wg<0){
                wg=wg+360
            }
            let comp=compArc.createObject(dha, {rotation: 360-jsonData.ph['h'+parseInt(i + 1)].gdec+zm.objSignsCircle.rot, ih: i+1, wg: wg, is: jsonData.ph['h'+parseInt(i + 1)].is, rsdeg:jsonData.ph['h'+parseInt(i + 1)].rsdeg, gdec:jsonData.ph['h'+parseInt(i + 1)].gdec, gdeg:jsonData.ph['h'+parseInt(i + 1)].gdeg, mdeg: jsonData.ph['h'+parseInt(i + 1)].mdeg, sdeg: jsonData.ph['h'+parseInt(i + 1)].sdeg, z:100+i})
        }
        if(app.t==='dirprim'){
            //xArcsBack.rotation-=sweg.dirPrimRot
            dha.rotation-=zm.dirPrimRot
        }
    }

    function getHousePos(g, rot, ip, defaultRet){
        let rotDiff=360-rot
        let initdeg=0-rotDiff
        var findeg
        if(initdeg+180<g){
            initdeg+=360
        }
        for(var i=0;i<12;i++){
            findeg=initdeg+housesCircle.aWs[i]//-rotDiff
            if(g>initdeg&&g<findeg){
                return i + 1
            }
            initdeg+=housesCircle.aWs[i]
        }
        initdeg=0-rotDiff
        for(i=0;i<12;i++){
            findeg=initdeg+housesCircle.aWs[i]
            if(g>initdeg&&g<findeg){
                return i + 1
            }
            initdeg+=housesCircle.aWs[i]
        }
        return defaultRet
    }
    function reloadHousesColors() {
        for(i=0;i<12;i++){
            let h=dha.children[i]
            h.colors=['red','red','red','red','red','red','red','red','red','red','red','red']
        }
    }
    function setCurrentHouseIndex(item){
        if(!r.isBack){
            if(zm.currentHouseIndex!==item.ih){
                zm.currentHouseIndex=item.ih
                r.currentHouse=zm.currentHouseIndex
            }else{
                zm.currentHouseIndex=-1
                r.currentHouse=zm.currentHouseIndex
            }
        }else{
            if(zm.currentHouseIndexBack!==item.ih){
                //sweg.objHousesCircleBack.currentIndex=item.ih-1
                zm.currentHouseIndexBack=item.ih
                r.currentHouse=zm.currentHouseIndexBack
            }else{
                zm.currentHouseIndexBack=-1
                r.currentHouse=zm.currentHouseIndexBack
            }
        }
        //log.lv('House: '+item.ih)
        //zm.saveZoomAndPosHouse(item.ih)
    }
}
