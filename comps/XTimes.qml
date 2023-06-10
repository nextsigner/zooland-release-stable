import QtQuick 2.0
import "../"
import ZoolText 1.0

Item {
    id: r
    width: row.width
    height: parent.height
    property var arrayHour: [0,0,0]
    property var arrayCrono: [0,0,0,0]
    property int yPos: apps.showTimes&&xDataBar.state!=='show'?r.height:0
    Behavior on yPos{NumberAnimation{duration: 250;easing.type: Easing.InOutQuad}}
    Row{
        id: row
        anchors.verticalCenter: parent.verticalCenter
        Row{
            id: row0
            anchors.verticalCenter: parent.verticalCenter
            Repeater{
                model: 3
                ZoolText{
                    text: index===0?'00':':00'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            tC.running=!tC.running
                        }
                        onDoubleClicked: {
                            tC.running=false
                            tC.vh=0
                            tC.vm=0
                            tC.vs=0
                            row0.children[0].text='0'
                            row0.children[1].text=':00'
                            row0.children[2].text=':00'
                        }
                    }
                }
            }
        }
        Item{width: app.fs*0.1;height: 1}
        Row{
            id: row1
            anchors.verticalCenter: parent.verticalCenter
            width: app.fs*1.6
            Repeater{
                model: 3
                ZoolText{
                    text: index===0?'00':':00'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            tH.v=10
                        }
                        onDoubleClicked: {

                        }
                    }
                }
            }
        }
    }
    Timer{
        id: tH
        running: true
        repeat: true
        interval: 1000
        property int v: 0
        onTriggered: {
            let d = new Date(Date.now())
            let h=d.getHours()
            let m=d.getMinutes()
            let s=d.getSeconds()
            let sM=''+m
            let sS=''+s
            if(m<10){
                sM='0'+sM
            }
            if(s<10){
                sS='0'+sS
            }
            let dia=d.getDate()
            let mes=d.getMonth() +1
            let anio=d.getYear()
            let sDia=''+dia
            if(dia<10){
                sDia='0'+dia
            }
            let sMes=''+mes
            if(mes<10){
                sMes='0'+mes
            }
            if(v<10){
                row1.children[0].text=''+h
                row1.children[1].text=':'+sM
                row1.children[2].text=':'+sS
            }else{
                let sAnio=''+anio
                row1.children[0].text=''+sDia
                row1.children[1].text='/'+sMes
                row1.children[2].text='/'+sAnio[1]+sAnio[2]
            }
            if(v>20){
                v=0
            }else{
                v++
            }

        }
    }
    Timer{
        id: tC
        running: false
        repeat: true
        interval: 1000
        property int vh: 0
        property int vm: 0
        property int vs: 0
        onTriggered: {
            if(vs===59){
                vs=0
                vm++
                if(vm===60){
                    vm=0
                    vh++
                }
            }else{
                vs++
            }

            let h=vh
            let m=vm
            let s=vs
            let sM=''+m
            let sS=''+s
            if(m<10){
                sM='0'+sM
            }
            if(s<10){
                sS='0'+sS
            }
            row0.children[0].text=''+h
            row0.children[1].text=':'+sM
            row0.children[2].text=':'+sS
        }
    }
}
