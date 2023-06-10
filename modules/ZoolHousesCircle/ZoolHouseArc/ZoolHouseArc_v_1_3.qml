import QtQuick 2.12
import ZoolText 1.0
import "../"

Item {
    id: r
    //width: housesCircle.currentHouse!==n?xArcs.width:xArcs.width+extraWidth
    width: app.currentHouseIndex!==n?xArcs.width:xArcs.width+extraWidth
    //width: r.width+sweg.fs*2
    height: width
    anchors.centerIn: parent
    property real wg: 0.0
    property int wb: apps.widthHousesAxis
    property int gr: 0
    property int n: -1
    //property int w: housesCircle.currentHouse!==n?housesCircle.w*0.5:sweg.fs*6.5
    property int w: app.fs
    property int c: 0
    //property var colors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property var colors: [apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor]
    property var colors2: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property bool showBorder: false
    property bool selected: app.currentHouseIndex===n
    property  real op: 100.0
    property int opacitySpeed: 100
    property int extraWidth: 0
    //property alias showEjeCentro: ejeCentro.visible

    //Behavior on w{enabled: apps.enableFullAnimation;NumberAnimation{duration: 500}}
    //Behavior on width{enabled: apps.enableFullAnimation;NumberAnimation{duration:500}}

    state: sweg.state
    states: [
        State {
            name: sweg.aStates[0]
            PropertyChanges {
                target: ejeV
                width:  r.width+sweg.fs*2//.5
            }
//            PropertyChanges {
//                target: canvas2
//                opacity:  0.0
//            }
            PropertyChanges {
                target: r
                //colors: r.colors//[apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor]
                extraWidth: 0
                w: (sweg.width-sweg.objAspsCircle.width)/2//housesCircle.parent.objectName==='sweg'?(!r.selected?sweg.fs*2.5:sweg.fs*6):(!r.selected?sweg.fs*3:sweg.fs*7)
            }
        },
        State {
            name: sweg.aStates[1]
            PropertyChanges {
                target: ejeV
                width:  r.width+sweg.fs*2.5
            }
//            PropertyChanges {
//                target: canvas2
//                opacity:  1.0
//            }
            PropertyChanges {
                target: r
                //colors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
                extraWidth: sweg.fs*2.5
                w: (sweg.width-sweg.objAspsCircle.width)/2
                //w: housesCircle.parent.objectName==='sweg'?(!r.selected?sweg.fs*2.5:sweg.fs*6):(!r.selected?sweg.fs*2.5:sweg.fs*8)
            }
        },
        State {
            name: sweg.aStates[2]
            PropertyChanges {
                target: ejeV
                width: r.width+sweg.fs*2
            }
//            PropertyChanges {
//                target: canvas2
//                opacity:  0.0
//            }
            PropertyChanges {
                target: r
                //colors: [apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor]
                extraWidth: 0
                //w: housesCircle.parent.objectName==='sweg'?(sweg.fs*2):(sweg.fs*4)
                w: (sweg.width-sweg.objAspsCircle.width)/2
            }
        }
    ]



    Rectangle{
        id: ejeCard1
        //width: sweg.fs*2
        width: !housesCircleBack.visible?sweg.fs*2:sweg.fs*2+housesCircleBack.extraWidth+sweg.fs*5
        height: 1
        color: apps.houseLineColor
        //anchors.centerIn: r
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: !housesCircleBack.visible?0-sweg.fs*2:0-sweg.fs*2-housesCircleBack.extraWidth-sweg.fs*2.5
        visible: c===0

//        Canvas {
//            id:canvasSen
//            width: sweg.fs*0.5
//            height: width
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.left: parent.left
//            antialiasing: true
//            onPaint:{
//                var ctx = canvasSen.getContext('2d');
//                //ctx.clearRect(0, 0, canvas.width, canvas.height);
//                ctx.beginPath();
//                ctx.moveTo(0, canvasSen.width*0.5);
//                ctx.lineTo(canvasSen.width, 0);
//                ctx.lineTo(canvasSen.width, canvasSen.width);
//                ctx.lineTo(0, canvasSen.width*0.5);
//                ctx.strokeStyle = canvas.parent.color
//                ctx.lineWidth = canvasSen.parent.height;
//                ctx.fillStyle = canvasSen.parent.color
//                ctx.fill();
//                ctx.stroke();
//            }
//        }

        Rectangle{
            width: sweg.fs*2.2
            height: sweg.fs
            radius: sweg.fs*0.1
            color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0-sweg.fs*2.2
            clip: true
            Text{
                id: esteTxt
                text: 'Horizonte ESTE';
                width: sweg.fs*2
                wrapMode: Text.WordWrap
                color: apps.backgroundColor
                font.pixelSize: app.fs*0.35;
                anchors.centerIn: parent
            }
        }
    }


    ZoolandSignArc{
        width: r.width
        height: width
        w: sweg.width-aspsCircle.width
        n: r.n//index===0?1:(index===1?9:5)
        c:r.n
        gr: r.gr//xSignArcs.rotation
        //rotation: index*(360/3)-30
        anchors.centerIn: parent
    }
    Rectangle{
        id: ejeV
        height: r.wb
        color: 'transparent'
        anchors.centerIn: r
        antialiasing: true
        Rectangle{
            //visible: false//Depurando
            visible: app.dev
            width: parent.width*3
            height: r.wb
            color: 'yellow'
            antialiasing: true
        }
        Row{
            anchors.left: circleBot.right
            //visible: false
            Rectangle{
                id: lineaEje
                width: ((ejeV.width-r.width)*0.5-circleBot.width)
//                width: sweg.objHousesCircle.houseShowSelectadIndex===-1?
//                         ((ejeV.width-r.width)*0.5-circleBot.width)
//                         :
//                           //((ejeV.width-r.width)*0.5-circleBot.width)+circleBot.width*2
//                           ((ejeV.width-r.width)*0.5)

                height: r.wb
                //color: apps.enableBackgroundColor?apps.fontColor:'white'//r.selected?r.colors[r.c]:'white'
                color: apps.houseLineColor
                antialiasing: true
                y:lineaEje.y
            }
            Rectangle{
                id: lineaEje2
                width: r.w
//                width: sweg.objHousesCircle.houseShowSelectadIndex===-1?
//                           r.w
//                         :
//                           r.w*3
                height: r.wb
                //color: apps.enableBackgroundColor?apps.fontColor:'white'//'red'//r.colors[r.c]
                color: apps.houseLineColor
                antialiasing: true
                //y:c!==6&&c!==0?(c!==6?0-height*0.5:height*0.5):height*0.25//c===0?0-height*0.5:height
                //anchors.verticalCenter: parent.top
                Component.onCompleted: {
                    if(c===0){
                        y=0-height*0.25
                    }else  if(c===6){
                        y=height*0.25
                    }else{
                        //y=height*0.5
                    }
                }
            }
        }
        Rectangle{
            id: circleBot
            width: sweg.objHousesCircle.houseShowSelectadIndex===-1?
                       sweg.fs*0.75
                     :
                       sweg.objHousesCircle.houseShowSelectadIndex===r.c?(sweg.fs*0.75+r.wb*2)*2:(sweg.fs*0.75*2)
            height: width
            radius: width*0.5
            //color: apps.enableBackgroundColor?apps.fontColor:'white'
            color: apps.backgroundColor
            border.width: r.wb
            border.color: apps.houseLineColor//apps.enableBackgroundColor?apps.fontColor:'white'//lineaEje.color
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            state: sweg.state

            states: [
                State {
                    name: sweg.aStates[0]
                    PropertyChanges {
                        target: circleBot
                        width: sweg.fs*0.75
                        border.width: 1
                        border.color: apps.enableBackgroundColor?apps.fontColor:'white'//'white'
                    }
                },
                State {
                    name: sweg.aStates[1]
                    PropertyChanges {
                        //        canvas2.clear_canvas()
                        //        canvas2.requestPaint()
                        //        canvas2.update()                target: circleBot
                        width: sweg.fs*0.75+r.wb*2
                        border.width: r.wb
                        border.color: lineaEje.color
                    }
                },
                State {
                    name: sweg.aStates[2]
                    PropertyChanges {
                        target: circleBot
                        width: sweg.fs*0.75
                        border.width: 1
                        border.color: apps.fontColor//'white'
                    }
                }
            ]

            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.AllButtons;
                onClicked: {
                    if (mouse.button === Qt.RightButton && (mouse.modifiers & Qt.ControlModifier)) {
                        //Qt.quit()
                        //sweg.state= 'pc'
                    }else if (mouse.button === Qt.LeftButton && (mouse.modifiers & Qt.ControlModifier)) {
                        if(sweg.objHousesCircle.houseShowSelectadIndex===-1 || sweg.objHousesCircle.houseShowSelectadIndex !== r.c){
                            sweg.objHousesCircle.houseShowSelectadIndex=r.c
                            //sweg.state= 'pc'
                        }else{
                            sweg.objHousesCircle.houseShowSelectadIndex=-1
                            //sweg.state= 'ps'
                        }
                    }else{

                    }
                    var ni=-1
                    ni=sweg.objHousesCircle.currentHouse!==r.n?r.n:-1
                    sweg.objHousesCircle.currentHouse=ni
                    app.currentHouseIndex=ni
                    //                    if(sweg.state!==sweg.aStates[1]){
                    //                        sweg.state=sweg.aStates[1]
                    //                        ni=sweg.objHousesCircle.currentHouse!==r.n?r.n:-1
                    //                        sweg.objHousesCircle.currentHouse=ni
                    //                        //swegz.sweg.objHousesCircle.currentHouse=ni
                    //                    }else{
                    //                        sweg.state=sweg.aStates[0]
                    //                        sweg.objHousesCircle.currentHouse=-1
                    //                    }
                }
            }
            ZoolText{
                text: '<b>'+r.n+'</b>'
                font.pixelSize: parent.width*0.6
                width: contentWidth
                height: contentHeight
                horizontalAlignment: Text.AlignHCenter
                //color: apps.enableBackgroundColor?apps.backgroundColor:'black'
                color: apps.fontColor
                anchors.centerIn: parent
                rotation: 0-r.rotation-parent.rotation
            }

        }
    }
    Rectangle{
        id: ejeCentro
        width: r.width+app.fs*3
        height: 4
        color: 'blue'//'transparent'
        anchors.centerIn: r
        rotation: 0-r.wg/2
        visible:false
        Rectangle{
            width: sweg.fs
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
                rotation: 270+ejeCentro.rotation
            }
        }
    }
}
