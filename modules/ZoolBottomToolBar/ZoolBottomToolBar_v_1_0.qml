import QtQuick 2.0

Item{
    id: r
    objectName: 'bottomBar'
    width: parent.width
    height: w
    anchors.bottom: parent.bottom
    visible: app.ci===r
    property int currentIndex: 0
    property int maximunIndex: rep.model.length-1
    property int w: app.fs*2

    Row{
        spacing: app.fs*0.25
        height: parent.height
        anchors.centerIn: parent
        Repeater{
            id: rep
            //model: ['B1', 'B2', 'B3']
            Rectangle{
                width: r.currentIndex===index?r.w*2:r.w
                height: width
                radius: width*0.1
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                anchors.bottom: parent.bottom
                Behavior on width{NumberAnimation{duration: 200}}
                Behavior on height{NumberAnimation{duration: 200}}
                Rectangle{
                    anchors.fill: parent
                    color: 'transparent'
                    border.width: 2
                    border.color: 'red'
                    radius: parent.radius
                    visible: false
                    Timer{
                        running: app.ci===r && r.currentIndex===index
                        repeat: true
                        interval: 500
                        onTriggered: parent.visible=!parent.visible
                    }
                }
                Text{
                    text: modelData[0]
                    font.pixelSize: parent.width*0.6
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
    }
    Rectangle{
        id: xInfo
        width: txtInfo.contentWidth+app.fs
        height: txtInfo.contentHeight+app.fs
        radius: app.fs*0.1
        color: apps.backgroundColor
        border.width: 1
        border.color: apps.fontColor
        anchors.bottom: parent.top
        anchors.bottomMargin: r.w+app.fs*0.25
        anchors.horizontalCenter: parent.horizontalCenter
        Text{
            id: txtInfo
            text: rep.model[r.currentIndex][1]//'???????????sdasfa'
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
            anchors.centerIn: parent
        }
    }
    Component.onCompleted: {
        let a =[]
        a.push(['PS', 'Tamaño de Planetas'])
        a.push(['TA', 'Tamaño de Aspectos'])
        a.push(['IC', 'Ver Simbolos o Planetas'])
        a.push(['CS', 'Configurar Servidor'])
        //a.push(['CS', 'Configurar Servidor'])
        rep.model=a
    }
    function toEnter(){
        if(r.currentIndex===rep.model.length-1){
            zhe.visible=true
        }
    }
    function toLeft(){
        if(r.currentIndex>0){
            r.currentIndex--
        }else{
            r.currentIndex=r.maximunIndex
        }
    }
    function toRight(){
        if(r.currentIndex<rep.model.length-1){
            r.currentIndex++
        }else{
            r.currentIndex=0
        }
    }
    function toUp(){
        if(r.currentIndex===0){
            sweg.fs=sweg.fs+app.fs*0.1
        }
        if(r.currentIndex===1){
            sweg.objaspsCircle.ew=sweg.objaspsCircle.ew-10
            //apps.xAsShowIcon=!apps.xAsShowIcon
        }
        if(r.currentIndex===2){
            apps.xAsShowIcon=!apps.xAsShowIcon
        }
    }
    function toDown(){
        if(r.currentIndex===0){
            sweg.fs=sweg.fs-app.fs*0.1
        }
        if(r.currentIndex===1){
            sweg.objaspsCircle.ew=sweg.objaspsCircle.ew+10
            //apps.xAsShowIcon=!apps.xAsShowIcon
        }
        if(r.currentIndex===2){
            apps.xAsShowIcon=!apps.xAsShowIcon
        }
    }

}
