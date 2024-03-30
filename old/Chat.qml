import QtQuick 2.0
import QtQuick.Controls 2.0
import QtWebView 1.0

Rectangle{
    id: r
    width: xApp.width*0.2
    height: parent.height
    color: apps.backgroundColor
    clip: true
    visible: apps.chat
    flags: Qt.WindowStaysOnTopHint
    property bool onTop: false
    MouseArea{
        anchors.fill: r
    }
    WebView{
        width: r.width
        height: r.height
        url: apps.chat?'https://tawk.to/chat/61617deb157d100a41ab9112/1fhif1h24':''
    }
}
