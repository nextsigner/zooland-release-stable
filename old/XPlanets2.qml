import QtQuick 2.0
import QtGraphicalEffects 1.0
import "./ss2" as SS
Item {
    id: r
    anchors.fill: parent
    objectName: 'xplanets'
    property int w: 500
    property alias ssp: ssPlanets
    state: sweg.state
    states: [
        State {
            name: sweg.aStates[0]
            PropertyChanges {
                target: ssPlanets
                ds.value: 6
                ss.value: 2000
                width: r.width
                height: r.height
            }
        },
        State {
            name: sweg.aStates[1]
            PropertyChanges {
                target: ssPlanets
                ds.value: 6
                ss.value: 2000
                width: r.width
                height: r.height
            }
        },
        State {
            name: sweg.aStates[2]
            PropertyChanges {
                target: ssPlanets
                ds.value: 6
                ss.value: 2000
                width: r.width
                height: r.height
            }
        },
        State {
            name: 'centrado'
            PropertyChanges {
                target: r
                anchors.horizontalCenterOffset: sweg.width*0.2
            }
        }
    ]
    SS.PlanetsMain{
        id: ssPlanets
        //canvas3dX: 0-canvas3dWidth*0.25
        //canvas3dY: 0-canvas3dHeight*0.25
        //canvas3dWidth: r.width*2
        //canvas3dHeight: r.height*2
        //radius: width*0.5
        //z:parent.z-1
        width: r.width*2
        height: r.height*2
        anchors.centerIn: parent
        onFocusedPlanetChanged: {
            na1.duration=500
            na2.duration=500
            state='centrado'
            tDesCentrado.restart()
        }
        Behavior on anchors.horizontalCenterOffset{enabled: apps.enableFullAnimation;NumberAnimation{id: na1; duration: 2500}}
        Behavior on anchors.verticalCenterOffset{enabled: apps.enableFullAnimation;NumberAnimation{id: na2; duration: 2500}}
        state: 'descentrado'
        states: [
            State {
                name: 'descentrado'
                PropertyChanges {
                    target: ssPlanets
                    anchors.horizontalCenterOffset: 0-sweg.width*0.48
                    anchors.verticalCenterOffset: 0-sweg.height*0.31
                }
                PropertyChanges {
                    target: xIconPlanet
                    opacity:1.0
                }
            },
            State {
                name: 'centrado'
                PropertyChanges {
                    target: ssPlanets
                    anchors.horizontalCenterOffset: 0
                    anchors.verticalCenterOffset: 0
                }
                PropertyChanges {
                    target: xIconPlanet
                    opacity:0.0
                }
            }
        ]
        Timer{
            id: tDesCentrado
            running: false
            repeat: false
            interval: 5000
            onTriggered: {
                if(app.currentPlanetIndex===-1)return
                na1.duration=3000
                na2.duration=3000
                ssPlanets.state='descentrado'
            }
        }
        Item{
            id: xIconPlanet
            width: app.fs*1.5
            height: width
            anchors.centerIn: parent
            opacity: 0.0
           //visible: app.currentPlanetIndex >=0
            Behavior on opacity{enabled: apps.enableFullAnimation;NumberAnimation{duration: 2000}}
            Image {
                id: img
                source: app.currentPlanetIndex>=0?"./resources/imgs/planetas/"+app.planetasRes[app.currentPlanetIndex]+".svg":""
                anchors.fill: parent
                visible: false
            }
            ColorOverlay {
                id: co
                anchors.fill: img
                source: img
                color: app.currentPlanetIndex>=1?'#ffffff':'#000000'
                opacity: 0.5
                antialiasing: true
                visible: app.currentPlanetIndex >=0
            }
            Rectangle{
                width: txtPlanetName.contentWidth+app.fs*0.25
                height: txtPlanetName.contentHeight+app.fs*0.25
                color: 'transparent'
                radius: app.fs*0.25
                border.width: 1
                border.color: 'white'
                anchors.bottom: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    anchors.fill: parent
                    color: 'black'
                    opacity: 0.5
                    radius: parent.radius
                    z:parent.z-1
                }
                XText {
                    id: txtPlanetName
                    text: app.currentPlanetIndex >=0?'<b>'+app.planetas[app.currentPlanetIndex]+'</b>':'<b>Tierra</b>'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    anchors.centerIn: parent
                }
            }
        }
    }
    Rectangle {
        id: bg
        anchors.fill: parent
        color: "black"
        visible: false
    }
}
