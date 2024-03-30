import QtQuick 2.0
import QtGraphicalEffects 1.0
import ZoolText 1.0

Rectangle{
    id: r
    width: r.fs*6
    height: r.fs*1.5
    border.width: 1
    border.color: apps.backgroundColor
    color: 'transparent'//app.signColors[numElement]
    radius: r.fs*0.25
    property int fs: app.fs*6
    property int numElement: 0
    property var aElements: ["Fuego", "Tierra", "Aire", "Agua"]
    property string element: aElements[numElement]
    property string arrayPlanets: ''
    onArrayPlanetsChanged: {
        rep.model=arrayPlanets.split('|')
    }
    Row{
        id: row
        spacing: app.fs*0.5//r.sizeValue*0.01
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        Repeater{
            id: rep
            //model: arrayPlanets.split('|')
            Item{
                width: r.fs
                height: width
                anchors.verticalCenter: parent.verticalCenter
                //visible: modelData
                Image{
                    id: img
                    //source: modelData?'../../resources/imgs/planetas/'+app.planetasRes[modelData]+'.svg':''
                    source: modelData?'../../../../resources/imgs/planetas/'+vars.planetasRes[modelData]+'.svg':''
                    //source: '../../../../resources/imgs/planetas/jupiter.svg'
                    anchors.fill: parent
                }
                ColorOverlay {
                    id: co
                    anchors.fill: img
                    source: img
                    color: vars.signColors[numElement]
                    antialiasing: true
                }
            }
        }
    }
}


