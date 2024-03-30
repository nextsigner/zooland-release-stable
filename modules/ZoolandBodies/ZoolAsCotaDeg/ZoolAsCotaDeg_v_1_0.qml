import QtQuick 2.0
import ZoolText 1.1

Rectangle{
    id: r
    width: app.fs*2//xIcon.width*2
    height: 20
    rotation: r.rot
    color: 'transparent'

    property bool isBack: false

    property int distancia: app.fs
    property int rot: -270
    property real gdec: 0.000
    property int g: -1
    property int m: -1
    property int s: -1
    property int ih: -1
    property int is: -1

    property alias cotaColor: cotaBg.color
    property alias cotaOpacity: cotaBg.opacity

    Item{
        width: r.distancia
        height: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: r.distancia
        Rectangle{
            id: cotaBg
            anchors.fill: parent
        }
        ZoolText{
            id: degData
            w: t.contentWidth
            r.width: w+padding*2
            //text:'°'+r.g+' \''+r.m+' \'\''+r.s+'\n'+sweg.getDDToDMS(r.gdec).deg
            text:''+vars.signos[r.is]+' Casa '+r.ih+'\n°'+parseInt(sweg.getDDToDMS(r.gdec).deg - (30*r.is))+' \''+sweg.getDDToDMS(r.gdec).min+' \'\''+sweg.getDDToDMS(r.gdec).sec
            wrapMode: Text.NoWrap
            textFormat: Text.PlainText
            fs: !r.isBack?img.width*0.25:img0.width*0.25
            padding: fs*0.5
            color: apps.fontColor
            textBackgroundColor: apps.backgroundColor
            textBackgroundOpacity: 0.5
            borderWidth: 1
            borderColor: apps.fontColor
            borderRadius: fs*0.5
            rotation: !r.isBack?img.rotation+Math.abs(r.rot):img0.rotation+Math.abs(r.rot)
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: r.distancia*0.5+height*0.5
        }
    }
}
