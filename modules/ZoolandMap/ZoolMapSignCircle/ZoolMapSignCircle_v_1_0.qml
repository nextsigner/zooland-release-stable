import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: r
    height: width
    anchors.centerIn: parent
    property int f: 0
    property int w: zm.zodiacBandWidth
    //property bool v: sweg.v
    property bool showBorder: false
    property bool showDec: apps.showDec
    property int rot: 0
    property bool showCenterSignPoint: false
    Repeater{
        model: apps.enableWheelAspCircle?36:0
        Item{
            width: r.width
            height: 1
            anchors.centerIn: parent
            rotation: 10*index
            MouseArea {
                id: maw
                width: r.w
                height: r.w*2
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin:  0-sweg.fs*0.05
                onClicked: r.v=!r.v
                property int m:0
                property date uDate//: app.currentDate
                property int f: 0
                property int uY: 0
                cursorShape: Qt.SizeVerCursor
                onWheel: {
                    let i=1
                    if (wheel.modifiers & Qt.ControlModifier) {
                        i=60
                    }
                    if (wheel.modifiers & Qt.ShiftModifier) {
                        i=60*24
                    }
                    if(wheel.angleDelta.y===120){
                        rotar(0,i)
                    }else{
                        rotar(1,i)
                    }
                    uY=wheel.angleDelta.y
                }
                //                Rectangle{
                //                    anchors.fill: parent
                //                    border.width: 1
                //                    border.color: 'red'
                //                }
            }
        }
    }
    Image{
        id: signs
        anchors.fill: r
        source: './signCircle.png'
        anchors.centerIn: parent
        visible: false
    }
    Image{
        id: signsDec
        anchors.fill: r
        source: './signCircleDec.png'
        anchors.centerIn: parent
        visible: false
    }

    Rectangle{
        id: mask
        width: r.width//*0.5
        height: width
        anchors.centerIn: r
        color: 'transparent'
        visible: false
        Rectangle{
            width: parent.width
            height: width
            border.width: !app.ev?r.w:r.w*0.5
            color: 'transparent'
            radius: width*0.5
            anchors.centerIn: parent
            //color: 'red'
        }
    }
    Rectangle{
        id: maskDec
        width: r.width//*0.5
        height: width
        anchors.centerIn: r
        color: 'transparent'
        visible: false
        Rectangle{
            width: parent.width
            height: width
            border.width: !app.ev?r.w:r.w*0.5
            color: 'transparent'
            radius: width*0.5
            anchors.centerIn: parent
            //color: 'red'
        }
    }
    OpacityMask {
        id: oMSignCircle
        anchors.fill: r
        source: signs
        maskSource: mask
        invert: false
        rotation: r.rot+36
        //visible: false
    }
    OpacityMask {
        id: oMSignCircleDec
        //anchors.fill: r
        width: r.width-r.w*2
        height: width
        anchors.centerIn: parent
        source: signsDec
        maskSource: maskDec
        rotation: oMSignCircle.rotation-3
        invert: false
        visible: r.showDec
    }
    Rectangle{
        id: borde1
        anchors.fill: parent
        color: 'transparent'
        border.width: 2
        border.color: apps.fontColor
        radius: width*0.5
    }
    Rectangle{
        id: borde2
        width: !app.ev?r.width-r.w*2:(r.width-r.w)
        height: width
        color: 'transparent'
        border.width: borde1.border.width
        border.color: apps.fontColor
        radius: width*0.5
        anchors.centerIn: parent
        //visible: false
    }
    Item{
        rotation: r.rot
        anchors.fill: parent
        Repeater{
            model: 12
            Rectangle{
                width: r.width
                height: 1
                color: 'transparent'
                rotation: 0-(index*30)-14.95
                anchors.centerIn: parent
                Image {
                    id: iconoSigno
                    source: "../../../resources/imgs/signos/"+index+".svg"
                    width: !app.ev?r.w*0.8:r.w*0.4
                    height: width
                    //rotation: 360-parent.parent.rotation+parent.rotation//+30
                    rotation: 360-r.rot-parent.rotation
                    antialiasing: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: r.w*0.1
                    Rectangle{
                        width: 3
                        height: width
                        anchors.centerIn: parent
                        visible: r.showCenterSignPoint
                    }
                }

            }
        }
    }
    Item{
        rotation: r.rot
        anchors.fill: parent
        visible: r.showDec
        Repeater{
            model: r.showDec?12:0
            Rectangle{
                width: r.width-r.w*2
                height: 1
                color: 'transparent'
                rotation: 0-(index*10)-4.95
                anchors.centerIn: parent
                Image {
                    id: iconoSignoDec
                    source: "../../../resources/imgs/signos/"+index+".svg"
                    width: !app.ev?r.w*0.8:r.w*0.4
                    height: width
                    rotation: 360-r.rot-parent.rotation
                    antialiasing: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: !app.ev?r.w*0.1:r.w*0.3
                    Rectangle{
                        width: 3
                        height: width
                        anchors.centerIn: parent
                        visible: r.showCenterSignPoint
                    }
                }
            }
        }
    }
    Item{
        rotation: r.rot
        anchors.fill: parent
        visible: r.showDec
        Repeater{
            model: r.showDec?12:0
            Rectangle{
                width: r.width-r.w*2
                height: 1
                color: 'transparent'
                rotation: 0-(index*10)-4.95-120
                anchors.centerIn: parent
                Image {
                    id: iconoSignoDec24
                    source: "../../../resources/imgs/signos/"+index+".svg"
                    width: !app.ev?r.w*0.8:r.w*0.4
                    height: width
                    rotation: 360-r.rot-parent.rotation
                    antialiasing: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: !app.ev?r.w*0.1:r.w*0.3
                    Rectangle{
                        width: 3
                        height: width
                        anchors.centerIn: parent
                        visible: r.showCenterSignPoint
                    }
                }
            }
        }
    }
    Item{
        rotation: r.rot
        anchors.fill: parent
        visible: r.showDec
        Repeater{
            model: r.showDec?12:0
            Rectangle{
                width: r.width-r.w*2
                height: 1
                color: 'transparent'
                rotation: 0-(index*10)-4.95-120-120
                anchors.centerIn: parent
                Image {
                    id: iconoSignoDec36
                    source: "../../../resources/imgs/signos/"+index+".svg"
                    width: !app.ev?r.w*0.8:r.w*0.4
                    height: width
                    rotation: 360-r.rot-parent.rotation
                    antialiasing: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: !app.ev?r.w*0.1:r.w*0.3
                    Rectangle{
                        width: 3
                        height: width
                        anchors.centerIn: parent
                        visible: r.showCenterSignPoint
                    }
                }
            }
        }
    }

    function subir(){
        rotar(1,1)
    }
    function bajar(){
        rotar(0,1)
    }
    function rotar(s,i){
        let grado=0
        let currentDate=zm.currentDate
        if(s===0){
            currentDate.setMinutes(currentDate.getMinutes() + i)
        }else{
            currentDate.setMinutes(currentDate.getMinutes() - i)
        }
        zm.currentDate=currentDate
    }
    function rotarSegundos(s){
        let currentDate=zm.currentDate
        if(s===0){
            currentDate.setSeconds(currentDate.getSeconds() + 10)
        }else{
            currentDate.setSeconds(currentDate.getSeconds() - 10)
        }
        zm.currentDate=currentDate
    }
}
