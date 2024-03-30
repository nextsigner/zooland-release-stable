import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: r
    width: row.width+app.fs*0.25
    height: txt.contentHeight<app.fs*1.2?app.fs*1.2:txt.contentHeight+app.fs*0.5
    color: apps.backgroundColor
    border.width: 0
    border.color: apps.fontColor
    radius: app.fs*0.25
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: zoolDataView.bottom
    z: zoolDataView.z-1
    property int currentIndex: -1
    property var textStatus: ['Mostrando sinastría.Aún no se ha creado el archivo', 'Mostrando Rev. Solar.Aún no se ha creado el archivo', 'Mostrando Tránsitos.Aún no se ha creado el archivo']
    onCurrentIndexChanged: setGui()
    state: currentIndex<0?'hide':'show'
    states: [
        State {
            name: "hide"
            PropertyChanges {
                target: r
                anchors.topMargin: 0-r.height
            }
        },
        State {
            name: "show"
            PropertyChanges {
                target: r
                anchors.topMargin: 0
            }
        }
    ]
    Behavior on y{NumberAnimation{duration: 500}}
    MouseArea{
        anchors.fill: parent
        //onClicked: r.currentIndex=0
    }
    Row{
        id: row
        spacing: app.fs*0.25
        anchors.centerIn: parent
        Text{
            id: txt
            //text: r.textStatus[r.currentIndex]
            font.pixelSize: app.fs*0.35
            color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Button{
            id: bot1
            font.pixelSize: app.fs*0.5
            height: app.fs*0.7
            anchors.verticalCenter: parent.verticalCenter
            onClicked: run(0)
        }
        Button{
            id: bot2
            font.pixelSize: app.fs*0.5
            height: app.fs*0.7
            anchors.verticalCenter: parent.verticalCenter
            onClicked: run(1)
        }
    }
    function setGui(){
        if(r.currentIndex<0)return
        txt.text=(r.textStatus[r.currentIndex]).replace(/\./g, '.\n')
        if(r.currentIndex===0){
            bot1.text='Crear Sinastría'
            bot2.text='Cancelar Sinastría'
            bot1.visible=true
            bot2.visible=true
        }
        if(r.currentIndex===1){
            bot1.text='Crear Rev. Solar'
            bot2.text='Cancelar Rev. Solar'
            bot1.visible=true
            bot2.visible=true
        }
        if(r.currentIndex===2){
            bot1.text='Crear Tránsitos'
            bot2.text='Cancelar Tránsitos'
            bot1.visible=true
            bot2.visible=true
        }
    }
    function run(numBot){
        if(r.currentIndex===0){
            if(numBot===0){
                app.j.mkSinFile(apps.urlBack)
            }
            if(numBot===1){
                app.j.loadJson(apps.url)
            }
        }
        if(r.currentIndex===1){
            if(numBot===0){
                app.j.mkRsFile(apps.urlBack)
            }
            if(numBot===1){
                app.j.loadJson(apps.url)
            }
        }
        if(r.currentIndex===2){
            if(numBot===0){
                app.j.mkTransFile()
            }
            if(numBot===1){
                app.j.loadJson(apps.url)
            }
        }
    }
}
