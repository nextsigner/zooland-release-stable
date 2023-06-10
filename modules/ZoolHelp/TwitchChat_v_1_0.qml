import QtQuick 2.7
import QtWebView 1.1
import QtMultimedia 5.12
import Qt.labs.settings 1.1

Rectangle{
    id: r
    color: 'red'

    property string userAdmin: 'RicardoMartinPizarro'
    property bool ringEnabled: false
    property bool editable: false

    Audio {
        id: mpRing
        source: 'file:/home/ns/nsp/uda/twitch-chat/sounds/ring_1.mp3';
        autoLoad: true
        autoPlay: true
    }
    Settings{
        id: s
        property string uHtml: ''
    }
    Item{
        id: xAppWV
        anchors.fill: parent
        //opacity: app.editable?1.0:0.65
        WebView{
            id: wv
            width: parent.width
            height: parent.height//*0.5
            url:"https://streamlabs.com/widgets/chat-box/v1/15602D8555920F741CDF"
            onLoadProgressChanged:{
                if(loadProgress===100){
                    //tCheck.start()
                }
            }
        }
    }
    }
