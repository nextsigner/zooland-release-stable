import QtQuick 2.12
import QtQuick.Controls 2.12

Item{
    id:r

    readonly property real lineHeight: (te.implicitHeight - 2 * te.textMargin) / te.lineCount
    readonly property alias lineCount: te.lineCount

    property bool showNumberLines: apps.editorShowNumberLines
    property bool wordWrap: true
    property alias text: te.text
    property alias textEdit: te

    property int fs: 16
    property color color:apps.fontColor
    property color backgroundColor:apps.backgroundColor
    property string text:''

    property int col: 0
    property int lin: 0

    property int numberLinesWidth: 0

    property string cursorColor: apps.fontColor
    property bool showPrevCursor: false

    onWidthChanged: te.setPos()
    Rectangle{
        anchors.fill: parent
        color: apps.backgroundColor
    }
    Flickable{
        id:flTE
        width: r.width
        height:r.height
        contentWidth: r.width//te.contentWidth//*1.5
        contentHeight: te.contentHeight+r.fs//*1.5
        boundsBehavior: Flickable.StopAtBounds
        ScrollBar.horizontal: ScrollBar{}
        ScrollBar.vertical: ScrollBar{
            //background: Rectangle{color: 'red'}
        }
        //x:((''+te.lineCount).length)*r.fs
        Row{
            spacing: app.fs*0.1
            anchors.left: parent.left
            anchors.leftMargin: r.showNumberLines?r.fs*0.1:r.fs
            Rectangle{
                id:xColNLI
                color:r.backgroundColor
                width: ((''+te.lineCount).length)*r.fs
                height: colNLI.height
                y:xTE.y
                visible: r.showNumberLines
                //anchors.right: xTE.left
                Rectangle{
                    width: 1
                    height: xTE.height
                    anchors.right: parent.right
                    color: r.color
                }

                Column{
                    id:colNLI
                    width: parent.width-2
                    Repeater{
                        model:te.lineCount
                        Item{
                            id:xNlI
                            width:(nli.text.length-8)*r.fs
                            height: r.lineHeight//r.fs*1.1
                            anchors.right: parent.right
                            onWidthChanged: {
                                r.numberLinesWidth=width
                            }
                            Text {
                                id:nli
                                text: '<b>'+parseInt(index+1)+'.</b>'
                                font.pixelSize: parent.height*0.8
                                anchors.bottom:parent.bottom
                                anchors.right: parent.right
                                color: 'white'
                            }
                            //Component.onCompleted: colNL.width=nl.contentWidth
                        }
                    }
                }
            }
            Item{
                id:xTE
                width: r.showNumberLines?r.width-xTE.x-xTE.parent.spacing-r.fs:r.width-xTE.x-r.fs*2
                height: te.contentHeight

                TextEdit{
                    id:te
                    property string ccl: '.'
                    property string ccl2: '.'
                    text:r.text
                    font.pixelSize: r.fs
                    color: r.color
                    width: parent.width
                    height: r.height
                    wrapMode: TextEdit.WordWrap
                    cursorDelegate: Rectangle{
                        id:teCursor
                        width: tec.width;
                        height: r.fs
                        radius: width*0.5
                        color:'transparent'
                        onYChanged: {
                            if(y>flTE.contentY+r.height-height*2){
                                flTE.contentY=y-r.height+height*2
                            }
                            if(y<flTE.contentY){
                                flTE.contentY=y
                            }
                        }
                        Rectangle{
                            id:tec
                            width: cc.contentWidth;
                            height: r.fs
                            border.width: r.showPrevCursor?2:0
                            border.color: 'red'
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.left
                            color:'transparent'
                            visible:te.ccl!=='\n'
                            Text{
                                id:cc
                                text:te.ccl!==''&&te.ccl!=='\n'?te.ccl:' '
                                font.pixelSize: te.font.pixelSize
                                color: 'red'
                                anchors.centerIn: parent
                            }
                            Rectangle{
                                id:tecDer
                                width: ccDer.contentWidth;
                                height: r.fs
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.right
                                color: r.cursorColor
                                border.color:te.color
                                border.width:v?1:0
                                property bool v: true
                                Timer{
                                    running: true
                                    repeat: true
                                    interval: 500
                                    onTriggered:tecDer.v=!tecDer.v
                                }
                                Text{
                                    id:ccDer
                                    text:te.ccl2!==''&&te.ccl2!=='\n'?te.ccl2:' '
                                    font.pixelSize: te.font.pixelSize
                                    color: 'red'
                                    anchors.centerIn: parent
                                }
                            }

                        }
                        Item{
                            id:tecinit
                            width: ccinit.contentWidth;
                            height: r.fs
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: tec.right
                            visible:te.ccl==='\n'
                            Text{
                                id:ccinit
                                text:'\uf061'
                                font.family: 'FontAwesome'
                                font.pixelSize: te.font.pixelSize
                                color: 'red'
                                anchors.centerIn: parent
                            }
                        }
                    }
                    onTextChanged: {
                        te.setPos()
                    }
                    onCursorPositionChanged: te.setPos()
                    function setPos(){
                        //console.log('LLLLL:-'+te.text.substring(te.cursorPosition-1,te.cursorPosition)+'-')
                        te.ccl=te.text.substring(te.cursorPosition-1,te.cursorPosition)
                        te.ccl2=te.text.substring(te.cursorPosition,te.cursorPosition+1)
                        r.lin=parseInt(te.cursorRectangle.y/te.cursorRectangle.height) + 1
                    }
                }
            }
        }
    }
    Rectangle{
        anchors.fill: parent
        color: 'transparent'
        border.width: 2
        border.color: apps.fontColor
    }
}
