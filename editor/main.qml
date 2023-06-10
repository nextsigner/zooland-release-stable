import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
ApplicationWindow {
    id: r
    visible: true
    width: Screen.width/2
    height: Screen.desktopAvailableHeight-altoBarra
    x:Screen.width/2
    title: 'Zool Editor'
    visibility: 'Windowed'
    color: 'black'

    property string data: ''

    property bool centrado: false
    property bool wordWrap: true

    property int fs: Screen.width*0.02
    property string moduleName: 'Editor Zool'
    property int altoBarra: 0

    property color c1: "#62DA06"
    property color c2: "#8DF73B"
    property color c3: "black"
    property color c4: "white"

    UnikTextEditor{
        id:unikTextEditor
        anchors.fill: parent
        fs:r.fs
        color: r.c1
        wordWrap: r.wordWrap
        text: r.data
        onEscaped: r.focus=true//Qt.quit()
        //onSendCode: wsSqlClient.sendCode(code)
    }
    Shortcut {
        sequence: "Ctrl+s"
        onActivated: {
            r.close()
            //Qt.quit()
        }
    }
    Shortcut {
        sequence: "Esc"
        onActivated: {
            r.close()
            //Qt.quit()
        }
    }
    Component.onCompleted: {

    }
}

