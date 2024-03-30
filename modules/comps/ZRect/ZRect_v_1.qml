import QtQuick 2.0

Rectangle{
    id: r
    color: showBg?apps.backgroundColor:'transparent'
    border.width: showBorder?wb:0
    border.color: cb
    property int wb: 1
    property color cb: apps.fontColor
    property bool showBg: true
    property bool showBorder: true
}
