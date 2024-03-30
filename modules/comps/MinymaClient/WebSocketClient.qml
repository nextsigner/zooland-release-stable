import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import Qt.WebSockets 1.0
import "qwebchannel.js" as WebChannel

Rectangle {
    id: r
    anchors.fill: parent
    property var channel
    property url url
    property var arrayDataList: []
    property var arrayUserList: []
    property string loginUserName//: r.parent.parent.loginUserName
    property bool logued: false
    property var parentObject
    signal loguinSucess()
    signal errorSucess()
    signal keepAliveSuccess()
    onLoguedChanged: parentObject.logued=logued
    onUrlChanged: {
        socket.url=url
    }
    WebSocket {
        id: socket
        property var send: function(arg) {
            sendTextMessage(arg);
        }
        onTextMessageReceived: {
            onmessage({data: message});
        }
        property var onmessage
        active: false
        url: r.url
        onStatusChanged: {
            switch (socket.status) {
            case WebSocket.Error:
                errorSucess()
                let msgError = "Error: " + socket.errorString;
                r.parent.parent.errorMessage(msgError)
                r.logued=false
                break;
            case WebSocket.Closed:
                msgError = "Error: Socket at " + url + " closed.";
                r.logued=false
                r.parent.parent.errorMessage(msgError)
                break;
            case WebSocket.Open:
                //open the webchannel with the socket as transport
                new WebChannel.QWebChannel(socket, function(ch) {
                    r.channel = ch;
                    //connect to the changed signal of the userList property
                    ch.objects.chatserver.userListChanged.connect(function(args) {
                        r.arrayUserList=ch.objects.chatserver.userList
                    });
                    //connect to the newMessage signal
                    ch.objects.chatserver.newMessage.connect(function(time, user, message) {
                        let json=JSON.parse(message)
                        if(json.to===r.loginUserName){
                            r.parent.parent.newMessageForMe(json.from, json.data)
                        }else{
                            r.parent.parent.newMessage(json.from, json.to, json.data)
                        }
                        r.arrayDataList.push(message)
                    });
                    //connect to the keep alive signal
                    ch.objects.chatserver.keepAlive.connect(function(args) {
                        if (r.loginUserName !== '')
                            //and call the keep alive response method as an answer
                            ch.objects.chatserver.keepAliveResponse(r.loginUserName);
                        keepAliveSuccess()
                        r.logued=true
                    });
                });
                break;
            }
        }
    }
    Timer{
        id: tAutoConn
        running: !r.logued || !socket.active
        repeat: true
        interval: 2000
        onTriggered: {
            socket.active=true
            loguin()
        }
    }
    function loguin(){
        if(!r.channel){
            r.logued=false
            return
        }
        r.channel.objects.chatserver.login(r.loginUserName, function(arg) {
            //check the return value for success
            if (arg === true) {
                loguinSucess()
                r.logued=true
            }else {
                //tiUserName.color='red'
            }
        });
    }
    function sendData(data){
        r.channel.objects.chatserver.sendMessage(r.loginUserName,data);
    }
}
