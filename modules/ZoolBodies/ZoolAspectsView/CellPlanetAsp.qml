import QtQuick 2.0

Rectangle {
    id: r
    border.width: 0
    border.color: 'gray'
    height: width
    antialiasing: true
    property int indexPlanet: -1
    property string folderImg: '../../../modules/ZoolBodies/ZoolAs/imgs_v1'
    Image {
        id: img
        source: r.folderImg+"/"+app.planetasRes[r.indexPlanet]+".svg"
        width: parent.width*0.8
        height: width
        anchors.centerIn: parent
        antialiasing: true
    }
}
