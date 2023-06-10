import QtQuick 2.0
import QtQuick.Controls 2.0
Item{
    id:r
    anchors.fill: parent
    property bool showTestButton: false
    property string host: 'ws://localhost'
    property int port: 1616
    property url url: host+':'+port
    property string loginUserName: 'test'

    property bool logued: false

    property var currentWsObject

    signal newMessage(string from, string to, string data)
    signal newMessageForMe(string from, string data)
    signal errorMessage(string message)

    Item{
        id: xWS
    }

    function resetWS(){
        for(var i=0;i<xWS.children.length;i++){
            xWS.children[i].destroy(1)
        }
        let comp=Qt.createComponent("WebSocketClient.qml")
        let obj=comp.createObject(xWS,{loginUserName: r.loginUserName, url: r.url, parentObject: r})
        r.currentWsObject=obj
    }
    Timer{
        id: tAutoReset
        running: !r.logued
        repeat: true
        interval: 6000
        onTriggered: {
            resetWS()
        }
    }
    Component.onCompleted: resetWS()
    function test(){
        let d = new Date(Date.now())
        sendData('Test from '+r.loginUserName, 'Minyma Server', 'Run from test function of Minyma Client.\n'+d.toString())
    }
    function sendData(from, to, data){
        let json={}
        json.from=from
        json.to=to
        json.data=data
        r.currentWsObject.sendData(JSON.stringify(json).replace(/\n/g, ' '))
    }
}
