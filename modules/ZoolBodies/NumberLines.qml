import QtQuick 2.0

Item{
    id: r
    width: !apps.showDec?signCircle.width-(!app.ev?apps.signCircleWidth:0):signCircle.width-(!app.ev?apps.signCircleWidth*3:apps.signCircleWidth*2)
    height: width
    anchors.centerIn: parent
    rotation: signCircle.rot
    visible: apps.showNumberLines
    property bool fnd: false //full number degree count
    Repeater{
        model: 360
        Item{
            width: parent.width-signCircle.w
            height: 1
            rotation: index
            anchors.centerIn: parent
            Rectangle{
                width: sweg.fs*0.25
                height: 1
                //y:0-1
                color: 'white'
                antialiasing: true
            }
        }
    }
    Repeater{
        model: 36
        Item{
            width: parent.width-signCircle.w
            height: 1
            rotation: index*10
            anchors.centerIn: parent
            Rectangle{
                width: sweg.fs*0.35
                height: 3
                y:-1
                color: 'white'
                antialiasing: true
            }
        }
    }
    Repeater{
        model: 36
        Item{
            width: parent.width-signCircle.w
            height: 1
            rotation: index*10
            anchors.centerIn: parent
            Rectangle{
                width: sweg.fs*0.35
                height: width
                x:sweg.fs*0.25
                y:0-width*0.5
                radius: width*0.5
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                rotation: 360-parent.rotation-signCircle.rot
                MouseArea{
                    anchors.fill: parent
                    onClicked: r.fnd=!r.fnd
                }
                Text{visible: r.fnd;text: 360-(index*10)===360?0:360-(index*10);font.pixelSize: parent.width*0.4;color: apps.fontColor;anchors.centerIn: parent;}
                Text{
                    visible: !r.fnd;
                    font.pixelSize: parent.width*0.4;
                    color: apps.fontColor;
                    anchors.centerIn: parent;
                    Component.onCompleted: {
                        if(index===1||index===4||index===7||index===10||index===13||index===16||index===19||index===22||index===25||index===28||index===31||index===34){
                            //parent.color='red'
                            text='20'
                        }else if(index===2||index===5||index===8||index===11||index===14||index===17||index===20||index===23||index===26||index===29||index===32||index===35){
                            //parent.color='green'
                            text='10'
                        }else{
                            //parent.color='blue'
                            text='0'
                        }
                    }
                }
            }
        }
    }
}
