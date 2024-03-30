import QtQuick 2.7
import QtQuick.Controls 2.0
import ZoolTextInput 1.0

import ZoolText 1.0
import ZoolButton 1.2

import comps.ZoolLoadingCircle 1.0

Rectangle {
    id: r
    width: xLatIzq.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor





    Column{
        id: col
        anchors.centerIn: parent
        spacing: vars.fs
        Item{width: 1; height: vars.fs;}
        Text{
            text: '<b>Crear nuevo usuario Zool</b>'
            font.pixelSize: vars.fs*0.65
            color: 'white'
        }

        ZoolTextInput{
            id: tiNombre
            width: r.width-vars.fs*0.5
            t.font.pixelSize: vars.fs*0.65
            anchors.horizontalCenter: parent.horizontalCenter
            KeyNavigation.tab: tiClave.t
            t.maximumLength: 30
            borderColor:apps.fontColor
            borderRadius: vars.fs*0.25
            padding: vars.fs*0.25
            horizontalAlignment: TextInput.AlignLeft
            Text {
                text: 'Nombre'
                font.pixelSize: vars.fs*0.5
                color: 'white'
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
            }
        }
        ZoolTextInput{
            id: tiClave
            width: r.width-vars.fs*0.5
            t.font.pixelSize: vars.fs*0.65
            anchors.horizontalCenter: parent.horizontalCenter
            KeyNavigation.tab: botReg
            t.maximumLength: 30
            t.echoMode: cbShowKey.checked?TextInput.Normal:TextInput.Password
            borderColor:apps.fontColor
            borderRadius: vars.fs*0.25
            padding: vars.fs*0.25
            horizontalAlignment: TextInput.AlignLeft
            Text {
                text: 'Clave'
                font.pixelSize: vars.fs*0.5
                color: 'white'
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
            }
        }
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: vars.fs*0.25
            Row{
                spacing: vars.fs*0.25
                anchors.verticalCenter: parent.verticalCenter
                Text{
                    text: 'Mostrar clave: '
                    font.pixelSize: vars.fs*0.5
                    color: apps.fontColor
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    id: cbShowKey
                    checked: false
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Button{
                id: botReg
                text: 'Registrar'
                font.pixelSize: vars.fs*0.5
                KeyNavigation.tab: tiNombre.t
                onClicked: {
                    if(tiNombre.text==='' || tiClave.text===''){
                        vars.j.showMsgDialog('Error! - Zool Informa', 'Faltan datos en el formulario','Para registrar el usuario hay que completar el formulario con un nombre y clave.')
                        return
                    }

                    let url=apps.host
                    url+='/zool/nuevoZoolUser'
                    url+='?n='+tiNombre.text
                    url+='&c='+unik.encData(tiClave.text, tiNombre.text, tiClave.text)
                    vars.j.getRD(url, getUser)
                    tWaitingResponse.restart()
                    zlc.visible=true
                }
            }
        }
        Text{
            opacity: tiClave.text!==''?1.0:0.0
            text: '<b>Atención!!</b>: No olvide esta clave.'
            width: r.width-vars.fs
            wrapMode: Text.WordWrap
            font.pixelSize: vars.fs*0.5
            color: apps.fontColor
        }
        Item{width: 1; height: vars.fs; opacity: tiClave.text!==''?1.0:0.0}
        Text{
            text: '<b>Información</b>: Esta aplicación es de uso libre y gratuito.\nEstar registrado permitirá ir guardando archivos en la nube o servidor de la aplicación si así usted lo desea.'
            width: r.width-vars.fs
            wrapMode: Text.WordWrap
            font.pixelSize: vars.fs*0.5
            color: apps.fontColor
        }
    }
    ZoolLoadingCircle{id: zlc; visible: false}
    Timer{
        id: tWaitingResponse
        running: false
        repeat: false
        interval: 10000
        onTriggered: {
            zlc.visible=false
            let msg=''
            msg+='Por alguna razón el último requerimiento que ha realizado al servidor de la aplicación Zool, no se ha podido procesar.\nPara más información comuníquese al correo nextsigner@gmail.com'
            vars.j.showMsgDialog('Zool Informa', 'El servidor no responde', msg)
        }
    }
    QtObject{
        id: getUser
        function setData(data, isData){
            zlc.visible=false
            tWaitingResponse.stop()
            if(vars.dev){
                log.lv('getUserAndSet:\n'+JSON.stringify(JSON.parse(data), null, 2))
            }
            if(isData){
                let j=JSON.parse(data)
                if(j.isRec){
                    if(vars.dev){
                        log.lv('New user, id: '+j.user._id)
                        log.lv('New user, n: '+j.user.n)
                        log.lv('New user, c: '+unik.decData(j.user.c, tiNombre.text, tiClave.text))
                    }
                    apps.zoolUser=j.user.n
                    apps.zoolUserId=j.user._id
                    apps.zoolKey=j.user.c
                }else{
                    vars.j.showMsgDialog('Zool Informa', 'Usuario no registrado.', j.msg)
                }

            }else{
                log.lv('Falla getUser: '+data)
            }
        }
    }
    function enter(){

    }
    function clear(){
        tiNombre.t.text=''
        tiClave.text=''
    }
    function toRight(){

    }
    function toLeft(){

    }
    function toUp(){

    }
    function toDown(){

    }
    function setInitFocus(){
        tiNombre.t.selectAll()
        tiNombre.t.focus=true
    }
}
