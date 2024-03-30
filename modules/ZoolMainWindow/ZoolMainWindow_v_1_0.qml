import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "../../js/Funcs.js" as JS
import "../../js/Capture.js" as Cap

ApplicationWindow {
    id: r
    property alias ip: itemXPlanets
    color: apps?apps.backgroundColor:'red'
    Item{
        id: itemXPlanets
        anchors.fill: parent
        //XPlanets{id: xPlanets}
        function showSS(){
            let comp=Qt.createComponent("XPlanets.qml")
            let obj=comp.createObject(itemXPlanets)
            if(obj){
                vars.sspEnabled=true
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
        sequence: 'Return'
        onActivated: {
            enterOrReturn()
        }
    }
    Shortcut{
        sequence: 'Enter'
        onActivated: {
            enterOrReturn()
        }
    }
    //Función Enter y Return
    function enterOrReturn(){
        /*if(tIsDoubleEnter.running){
            tIsDoubleEnter.stop()
            zm.visible=!zm.visible
            return
        }else{
            if(zm.visible){
                zm.toEnter()
                return
            }else{
                tIsDoubleEnter.restart()
            }
        }*/
        if(vars.ci){
            vars.ci.toEnter()
        }
    }


    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(zm.visible){
                zm.toUp()
                return
            }
            if(vars.ci){
                vars.ci.toUp()
            }
            //            if(vars.currentPlanetIndex>0){
            //                vars.currentPlanetIndex--
            //            }else{
            //                vars.currentPlanetIndex=21
            //            }
        }
    }
    Shortcut{
        sequence: 'Down'
        onActivated: {
            if(zm.visible){
                zm.toDown()
                return
            }
            if(vars.ci){
                vars.ci.toDown()
            }
            //            if(vars.currentPlanetIndex<21){
            //                vars.currentPlanetIndex++
            //            }else{
            //                vars.currentPlanetIndex=0
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
            if(vars.ci && (vars.ci.objectName==='zm' || vars.ci.objectName==='fileMaker')){
                //Qt.quit()
                vars.ci.toLeft()
                return
            }
            if(vars.ci && vars.ci.objectName==='list'){
                vars.ci=zdb
                return
            }else if(vars.ci && vars.ci.objectName==='zdb'){
                if(zdb.latFocus===1  && vars.ev){
                    zdb.latFocus=0
                }else{
                    //zbtb.currentIndex=zbtb.maximunIndex
                    //vars.ci=zbtb
                    vars.ci=zm
                }

                return
            }else if(vars.ci && vars.ci.objectName==='zm'){
                if(zbtb.currentIndex === 0){
                    if(zsm.getPanel('ZoolRemoteParamsList').ol.visible){
                        vars.ci=zsm.getPanel('ZoolRemoteParamsList').ol
                    }else{
                        vars.ci=zsm.getPanel('ZoolRemoteParamsList')
                    }
                    return
                }
                //vars.ci=zdb
                //return
            }else{
                zbtb.currentIndex=zbtb.maximunIndex
                vars.ci=zbtb
            }
            vars.ci.toLeft()

            //Qt.quit()
        }
    }
    Shortcut{
        sequence: 'Right'
        property int v: 0
        onActivated: {
            if(xCartelInicio.visible){
                xCartelInicio.visible=false
                return
            }
            if(vars.ci && (vars.ci.objectName==='zm' || vars.ci && vars.ci.objectName==='fileMaker')){
                vars.ci.toRight()
                return
            }
            if(vars.ci && vars.ci.objectName==='list'){
                //zbtb.currentIndex=0
                //vars.ci=zbtb
                vars.ci=zm
                return
            }else if(vars.ci && vars.ci.objectName==='zdb'){
                if(zdb.latFocus===0 && vars.ev){
                    zdb.latFocus=1
                }else{
                    if(zsm.getPanel('ZoolRemoteParamsList').ol.visible){
                        vars.ci=zsm.getPanel('ZoolRemoteParamsList').ol
                    }else{
                        vars.ci=zsm.getPanel('ZoolRemoteParamsList')
                    }
                }
                return
            }else if(vars.ci && vars.ci.objectName==='zm'){
                if(zbtb.maximunIndex === zbtb.currentIndex){
                    vars.ci=zdb
                    return
                }
                //vars.ci=zdb
                //return
            }else{
                vars.ci=zsm.getPanel('ZoolRemoteParamsList')
            }
            vars.ci.toRight()
            /*if(v<vars.aParams.length-1){
                v++
            }else{
                v=0
            }
            zsfdm.loadParamsFromString(vars.aParams[v])*/
        }
    }



    //Teclado
    Shortcut{
        sequence: 'Tab'
        property int currentIndex: 0
        onActivated: {
            if(currentIndex<vars.aCi.length-1){
                currentIndex++
            }else{
                currentIndex=0
            }
            vars.ci=vars.aCi[currentIndex]
            if(zsm.aPanelsIds.indexOf(vars.j.qmltypeof(vars.ci))>=0){
                zsm.showPanel(vars.j.qmltypeof(vars.ci))
            }
            //zsm.aPanelsIds.push(vars.j.qmltypeof(r))
        }
    }
    Shortcut{
        sequence: 'Ctrl+Tab'
        property int currentIndex: 0
        onActivated: {
            if(currentIndex<vars.aCiCtrl.length-1){
                currentIndex++
            }else{
                currentIndex=0
            }
            vars.ci=vars.aCiCtrl[currentIndex]
            if(zsm.aPanelsIds.indexOf(vars.j.qmltypeof(vars.ci))>=0){
                zsm.showPanel(vars.j.qmltypeof(vars.ci))
            }
            //zsm.aPanelsIds.push(vars.j.qmltypeof(r))
        }
    }
    Shortcut{
        sequence: 'Ctrl++'
        onActivated: {
            sweg.zoomUp()
        }
    }
    Shortcut{
        sequence: 'Ctrl+-'
        onActivated: {
            sweg.zoomDown()
        }
    }
    Shortcut{
        sequence: 'Ctrl+Right'
        onActivated: {
            sweg.rectSweg.x+=vars.fs*0.5
        }
    }
    Shortcut{
        sequence: 'Ctrl+Left'
        onActivated: {
            sweg.rectSweg.x-=vars.fs*0.5
        }
    }
    Shortcut{
        sequence: 'Ctrl+Up'
        onActivated: {
            sweg.rectSweg.y-=vars.fs*0.5
        }
    }
    Shortcut{
        sequence: 'Ctrl+Down'
        onActivated: {
            sweg.rectSweg.y+=vars.fs*0.5
        }
    }
    Shortcut{
        sequence: 'Ctrl+i'
        onActivated: {
            apps.xAsShowIcon=!apps.xAsShowIcon
        }
    }
}
