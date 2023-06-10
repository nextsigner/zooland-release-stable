import QtQuick 2.0
import ZoolText 1.0

Rectangle{
    id: r
    width: r.fs*6
    height: r.fs*1.5
    border.width: 1
    border.color: apps.backgroundColor
    color: apps.fontColor
    radius: r.fs*0.25
    property int fs: app.fs*6
    property bool isBack: false
    onWidthChanged: {
        zt1.font.pixelSize = r.width*0.15
    }
    MouseArea{
        enabled: !r.locked
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons;
        onClicked: {
            if (mouse.button === Qt.RightButton && (mouse.modifiers & Qt.ControlModifier)) {
                zoolElementsView.settings.zoom+=0.1
            }else if(mouse.button === Qt.LeftButton  && (mouse.modifiers & Qt.ControlModifier)){
                zoolElementsView.settings.zoom-=0.1
            }else{
                log.lv('Elemento no sabe que hacer: ???')
            }
        }
    }
    Row{
        anchors.centerIn: parent
        spacing: r.fs*0.5
        Text{id: zt1; text: !r.isBack?'<b>Interior</b>':'<b>Exterior</b>'; color: apps.backgroundColor; font.pixelSize: r.width*0.15}

    }
}
