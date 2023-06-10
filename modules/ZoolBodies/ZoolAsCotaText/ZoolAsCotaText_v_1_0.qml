import QtQuick 2.0
import ZoolText 1.1
import ZoolButton 1.2

Rectangle{
    id: r
    width: app.fs*2//xIcon.width*2
    height: 20
    rotation: r.rot
    color: 'transparent'
    opacity: text===''?0.0:1.0
    signal clicked()

    property int widthObjectAcoted: 0

    property bool isBack: false

    property bool isPinched: false

    property int distancia: app.fs
    property int rot: -270
    property string text: ''

    property alias cotaColor: cotaBg.color
    property alias cotaOpacity: cotaBg.opacity

    Item{
        width: r.distancia
        height: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: r.distancia*0.5+widthObjectAcoted*0.5
        Rectangle{
            id: cotaBg
            anchors.fill: parent
        }
        ZoolText{
            id: degData
            w: t.contentWidth
            r.width: w+padding*2
            text:r.text
            wrapMode: Text.NoWrap
            textFormat: Text.RichText
            fs: app.fs*0.35//!r.isBack?img.width*0.25:img0.width*0.25
            padding: fs*0.5
            color: apps.fontColor
            textBackgroundColor: apps.backgroundColor
            textBackgroundOpacity: 1.0
            borderWidth: 1
            borderColor: apps.fontColor
            borderRadius: fs*0.5
            rotation: !r.isBack?img.rotation+Math.abs(r.rot):img0.rotation+Math.abs(r.rot)
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: r.distancia*0.5+height*0.5
            MouseArea{
                anchors.fill: parent
                onClicked: r.clicked()
            }
            ZoolButton{
                text: '\uf08d'
                colorInverted:r.isPinched
                fs: app.fs*0.5
                borderWidth: 1
                opacity: r.isPinched?1.0:0.5
                anchors.bottom: parent.top
                anchors.bottomMargin: r.isPinched?0-app.fs*0.1:app.fs*0.1
                anchors.right: parent.right
                rotation:!r.isPinched?25:0
                onClicked: r.isPinched=!r.isPinched
            }
        }

    }
}
