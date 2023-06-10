import QtQuick 2.0
import ZoolText 1.0
import "../"

Item {
    id: r
    width: housesCircleBack.currentHouse!==n?xArcsBack.width:xArcsBack.width+extraWidth
    height: width
    anchors.centerIn: parent
    property real wg: 0.0
    property int wb: apps.widthHousesAxis
    property int gr: 0
    property int n: -1
    //property int w: housesCircleBack.currentHouse!==n?housesCircleBack.w*0.5:sweg.fs*6.5
    property int w: (housesCircleBack.width-housesCircle.width)/2
    property int c: 0
    property var colors: [apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack]
    property var colors2: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property bool showBorder: false
    property bool selected: housesCircleBack.currentHouse===n
    property  real op: 100.0
    property int opacitySpeed: 100
    property int extraWidth: 0
    //property alias showEjeCentro: ejeCentro.visible

    //Behavior on w{enabled: apps.enableFullAnimation;NumberAnimation{duration: 500}}
    //Behavior on width{enabled: apps.enableFullAnimation;NumberAnimation{duration:500}}
//    state: sweg.state
//    states: [
//        State {
//            name: sweg.aStates[0]
//            PropertyChanges {
//                target: ejeV
//                width:  r.width+sweg.fs*2//.5
//            }
//            PropertyChanges {
//                target: canvas2
//                opacity:  0.0
//            }
//            PropertyChanges {
//                target: r
//                //colors: [apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack]
//                extraWidth: 0
//                //w: (sweg.width-sweg.objAspsCircle.width)/2//housesCircle.parent.objectName==='sweg'?(!r.selected?sweg.fs*2.5:sweg.fs*6):(!r.selected?sweg.fs*3:sweg.fs*7)
//            }
//        },
//        State {
//            name: sweg.aStates[1]
//            PropertyChanges {
//                target: ejeV
//                width:  r.width+sweg.fs*2.5
//            }
//            PropertyChanges {
//                target: canvas2
//                opacity:  1.0
//            }
//            PropertyChanges {
//                target: r
//                //colors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
//                extraWidth: sweg.fs*2.5
//                w: (sweg.width-sweg.objAspsCircle.width)/2
//                //w: housesCircle.parent.objectName==='sweg'?(!r.selected?sweg.fs*2.5:sweg.fs*6):(!r.selected?sweg.fs*2.5:sweg.fs*8)
//            }
//        },
//        State {
//            name: sweg.aStates[2]
//            PropertyChanges {
//                target: ejeV
//                width: r.width+sweg.fs*2
//            }
//            PropertyChanges {
//                target: canvas2
//                opacity:  0.0
//            }
//            PropertyChanges {
//                target: r
//                //colors: ['#685E05', '#4B450A', '#685E05', '#4B450A', '#685E05', '#4B450A', '#685E05', '#4B450A', '#685E05', '#4B450A', '#685E05', '#4B450A']
//                //colors: [apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack, apps.houseColorBack]
//                extraWidth: 0
//                //w: housesCircle.parent.objectName==='sweg'?(sweg.fs*2):(sweg.fs*4)
//                w: (sweg.width-sweg.objAspsCircle.width)/2
//            }
//        }
//    ]

    onColorsChanged: {
        canvas.requestPaint()
        canvas2.requestPaint()
        canvasSen.requestPaint()
    }
    onWidthChanged: {
        canvas.anchors.centerIn= r
        canvas2.anchors.centerIn= r
        canvas.requestPaint()
        canvas2.requestPaint()
    }
    onWChanged: {
        canvas.requestPaint()
        canvas2.requestPaint()
    }
    onSelectedChanged: {
        if(!selected)canvas.opacity=0.5
    }
    Behavior on opacity{enabled: apps.enableFullAnimation;
        NumberAnimation{duration: r.opacitySpeed}
    }
    onRotationChanged: {
        canvas.clear_canvas()
        canvas.requestPaint()
        canvas2.clear_canvas()
        canvas2.requestPaint()
    }
    Rectangle{
        anchors.fill: r
        color: 'transparent'
        border.width: 2
        border.color: 'red'
        radius: width*0.5
        visible: r.showBorder
        antialiasing: true
    }
    Rectangle{
        id: ejeCard1
        width: sweg.fs*2
        height: 1
        color: apps.houseLineColorBack
        //anchors.centerIn: r
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 0-sweg.fs*0.5
        visible: c===0
        Canvas {
            id:canvasSen
            width: sweg.fs*0.5
            height: width
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            antialiasing: true
            onPaint:{
                var ctx = canvasSen.getContext('2d');
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.beginPath();
                ctx.moveTo(0, canvasSen.width*0.5);
                ctx.lineTo(canvasSen.width, 0);
                ctx.lineTo(canvasSen.width, canvasSen.width);
                ctx.lineTo(0, canvasSen.width*0.5);
                ctx.strokeStyle = canvas.parent.color
                ctx.lineWidth = canvasSen.parent.height;
                ctx.fillStyle = canvasSen.parent.color
                ctx.fill();
                ctx.stroke();
            }
        }
    }
    Canvas {
        id:canvas
        width: r.width//-sweg.fs
        height: width
        opacity: 0.65
        antialiasing: true
        onPaint:{
            var ctx = canvas.getContext('2d');
            ctx.reset();
            var x = canvas.width*0.5;
            var y = canvas.height*0.5;
            //var radius = canvas.width*0.5-r.w*0.5;
            var rad=parseInt(canvas.width*0.5-r.w*0.5)

            //console.log('Rad: '+rad)
            var radius = rad>0?rad:r.width;
            ctx.beginPath();
            ctx.arc(x, y, radius, ((2 * Math.PI) / 360 * 180)-(2 * Math.PI) / 360 * r.wg, (2 * Math.PI) / 360 * 180);
            ctx.lineWidth = r.w;
            ctx.strokeStyle = sweg.state===sweg.aStates[1]?r.colors2[r.c]:r.colors[r.c];
            ctx.stroke();
        }
        function clear_canvas() {
            canvas.requestPaint();
        }
    }
    Canvas {
        id:canvas2
        width: r.width
        height: width
        opacity: canvas.opacity
        antialiasing: true
        onPaint:{
            var ctx = canvas2.getContext('2d')
            ctx.reset();
            var x = canvas2.width*0.5+r.wb;
            var y = canvas2.height*0.5
            var rad=parseInt(canvas.width*0.5)
            var radius = rad>0?rad:r.width;

            ctx.beginPath();
            ctx.arc(x, y, radius, ((2 * Math.PI) / 360 * 180)-(2 * Math.PI) / 360 * r.wg, (2 * Math.PI) / 360 * 180);
            ctx.lineWidth = r.wb;
            ctx.strokeStyle = sweg.state===sweg.aStates[1]?r.colors2[r.c]:r.colors[r.c];
            ctx.stroke();
        }
        function clear_canvas() {
            canvas2.requestPaint();
        }
    }
    Rectangle{
        id: ejeV
        width: parent.width+sweg.fs*2
        height: r.wb
        color: 'transparent'
        //color: 'yellow'
        anchors.centerIn: r
        antialiasing: true
        Rectangle{
            visible: false//Depurando
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
                height: r.wb
                color: apps.houseLineColorBack//apps.enableBackgroundColor?apps.fontColor:'white'//r.selected?r.colors[r.c]:'white'
                antialiasing: true
                y:lineaEje.y
            }
            Rectangle{
                id: lineaEje2
                width: r.w
                height: r.wb
                color: apps.houseLineColorBack//apps.enableBackgroundColor?apps.fontColor:'white'//'red'//r.colors[r.c]
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
            width: sweg.fs*0.5+r.wb
            height: width
            radius: width*0.5
            //color: apps.enableBackgroundColor?apps.backgroundColor:'white'
            color: 'transparent'
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            Rectangle{
                anchors.fill: parent
                radius: width*0.5
                color: apps.backgroundColor
                border.width: r.wb
                border.color: apps.houseLineColorBack
                opacity: 0.65
                antialiasing: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    var ni=-1
                    ni=sweg.objHousesCircleBack.currentHouse!==r.n?r.n:-1
                    sweg.objHousesCircleBack.currentHouse=ni
                }
            }
            ZoolText{
                id: txtNumHouse
                text: '<b>'+r.n+'</b>'
                font.pixelSize: parent.width*0.6
                width: contentWidth
                height: contentHeight
                horizontalAlignment: Text.AlignHCenter
                color: apps.fontColor
                //color: circleBot.border.color
                anchors.centerIn: parent
                rotation:app.mod!=='dirprim'?0-r.rotation-r.parent.rotation:0-r.rotation-r.parent.rotation-sweg.objHousesCircleBack.rotation
           }
        }
        Rectangle{
            width: circleBot.width*1.5
            height: width
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            anchors.centerIn: circleBot
            anchors.horizontalCenterOffset: 0-circleBot.width*2
            visible: r.c===0 || r.c===6
            z:parent.z-1
            Rectangle{
                id: line1
                width: parent.width//sweg.fs*0.5
                height: 1
                color: apps.houseLineColorBack
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.right
            }
            Text{
                id: esteTxt
                text: r.c===0?'<b>Asc</b>':'<b>Desc</b>'
                color: apps.fontColor
                font.pixelSize: parent.width*0.35
                anchors.centerIn: parent
                rotation: txtNumHouse.rotation
            }
        }
    }

