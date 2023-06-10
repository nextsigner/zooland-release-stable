import QtQuick 2.7
import QtQuick.Controls 2.0
import "./js/Funcs.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: 'black'
    border.width: 2
    border.color: 'white'
    state: 'hide'
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: r
                x:0
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                x:r.width
            }
        }
    ]
    Behavior on x{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        TextArea{
            id: ta
            width: r.width
            height: r.height
            font.pixelSize: app.fs*0.5
            color: 'white'
            wrapMode: Text.WordWrap
        }
    }
    function loadJson(file){
        if(!unik.fileExist(file)){
            ta.text='El archivo '+file+' no existe.'
            return
        }
        let fd=unik.getFile(file)
        //let j=JSON.parse(fd)
        //console.log('j:'+JSON.stringify(j))
        //console.log('j:'+JSON.stringify(j2))
        //ta.text=j.signos['s1'].h
    }
//    Rectangle{
//        anchors.fill: r
//    }

}
