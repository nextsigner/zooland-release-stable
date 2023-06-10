import QtQuick 2.7
import QtGraphicalEffects 1.0

Item {
    id: r
    width: xApp.width*0.2
    height: width
    visible: false
    property real zoom: 2.0
    property int lupaX: xLupa.image.x
    property int lupaY: xLupa.image.y
    property url url
    clip: true
    antialiasing: true
    Rectangle{
        anchors.fill: r
        color: 'black'
    }
    Image {
        id: img
        source: r.url
        width: xApp.width
        height: xApp.height
        x:r.lupaX+r.width*0.5-xLupa.width*0.5//0-lupaX*r.zoom+xApp.width*(r.zoom*0.25)//-r.width*0.5
        y: r.lupaY+r.height*0.5-xLupa.height*0.5//0-lupaY*r.zoom+xApp.height*(r.zoom*0.25)//-r.width*0.5
        scale: r.zoom
       antialiasing: true
    }
    Rectangle{
        anchors.fill: r
        border.width: 2
        border.color: 'white'
        color: 'transparent'
    }
}