//    Rectangle{
//        id: ejeCentro
//        width: canvas.width
//        height: 4
//        color: 'blue'//'transparent'
//        anchors.centerI
//        n: r
//        rotation: 0-r.wg/2
//        visible:false
//        Rectangle{
//            width: sweg.fs
//            height: width
//            //x:(r.w-width)/2
//            border.width: 2
//            border.color: 'white'
//            radius: width*0.5
//            color: 'red'//r.colors[r.c]
//            anchors.verticalCenter: parent.verticalCenter
//            rotation: 90-r.rotation-parent.rotation
//            antialiasing: true
//            ZoolText {
//                text: '<b>'+parseFloat(r.wg).toFixed(2)+'</b>'
//                font.pixelSize: parent.width*0.3
//                anchors.centerIn: parent
//                color: 'white'
//                rotation: 270+ejeCentro.rotation
//            }
//        }
//    }

    Timer{
        id: tc
        running: !app.capturing?r.selected:false
        repeat: true
        interval: 350
        onTriggered: {
            canvas.opacity=canvas.opacity===1.0?0.65:1.0
        }
    }


    //Eje de Casa
    Rectangle{
        width: r.width*0.5
        height: apps.widthHousesAxis
        anchors.verticalCenter: parent.verticalCenter
        //anchors.centerIn: parent
        color: apps.houseLineColorBack
        //color: 'blue'
        visible: apps.showHousesAxis
        y: lineaEje2.y
        antialiasing: true
    }

    function refresh(){
        canvas.clear_canvas()
        canvas.requestPaint()
        canvas.update()

        canvas2.clear_canvas()
        canvas2.requestPaint()
        canvas2.update()
    }
}
