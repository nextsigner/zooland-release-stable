import QtQuick 2.0

Rectangle{
    id: r
    width: children[0].width+app.fs*0.5
    height: children[0].height+app.fs*0.5
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.25
}
