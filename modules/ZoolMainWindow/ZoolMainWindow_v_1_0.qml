import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "../../js/Funcs.js" as JS
import "../../js/Capture.js" as Cap

Window {
    id: r
    property alias ip: itemXPlanets
    Item{
        id: itemXPlanets
        anchors.fill: parent
        //XPlanets{id: xPlanets}
        function showSS(){
            let comp=Qt.createComponent("XPlanets.qml")
            let obj=comp.createObject(itemXPlanets)
            if(obj){
                app.sspEnabled=true
            }
        }
        function hideSS(){
            for(var i=0;itemXPlanets.children.length;i++){
                itemXPlanets.children[i].destroy(1)
            }
        }
        Component.onCompleted: {
            if(unik.objectName!=='unikpy'){
                showSS()

            }
        }
    }

    //    Keys.onDownPressed: {
    //        log.l('event: '+event.text)
    //        log.visible=true
    //    }


    Component.onCompleted: {

    }
    Shortcut{
        sequence: 'Esc'
        onActivated: app.close()
    }
    Shortcut{
        sequence: 'Enter'
        onActivated: {
            if(app.ci){
                app.ci.toEnter()
            }
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(app.ci){
                app.ci.toUp()
            }
//            if(app.currentPlanetIndex>0){
//                app.currentPlanetIndex--
//            }else{
//                app.currentPlanetIndex=21
//            }
        }
    }
    Shortcut{
        sequence: 'Down'
        onActivated: {
            if(app.ci){
                app.ci.toDown()
            }
//            if(app.currentPlanetIndex<21){
//                app.currentPlanetIndex++
//            }else{
//                app.currentPlanetIndex=0
//            }
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            if(log.visible){
                log.visible=false
                return
            }
            if(app.ci && app.ci.objectName==='list'){
                app.ci=zoolDataBodies
                return
            }else if(app.ci && app.ci.objectName==='zoolDataBodies'){
                zbtb.currentIndex=zbtb.maximunIndex
                app.ci=zbtb
                return
            }else if(app.ci && app.ci.objectName==='bottomBar'){
                if(zbtb.currentIndex === 0){
                    app.ci=zsm.getPanel('ZoolRemoteParamsList')
                    return
                }
                //app.ci=zoolDataBodies
                //return
            }else{
                zbtb.currentIndex=zbtb.maximunIndex
                app.ci=zbtb
            }
            app.ci.toLeft()

            //Qt.quit()
        }
    }
    Shortcut{
        sequence: 'Right'
        property int v: 0
        onActivated: {
            if(app.ci && app.ci.objectName==='list'){
                zbtb.currentIndex=0
                app.ci=zbtb
                return
            }else if(app.ci && app.ci.objectName==='bottomBar'){
                if(zbtb.maximunIndex === zbtb.currentIndex){
                    app.ci=zoolDataBodies
                    return
                }
                //app.ci=zoolDataBodies
                //return
            }else{
                app.ci=zsm.getPanel('ZoolRemoteParamsList')
            }
            app.ci.toRight()
            /*if(v<app.aParams.length-1){
                v++
            }else{
                v=0
            }
            zsfdm.loadParamsFromString(app.aParams[v])*/
        }
    }

}
