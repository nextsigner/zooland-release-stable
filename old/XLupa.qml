import QtQuick 2.7
import QtGraphicalEffects 1.0
Item {
    id: r
    width: app.fs*4
    height: width
    y: apps.lupaY//parent.height*0.5-r.width*0.5+sweg.verticalOffSet
    x: apps.lupaX//parent.width*0.5-r.height*0.5
    property real zoom: 2.0
    property alias image:img
    property alias centroLupa: centro
    property int mod: apps.lupaMod
    clip: mod!==0
    onModChanged: {
        borde.visible=true
        borde.opacity=apps.lupaOpacity
        if(mod===0){
            swegz.state='hide'
        }
        if(mod===1){
            swegz.state='show'
            img.visible=true
        }
        if(mod===2){
            swegz.state='show'
            apps.lt=false
            apps.showLupa=true
            img.visible=false
        }
    }
    onXChanged: an.running=true
    Behavior on x{enabled: apps.enableFullAnimation;NumberAnimation{duration: 1000;easing.type: Easing.OutQuad}}
    Behavior on y{enabled: apps.enableFullAnimation;NumberAnimation{duration: 1000;easing.type: Easing.OutQuad}}
    MouseArea{
        anchors.fill: r
        drag.axis: Drag.XAndYAxis
        drag.target: r
        onWheel: {
            if(wheel.angleDelta.y===120){
                apps.lupaRot++
            }else{
                apps.lupaRot--
            }
        }
        onClicked: {
//            if(mod===0){
//                mod=1
//                return
//            }
//            if(mod===1){
//                mod=2
//                return
//            }
//            if(mod===2){
//                mod=0
//                return
//            }
        }
    }
    Rectangle{
        id: bg
        anchors.fill: r
        color: 'black'
        visible: img.visible
    }
    Image {
        id: img
        x:0-r.x*r.zoom+xApp.width*(r.zoom*0.25)-r.width*0.5
        y: 0-r.y*r.zoom+xApp.height*(r.zoom*0.25)-r.width*0.5
        width: xApp.width
        height: xApp.height
        scale: r.zoom
        visible: r.mod!==2
    }
    Rectangle {
        id: mask
        width: 100
        height: 50
        //radius: width*0.5
        visible: false
    }
    Column{
        visible: r.mod===0
        anchors.centerIn: parent
        Repeater{
            model: 3
            Rectangle{
                id: lineAxis
                width: apps.lupaAxisWidth
                height: index===1?30:xApp.height*3
                color: index===1?'transparent':apps.lupaColor
                SequentialAnimation{
                    id: an2
                    running: index===1&&an.running
                    loops: Animation.Infinite
                    PropertyAnimation{
                        target: lineAxis
                        property: "height"
                        from:r.width
                        to:centro.width
                    }

                    PauseAnimation {
                        duration: 100
                    }
                    PropertyAnimation{
                        target: lineAxis
                        property: "height"
                        from:centro.width
                        to:r.width
                    }
                }
            }
        }
    }
    Row{
        visible: r.mod===0
        anchors.centerIn: parent
        Repeater{
            model: 3
            Rectangle{
                id: lineAxis2
                height: apps.lupaAxisWidth
                width: index===1?30:xApp.height*3
                color: index===1?'transparent':apps.lupaColor
                SequentialAnimation{
                    id: an22
                    running: index===1&&an.running
                    loops: Animation.Infinite
                    PropertyAnimation{
                        target: lineAxis2
                        property: "width"
                        from:r.width
                        to:centro.width
                    }

                    PauseAnimation {
                        duration: 100
                    }
                    PropertyAnimation{
                        target: lineAxis2
                        property: "width"
                        from:centro.width
                        to:r.width
                    }
                }
            }
        }
    }
    Rectangle{
        id: borde
        anchors.fill: r
        radius: r.mod===0||r.mod===2?width*0.5:0
        color: 'transparent'
        border.width: apps.lupaBorderWidth
        border.color: apps.lupaColor
        opacity: apps.lupaOpacity
        visible: !xLayerTouch.visible
    }
    Timer{
        id: tScreenShot
        running: img.visible
        repeat: true
        interval: 1
        onTriggered: {
            tScreenShot.stop()
            xApp.grabToImage(function(result) {
                //console.log('Url: '+result.url)
                img.source=result.url
                tScreenShot.restart()
            });
        }
    }
    Timer{
        id: tCentro
        running: false
        repeat: false
        interval: 3000
        onTriggered: an.running=false
    }
    Rectangle{
        id: centro
        width: apps.lupaCenterWidth
        height: width
        radius: width*0.5
        color: 'transparent'
        border.width: 1
        border.color: borde.border.color
        anchors.centerIn: parent
        visible: an.running
        Rectangle{
            id: bgc1
            anchors.fill: parent
            radius: parent.radius
            opacity: 0.0
        }
        Rectangle{
            id: bgc2
            anchors.fill: parent
            radius: parent.radius
            opacity: 0.0
        }
    }
    Rectangle{
        color: 'yellow'
        width: 20
        height: width
        radius: width*0.5
        anchors.centerIn: parent
        visible: false
    }
    SequentialAnimation{
        id: an
        running: false
        onRunningChanged: tCentro.restart()
        loops: Animation.Infinite
        PropertyAnimation{
            target: centro
            property: "opacity"
            from:1.0
            to:0.0
        }

        PauseAnimation {
            duration: 100
        }
        PropertyAnimation{
            target: centro
            property: "opacity"
            from:0.0
            to:1.0
        }
    }
    SequentialAnimation{
        running: an.running
        loops: Animation.Infinite

        PropertyAnimation {
            target: bgc1; property: "opacity";from:0.0;to:0.5 }
        PropertyAnimation {
            target: bgc1; property: "opacity";from:0.5;to:0.0 }
        PropertyAnimation {
            target: bgc2; property: "opacity";from:0.0;to:0.5 }
        PropertyAnimation {
            target: bgc2; property: "opacity";from:0.5;to:0.0 }
    }
}
