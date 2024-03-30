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
    property int fs: app.fs*0.5
    //signal
    onCurrentDateChanged: {
        r.anio=r.currentDate.getFullYear()        
    }
    Row{
        Rectangle{
            width: row2.width
            height: r.height*0.4
            Text {
                id: labelFecha
                text: 'Año'
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
            }
        }
    }
    Component.onCompleted: {
        if(!r.currentDate)r.currentDate=new Date(Date.now())
    }
}
