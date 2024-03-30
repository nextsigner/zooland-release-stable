import QtQuick 2.0
import QtQuick.Controls 2.0
import comps.ZoolMando 1.0
Rectangle{
    id: r
    width: parent.width
    height: col0.height+vars.fs
    color: 'black'
    border.width: 2
    border.color: 'white'
    visible: false
    property real cLat: apps.userLat
    property real cLon: apps.userLon
    property int cAlt: apps.userAlt
    property int cGmt: apps.userGmt

    property real stepSize: 1.00

    onVisibleChanged: {
        if(visible){
            r.cLat = apps.userLat
            r.cLon = apps.userLon
            r.cAlt = apps.userAlt
            r.cGmt = apps.userGmt
            tiLat.text = parseFloat(apps.userLat).toFixed(4)
            tiLon.text = parseFloat(apps.userLon).toFixed(4)
            tiAlt.text = parseInt(apps.userAlt)
            tiGmt.text = parseInt(apps.userGmt)
            tiCity.text = apps.userCity
            tiLat.focus = true
            vars.ci=r
        }else{
            tiLat.focus=false
            tiLon.focus=false
            tiAlt.focus=false
            tiGmt.focus=false
            tiCity.focus=false
        }
    }
    Rectangle{
        id: bgBackOpacity
        width: parent.width
        height: parent.height*20
        color: 'black'
        opacity: 0.75
        z: r.z-1
    }
    Column{
        id: col0
        spacing: vars.fs*2
        anchors.centerIn: parent
        Row{
            spacing: vars.fs*2
            //anchors.centerIn: parent
            Column{
                id: col1
                spacing: vars.fs*0.1
                anchors.verticalCenter: parent.verticalCenter
                Text{
                    id: txt1
                    text: 'Coordenadas Geográficas de Usuario'
                    color: 'white'
                    font.pixelSize: vars.fs*1.5
                    anchors.left: parent.left
                    anchors.leftMargin: vars.fs*0.5
                    //anchors.top: parent.top
                    //anchors.topMargin: vars.fs*0.5
                }
                Text{
                    text: 'Coords. Actuales: Latitud= '+apps.userLat+'    Longitud= '+apps.userLon+'    Altitud= '+apps.userAlt
                    color: 'white'
                    font.pixelSize: vars.fs
                    anchors.left: parent.left
                    anchors.leftMargin: vars.fs*0.5
                    //anchors.top: txt1.bottom
                    //anchors.topMargin: vars.fs*0.5
                }
            }
            Text{
                id: txt2
                text: 'Paso: '+parseFloat(r.stepSize).toFixed(2)+'\n(Enter para cambiar)'
                color: 'white'
                font.pixelSize: vars.fs*1.5
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                width: vars.fs*8
                height: vars.fs*2
                color: 'transparent'
                border.width: 2
                border.color: 'white'
                anchors.verticalCenter: parent.verticalCenter
                //clip: true
                Text{
                    text: 'Latitud:'
                    color: 'white'
                    font.pixelSize: vars.fs*0.75
                    anchors.bottom: parent.top
                }
                TextInput{
                    id: tiLat
                    width: parent.width-4
                    height: parent.height-4
                    color: 'white'
                    font.pixelSize: parent.height-vars.fs*0.2
                    anchors.centerIn: parent
                    Keys.onReturnPressed: r.toEnter()
                }
            }
            Rectangle{
                width: vars.fs*8
                height: vars.fs*2
                color: 'transparent'
                border.width: 2
                border.color: 'white'
                anchors.verticalCenter: parent.verticalCenter
                //clip: true
                Text{
                    text: 'Longitud:'
                    color: 'white'
                    font.pixelSize: vars.fs*0.75
                    anchors.bottom: parent.top
                }
                TextInput{
                    id: tiLon
                    width: parent.width-4
                    height: parent.height-4
                    color: 'white'
                    font.pixelSize: parent.height-vars.fs*0.2
                    anchors.centerIn: parent
                    Keys.onReturnPressed: r.toEnter()
                }
            }
            Rectangle{
                width: vars.fs*8
                height: vars.fs*2
                color: 'transparent'
                border.width: 2
                border.color: 'white'
                anchors.verticalCenter: parent.verticalCenter
                //clip: true
                Text{
                    text: 'Altitud:'
                    color: 'white'
                    font.pixelSize: vars.fs*0.75
                    anchors.bottom: parent.top
                }
                TextInput{
                    id: tiAlt
                    width: parent.width-4
                    height: parent.height-4
                    color: 'white'
                    font.pixelSize: parent.height-vars.fs*0.2
                    anchors.centerIn: parent
                    Keys.onReturnPressed: r.toEnter()
                }
            }
            Rectangle{
                width: vars.fs*3
                height: vars.fs*2
                color: 'transparent'
                border.width: 2
                border.color: 'white'
                anchors.verticalCenter: parent.verticalCenter
                //clip: true
                Text{
                    text: 'GMT:'
                    color: 'white'
                    font.pixelSize: vars.fs*0.75
                    anchors.bottom: parent.top
                }
                TextInput{
                    id: tiGmt
                    width: parent.width-4
                    height: parent.height-4
                    color: 'white'
                    font.pixelSize: parent.height-vars.fs*0.2
                    anchors.centerIn: parent
                    Keys.onReturnPressed: r.toEnter()
                }
            }
            Button{
                id: bot1
                text: 'Listo'
                anchors.verticalCenter: parent.verticalCenter
                onClicked: r.toEnter()
            }
        }
        Row{
            spacing: vars.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                width: r.width-vars.fs*3
                height: vars.fs*2
                color: 'transparent'
                border.width: 2
                border.color: 'white'
                anchors.verticalCenter: parent.verticalCenter
                //clip: true
                Text{
                    text: 'Nombre del lugar:'
                    color: 'white'
                    font.pixelSize: vars.fs*0.75
                    anchors.bottom: parent.top
                }
                TextInput{
                    id: tiCity
                    width: parent.width-4
                    height: parent.height-4
                    color: 'white'
                    font.pixelSize: parent.height-vars.fs*0.2
                    anchors.centerIn: parent
                    Keys.onReturnPressed: r.toEnter()
                }
            }
        }
    }
    ZoolMando{
        id: zoolMando1
        width: vars.fs*16
        height: width
        num:1
        //parent: bgBackOpacity
        anchors.centerIn: bgBackOpacity
        //anchors.verticalCenterOffset: 0-vars.fs*16
        onLeft:{
            toLeft()
        }
        onRight:{
            toRight()
        }
        onUp:{
            toUp()
        }
        onDown:{
            toDown()
        }
        onEnter:{
            toEnter()
        }
    }
    function toEnter(){
        if(tiLat.focus){
            tiLon.focus=true
            return
        }
        if(tiLon.focus){
            tiAlt.focus=true
            return
        }
        if(tiAlt.focus){
            tiGmt.focus=true
            return
        }
        if(tiGmt.focus){
            tiCity.focus=true
            return
        }
        if(tiCity.focus){
            bot1.focus=true
            return
        }
        if(bot1.focus){
            if(tiLat.text!=='' && tiLon.text!=='' && tiAlt.text!==''  && tiGmt.text!==''  && tiCity.text!==''){
                apps.userLat=parseFloat(tiLat.text).toFixed(4)
                apps.userLon=parseFloat(tiLon.text).toFixed(4)
                apps.userAlt=parseInt(tiAlt.text)
                apps.userGmt=parseInt(tiGmt.text)
                apps.userCity=tiCity.text
                r.visible=false
                vars.ci=zbtb
            }
            return
        }
        if(r.stepSize===1.00){
            r.stepSize=0.10
            return
        }
        if(r.stepSize===0.10){
            r.stepSize=0.01
            return
        }
        if(r.stepSize===0.01){
            r.stepSize=1.00
            return
        }
    }
    function toLeft(){
        if(tiLat.focus){
            bot1.focus=true
            return
        }
        if(tiLon.focus){
            tiLat.focus=true
            return
        }
        if(tiAlt.focus){
            tiLon.focus=true
            return
        }
        if(tiGmt.focus){
            tiAlt.focus=true
            return
        }
        if(bot1.focus){
            tiGmt.focus=true
            return
        }
    }
    function toRight(){
        if(tiLat.focus){
            tiLon.focus=true
            return
        }
        if(tiLon.focus){
            tiAlt.focus=true
            return
        }
        if(tiAlt.focus){
            tiGmt.focus=true
            return
        }
        if(tiGmt.focus){
            bot1.focus=true
            return
        }
        if(bot1.focus){
            tiLat.focus=true
            return
        }
    }
    function toUp(){
        if(tiLat.focus){
            if(r.cLat>=180){
                r.cLat=180.00
            }else{
                r.cLat+=r.stepSize
            }
            tiLat.text=parseFloat(r.cLat).toFixed(4)
            return
        }
        if(tiLon.focus){
            if(r.cLon>=180){
                r.cLon=180.00
            }else{
                r.cLon+=r.stepSize
            }
            tiLon.text=parseFloat(r.cLon).toFixed(4)
            return
        }
        if(tiAlt.focus){
            if(r.cAlt>=30000){
                r.cAlt=30000
            }else{
                r.cAlt+=1
            }
            tiAlt.text=parseInt(r.cAlt)
            return
        }
        if(tiGmt.focus){
            if(r.cGmt>=12){
                r.cGmt=12
            }else{
                r.cGmt+=1
            }
            tiGmt.text=parseInt(r.cGmt)
            return
        }
    }
    function toDown(){
        if(tiLat.focus){
            if(r.cLat<=-180){
                r.cLat=-180.00
            }else{
                r.cLat-=r.stepSize
            }
            tiLat.text=parseFloat(r.cLat).toFixed(4)
            return
        }
        if(tiLon.focus){
            if(r.cLon<=-180){
                r.cLon=-180.00
            }else{
                r.cLon-=r.stepSize
            }
            tiLon.text=parseFloat(r.cLon).toFixed(4)
            return
        }
        if(tiAlt.focus){
            if(r.cAlt<=-1000){
                r.cAlt=-1000
            }else{
                r.cAlt-=1
            }
            tiAlt.text=parseInt(r.cAlt)
            return
        }
        if(tiGmt.focus){
            if(r.cGmt<=-12){
                r.cGmt=-12
            }else{
                r.cGmt-=1
            }
            tiGmt.text=parseInt(r.cGmt)
            return
        }
    }
}
