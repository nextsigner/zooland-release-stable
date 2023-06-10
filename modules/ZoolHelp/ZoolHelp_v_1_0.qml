import QtQuick 2.12
import ZoolButton 1.2

Rectangle{
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property int svIndex: zsm.currentIndex
    property int itemIndex: -1
    property int fs: app.fs*0.75
    Column{
        id: col0
        anchors.centerIn: parent
        Rectangle{
            id: txt1
            width: r.width
            height: r.height
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            clip: true
            Text{
                text: '<b>Ayuda (Area en construcción)</b>'
                font.pixelSize: r.fs
                color: 'white'
                width: r.width-app.fs
                anchors.centerIn: parent
                //textFormat: Text.MarkdownText
                wrapMode: Text.WordWrap
            }
        }

//        ZoolButton{
//            text: 'Activar Chat de Twitch'
//            anchors.horizontalCenter: parent.horizontalCenter
//            onClicked:{
//                mkTwichChat()
//            }
//        }
//        TwitchChat_v_1_0{
//            width: r.width
//            height: app.fs*30
//            anchors.horizontalCenter: parent.horizontalCenter
//        }
    }
    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Ayuda')
        //let currentFileZoolText='./resources/zooltext.txt'
    }
    function mkTwichChat(){

    }
}
