import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../"

Item {
    id: r
    property int gr: 0
    property int n: -1
    property int w: signCircle.w
    property int c: 0
    //property var colors: ['red', '#FBE103', '#09F4E2', '#0D9FD6']
    property bool showBorder: false
    //Behavior on w{NumberAnimation{duration: sweg.speedRotation}}
    state: sweg.state
    states: [
        State {
            name: sweg.aStates[0]
            PropertyChanges {
                target: r
                //w: sweg.fs*0.5
            }
            PropertyChanges {
                target: xImg
                //width: sweg.fs*0.5
            }
        },
        State {
            name: sweg.aStates[1]
            PropertyChanges {
                target: r
                //w: sweg.fs*0.5
            }
            PropertyChanges {
                target: xImg
                //width: sweg.fs*0.5
            }
        },
        State {
            name: sweg.aStates[2]
            PropertyChanges {
                target: r
                //w: sweg.fs*0.5
            }
            PropertyChanges {
                target: xImg
                //width: sweg.fs*0.5
            }
        }
    ]
    onWidthChanged: canvas.requestPaint()
    onWChanged: {
        //canvas.ctx
        canvas.requestPaint()
        //xImg.x=(0-xImg.width*0.5)+apps.signCircleWidth*0.5
    }
    Rectangle{
        anchors.fill: r
        color: 'transparent'
        border.width: 2
        border.color: 'red'
        radius: width*0.5
        visible: r.showBorder
    }
    Canvas {
        id: canvas
        width: r.width//-sweg.fs
        height: width
        onPaint:{
            var ctx = canvas.getContext('2d');
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            var x = canvas.width*0.5;
            var y = canvas.height*0.5;
            var rad=parseInt(canvas.width*0.5-r.w*0.5)
            var radius = rad>0?rad:r.width;

            var startAngle = 1.0 * Math.PI;
            var endAngle = 1.1666 * Math.PI;
            var counterClockwise = false;
            ctx.beginPath();
            ctx.arc(x, y, radius, startAngle, endAngle, counterClockwise);
            ctx.lineWidth = r.w;
            // line color
            ctx.strokeStyle = app.signColors[r.c];
            ctx.stroke();
        }
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
            onWidthChanged: canvas.requestPaint()
            MouseArea{
                anchors.fill: parent
                onClicked: parent.resaltado=!parent.resaltado
            }
            Rectangle{
                width: xImg.width*3
                height: width
                radius: width*0.5
                border.width: 4
                border.color: app.signColors[r.c]
                anchors.centerIn: parent
                z: parent.z-1
                opacity: xImg.resaltado?1.0:0.0
                Behavior on opacity{
                    NumberAnimation{duration: 350}
                }
                Rectangle{
                    anchors.fill: parent
                    color: app.signColors[c]
                    radius: width*0.5
                    opacity: 0.35
                }
            }
            Column{
                anchors.centerIn: parent
                XText {
                    text: '<b>'+app.signos[r.n - 1]+'</b>'
                    font.pixelSize: r.w*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: xImg.resaltado
                    opacity: xImg.resaltado?1.0:0.0
//                    Behavior on width{
//                        NumberAnimation{duration: 350}
//                    }
                }
                Image {
                    id: iconoSigno
                    source: "../resources/imgs/signos/"+parseInt(r.n - 1)+".svg"
                    property int w: xImg.width*0.75
                    width: xImg.width//!xImg.resaltado?r.w:r.w*2
                    height: width
                    //anchors.centerIn: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    //x:100
                    antialiasing: true
                    /*Behavior on width{
                        NumberAnimation{duration: 350}
                    }*/
                }
            }
        }
    }
}
