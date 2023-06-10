import QtQuick 2.12
import QtGraphicalEffects 1.12

Rectangle {
    id: r
    //width: sweg.width
    //height: width
    radius: width*0.5
    //rotation: -90-30
    //color:'blue'
    color:'transparent'
    clip: true
    property var aColors: ['red', 'blue', 'yellow', 'green', 'gray', 'pink', 'white', '#ff88330', '#88ff33', '#8833ff', '#008833', '#88aa33']
    property int gr: 0
    property int n: -1
    property int w: signCircle.w
    property int c: 0
    visible: c===0
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
            rotation: 0
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
            rotation: r.gr
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
        color: 'red'//r.aColors[r.c]
        visible: false
        anchors.centerIn: bug
    }

    OpacityMask {
        anchors.fill: bug
        source: mask
        maskSource: bug
        invert: true
        rotation: -90
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
    Rectangle{
        width: r.width//-((r.w-xImg.width)/2)
        height: 8
        anchors.centerIn: r
        color: 'transparent'//'blue'
        rotation: 15
        antialiasing: true
        Rectangle{
            id: xImg
            //width: apps.signCircleWidth*0.8//signCircle.w*0.5
            width: r.w*0.8
            height: width
            //border.width: 10
            //border.color: 'red'
            color: 'transparent'
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: !app.ev?0-(xImg.width-apps.signCircleWidth)*0.5:0-(xImg.width-apps.signCircleWidth*0.5)*0.5
            //x:(0-xImg.width*0.5)+apps.signCircleWidth*0.5
            //x:((r.w-xImg.width)/4)
            //x:(apps.signCircleWidth-xImg.width)/4
            //x:100
            rotation: 0-r.rotation-15-r.gr//-90
            antialiasing: true
            property bool resaltado: false//panelDataBodies.currentIndexSign === r.n - 1
            //onWidthChanged: canvas.requestPaint()
            MouseArea{
                anchors.fill: parent
                onClicked: parent.resaltado=!parent.resaltado
            }
            Rectangle{
                width: xImg.width*3
                height: width
                radius: width*0.5
                border.width: 4
                border.color: 'blue'//app.signColors[r.c]
                anchors.centerIn: parent
                z: parent.z-1
                opacity: xImg.resaltado?1.0:0.0
                Behavior on opacity{
                    NumberAnimation{duration: 350}
                }
                Rectangle{
                    anchors.fill: parent
                    color: '#ff8833'//app.signColors[c]
                    radius: width*0.5
                    opacity: 0.35
                }
            }
        }
    }


}
