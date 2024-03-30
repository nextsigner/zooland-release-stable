import QtQuick 2.0
import ZoolText 1.0

Rectangle {
    id: r
    width: row.width//+vars.fs
    //height: labelText===''?colAll.height:colAll.height+txtLabelText.height+r.fs*0.1
    height: colAll.height
    color: apps.backgroundColor
    border.width: 0
    border.color: apps.fontColor
    property bool locked: false
    property string labelText: ''
    property bool enableGMT: true
    property bool isBack: false
    property var currentDate: !isBack?app.currentDate:app.currentDateBack
    property int anio: 0
    property int mes: 0
    property int dia: 0
    property int hora: 0
    property int minuto: 0
    property real gmt: !r.isBack?app.currentGmt:app.currentGmtBack
    property int fs: vars.fs?vars.fs*0.5:16
    property bool setAppTime: false

    property int currentIndex: 0

    onFocusChanged: {
        if(!focus)controlTimeFecha.cFocus=-1
        if(focus)controlTimeFecha.cFocus=0
    }
    onCurrentDateChanged: {
        if(!r.currentDate)return
        r.anio=r.currentDate.getFullYear()
        r.mes=r.currentDate.getMonth() + 1
        r.dia=r.currentDate.getDate()
        r.hora=r.currentDate.getHours()
        r.minuto=r.currentDate.getMinutes()
        if(r.setAppTime){
            //log.l('222 Reload CD1...')
            //log.visible=true
            //log.l('-1 Reload CD1... '+r.setAppTime)
            //log.visible=true
            if(!r.isBack){
                app.currentDate=r.currentDate
            }else{
                app.currentDateBack=r.currentDate
            }
        }else{
            //log.l('333 Reload CD1...')
            //log.visible=true
        }
        //r.setAppTime=true
    }

    Column{
        id: colAll
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        ZoolText {
            id: txtLabelText
            text: r.labelText
            font.pixelSize: r.fs
            color: 'white'
            visible: r.labelText!==''
        }
        Item{width: 1; height:r.fs*0.25;visible: r.labelText!==''}
        Row{
            Rectangle{
                width: row2.width
                height: r.fs*1.2
                Text {
                    id: labelFecha
                    text: 'Fecha'
                    font.pixelSize: r.fs*0.5
                    anchors.centerIn: parent
                }
            }

            Item{
                width: r.fs
                height: 2
                visible: !r.enableGMT
            }
            Rectangle{
                id: xLabelGmt
                width: r.fs*3
                height: r.fs*1.2
                visible: r.enableGMT
                Text {
                    id: labelGmt
                    text: 'GMT'
                    font.pixelSize: r.fs*0.5
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                width: row1.width
                height: r.fs*1.2
                Text {
                    id: labelHora
                    text: 'Hora'
                    font.pixelSize: r.fs*0.5
                    anchors.centerIn: parent
                }
            }
        }
        Row{
            id: row
            //anchors.bottom: parent.bottom
            Row{
                id: row2
                spacing: -1
                Rectangle{
                    id: xAnio
                    width: r.fs*3
                    height: r.fs*1.8
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    MouseArea{
                        enabled: !r.locked
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            r.currentIndex=0
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
                        width: parent.width-parent.border.width*2
                        height: parent.height-parent.border.width*2
                        color: 'transparent'
                        border.width: vars.fs*0.25
                        border.color: 'red'
                        anchors.centerIn: parent
                        visible: r.currentIndex===0
                    }
                }
                Rectangle{
                    id: xMes
                    width: r.fs*2
                    height: r.fs*1.8
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    MouseArea{
                        enabled: !r.locked
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            r.currentIndex=1
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
                        width: parent.width-parent.border.width*2
                        height: parent.height-parent.border.width*2
                        color: 'transparent'
                        border.width: vars.fs*0.25
                        border.color: 'red'
                        anchors.centerIn: parent
                        visible: r.currentIndex===1
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
                    id: xDia
                    width: r.fs*2
                    height: r.fs*1.8
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    MouseArea{
                        enabled: !r.locked
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            r.currentIndex=2
                        }
                    }
                    Text{
                        id: t3
                        text: r.dia
                        color: apps.fontColor
                        font.pixelSize: r.fs
                        anchors.centerIn: parent
                    }
                    Rectangle{
                        width: parent.width-parent.border.width*2
                        height: parent.height-parent.border.width*2
                        color: 'transparent'
                        border.width: vars.fs*0.25
                        border.color: 'red'
                        anchors.centerIn: parent
                        visible: r.currentIndex===2
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
            Item{
                width: r.fs
                height: 2
                visible: !r.enableGMT
            }
            Rectangle{
                id: xGmt
                width: xLabelGmt.width
                height: r.fs*1.8
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                visible: r.enableGMT
                Text{
                    id: t8
                    text: r.gmt
                    color: apps.fontColor
                    font.pixelSize: r.fs
                    anchors.centerIn: parent
                }
                MouseArea{
                    id: maw
                    anchors.fill: parent
                    //onClicked: r.v=!r.v
                    property int m:0
                    property date uDate//: app.currentDate
                    property int f: 0
                    property int uY: 0
                    acceptedButtons: Qt.AllButtons;
                    onClicked: {
                        r.currentIndex=3
                    }
                }
                Rectangle{
                    width: parent.width-parent.border.width*2
                    height: parent.height-parent.border.width*2
                    color: 'transparent'
                    border.width: vars.fs*0.25
                    border.color: 'red'
                    anchors.centerIn: parent
                    visible: r.currentIndex===3
                }
            }
            Row{
                id: row1
                Rectangle{
                    id: xHora
                    width: r.fs*2
                    height: r.fs*1.8
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    MouseArea{
                        enabled: !r.locked
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            r.currentIndex=4
                        }
                    }
                    Text{
                        id: t4
                        text: r.hora
                        color: apps.fontColor
                        font.pixelSize: r.fs
                        anchors.centerIn: parent
                    }
                    Rectangle{
                        width: parent.width-parent.border.width*2
                        height: parent.height-parent.border.width*2
                        color: 'transparent'
                        border.width: vars.fs*0.25
                        border.color: 'red'
                        anchors.centerIn: parent
                        visible: r.currentIndex===4
                    }
                }

                Rectangle{
                    id: xMinuto
                    width: r.fs*2
                    height: r.fs*1.8
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    MouseArea{
                        enabled: !r.locked
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            r.currentIndex=5
                        }
                    }
                    Text{
                        id: t6
                        text: r.minuto>9?r.minuto:'0'+r.minuto
                        color: apps.fontColor
                        font.pixelSize: r.fs
                        anchors.centerIn: parent
                    }
                    Rectangle{
                        width: parent.width-parent.border.width*2
                        height: parent.height-parent.border.width*2
                        color: 'transparent'
                        border.width: vars.fs*0.25
                        border.color: 'red'
                        anchors.centerIn: parent
                        visible: r.currentIndex===5
                    }
                    Rectangle{
                        width: t5.contentWidth+2
                        height: t5.contentHeight+2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.left
                        color: apps.backgroundColor
                        Text{
                            id: t5
                            text: ':'
                            color: apps.fontColor
                            font.pixelSize: r.fs*0.65
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
    //property var aRect: [t4, t6, t8, t3, t2, t1]
    property var aRect: [t1, t2, t3, t8, t4, t6]
    property int cFocus: -1
    onCFocusChanged: {
        t1.visible=true
        t2.visible=true
        t3.visible=true
        t4.visible=true
        t5.visible=true
        t6.visible=true
        //t7.visible=true
        t8.visible=true
    }
    Rectangle{
        width: parent.width-parent.border.width*2
        height: parent.height-parent.border.width*2
        color: 'transparent'
        border.width: vars.fs*0.1
        border.color: 'red'
        anchors.centerIn: parent
        visible: r.focus
    }
    Timer{
        running: r.cFocus>=0 && r.focus
        repeat: true
        interval: 250
        onTriggered: {
            let b=!aRect[r.cFocus].visible
            if(aRect[r.cFocus]!==t1)t1.visible=true
            if(aRect[r.cFocus]!==t2)t2.visible=true
            if(aRect[r.cFocus]!==t3)t3.visible=true
            if(aRect[r.cFocus]!==t4)t4.visible=true
            if(aRect[r.cFocus]!==t5)t5.visible=true
            if(aRect[r.cFocus]!==t6)t6.visible=true
            if(aRect[r.cFocus]!==t8)t8.visible=true
            aRect[r.cFocus].visible=b
        }
    }
    Component.onCompleted: {
        if(!r.currentDate || r.currentDate.toString().indexOf('Invalid')>=0){
            r.currentDate=new Date(Date.now())
            //log.ls('r.currentDate now:'+r.currentDate.toString(), 0, xLatIzq.width)
        }
        r.anio=r.currentDate.getFullYear()
        r.mes=r.currentDate.getMonth() + 1
        r.dia=r.currentDate.getDate()
        r.hora=r.currentDate.getHours()
        r.minuto=r.currentDate.getMinutes()
    }
    function setTime(datetime){
        let sap=r.setAppTime
        r.setAppTime=false
        r.currentDate=datetime
        r.setAppTime=sap
    }
    function toRight(){
//        if(r.cFocus<5){
//            r.cFocus++
//        }else{
//            r.cFocus=0
//        }
        let ci=r.currentIndex
        if(ci<5){
            ci++
        }else{
            ci=0
        }
        r.currentIndex=ci
        r.cFocus=ci
    }
    function toLeft(){
        let ci=r.currentIndex
        if(ci>0){
            ci--
        }else{
            ci=5
        }
        r.currentIndex=ci
        r.cFocus=ci
    }
    function toUp(){
        if(r.currentIndex===0){
            anioUp()
            return
        }
        if(r.currentIndex===1){
            mesUp()
            return
        }
        if(r.currentIndex===2){
            diaUp()
            return
        }
        if(r.currentIndex===3){
            gmtUp()
            return
        }
        if(r.currentIndex===4){
            horaUp()
            return
        }
        if(r.currentIndex===5){
            minUp()
            return
        }
    }
    function toDown(){
        if(r.currentIndex===0){
            anioDown()
            return
        }
        if(r.currentIndex===1){
            mesDown()
            return
        }
        if(r.currentIndex===2){
            diaDown()
            return
        }
        if(r.currentIndex===3){
            gmtDown()
            return
        }
        if(r.currentIndex===4){
            horaDown()
            return
        }
        if(r.currentIndex===5){
            minDown()
            return
        }
    }

    //Funciones de Up Down
    function anioUp(){
        let d = r.currentDate
        let d2=new Date(d.getTime())
        d2.setFullYear(d2.getFullYear() + 1)
        r.currentDate = new Date(d2)
    }
    function anioDown(){
        let d = r.currentDate
        let d2=new Date(d.getTime())
        d2.setFullYear(d2.getFullYear() - 1)
        r.currentDate = new Date(d2)
    }
    function mesUp(){
        let d = r.currentDate
        let d2=new Date(d.getTime())
        d2.setMonth(d2.getMonth() + 1)
        r.currentDate = new Date(d2)
    }
    function mesDown(){
        let d = r.currentDate
        let d2=new Date(d.getTime())
        d2.setMonth(d2.getMonth() - 1)
        r.currentDate = new Date(d2)
    }
    function diaUp(){
        let d = r.currentDate
        let d2=new Date(d.getTime())
        d2.setDate(d2.getDate() + 1)
        r.currentDate = new Date(d2)
    }
    function diaDown(){
        let d = r.currentDate
        let d2=new Date(d.getTime())
        d2.setDate(d2.getDate() - 1)
        r.currentDate = new Date(d2)
    }
    function gmtUp(){
        let cgmt
        cgmt=r.gmt
        if(cgmt<12.00){
            cgmt+=1.0//0.1
        }else{
            cgmt=-12.00
        }
        r.gmt=parseFloat(cgmt).toFixed(1)
    }
    function gmtDown(){
        let cgmt
        cgmt=r.gmt
        if(cgmt>-12.00){
            cgmt-=1.0//0.1
        }else{
            cgmt=12.00
        }
        r.gmt=parseFloat(cgmt).toFixed(1)
    }
    function horaUp(){
        let d = r.currentDate
        let d2=new Date(d.getTime())
        d2.setHours(d2.getHours() + 1)
        r.currentDate = new Date(d2)
    }
    function horaDown(){
        let d = r.currentDate
        let d2=new Date(d.getTime())
        d2.setHours(d2.getHours() - 1)
        r.currentDate = new Date(d2)
    }
    function minUp(){
        let d = r.currentDate
        let d2=new Date(d.getTime())
        d2.setMinutes(d2.getMinutes() + 1)
        r.currentDate = new Date(d2)
    }
    function minDown(){
        let d = r.currentDate
        let d2=new Date(d.getTime())
        d2.setMinutes(d2.getMinutes() - 1)
        r.currentDate = new Date(d2)
    }
}
