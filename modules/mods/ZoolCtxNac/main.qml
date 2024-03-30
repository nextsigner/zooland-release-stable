import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
//import "/media/ns/ZONA-A1/zool" as Zool
ApplicationWindow{
    id: app
    visibility: 'Maximized'
    visible: true
    width: Screen.width
    height: Screen.height
    color: 'black'
    title: 'Fake Window Zool'
    property int fs: width*0.02
    Item{
        id: apps
        property color backgroundColor: 'black'
        property color fontColor: 'white'
    }
    Item{
        id: xApp
        anchors.fill: parent
        Item{
            id: xSwe1
            width: xApp.width*0.6
            height: xApp.height
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            Rectangle{
                anchors.fill: parent
                color: 'transparent'
                border.width: 1
                border.color: 'red'
                //radius: width*0.5
                anchors.centerIn: parent
            }
            Rectangle{
                width: txt1.contentWidth+12
                height: txt1.contentHeight+12
                color: 'transparent'
                border.width: 1
                border.color: 'red'
                Text{
                    id: txt1
                    text: 'Area xMed Zool'
                    font.pixelSize: 12
                    color: 'red'
                    anchors.centerIn: parent
                }
            }
            SweGraphicFake{
                id: sweg
                objectName: 'sweg'                
                Rectangle{
                    //id: signCircle
                    anchors.fill: parent
                    color: 'transparent'
                    anchors.centerIn: parent
                }
            }
        }
        Item{
            id: panelZoolModules
            width: xApp.width*0.2
            height: parent.height
            property alias c: col
            Column{
                id: col
            }
        }
        Item{
            id: xLatDer
            width: xApp.width*0.2
            height: xApp.height
            anchors.right: parent.right
        }
    }
    ModuleMain{}
    Shortcut{
        sequence: 'Esc'
        //onActivated: Qt.quit()
    }
}
