import QtQuick 2.12
import QtGraphicalEffects 1.12

Rectangle {
    id: r
    width: sweg.width
    height: width
    radius: width*0.5
    //color:'blue'
    color:'transparent'
    clip: true
    property int w: 50
    Rectangle{

        id: bug
        width: r.width//*0.5
        height: r.height//*0.5
        //color: 'yellow'
        radius: width*0.5
        color: 'transparent'
        //border.width: 10
        border.color: '#ff5833'
        clip: true
        visible: false
        Rectangle{
            id: tb
            //width: parent.width+border.width
            //height: parent.height+border.width
            width: r.width+border.width*2
            height: r.height+border.width*2
            color: 'transparent'
            radius: width*0.5
            border.width:r.width*0.5
            anchors.centerIn: parent
        }
        Rectangle{
            id: vacioCentral
            width: r.width-r.w*2
            height: width
            color: 'blue'
            radius: width*0.5
            anchors.centerIn: parent
        }
        Item{
            id: e1
            width: parent.width
            height: 1
            rotation: 15
            anchors.centerIn: parent
            Rectangle{
                width: parent.parent.width
                height: parent.parent.height
                color: 'pink'
                anchors.left: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Item{
            id: e2
            width: parent.width
            height: 1
            rotation: -15
            anchors.centerIn: parent
            Rectangle{
                width: parent.parent.width
                height: parent.parent.height
                color: 'pink'
                anchors.right: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

    }


    Rectangle{
        id: mask
        width: r.width
        height: r.height
        color: 'red'
        visible: false
        anchors.centerIn: bug
    }

    OpacityMask {
        anchors.fill: bug
        source: mask
        maskSource: bug
        invert: true
    }
    Rectangle{
        id: ctb
        width: tb.width
        height: tb.height
        color: 'transparent'
        radius: width*0.5
        border.width:r.width*0.5
        border.color: 'pink'
        anchors.centerIn: bug
        visible: false
    }
}
