import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: r
    property alias text: t.text
    property alias fontSize: b.font.pixelSize
    signal clicked
    Button{
        id: b
        text: ''
        font.pixelSize: app.fs*0.35
        anchors.fill: r
        onClicked: {
            r.clicked()
        }
        Text{
            id: t
            font.family: "FontAwesome"
            //font.family: "fa-brands-400"
            font.pixelSize: parent.width*0.8
            anchors.centerIn: parent
        }
    }
}
