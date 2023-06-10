import QtQuick 2.0
import QtQuick.Controls 2.0
import "../"

Item {
    id: r
    property alias text: txt.text
    property alias t: txt
    property alias r: xText
    property int fs: app.fs
    width: txt.contentWidth
    height: xText.height
    Rectangle{
        id: xText
        width: txt.width
        height: r.fs*1.2
        color: 'black'
        border.width: 0
        border.color: 'white'
        Text {
            id: txt
            font.pixelSize: r.fs
            color: 'white'
            //width: r.width-app.fs
            anchors.centerIn: parent
        }
    }
}
