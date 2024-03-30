import QtQuick 2.12

Rectangle {
    id: r
    width: app.fs*2
    height: width
    radius: width*0.5
    color: 'transparent'
    visible: typeEclipse!==-1
    property int typeEclipse: -1
    Image {
        id: sol
        source: "../../resources/imgs/sol1.png"
        width: parent.width*1.8
        height: width
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 0-r.width*0.1
        visible: r.typeEclipse===0
    }
    Image {
        id: luna
        source: "../../resources/imgs/luna1.png"
        width: parent.width+parent.width*0.1
        height: width
        anchors.centerIn: parent
        //anchors.horizontalCenterOffset: 0-r.width*0.1
        visible: r.typeEclipse===1
    }
    Rectangle {
        anchors.fill: r
        radius: width*0.5
        color: 'transparent'
        clip: true
        Rectangle{
            id: som
            width: r.width*0.8
            height: width
            radius: width*0.5
            color: 'black'
            x:0
            anchors.verticalCenter: parent.verticalCenter
            SequentialAnimation{
                running: r.width>0
                loops: Animation.Infinite
                PropertyAnimation{
                    target: som
                    property: "x"
                    from:r.width
                    to: r.typeEclipse===0?0:0+r.width*0.05
                    duration: 3000
                    easing.type: Easing.InOutQuad
                }
                PauseAnimation {
                    duration: 2000
                }
                PropertyAnimation{
                    target: som
                    property: "x"
                    from:r.typeEclipse===0?0:0+r.width*0.05
                    to: 0-r.width//-som.width
                    duration: 3000
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
    MouseArea{
        anchors.fill: r
        onClicked: sweg.objEclipseCircle.visible=false
        //Rectangle{anchors.fill: parent; color: 'red';opacity:0.5}
    }
}
