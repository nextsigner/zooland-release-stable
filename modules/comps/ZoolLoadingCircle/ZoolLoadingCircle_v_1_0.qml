import QtQuick 2.0

Item{
    id: r
    width: app.fs*3
    height: width
    anchors.centerIn: parent
    property string text: 'Cargando...'
    property var aG: [-20, 180, 40, -270]
    property var aG2: [100, -10, -350, 360]
    Rectangle{
        id: r2
        width: app.fs*3
        height: width
        radius: width*0.5
        color: 'transparent'
        border.width: app.fs*0.1
        border.color: apps.fontColor
        anchors.centerIn: parent
        SequentialAnimation on rotation {
            running: true
            loops: Animation.Infinite

            NumberAnimation {
                targets: r2
                properties: "rotation"
                duration: 4000
                from: r.rotation
                to: 250
            }
            NumberAnimation {
                targets: r2
                properties: "rotation"
                duration: 3000
                from: r.rotation
                to: 60
            }
            NumberAnimation {
                targets: r2
                properties: "rotation"
                duration: 5000
                from: r.rotation
                to: 360
            }
        }


        Repeater{
            model: [2000, 1500, 3500, 1000]
            Rectangle{
                id: eje
                width: r.width
                height: 3
                color: 'transparent'
                anchors.centerIn: parent
                SequentialAnimation on rotation {
                    running: true
                    loops: Animation.Infinite

                    NumberAnimation {
                        targets: eje
                        properties: "rotation"
                        duration: modelData
                        from: eje.rotation
                        to: r.aG[index]
                    }
                    NumberAnimation {
                        targets: eje
                        properties: "rotation"
                        duration: modelData
                        from: eje.rotation
                        to: r.aG2[index]
                    }
                }
                Rectangle{
                    width: app.fs*0.5
                    height: width
                    color: apps.fontColor
                    radius: width*0.5
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
    Text{
        text: r.text
        font.pixelSize: app.fs*0.5
        color: apps.fontColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        anchors.topMargin: app.fs*0.5
    }

}
