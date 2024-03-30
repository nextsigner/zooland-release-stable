import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id: r
    width: app.width
    height: app.fs*3
    color: 'black'
    border.width: 2
    border.color: 'white'
    visible: false
    onVisibleChanged: {
        if(visible){
            let fp=unik.getPath(4)+'/host'
            let h=unik.getFile(fp)//.replace(/ /g, '').replace(/\n/g, '')
            if(h==='' || h.lenght < 3){
                h='http://zool.loca.lt'
            }
            ti.text=h
            ti.focus=true
            app.ci=r
        }else{
            ti.focus=false
        }
    }
    Text{
        text: 'Servidor'
        color: 'white'
        font.pixelSize: app.fs*0.35
        anchors.left: parent.left
        anchors.leftMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
    }
    Row{
        spacing: app.fs*0.25
        anchors.centerIn: parent
        Rectangle{
            width: r.width-bot1.width-parent.spacing*2
            height: app.fs
            color: 'transparent'
            border.width: 2
            border.color: 'white'
            anchors.verticalCenter: parent.verticalCenter
            clip: true
            TextInput{
                id: ti
                width: parent.width-4
                height: parent.height-4
                color: 'white'
                font.pixelSize: parent.height-app.fs*0.1
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
    function toEnter(){
        let fp=unik.getPath(4)+'/host'
        let h=ti.text.replace(/ /g, '').replace(/\n/g, '')
        unik.setFile(fp, h)
        //log('Se ha definido la url del servidor: '+h)
        r.visible=false
        //app.checkNewVersion()
        app.ci=zbtb
        zsm.getPanel('ZoolRemoteParamsList').itemIndex=0
        zsm.getPanel('ZoolRemoteParamsList').toEnter()
    }
}
