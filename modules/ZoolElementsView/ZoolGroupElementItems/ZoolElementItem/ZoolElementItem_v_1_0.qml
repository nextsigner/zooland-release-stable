import QtQuick 2.0
import ZoolText 1.0

Rectangle{
    id: r
    width: r.fs*6
    height: r.fs*1.5
    border.width: 1
    border.color: apps.backgroundColor
    color: app.signColors[numElement]
    radius: r.fs*0.25
    property int fs: app.fs*6
    property int numElement: 0
    property var aElements: ["Fuego", "Tierra", "Aire", "Agua"]
    property string element: aElements[numElement]
    property int porc: 99
    onWidthChanged: {
        zt1.font.pixelSize = r.width*0.15
        zt2.font.pixelSize = r.width*0.15
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
                //log.lv('Elemento no sabe que hacer: ???')
                zoolElementsView.tooglePlanetsOpacity()
            }
        }
    }
    Row{
        anchors.centerIn: parent
        spacing: r.fs*0.5
        Text{id: zt1; text: '<b>'+r.element+'</b>'; color: r.numElement===0||r.numElement===3?'white':'black'; font.pixelSize: r.width*0.15}
        Text{id: zt2; text: '<b>%'+r.porc+'</b>'; color: r.numElement===0||r.numElement===3?'white':'black'; font.pixelSize: r.width*0.15}
    }
}


