import QtQuick 2.0

Item{
    id:r
    property string host: zsfdm.host
    property bool isServerOnLine: false
    onIsServerOnLineChanged: {
        if(isServerOnLine){
            timerFistRun.stop()
            zpn.addNot('El servidor Zool ha sido encendido.', true, 10000)
        }else{
            zpn.addNot('El servidor Zool ha sido apagado.', true, 10000)
        }
    }
    QtObject{
        id: setIsServerOnLine
        function setData(data, isData){
            if(isData){
                isServerOnLine=true
            }else{
                isServerOnLine=false
            }
        }
    }
    QtObject{
        id: setAppId
        function setData(data, isData){
            //timerSetAppId.stop()
            if(isData){
                //isServerOnLine=true
                let j=JSON.parse(data)
                if(j.isRec){
                    apps.appId=j.app._id
                    //timerSetAppId.stop()
                    zpn.addNot('Aplicación registrada: '+apps.appId, false)
                }else{
                    zpn.addNot('setAppId isData: data='+j.isRec, false)
                }

            }else{
                zpn.addNot('setAppId no isData', false)
            }
        }
    }
    QtObject{
        id: setUserAndAppId
        function setData(data, isData){
            //timerSetAppId.stop()
            if(isData){
                //log.lv('setUserAndAppId: '+data)
                let j=JSON.parse(data)
                if(j.isRec && j.app._id===apps.appId && j.app.userId===apps.zoolUserId){
                    timerCheckUserAndAppIds.stop()
                    if(app.dev)log.lv('setUserAndAppId dice UserId y AppId sincronizadas')
                }else{
                    if(app.dev)log.lv('setUserAndAppId dice UserId y AppId NO sincronizadas')
                }

            }else{
                //zpn.addNot('setUserAndAppId no isData', false)
            }
        }
    }
    Timer{
        id: timerSetAppId
        running: r.isServerOnLine && apps.appId.length<1
        interval: 5000
        repeat: true
        onTriggered: {
            log.lv('timerSetAppId...')
            app.j.getRD(r.host+'/zool/setNewAppId', setAppId)
        }
    }
    Timer{
        id: timerFistRun
        running: apps.enableShareInServer
        interval: 15000
        repeat: false
        onTriggered: {
            zpn.addNot('El servidor de Zool no se encuentra encendido.', true, 6000)
        }
    }
    Timer{
        id: timerCheckStatus
        running: apps.enableShareInServer
        interval: 5000
        repeat: true
        onTriggered: {
            app.j.getRD(r.host, setIsServerOnLine)
        }
    }
    Timer{
        id: timerCheckUserAndAppIds
        running: apps.enableShareInServer && apps.appId.length>1 && apps.zoolUserId.length>1
        interval: 5000
        repeat: true
        onTriggered: {
            app.j.getRD(r.host+'/zool/setUserId?appId='+apps.appId+'&userId='+apps.zoolUserId, setUserAndAppId)
        }
    }
    Component.onCompleted: {
        if(apps.enableShareInServer){
            init()
        }
    }
    function init(){

    }
    function stop(){
        timerFistRun.stop()
        timerCheckStatus.stop()
        timerSetAppId.stop()
    }
    function timer() {
        return Qt.createQmlObject("import QtQuick 2.0; Timer {}", r);
    }
}
