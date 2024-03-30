import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.12
import "../../js/Funcs.js" as JS

import ZoolandDataBodies.ZoolDataBodiesItem 1.0

Rectangle {
    id: r
    objectName: 'zdb'
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
    //Behavior on x{NumberAnimation{duration: vars.msDesDuration}}
    Row{
        width: parent.width-r.border.width*2
        anchors.horizontalCenter: parent.horizontalCenter
        ZoolDataBodiesItem{id: xBodiesInt; isBack: false; isLatFocus: r.latFocus===0}
        ZoolDataBodiesItem{id: xBodiesExt; isBack: true; isLatFocus: r.latFocus===1}
    }
    Rectangle{
        width: labelCargando.contentWidth+vars.fs*0.25
        height: labelCargando.contentHeight+vars.fs*0.25
        radius: vars.fs*0.25
        border.width: 2
        border.color: apps.fontColor
        color: apps.backgroundColor
        opacity: !vars.ev?(xBodiesInt.opacity===1.0?0.0:1.0):(xBodiesInt.opacity===1.0&&xBodiesExt.opacity===1.0?0.0:1.0)
        anchors.centerIn: parent
        Text{
            id: labelCargando
            text: 'Cargando'
            font.pixelSize: vars.fs
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
            running: vars.ci===r
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
        if(zdb.latFocus===0){
            if(currentIndex>-1){
                currentIndex--
            }else{
                currentIndex=21
            }
        }
        if(zdb.latFocus===1){
            if(currentIndexBack>-1){
                currentIndexBack--
            }else{
                currentIndexBack=21
            }
        }
    }
    function toDown(){
        if(zdb.latFocus===0){
            if(currentIndex<21){
                currentIndex++
            }else{
                currentIndex=-1
            }
        }
        if(zdb.latFocus===1){
            if(currentIndexBack<16){
                currentIndexBack++
            }else{
                currentIndexBack=-1
            }
        }
    }
    function toEnter(){
        //zpn.addNot('xBodiesInt.currentIndex: '+xBodiesInt.currentIndex, false, 0)
        if(latFocus===0){
            if(currentIndex===-1){
                sweg.currentPlanetIndex=-1
                sweg.currentHouseIndex=-1
                sweg.centerZoomAndPos()
                return
            }
            if(xBodiesInt.currentIndex>21){
                sweg.currentHouseIndex=xBodiesInt.currentIndex-16
            }else{
                if(sweg.currentPlanetIndex!==xBodiesInt.currentIndex){
                    sweg.currentPlanetIndex=xBodiesInt.currentIndex
                    let ih=xBodiesInt.listModel.get(xBodiesInt.currentIndex).ih
                    //zpn.addNot('iii: '+ih)
                    sweg.currentHouseIndex=ih
                }else{
                    sweg.currentPlanetIndex=-1
                    sweg.currentHouseIndex=-1
                }
            }
        }else{
            if(xBodiesExt.currentIndex>21){
                sweg.currentHouseIndex=xBodiesExt.currentIndex-16
            }else{
                if(sweg.currentPlanetIndexBack!==xBodiesExt.currentIndex){
                    sweg.currentPlanetIndexBack=xBodiesExt.currentIndex
                }else{
                    sweg.currentPlanetIndexBack=-1
                    sweg.currentHouseIndexBack=-1
                }
            }
        }
        //zpn.addNot('NHI: '+sweg.currentHouseIndex, false, 0)
        //zpn.addNot('NHIB: '+sweg.currentHouseIndexBack, false, 0)
    }
}
