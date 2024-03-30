import QtQuick 2.0
import QtGraphicalEffects 1.12

Rectangle {
    id: r
    width: rowCuerpos.width
    height: app.fs*0.9
    color: arrColors[tipo]
    border.width: 2
    border.color: 'white'
    radius: app.fs*0.1
    property bool invertido: false
    property int tipo: -1
    property int ic1: -1
    property int ic2: -1
    property string c1: 'moon'
    property string c2: 'sun'
    property string asp: ''
    property var arrColors: ['red','#ff8833',  'green', '#124cb1']
    property int indexAsp: -1
    Row{
        id: rowCuerpos
        visible: !r.invertido
        spacing: app.fs*0.6
        anchors.centerIn: r
        Repeater{
            model: 2
            Item{
                width: app.fs*0.7
                height: width
                Image {
                    id: iconoPlaneta
                    source: index===0?"./resources/imgs/planetas/"+app.planetasRes[r.ic1]+".svg":"./resources/imgs/planetas/"+app.planetasRes[r.ic2]+".svg"
                    visible: false
                    anchors.fill: parent
                }
                ColorOverlay {
                    anchors.fill: iconoPlaneta
                    source: iconoPlaneta
                    color: 'white'
                }
            }
        }
    }
    Row{
        id: rowCuerpos2
        visible: r.invertido
        spacing: app.fs*0.6
        anchors.centerIn: r
        Repeater{
            model: 2
            Item{
                width: app.fs*0.7
                height: width
                Image {
                    id: iconoPlaneta2
                    source: index===0?"./resources/imgs/planetas/"+app.planetasRes[r.ic2]+".svg":"./resources/imgs/planetas/"+app.planetasRes[r.ic1]+".svg"
                    visible: false
                    anchors.fill: parent
                }
                ColorOverlay {
                    anchors.fill: iconoPlaneta2
                    source: iconoPlaneta2
                    color: 'white'
                }

            }
        }
    }
    Image {
        id: iconAsp
        width: app.fs*0.75
        height: width
        source: "./resources/imgs/"+r.tipo+".svg"
        anchors.centerIn: r
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            if(sweg.objAspsCircle.currentAspSelected!==r.indexAsp){
                sweg.objAspsCircle.currentAspSelected=r.indexAsp
            }else{
                sweg.objAspsCircle.currentAspSelected=-1
            }
        }
        //Rectangle{anchors.fill: parent; color: 'red';opacity:0.5}
    }
}
