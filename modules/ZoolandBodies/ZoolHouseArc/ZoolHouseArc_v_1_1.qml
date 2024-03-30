import QtQuick 2.0

Rectangle {
    id: r
    radius: width*0.5
    color: 'transparent'
    property bool isBack: false
    property color hc: !isBack?apps.houseColor:apps.houseColorBack
    property bool selected: !isBack?(housesCircle.currentHouse===n):(housesCircleBack.currentHouse===n)
    property real wg: 0.0
    property int gr: 0
    property int n: -1
    property int w: vars.fs
    property int c: 0
    property bool showBorder: false
    property  real op: 100.0
    Repeater{
        model: wg-3
        Item{
            width: sweg.width*2
            height: 1
            anchors.centerIn: parent
            rotation: 0-index
            Rectangle{
                width: sweg.width-sweg.pz+vars.fs
                height: 20
                color: r.hc
                anchors.top: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: sweg.pz+vars.fs
            }
        }
    }
    Repeater{
        model: 3
        Item{
            width: sweg.width*2
            height: 1
            anchors.centerIn: parent
            rotation: 0-index-(r.wg-3)//-index
            Rectangle{
                width: sweg.width-sweg.pz+vars.fs
                height: 20
                //color:'yellow'
                color: r.hc
                anchors.bottom: parent.top
                anchors.left: parent.left
                anchors.leftMargin: sweg.pz+vars.fs
            }
        }
    }
    Item{
        width: sweg.width*2
        height: 1
        anchors.centerIn: parent
        rotation: 0-r.wg
        Rectangle{
            width: sweg.width-sweg.pz+vars.fs
            height: 20
            //color:'blue'
            color: r.hc
            anchors.bottom: parent.top
            anchors.left: parent.left
            anchors.leftMargin: sweg.pz+vars.fs
        }
    }
}

