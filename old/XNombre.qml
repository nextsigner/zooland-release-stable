import QtQuick 2.0
import QtGraphicalEffects 1.12

Rectangle {
    id: r
    width: txtNom.contentWidth+app.fs*2
    height: txtNom.contentHeight+app.fs
    color: 'transparent'
    border.width: 2
    border.color: 'red'
    property string nom: 'Nombre'
    Rectangle {
        anchors.fill: r
       opacity: 0.65
    }

    XText {
        id: txtNom
        text: r.nom
        font.pixelSize: app.fs
        anchors.centerIn: r
        textFormat: Text.RichText
    }
}
