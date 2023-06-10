import QtQuick 2.0

Item {
    id: r
    property int fs: app.fs*0.5
    property string currentDateString: '0/0/0000 00: 00hs'
    property color c1: 'white'
    property color c2: 'black'
    Rectangle{
        width: col.width+app.fs
        height: col.height+app.fs
        color: c2
        border.width: 2
        border.color: c1
        radius: app.fs*0.25
        Column{
            id: col
            anchors.centerIn: parent
            XText {
                id: txtDate
                text: '<b>Fecha: </b>'+r.currentDateString
                font.pixelSize: r.fs
                color: c1
            }
        }
    }
}
