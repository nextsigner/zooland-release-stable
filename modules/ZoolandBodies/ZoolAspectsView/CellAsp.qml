import QtQuick 2.0

Rectangle {
    id: r
    height: width
    color: indexAsp!==-1?arrColors[indexAsp]:(!apps.panelAspShowBg?'transparent':apps.backgroundColor)
    property var arrColors: ['red','#ff8833',  'green', '#124cb1']
    property int indexAsp: -1
    property int indexPosAsp: -1
    SequentialAnimation{
        running: indexPosAsp===sweg.objAspsCircle.currentAspSelected&&sweg.objAspsCircle.currentAspSelected!==-1
        loops: Animation.Infinite
        onRunningChanged: {
            if(!running){
                r.border.width=1
                r.border.color='gray'
            }
        }
        ParallelAnimation{
            PropertyAnimation{
                target: r
                property: "border.width"
                from: 2; to: 4
            }
            PropertyAnimation{
                target: r
                property: "border.color"
                from: "#ffffff"; to: "red"
            }
        }

        PauseAnimation {
            duration: 500
        }
        ParallelAnimation{
            PropertyAnimation{
                target: r
                property: "border.width"
                from: 4; to: 2
            }
            PropertyAnimation{
                target: r
                property: "border.color"
                from: "red"; to: "#ffffff"
            }
        }
    }
//    Rectangle {
//        anchors.fill: parent
//        border.width: 2
//        border.color: 'red'
//        color: 'transparent'
//        //visible: indexPosAsp===sweg.objAspsCircle.currentAspSelected&&sweg.objAspsCircle.currentAspSelected!==-1
//    }
    MouseArea{
        id: ma
        anchors.fill: parent
        property int uCurrentPlanetIndex: -1
        onClicked: {
            if(sweg.objAspsCircle.currentAspSelected!==r.indexPosAsp){
                sweg.objAspsCircle.currentAspSelected=r.indexPosAsp
                //swegz.sweg.objAspsCircle.currentAspSelected=r.indexPosAsp
                ma.uCurrentPlanetIndex=app.currentPlanetIndex
                app.currentPlanetIndex=-1
                app.currentHouseIndex=-1
                apps.showAspCircle=true
            }else{
                sweg.objAspsCircle.currentAspSelected=-1
                //swegz.sweg.objAspsCircle.currentAspSelected=-1
                app.currentPlanetIndex=ma.uCurrentPlanetIndex
            }
        }
    }
    Rectangle{
        width: 1
        height: r.height
        color: apps.fontColor
    }
    Rectangle{
        width: r.width
        height: 1
        color: apps.fontColor
        anchors.bottom: parent.bottom
    }
    Text{
        text:'<b>'+r.indexPosAsp+'</b>'
        font.pixelSize: 10
        anchors.centerIn: parent
        color: 'white'
        visible: false//r.indexPosAsp!==-1
    }
}
