import QtQuick 2.0

Item {
    id: r
    width: parent.height-app.fs*6
    height: width
    //anchors.centerIn: parent
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    property var objSignsCircle: signCircle
    Rectangle{
        width: r.width*2
        height: 1
        color: 'red'
        anchors.centerIn: parent
    }
    Rectangle{
        id: signCircle
        //anchors.fill: parent
        width:  r.width*2//-app.fs*2
        height: width
        color: 'transparent'
        border.width: 30
        border.color: 'red'
        radius: width*0.5
        anchors.centerIn: parent
        property int rot: rotation
    }
    function centerZoomAndPos(){}
}
