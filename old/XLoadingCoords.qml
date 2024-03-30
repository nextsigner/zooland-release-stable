import QtQuick 2.0

Rectangle {
    id: r
    color: 'black'
    anchors.fill: parent
    visible: false
    property string ciudad: '...????'
    onVisibleChanged: {
        if(!visible){
            labelLoadingLugar.font.pixelSize=app.fs*2
            labelLoadingLugar.visible=false
        }
        if(visible){
            tll.start()
        }
    }
    MouseArea{
        anchors.fill: r
        onClicked: r.visible=false
    }
    Rectangle{
        anchors.fill: r
        color: 'black'
        opacity: 0.5
    }
   Text{
       id: labelLoadingLugar
        width: r.width*0.8
        text: 'Cargando Coordenadas de '+r.ciudad
        color: 'white'
        font.pixelSize: app.fs*2
        wrapMode: Text.WordWrap
        anchors.centerIn: parent
        visible: false
   }
   Timer{
       id: tll
        running: false
        repeat: true
        interval: 50
        onTriggered: {
            if(labelLoadingLugar.contentHeight+app.fs*2>r.height){
                labelLoadingLugar.font.pixelSize-=labelLoadingLugar.font.pixelSize*0.1
            }else{
                labelLoadingLugar.visible=true
                tll.stop()
            }
        }
   }
}
