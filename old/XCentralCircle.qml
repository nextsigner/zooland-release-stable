import QtQuick 2.0
import QtGraphicalEffects 1.12

Item {
    id: r
    anchors.fill: parent
    property alias rectCentral: circ2
    Rectangle{
        id: bg
        width: parent.width*2
        height: parent.height
        color: 'black'
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false

    }
    Rectangle{
        id: circ
        width: xApp.width
        height: xApp.height
        color: 'transparent'
        visible: false
        Rectangle{
            id: circ2
            width: app.width*0.18
            height: width*1.2//app.height*0.35
            anchors.centerIn: parent
            //radius: width*0.5
            color: 'blue'
        }
    }
    OpacityMask {
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        source: bg
        maskSource: circ
        invert: true
    }
}
