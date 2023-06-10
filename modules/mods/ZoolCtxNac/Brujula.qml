import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: r
    width: app.fs*4
    height: width
    Image {
        id: img
        source: "brujula.png"
        width: r.width
        height: width
        anchors.centerIn: parent

        visible: false
    }
    ColorOverlay{
        anchors.fill: img
        source: img
        color: 'yellow'

        SequentialAnimation on color{
            running: true
            loops: Animation.Infinite

            ColorAnimation {
                from: "red"
                to: "yellow"
                duration: 300
            }
            ColorAnimation {
                from: "yellow"
                to: "red"
                duration: 300
            }
        }
    }
    Column{
        spacing: app.fs*0.5
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0-app.fs*0.5
        anchors.right: parent.left
        //anchors.rightMargin: app.fs*0.5
        Rectangle{
            anchors.right: parent.right
            //anchors.right: parent.left
            //anchors.rightMargin: app.fs*0.5
            width:  txt2.contentWidth+app.fs*0.5
            height: txt2.contentHeight+app.fs*0.5
            border.width: 1
            border.color: 'black'
            radius: app.fs*0.25
            Text {
                id: txt2
                text: '<b>Hacia el Este</b>'
                font.pixelSize: app.fs*0.5
                anchors.centerIn: parent
            }
        }

        Item{
            width: r.width*0.3
            height: width*0.5
            rotation: 180
            anchors.right: parent.right
            Image {
                id: img2
                source: "flecha.png"
                width: parent.width
                height: parent.width
                anchors.centerIn: parent
                visible: false
            }
            ColorOverlay{
                anchors.fill: img2
                source: img2
                color: 'yellow'
                SequentialAnimation on color{
                    running: true
                    loops: Animation.Infinite

                    ColorAnimation {
                        from: "red"
                        to: "yellow"
                        duration: 300
                    }
                    ColorAnimation {
                        from: "yellow"
                        to: "red"
                        duration: 300
                    }
                }
            }
        }
    }
}
