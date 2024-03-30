import QtQuick 2.0

Rectangle {
    id: r
    radius: width*0.5
    color: 'transparent'
    property bool isBack: false
    property color hc: selected?
                           ( !isBack?sweg.aThemes[sweg.s.currentThemeIndex][0]:sweg.aThemes[sweg.s.currentThemeIndex][2] )
                         :( !isBack?sweg.aThemes[sweg.s.currentThemeIndex][1]:sweg.aThemes[sweg.s.currentThemeIndex][3] )
    property bool selected: !isBack?(sweg.currentHouseIndex===n):(sweg.currentHouseIndexBack===n)
    property real wg: 0.0
    property int gr: 0
    property int n: -1
    property int w: vars.fs
    property int c: 0
    property bool showBorder: false
    property  real op: 100.0
    //property int wzha: (bordeSwegExt.width-bordeHousesCircleBackInt.width)*0.25//-sweg.w*2-20//((sweg.width-signCircle.width)*2)-10//10//sweg.width-sweg.pz+vars.fs //Width House Arc
    property int wzha: isBack?r.width-(signCircle.width):r.width*0.5-aspsCircle.width*0.5-sweg.w*2
    //opacity: r.selected?1.0:0.5
    Repeater{
        model: wg-3
        Item{
            width: r.width//sweg.width*2
            height: 1
            anchors.centerIn: parent
            rotation: 0-index
            Rectangle{
                width: r.wzha
                height: 20
                color: r.hc
                anchors.top: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: !r.isBack?sweg.w*2:0
            }
        }
    }
    Repeater{
        model: 3
        Item{
            width: r.width//sweg.width*2
            height: 1
            anchors.centerIn: parent
            rotation: 0-index-(r.wg-3)//-index
            Rectangle{
                width: r.wzha
                height: 20
                //color:'yellow'
                color: r.hc
                anchors.bottom: parent.top
                anchors.left: parent.left
                anchors.leftMargin: !r.isBack?sweg.w*2:0
            }
        }
    }
    Item{
        width: r.width//sweg.width*2
        height: 1
        anchors.centerIn: parent
        rotation: 0-r.wg
        Rectangle{
            width: r.wzha
            height: 20
            //color:'blue'
            color: r.hc
            anchors.bottom: parent.top
            anchors.left: parent.left
            anchors.leftMargin: !r.isBack?sweg.w*2:0//pz+vars.fs
        }
    }
}

