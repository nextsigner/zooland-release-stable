import QtQuick 2.0

Item{
    id: r
    objectName: 'bottomBar'
    width: parent.width
    height: w
    anchors.bottom: parent.bottom
    visible: vars.ci===r
    property int currentIndex: 0
    property int maximunIndex: rep.model.length-1
    property int w: vars.fs*2

    Row{
        spacing: vars.fs*0.25
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
                        running: vars.ci===r && r.currentIndex===index
                        repeat: true
                        interval: 500
                        onTriggered: parent.visible=!parent.visible
                        onRunningChanged: {
                            if(!running)parent.visible=false
                        }
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
        width: txtInfo.contentWidth+vars.fs
        height: txtInfo.contentHeight+vars.fs
        radius: vars.fs*0.1
        color: apps.backgroundColor
        border.width: 1
        border.color: apps.fontColor
        anchors.bottom: parent.top
        anchors.bottomMargin: r.w+vars.fs*0.25
        anchors.horizontalCenter: parent.horizontalCenter
        Text{
            id: txtInfo
            text: rep.model[r.currentIndex][1]//'???????????sdasfa'
            font.pixelSize: vars.fs*0.5
            color: apps.fontColor
            anchors.centerIn: parent
        }
    }
    Component.onCompleted: {
        let a =[]
        a.push(['FS', 'Tamaño de Objetos'])
        a.push(['PS', 'Tamaño de Planetas'])
        a.push(['IC', 'Ver Simbolos o Planetas'])
        a.push(['CS', 'Configurar Servidor'])
        a.push(['CU', 'Configurar Coordenadas de Usuario'])
        //a.push(['CS', 'Configurar Servidor'])
        rep.model=a
    }
    function toEnter(){
        let str=rep.model[r.currentIndex][0]
        if(str==='CU'){
            zuce.visible=true
        }
        if(str==='CS'){
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
        let str=rep.model[r.currentIndex][0]
        if(str==='FS'){
            if(apps.fs<40){
               apps.fs++
            }else{
                apps.fs=40
            }
        }
        if(str==='PS'){
            if(apps.planetsSize>vars.fs*3){
                apps.planetsSize=vars.fs*3
            }
            apps.planetsSize=apps.planetsSize+vars.fs*0.1
            sweg.objPlanetsCircle.calcAspDiam()
        }
        if(str==='IC'){
            apps.xAsShowIcon=!apps.xAsShowIcon
        }
    }
    function toDown(){
        let str=rep.model[r.currentIndex][0]
        if(str==='FS'){
            if(apps.fs>20){
               apps.fs--
            }else{
                apps.fs=20
            }
        }
        if(str==='PS'){
            if(apps.planetsSize<vars.fs*0.5){
                apps.planetsSize=vars.fs*0.5
            }
            apps.planetsSize=apps.planetsSize-vars.fs*0.1
            sweg.objPlanetsCircle.calcAspDiam()
        }
        if(str==='IC'){
            apps.xAsShowIcon=!apps.xAsShowIcon
        }
    }

}
