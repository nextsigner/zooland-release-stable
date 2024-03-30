import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: r
    property alias text: txt.text
    property alias t: txt
    property int fs: app.fs
    property bool c: false
    property alias bw: xTi.border
    property alias bc: xTi.border
    signal pressed
    signal downPressed
    width: app.fs*5
    height: xTi.height
    //focus: txt.focus
    //signal textChanged(string text)
    Rectangle{
        id: xTi
        width: r.width//+app.fs
        height: r.fs
        color: 'transparent'
        border.width: 1
        border.color: 'white'
        clip: true
        anchors.centerIn: r
        Rectangle{
            id: bg
            anchors.fill: parent
            z: parent.z-1
            opacity: 0.2
            SequentialAnimation{
                running: r.focus
                loops: Animation.Infinite
                PropertyAnimation {
                    target: bg
                    property: "opacity"
                    from: 0.0
                    to: 0.2
                }
                PauseAnimation {
                    duration: 200
                }
                PropertyAnimation {
                    target: bg
                    property: "opacity"
                    from: 0.2
                    to: 0.0
                }
            }
        }
        TextInput {
            id: txt
            font.pixelSize: r.fs
            color: 'white'
            width: parent.width-app.fs*0.25
            anchors.centerIn: parent
            horizontalAlignment: r.c?TextInput.AlignHCenter:TextInput.AlignLeft
            onTextChanged: r.textChanged(text)
            Keys.onReturnPressed: r.pressed()
            Keys.onEnterPressed: r.pressed()
            Keys.onDownPressed: r.downPressed()
        }
    }
}
