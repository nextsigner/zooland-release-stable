import QtQuick 2.0
import QtQuick.Window 2.0
import ZoolText 1.1
import ZoolButton 1.2

Rectangle{
    id: r
    width: Screen.width*0.35
    height: col.height+app.fs*2
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    radius: app.fs*0.25
    clip: true
    anchors.centerIn: parent
    property string title: 'Title'
    property string subTitle: 'SubTitle'
    property string text: 'Text'
    Column{
        id: col
        spacing: app.fs*0.25
        anchors.centerIn: parent
        ZoolText{
            id: txt1
            text: r.title
            width: r.width-app.fs
            w: width
            anchors.left: parent.left
        }
        ZoolText{
            id: txt2
            text: '<b>'+r.subTitle+'</b>'
            width: r.width-app.fs
            w: width
            font.pixelSize: app.fs*0.5
        }
        ZoolText{
            id: txt3
            text: r.text
            width: r.width-app.fs
            w: width
            font.pixelSize: app.fs*0.5
        }
        Item{width: 1;height: app.fs*0.5}
        ZoolButton{
            text: 'Aceptar'
            anchors.right: parent.right
            onClicked: {
                r.destroy(0)
            }
        }
    }
    Component.onCompleted: app.ci=r
    function toEnter(){
        r.destroy(0)
    }
    function toLeft(){

    }
    function toRight(){

    }
    function toDown(){

    }
    function toUp(){

    }
}
