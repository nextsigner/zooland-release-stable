import QtQuick 2.0

Item {
    id: r
    width: sweg.fs*4
    height: width
    anchors.centerIn: parent
    z:r.parent.z-1
    rotation: 0-signCircle.rotation
    property int iconoSignRot: 0
    property int is: -1
    property int gdeg: -1
    property int mdeg: -1
    property int sdeg: -1
    property int rsgdeg: -1
    property int ih: -1
    property bool expand: false
    property int wtc: sweg.fs //width of each circle de triple circle
    Rectangle{
        id: eje1
        //width: r.expand?r.width-circle1.width:sweg.fs
        //width: r.parent.parent.parent.objectName==='sweg'?(r.expand?r.width-circle1.width:sweg.fs):(r.expand?r.width-circle1.width-sweg.fs:sweg.fs)
        width: r.parent.parent.parent.parent.parent.objectName==='sweg'?sweg.fs*3:sweg.fs*2.25
        height: 2
        anchors.centerIn: parent
        color: 'transparent'
        rotation: -120+60
        antialiasing: true
        Behavior on width{
            enabled: apps.enableFullAnimation;
            NumberAnimation{duration: 1000}
        }
        Rectangle{
            id: circle1
            width: r.wtc
            height: width
            radius: width*0.5
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.left
            color: 'white'
            antialiasing: true

            Image {
                id: img1
                source: "./resources/imgs/signos/"+r.is+".svg"
                width: parent.width*0.9
                height: width
                anchors.centerIn: parent
                rotation: r.iconoSignRot + 60
                antialiasing: true
                Rectangle{
                    width: 4
                    height: parent.height+20
                    color: 'red'
                    anchors.centerIn: parent
                    visible: false
                    antialiasing: true
                    Rectangle{
                        width: 8
                        height: width
                        color: 'blue'
                        radius: width*0.5
                        border.width: 2
                        border.color: 'white'
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.centerIn: parent
                        antialiasing: true
                    }
                }
            }
        }
    }
    Rectangle{
        width: eje1.width
        //width: r.expand?r.width-circle1.width:sweg.fs
        height: 2
        anchors.centerIn: parent
        color: 'transparent'
        rotation: -240+60
        antialiasing: true
        Behavior on width{
            enabled: apps.enableFullAnimation;
            NumberAnimation{duration: 1000}
        }
        Rectangle{
            id: circle2
            width: r.wtc
            height: width
            radius: width*0.5
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.left
            antialiasing: true
            Image {
                id: img2
                source: "./resources/imgs/casa.svg"
                width: parent.width
                height: width
                rotation: r.iconoSignRot + 180
                antialiasing: true
            }
            Text{
                font.pixelSize: r.ih<=9?r.wtc*0.6:r.wtc*0.4
                text: '<b>'+r.ih+'</b>'
                color: 'white'
                anchors.centerIn: parent
                rotation: r.iconoSignRot + 180
            }
        }
    }
    Rectangle{
        width: eje1.width
        //width: r.expand?r.width-circle1.width:sweg.fs
        height: 2
        anchors.centerIn: parent
        color: 'transparent'
        rotation: 0+60
        antialiasing: true
        Behavior on width{
            enabled: apps.enableFullAnimation;
            NumberAnimation{duration: 1000}
        }
        Rectangle{
            id: circle3
            width: r.wtc
            height: width
            radius: width*0.5
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.left
            antialiasing: true
            Row{
                anchors.centerIn: parent
                rotation: r.iconoSignRot - 60
                Text{
                    font.pixelSize: r.wtc*0.35
                    text: '<b>°'+r.rsgdeg+'</b>'
                }
                Text{
                    font.pixelSize: r.wtc*0.25
                    text: '<b>\''+r.mdeg+'</b>'

                }
            }
        }
    }
}
