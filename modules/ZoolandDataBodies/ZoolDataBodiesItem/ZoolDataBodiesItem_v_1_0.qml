import QtQuick 2.12
import QtQuick.Controls 2.0
//import "../js/Funcs.js" as JS

Column{
    id: r
    width: !app.ev?parent.width:parent.width*0.5
    opacity: 0.0
    property bool isBack: false
    property bool isLatFocus: false
    property int currentIndex: !isBack?zoolDataBodies.currentIndex:zoolDataBodies.currentIndexBack
    Behavior on opacity{NumberAnimation{id:numAn1;duration:10}}
    Rectangle{
        id: headerLv
        width: r.width
        height: app.fs*0.85
        color: r.isBack?apps.houseColorBack:apps.houseColor//apps.fontColor
        border.width: 1
        border.color: apps.fontColor
        Item{
            width: r.width
            height: txtTit.contentHeight
            anchors.centerIn: parent
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(!r.isBack){
                        zoolDataBodies.latFocus=0
                    }else{
                        zoolDataBodies.latFocus=1
                    }
                }
            }
            Text {
                id: txtTit
                text: 'Lista de Cuerpos'
                font.pixelSize: app.fs*0.4
                width: parent.width-app.fs*0.2
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                color: r.isBack?apps.xAsColorBack:apps.xAsColor
                anchors.centerIn: parent
            }
        }
    }
    ListView{
        id: lv
        spacing: app.fs*0.1
        width: r.width-app.fs*0.25//r.parent.width-r.border.width*2
        height: xLatDer.height-headerLv.height
        delegate: compItemList
        model: lm
        cacheBuffer: 60
        displayMarginBeginning: lv.height*2
        displayMarginEnd: lv.height*2
        clip: true
        ScrollBar.vertical: ScrollBar {}
        anchors.horizontalCenter: parent.horizontalCenter
    }
    ListModel{
        id: lm
        function addItem(indexSign, indexHouse, grado, minuto, segundo, stringData){
            return {
                is: indexSign,
                ih: indexHouse,
                gdeg:grado,
                mdeg: minuto,
                sdeg: segundo,
                sd: stringData
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: xItem
            width: lv.width
            height: !app.ev?
                        //Mostrando 1 columna de datos.
                        (index===zoolDataBodies.currentIndex?(colTxtSelected.height+app.fs*0.1):
                                                               (txtData.contentHeight+app.fs*0.1)):

                        //Mostrando 2 columas de Datos
                        (colTxtEV.height+app.fs*0.1)

            color: !r.isBack?(index===zoolDataBodies.currentIndex||(index>21&&sweg.objHousesCircle.currentHouse===index-21)?apps.fontColor:apps.backgroundColor):(index===zoolDataBodies.currentIndexBack||(index>21&&sweg.objHousesCircleBack.currentHouse===index-21)?apps.fontColor:apps.backgroundColor)
            border.width: 1
            border.color: !r.isBack?apps.houseColor:apps.houseColorBack
            visible: !app.ev?txtData.width<xItem.width:true
            //anchors.horizontalCenter: parent.horizontalCenter
            Behavior on opacity{NumberAnimation{duration: 250}}
            property bool textSized: false
            onTextSizedChanged: {}
            Rectangle{
                anchors.fill: parent
                color: !r.isBack?apps.houseColor:apps.houseColorBack
                opacity: 0.5
            }
            Text {
                id: txtData
                //text: sd
                font.pixelSize: app.fs
                textFormat: Text.RichText
                color: !r.isBack?(index===zoolDataBodies.currentIndex||(index>21&&sweg.objHousesCircle.currentHouse===index-21)?apps.backgroundColor:apps.fontColor):(index===zoolDataBodies.currentIndexBack||(index>21&&sweg.objHousesCircleBack.currentHouse===index-21)?apps.backgroundColor:apps.fontColor)
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                visible: !app.ev && index!==zoolDataBodies.currentIndex
                onVisibleChanged: {
                    if(!visible){
                        //font.pixelSize=app.fs
                    }
                }
                Timer{
                    running: parent.width>xItem.width-app.fs*0.1 && !app.ev
                    repeat: true
                    interval: 50
                    onTriggered: {
                        tShow.restart()
                        parent.font.pixelSize-=1
                    }
                }
            }
            Column{
                id: colTxtSelected
                anchors.centerIn: parent
                visible: !app.ev && index===zoolDataBodies.currentIndex
                Text {
                    id: txtDataSelected1
                    font.pixelSize: app.fs
                    textFormat: Text.RichText
                    color: !r.isBack?(index===zoolDataBodies.currentIndex||(index>21&&sweg.objHousesCircle.currentHouse===index-21)?apps.backgroundColor:apps.fontColor):(index===zoolDataBodies.currentIndexBack||(index>21&&sweg.objHousesCircleBack.currentHouse===index-21)?apps.backgroundColor:apps.fontColor)
                    horizontalAlignment: Text.AlignHCenter
                    //anchors.centerIn: parent
                    visible: !app.ev
                    Timer{
                        running: parent.width>xItem.width-app.fs*0.1 && !app.ev
                        repeat: true
                        interval: 50
                        onTriggered: {
                            tShow.restart()
                            parent.font.pixelSize-=1
                        }
                    }
                }
                Text {
                    id: txtDataSelected2
                    font.pixelSize: app.fs
                    textFormat: Text.RichText
                    color: !r.isBack?(index===zoolDataBodies.currentIndex||(index>21&&sweg.objHousesCircle.currentHouse===index-21)?apps.backgroundColor:apps.fontColor):(index===zoolDataBodies.currentIndexBack||(index>21&&sweg.objHousesCircleBack.currentHouse===index-21)?apps.backgroundColor:apps.fontColor)
                    horizontalAlignment: Text.AlignHCenter
                    //anchors.centerIn: parent
                    visible: !app.ev
                    Timer{
                        running: parent.width>xItem.width-app.fs*0.1 && !app.ev
                        repeat: true
                        interval: 50
                        onTriggered: {
                            tShow.restart()
                            parent.font.pixelSize-=1
                        }
                    }
                }
            }
            Column{
                id: colTxtEV
                anchors.centerIn: parent
                Text {
                    id: txtDataEV
                    font.pixelSize: app.fs//*0.4
                    textFormat: Text.RichText
                    color: !r.isBack?(index===zoolDataBodies.currentIndex||(index>21&&sweg.objHousesCircle.currentHouse===index-21)?apps.backgroundColor:apps.fontColor):(index===zoolDataBodies.currentIndexBack||(index>21&&sweg.objHousesCircleBack.currentHouse===index-21)?apps.backgroundColor:apps.fontColor)
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: app.ev
                    opacity: r.isLatFocus?1.0:0.65
                    Timer{
                        running: parent.contentWidth>xItem.width-app.fs*0.1 && app.ev
                        repeat: true
                        interval: 50
                        onTriggered: {
                            tShow.restart()
                            parent.font.pixelSize-=1
                        }
                    }
                }
                Text {
                    id: txtDataEV2
                    font.pixelSize: app.fs//*0.4
                    textFormat: Text.RichText
                    color: !r.isBack?(index===zoolDataBodies.currentIndex||(index>21&&sweg.objHousesCircle.currentHouse===index-21)?apps.backgroundColor:apps.fontColor):(index===zoolDataBodies.currentIndexBack||(index>21&&sweg.objHousesCircleBack.currentHouse===index-21)?apps.backgroundColor:apps.fontColor)
                    horizontalAlignment: Text.AlignHCenter
                    //anchors.centerIn: parent
                    visible: app.ev
                    opacity: r.isLatFocus?1.0:0.65
                    anchors.horizontalCenter: parent.horizontalCenter
                    Timer{
                        running: parent.contentWidth>xItem.width-app.fs*0.1 && app.ev
                        repeat: true
                        interval: 50
                        onTriggered: {
                            tShow.restart()
                            parent.font.pixelSize-=1
                        }
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (mouse.modifiers & Qt.ControlModifier) {
                        if(index<=21){
                            app.j.showIW()
                        }
                    }else{
                        if(index>21){
                            if(!r.isBack){
                                zoolDataBodies.latFocus=0
                                sweg.objHousesCircle.currentHouse=index-21
                            }else{
                                zoolDataBodies.latFocus=1
                                sweg.objHousesCircleBack.currentHouse=index-21
                            }
                        }else{
                            if(!r.isBack){
                                zoolDataBodies.latFocus=0
                                if(app.currentPlanetIndex!==index){
                                    app.currentPlanetIndex=index
                                    zoolDataBodies.currentIndex=index
                                }else{
                                    app.currentPlanetIndex=-1
                                    zoolDataBodies.currentIndex=-1
                                    sweg.objHousesCircle.currentHouse=-1
                                }
                            }else{
                                zoolDataBodies.latFocus=1
                                if(app.currentPlanetIndexBack!==index){
                                    app.currentPlanetIndexBack=index
                                    zoolDataBodies.currentIndexBack=index
                                }else{
                                    app.currentPlanetIndexBack=-1
                                    zoolDataBodies.currentIndexBack=-1
                                    sweg.objHousesCircleBack.currentHouse=-1
                                }
                            }
                        }
                        apps.zFocus='xLatDer'
                    }
                }
            }
            Component.onCompleted: {
                txtData.text=sd.replace(/ @ /g, ' ')
                let m0=sd.split(' @ ')
                txtDataEV.text=m0[0]//sd.replace(/ @ /g, '<br />')
                if(m0[1]){
                    txtDataEV2.text=m0[1]
                    txtDataSelected1.text=m0[0]
                    txtDataSelected2.text=m0[1]
                }else{
                    //log.ls('sd: '+sd, 0, 500)
                }

                //cantTextSized++
                //log.ls('cantTextSized: '+index, 0, 500)
                //                log.l('sd: '+sd)
                //                log.l('xItem.width: '+xItem.width)
                //                log.l('xItem.height: '+xItem.height)
                //                log.visible=true
            }
        }
    }
    Timer{
        id: tShow
        running: false
        repeat: false
        interval: 500
        onTriggered: {
            numAn1.duration=250
            r.opacity=1.0
        }
    }
    function loadJson(json){
        numAn1.duration=1
        r.opacity=0.0
        lm.clear()
        let jo
        let o
        var ih
        //for(var i=0;i<15;i++){
        for(var i=0;i<20;i++){
            //stringIndex='&index='+i
            jo=json.pc['c'+i]
            if(!r.isBack){
                ih=sweg.objHousesCircle.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)
            }else{
                ih=sweg.objHousesCircleBack.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)
            }
            var s = '<b>'+jo.nom+'</b> en <b>'+app.signos[jo.is]+'</b> @ <b>Grado:</b>°' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' <b>Casa:</b> ' +ih
            if(jo.retro===0&&i!==10&&i!==11)s+=' <b>R</b>'
            //console.log('--->'+s)
            lm.append(lm.addItem(jo.is, ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))


            //            if(i===0){
            //                houseSun=ih
            //            }
        }
        let o1=json.ph['h1']
        //s = 'Ascendente °' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' ' +app.signos[o1.is]
        s = '<b>Ascendente</b> en <b>'+app.signos[o1.is]+'</b> @ <b>Grado:</b>°' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' <b>Casa:</b> 1'
        lm.append(lm.addItem(o1.is, 1, o1.rsgdeg, o1.mdeg, o1.sdeg,  s))
        o1=json.ph['h10']
        //s = 'Medio Cielo °' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' ' +app.signos[o1.is]
        s = '<b>Medio Cielo</b> en <b>'+app.signos[o1.is]+'</b> @ <b>Grado:</b>°' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' <b>Casa:</b> 10'
        lm.append(lm.addItem(o1.is, 10, o1.rsgdeg, o1.mdeg, o1.sdeg, s))
        //log.ls('o1.is: '+o1.is, 0, 500)

        //Load Houses
        for(i=1;i<13;i++){
            jo=json.ph['h'+i]
            //s = 'Casa '+i+' °' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' ' +app.signos[jo.is]
            s = '<b>Casa</b> '+i+' en <b>'+app.signos[jo.is]+'</b> @ <b>Grado:</b>°' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ''
            lm.append(lm.addItem(jo.is, i, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
            //lm2.append(lm2.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
        }


        //Load Houses
        /*lm2.clear()
        for(i=1;i<13;i++){
            jo=json.ph['h'+i]
            s = 'Casa '+i+' °' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' ' +app.signos[jo.is]
            lm2.append(lm2.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
        }*/

        //if(app.mod!=='rs'&&app.mod!=='pl')r.state='show'
    }
}
