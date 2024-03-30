import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../../comps' as Comps

import ZoolDataText 1.0
import ZoolButton 1.2

import web.ZoolUserManager.ZoolUserMaker 1.0
import web.ZoolUserManager.ZoolUserTools 1.0

Item{
    id: r
    width: xMed.width
    height: xMed                                  .height//-indicatorSV.height-xPanelesTits.height
    clip: true
    //property int currentIndex: count-1//apps.currentSwipeViewIndex
    //property int count: indicatorSV.count
//    property var aPanelsIds: []
//    property var currentSectionFocused
//    property var aPanelesTits: []

    property bool logued: false
    property bool userSeted: apps.zoolUser!=='' && apps.zoolKey!=='' && apps.zoolUserId!==''

    Column{
        width: r.width
        anchors.centerIn: parent
        Item{
            id: xPanels
            width: r.width
            height: r.height

            //2
            Comps.XPaneles{ZoolUserTools{id: zoolUserTools; visible:userSeted}}

            //1
            Comps.XPaneles{ZoolUserMaker{id: zoolUserMaker; visible:!userSeted}}
        }
    }
    Component.onCompleted: {
        //zsm.aPanelsIds.push(app.j.qmltypeof(r))
        //zsm.aPanelesTits.push('Usuario Zool')
        //r.showSection(s.currentQmlTypeShowed)
    }
    function getPanel(typeOfSection){
        let obj
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            //if(app.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
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
            //if(app.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
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
            if(app.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                ci=zsm.aPanelsIds.indexOf(app.j.qmltypeof(o))
                break
            }
        }

        return ci
    }
}
