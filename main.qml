/*
Los únicos unik.getPath(x) que funcionaron para leer los archivos de raiz de todo el código son los siguientes:
unik.getPath(1)
unik.getPath(4)
unik.getPath(5)
Atención: Para leer por ejemplo uVersionZooland.txt que está en la raiz solo hizo falta
unik.getPath('./uVersionZooland.txt')
*/

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.0
import QtMultimedia 5.12

import unik.Unik 1.0


import "./comps" as Comps

import unik.Unik 1.0
import ZoolMainWindow 1.0
import comps.ZoolAppSettings 1.0
import ZoolandVars 1.0

//Objetos GUI
import ZoolDataView 1.1
import ZoolandBodies 1.1
//import ZoolandMap 1.0
//import ZoolandFileDataManager 1.0
import ZoolandDataBodies 1.0
import ZoolSectionsManager 1.1
import ZoolBottomToolBar 1.0
import ZoolFileMaker 1.5
import comps.ZoolUserCoordsEditor 1.0
import comps.ZoolMando 1.0

//Comps GUI
import comps.ZRect 1.0
import comps.ZoolPanelNotifications 1.0
import ZoolLogView 1.0

//Elementos
import web.ZoolandServerFileDataManager 1.0

ZoolMainWindow{
    id: app
    visible: true
    visibility: "Maximized"
    //width: Qt.platform.os==='android'?1920:Screen.width
    //height: Qt.platform.os==='android'?1080:Screen.height
    width: Screen.width
    height: Screen.height
    title: 'Zooland'

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
    ZoolandVars{id: vars}

    Item{
        id: xApp
        width: app.width-vars.xAppMargin*2
        height: app.height-vars.xAppMargin*2
        anchors.centerIn: parent
        Column{
            width: parent.width
            ZoolDataView{id: zoolDataView}
            Row{
                height: xApp.height-zoolDataView.height
                ZRect{
                    id: xLatIzq
                    //width: vars.ci.objectName==='fileMaker'?xApp.width+vars.xAppMargin*2:xApp.width*0.2
                    width:vars.ci.objectName==='zm'?0:xApp.width*0.2
                    height: parent.height
                    ZoolSectionsManager{id: zsm}
                }
                ZRect{
                    id: xMed
                    width: vars.ci.objectName==='zm'?xApp.width:xApp.width*0.6
                    height: parent.height
                    clip: true
                    ZoolandBodies{id: sweg}
//                    ZoolandMap{
//                        id: zoolMap
//                        width: height
//                        height: parent.height
//                    }
                    ZoolMando{
                        id: zm
                        objectName: 'zm'
                        width: vars.fs*4
                        height: width
                        num:0
                        c: 'red'
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        visible: vars.ci===zm
                        op: 0.75
                        onEnter:sweg.toEnter()
                        onUp:sweg.toUp()
                        onDown:sweg.toDown()
                        onLeft:sweg.toLeft()
                        onRight:sweg.toRight()
                        property var uCi
                        property color txtColor: 'red'
                        onVisibleChanged: {
                            if(visible){
                                uCi=app.ci
                                //vars.ci=xApp
                                //sweg.mm=0
                            }else{
                                //vars.ci=uCi
                            }
                        }
                        Text{
                            text: '<b>'+parseInt(sweg.mm + 1)+'</b>'
                            font.pixelSize:vars.fs*0.7
                            color: zm.txtColor//apps.fontColor
                            anchors.centerIn: parent
                        }
                        Text{
                            text: '<b>'+sweg.mmEdadRs+'</b>'
                            font.pixelSize:vars.fs*0.7
                            color: apps.fontColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: sweg.mm===5
                        }
                        Text{
                            text: sweg.currentPlanetIndex>=0?'<b>'+vars.aBodies[sweg.currentPlanetIndex]+'</b>':''
                            font.pixelSize:vars.fs*0.7
                            color: apps.backgroundColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                            visible: sweg.mm===0
                            Rectangle{
                                width: parent.width+10
                                height: parent.height+10
                                color: apps.fontColor
                                border.color: apps.backgroundColor
                                border.width: 1
                                radius: 8
                                z: parent.z-1
                                anchors.centerIn: parent
                                visible: parent.text!==''
                            }
                        }
                    }
                }
                ZRect{
                    id: xLatDer
                    width: xApp.width*0.2
                    height: parent.height
                    clip:true
                    visible: vars.ci.objectName!=='zm'
                    ZoolandDataBodies{id: zdb}
                    ZoolPanelNotifications{
                        id: zpn
                        parent:vars.ci.objectName==='zm'?xMed:xLatDer
                    }

                }
            }
        }
        Item{
            id: senMano
            width: 10
            height: 10
            visible: sweg.mm===1
            rotation: x<parent.width*0.5?0:180
            Behavior on rotation{NumberAnimation{duration: 500; easing.type: Easing.InOutQuad}}
            onVisibleChanged: {
                x=parent.width*0.5
                y=parent.height*0.5
            }
            //anchors.centerIn: parent
            Image {
                id: imgMano
                source: "./resources/imgs/mano_1.png"
                width: vars.fs*30
                fillMode: Image.PreserveAspectFit
                x: 0-width+(width*0.12)
                y: 0-(height*0.28)
                //rotation: parent.x<parent.parent.width*0.5+width*0.1?0:180
            }
            //                        Rectangle{
            //                            width: 10
            //                            height: 10
            //                            anchors.centerIn: parent
            //                            color: 'red'
            //                        }
        }
        //ZoolUserManager{id: zoolUserManager}
        ZoolUserCoordsEditor{id: zuce}
        ZoolBottomToolBar{id: zbtb}
        ZoolFileMaker{id: zoolFileMaker}
        //ZoolandFileDataManager{id: zfdm}
        ZoolLogView{id: log}
    }
    ZoolandServerFileDataManager{id: zsfdm}
    Timer{
        id: tIsDoubleEnter
        running: false
        repeat: false
        interval: 1500
        onTriggered: {
            //zm.visible=!zm.visible
        }
    }
    Rectangle{
        id: xCartelInicio
        anchors.fill: parent
        color: 'black'
        Column{
            spacing: 4
            anchors.centerIn: parent
            Text{
                id: zvtxt
                text: 'Iniciando...'
                font.pixelSize: 50
                color: 'white'
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text{
                id: zvtxt2
                text: 'Creado por Ricardo Martín Pizarro'
                font.pixelSize: 25
                color: 'white'
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Timer{
            running: true
            repeat: false
            interval: Qt.platform.os==='linux'?5000:5000
            onTriggered: parent.visible=false
        }
    }
    Component.onCompleted: {
        //Set version number.
        let uVersionFolderPath='/home/ns/nsp/zooland'
        let uVersionFilePath='/home/ns/nsp/zooland-release/uVersionZooland.txt'
        if(unik.folderExist(uVersionFolderPath)){
            let fd=unik.getFile(uVersionFilePath)
            let unv=fd!=='error'?parseInt(fd):'1000'
            let nnv=unv + 1
            unik.setFile(uVersionFilePath, nnv)
            zvtxt.text='Zooland Versión 1.'+nnv+''
        }else{
            let str=''
            let uVersionFilePath='./uVersionZooland.txt'
            let fd=unik.getFile(uVersionFilePath)
            let unv=fd!=='error'?parseInt(fd):'????'
            str+='Zooland Versión 1.'+unv+''
            //str+='Creado por Ricardo Martín Pizarro\n'
            zvtxt.text=str
        }


        //Add to aCi Tab Keyboard
        vars.aCi.push(zsm.getPanel('ZoolRemoteParamsList'))
        vars.aCi.push(zdb)
        //Add to aCiCtrl  Ctrl+Tab Keyboard
        vars.aCiCtrl.push(zoolFileMaker)

        unik.clearDir(unik.getPath(2))
        if(Qt.application.arguments.indexOf('-dev')>=0)vars.dev=true
        zpn.addNot(unik.getFile('ucommit.txt'), true, 15000)
        let sw=Screen.width
        let sh=Screen.height
        vars.res=''+sw+'x'+sh+''
        zpn.addNot('Resolución de pantalla: '+sw+'x'+sh, true, 10000)
        zpn.addNot('Usuario: '+apps.zoolUser, true, 10000)

        if(sw===960 && sh===540){
            //Resolución 960x540 de ChromeCast HD
            zpn.addNot('Ejecutando en ChromeCast', true, 10000)
            sweg.width=vars.fs*24
            sweg.w=vars.fs
            sweg.pz=38

        }else{
            //Esta configuracion va bien 1920x1080
            zpn.addNot('Ejecutando fuera de ChromeCast', true, 10000)
            sweg.width=vars.fs*46
            sweg.w=vars.fs*1.5
            sweg.pz=60
        }
        //log.lv('Iniciado')
    }
}
