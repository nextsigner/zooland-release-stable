import QtQuick 2.0

Rectangle {
    id: r
    width: row.width//+app.fs
    height: r.fs+app.fs
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor

    property bool isBack: false
    property var currentDate//: numCiclosVida.currentDate
    property int anio: 0
    property int mes: 0
    property int dia: 0
    property int fs: app.fs*0.5
    //signal
    onCurrentDateChanged: {
        r.anio=r.currentDate.getFullYear()
        r.mes=r.currentDate.getMonth() + 1
        r.dia=r.currentDate.getDate()
        //numCiclosVida.currentDate=r.currentDate
    }
    Row{
        Rectangle{
            width: row2.width
            height: r.height*0.4
            Text {
                id: labelFecha
                text: 'Fecha'
                font.pixelSize: app.fs*0.35
                anchors.centerIn: parent
            }
        }
    }
    Row{
        id: row
        anchors.bottom: parent.bottom
        Row{
            id: row2
            spacing: -1
            Rectangle{
                id: xDia
                width: r.fs*2
                height: r.height*0.6
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        let d = r.currentDate
                        let d2=new Date(d.getTime())
                        if(wheel.angleDelta.y>=0){
                            d2.setDate(d2.getDate() + 1)
                            r.currentDate = new Date(d2)
                        }else{
                            d2.setDate(d2.getDate() - 1)
                            r.currentDate = new Date(d2)
                        }
                    }
                }
                Text{
                    id: t3
                    text: r.dia
                    color: apps.fontColor
                    font.pixelSize: r.fs
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                id: xMes
                width: r.fs*2
                height: r.height*0.6
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        let d = r.currentDate
                        let d2=new Date(d.getTime())
                        if(wheel.angleDelta.y>=0){
                            d2.setMonth(d2.getMonth() + 1)
                            r.currentDate = new Date(d2)
                        }else{
                            d2.setMonth(d2.getMonth() - 1)
                            r.currentDate = new Date(d2)
                        }
                    }
                }
                Text{
                    id: t2
                    text: r.mes>9?r.mes:'0'+r.mes
                    color: apps.fontColor
                    font.pixelSize: r.fs
                    anchors.centerIn: parent
                }
                Rectangle{
                    width: tb1.contentWidth+2
                    height: tb1.contentHeight+2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.left
                    color: apps.backgroundColor
                    Text{
                        id: tb1
                        text: '/'
                        color: apps.fontColor
                        font.pixelSize: r.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            Rectangle{
                id: xAnio
                width: r.fs*3
                height: r.height*0.6
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        let d = r.currentDate
                        let d2=new Date(d.getTime())
                        if(wheel.angleDelta.y>=0){
                            d2.setFullYear(d2.getFullYear() + 1)
                            r.currentDate = new Date(d2)
                        }else{
                            d2.setFullYear(d2.getFullYear() - 1)
                            r.currentDate = new Date(d2)
                        }
                    }
                }
                Text{
                    id: t1
                    text: r.anio
                    color: apps.fontColor
                    font.pixelSize: r.fs
                    anchors.centerIn: parent
                }
                Rectangle{
                    width: tb2.contentWidth+2
                    height: tb2.contentHeight+2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.left
                    color: apps.backgroundColor
                    Text{
                        id: tb2
                        text: '/'
                        color: apps.fontColor
                        font.pixelSize: r.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        if(!r.currentDate)r.currentDate=new Date(Date.now())
    }
}
