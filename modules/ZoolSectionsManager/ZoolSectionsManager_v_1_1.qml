import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../comps' as Comps

import ZoolRemoteParamsList 1.1
import ZoolButton 1.2

//import web.ZoolUserManager 1.0

Item{
    id: r
    width: xLatIzq.width
    height: xLatIzq.height//-indicatorSV.height-xPanelesTits.height
    clip: true
    property int currentIndex: count-1//apps.currentSwipeViewIndex
    property int count: indicatorSV.count
    property var aPanelsIds: []
    property var currentSectionFocused
    property var aPanelesTits: []
    onAPanelsIdsChanged: {
        indicatorSV.count=aPanelsIds.length
    }
    onCurrentIndexChanged:{
        apps.currentSwipeViewIndex=currentIndex
        r.showPanel(r.aPanelsIds[zsm.currentIndex])
        //zsm.getPanel('ZoolRevolutionList').desactivar()
    }
    Column{
        width: r.width
        anchors.centerIn: parent
        Rectangle{
            id: xPanelesTits
            width: xLatIzq.width
            height: r.aPanelesTits[zsm.currentIndex]?vars.fs*0.6:0
            color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                text: parseInt(zsm.currentIndex + 1)+': '+r.aPanelesTits[zsm.currentIndex]
                color: apps.backgroundColor
                font.pixelSize: vars.fs*0.5
                anchors.centerIn: parent
            }
        }

        Item{
            id: xPanels
            width: r.width
            height: r.height-xPanelesTits.height-xIndicadorSV.height
            //2
            //Comps.XPaneles{ZoolFileMaker{id: zoolFileMaker}}
            //1
            Comps.XPaneles{ZoolRemoteParamsList{id: zoolRemoteParamsList}}
        }
        Rectangle{
            id: xIndicadorSV
            width: xLatIzq.width
            height: indicatorSV.height
            color: 'transparent'
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    apps.zFocus='xLatIzq'
                }
            }
            PageIndicator {
                id: indicatorSV
                interactive: true
                count: 0//zsm.aPanelsIds.length
                currentIndex: apps.currentSwipeViewIndex//zsm.currentIndex
                anchors.centerIn: parent
                onCurrentIndexChanged: zsm.currentIndex=currentIndex
                delegate: Rectangle{
                    width: vars.fs*0.5
                    height: width
                    radius: width / 2
                    color: apps.fontColor
                    opacity: index === indicatorSV.currentIndex?0.95: pressed ? 0.7: 0.45
                    Text{
                        text:'\uf26c'
                        font.family: "FontAwesome"
                        font.pixelSize: parent.width*0.6
                        color: apps.backgroundColor
                        anchors.centerIn: parent
                        visible: index===0&&apps.repLectVisible
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            zsm.currentIndex=index                            
                            if (mouse.modifiers) {
                                apps.repLectVisible=!apps.repLectVisible
                            }
                        }
                    }
                }
                Timer{
                    running: parent.count===0
                    repeat: true
                    interval: 1000
                    onTriggered: parent.count=zsm.aPanelsIds.length
                }
            }
            ZoolButton{
                text:'\uf0ab'
                width: parent.height-4
                height: width
                rotation: 90
                borderWidth: 0
                borderColor: 'transparent'
                colorInverted: true
                anchors.verticalCenter: xIndicadorSV.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 2
                onClicked: {
                    if(r.currentIndex>0)r.currentIndex--
                }
            }
            ZoolButton{
                text:'\uf0ab'
                width: parent.height-4
                height: width
                rotation: -90
                colorInverted: true
                anchors.verticalCenter: xIndicadorSV.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 2
                onClicked: {
                    if(r.currentIndex<r.count)r.currentIndex++
                }
            }
        }

    }
    Timer{
        running: true
        repeat: false
        interval: 2000
        onTriggered: {
            showPanel(r.aPanelsIds[apps.currentSwipeViewIndex])
            //r.currentIndex=apps.currentSwipeViewIndex
        }
    }
    function getPanel(typeOfSection){
        let obj
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            //if(vars.dev)log.lv('getPanel( '+typeOfSection+' ): ' +vars.j.qmltypeof(o))
            if(''+vars.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                break
            }
        }
        return obj
    }
    function showPanel(typeOfSection){
        //let newCi=-1
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            //if(vars.dev)log.lv('getPanel( '+typeOfSection+' ): ' +vars.j.qmltypeof(o))
            if(''+vars.j.qmltypeof(o)===''+typeOfSection){
                o.visible=true
                //newCi=i
                r.currentSectionFocused=o
            }else{
                o.visible=false
            }
        }
        //r.currentIndex=newCi
    }
    function getPanelIndex(typeOfSection){
        let ci=-1
        let obj
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            if(vars.dev)log.lv('getPanel( '+typeOfSection+' ): ' +vars.j.qmltypeof(o))
            if(''+vars.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                ci=zsm.aPanelsIds.indexOf(vars.j.qmltypeof(o))
                break
            }
        }

        return ci
    }
}
