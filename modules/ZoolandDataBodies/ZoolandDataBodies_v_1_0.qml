import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.12
import "../../js/Funcs.js" as JS

import ZoolandDataBodies.ZoolDataBodiesItem 1.0

Rectangle {
    id: r
    objectName: 'zoolDataBodies'
    width: parent.width
    height: parent.height
    anchors.bottom: parent.bottom
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    state: 'show'
    property var uJson
    property int latFocus: 0
    property int currentIndex: -1
    property int currentIndexBack: -1
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: r
                x:r.parent.width-r.width
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                x:r.parent.width
            }
        }
    ]
    Behavior on x{NumberAnimation{duration: app.msDesDuration}}
    Row{
        width: parent.width-r.border.width*2
        anchors.horizontalCenter: parent.horizontalCenter
        ZoolDataBodiesItem{id: xBodiesInt; isBack: false; isLatFocus: r.latFocus===0}
        ZoolDataBodiesItem{id: xBodiesExt; isBack: true; isLatFocus: r.latFocus===1}
    }
    Rectangle{
        width: labelCargando.contentWidth+app.fs*0.25
        height: labelCargando.contentHeight+app.fs*0.25
        radius: app.fs*0.25
        border.width: 2
        border.color: apps.fontColor
        color: apps.backgroundColor
        opacity: !app.ev?(xBodiesInt.opacity===1.0?0.0:1.0):(xBodiesInt.opacity===1.0&&xBodiesExt.opacity===1.0?0.0:1.0)
        anchors.centerIn: parent
        Text{
            id: labelCargando
            text: 'Cargando'
            font.pixelSize: app.fs
            color: apps.fontColor
            anchors.centerIn: parent
        }
    }
    Rectangle{
        anchors.fill: parent
        color: 'transparent'
        border.width: 2
        border.color: 'red'
        visible: false
        Timer{
            running: app.ci===r
            repeat: true
            interval: 500
            onTriggered: parent.visible=!parent.visible
        }
    }
    function loadJson(json){
        r.latFocus=0
        xBodiesInt.loadJson(json)
        //zoolMediaLive.loadJson(json)
    }
    function loadJsonBack(json){
        xBodiesExt.loadJson(json)
    }
    function toUp(){
        if(zoolDataBodies.latFocus===0){
            if(currentIndex>-1){
                currentIndex--
            }else{
                currentIndex=21
            }
        }
        if(zoolDataBodies.latFocus===1){
            if(currentIndexBack>-1){
                currentIndexBack--
            }else{
                currentIndexBack=21
            }
        }
    }
    function toDown(){
        if(zoolDataBodies.latFocus===0){
            if(currentIndex<16){
                currentIndex++
            }else{
                currentIndex=-1
            }
        }
        if(zoolDataBodies.latFocus===1){
            if(currentIndexBack<16){
                currentIndexBack++
            }else{
                currentIndexBack=-1
            }
        }
    }
    function toEnter(){
        if(latFocus===0){
            if(xBodiesInt.currentIndex>16){
                sweg.objHousesCircle.currentHouse=xBodiesInt.currentIndex-16
            }else{
                if(app.currentPlanetIndex!==xBodiesInt.currentIndex){
                    app.currentPlanetIndex=xBodiesInt.currentIndex
                }else{
                    app.currentPlanetIndex=-1
                    sweg.objHousesCircle.currentHouse=-1
                }
            }
        }else{
            if(xBodiesExt.currentIndex>16){
                sweg.objHousesCircle.currentHouse=xBodiesExt.currentIndex-16
            }else{
                if(app.currentPlanetIndexBack!==xBodiesExt.currentIndex){
                    app.currentPlanetIndexBack=xBodiesExt.currentIndex
                }else{
                    app.currentPlanetIndexBack=-1
                    sweg.objHousesCircleBack.currentHouse=-1
                }
            }
        }


    }
}
