import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: r
    width: parent.width//sweg.fs*4
    height: width
    anchors.centerIn: parent
    z:r.parent.z-1
    rotation: 0-signCircle.rotation
    property string folderImg: '../../modules/ZoolBodies/ZoolAs/imgs_v1'
    property int iconoSignRot: 0
    property int is: -1
    property int gdeg: -1
    property int mdeg: -1
    property int sdeg: -1
    property int rsgdeg: -1
    property int ih: -1
    property bool expand: false
    property int wtc: (sweg.fs*0.5)/(sweg.xs*0.5) //width of each circle de triple circle
    property int p: -1
    property alias pointerRot: eje.rotation
    property int pointerFs: app.fs*5.5
    property real xs: sweg.xs
    property var aMargins: [0.5, 0.3, 0.4, 0.4, 0.4, 0.5, 0.5, 0.5, 0.4, 0.3, 0.5, 0.5, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]

    property bool isBack: false

    onOpacityChanged: {
        if(opacity===1.0)setPointerFs()
    }
    onXsChanged: {
        setPointerFs()
    }
    function setPointerFs(){
        let f1=0.4
        let f2=0.5
        let f3=2.0
        for(var i=0;i<46;i++){
            f1+=0.1
            f2+=0.1
            f3+=0.25
            if(r.xs>=f1&&r.xs<f2){
                pointerFs=app.fs*5.5/f3
                break
            }
        }
    }
    Rectangle{
        id: eje
        width: r.width
        height: width
        color: 'transparent'
        //color: 'red'
        anchors.centerIn: parent
        Rectangle{
            width: r.pointerFs*5
            height: apps.pointerLineWidth
            //color: apps.pointerLineColor
            //color: borde.border.color
            color: rectData.border.color
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: apps.xAsShowIcon?r.width*(r.aMargins[r.p]):r.width*0.5+sweg.fs*0.25
            Rectangle{
                id: rectData
                width: col.width+r.pointerFs*0.5
                height: col.height+r.pointerFs*0.5
                color: apps.fontColor
                border.width: 3
                border.color: apps.pointerLineColor
                radius: r.pointerFs*0.25
                //rotation: r.iconoSignRot-eje.rotation
                rotation: !r.isBack?
                              r.iconoSignRot-eje.rotation
                            :
                              r.iconoSignRot-eje.rotation-sweg.objPlanetsCircleBack.rotation
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.top
                SequentialAnimation on border.color {
                    running: !app.capturing
                    loops: Animation.Infinite
                    onRunningChanged: {
                        if(!running)rectData.border.color=apps.pointerLineColor
                    }
                    ColorAnimation { from: apps.pointerLineColor; to: apps.fontColor; duration: 200 }
                    ColorAnimation { from: apps.fontColor; to: apps.pointerLineColor; duration: 200 }
                    ColorAnimation { from: apps.pointerLineColor; to: apps.backgroundColor; duration: 200 }
                    ColorAnimation { from: apps.backgroundColor; to: apps.pointerLineColor; duration: 200 }
                }
                Column{
                    id: col
                    spacing: r.pointerFs*0.25
                    anchors.centerIn: parent
                    Row{
                        spacing: r.pointerFs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Rectangle{
                            width: r.pointerFs//*0.8
                            height: width
                            radius: width*0.5
                            color: apps.fontColor
                            border.width: 2
                            border.color: apps.backgroundColor
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                id: img0
                                //source: "../../resources/imgs/planetas/"+app.planetasRes[r.p]+".svg"
                                source: r.folderImg+"/"+app.planetasRes[r.p]+".svg"
                                width: parent.width*0.8
                                height: width
                                anchors.centerIn: parent
                                antialiasing: true
                                visible: false
                            }
                            ColorOverlay {
                                id: co0
                                anchors.fill: img0
                                source: img0
                                color: apps.backgroundColor
                                //rotation: img1.rotation
                                antialiasing: true
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: apps.xAsShowIcon=!apps.xAsShowIcon
                            }
                        }
                        Rectangle{
                            width: r.pointerFs//*0.8
                            height: width
                            radius: width*0.5
                            color: apps.fontColor
                            border.width: 2
                            border.color: apps.backgroundColor
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                id: img1
                                source: r.is>=0?"../../resources/imgs/signos/"+r.is+".svg":""
                                width: parent.width*0.8
                                height: width
                                anchors.centerIn: parent
                                antialiasing: true
                                visible: false
                            }
                            ColorOverlay {
                                id: co1
                                anchors.fill: img1
                                source: img1
                                color: apps.backgroundColor
                                //rotation: img1.rotation
                                antialiasing: true
                            }
                        }

                    }
                    Row{
                        spacing: r.pointerFs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: app.planetas[r.p]+' en '+app.signos[r.is]
                            font.pixelSize: r.pointerFs*0.5
                            color: apps.backgroundColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        spacing: r.pointerFs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: 'En el grado °'+r.rsgdeg+'\''+r.mdeg
                            font.pixelSize: r.pointerFs*0.5
                            color: apps.backgroundColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        spacing: r.pointerFs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: 'Casa '
                            font.pixelSize: r.pointerFs*0.5
                            color: apps.backgroundColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Rectangle{
                            width: r.pointerFs*0.8
                            height: width
                            radius: width*0.5
                            color: apps.fontColor
                            border.width: 2
                            border.color: apps.backgroundColor
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                id: img2
                                source: "../../resources/imgs/casa.svg"
                                width: parent.width*0.8
                                height: width
                                rotation: r.iconoSignRot + 180 - r.rotation
                                antialiasing: true
                                visible: false
                                anchors.centerIn: parent
                            }
                            ColorOverlay {
                                id: co2
                                anchors.fill: img2
                                source: img2
                                color: apps.backgroundColor
                                //rotation: img1.rotation
                                antialiasing: true
                            }
                            Text{
                                font.pixelSize: r.ih<=9?parent.width*0.6:parent.width*0.4
                                text: '<b>'+r.ih+'</b>'
                                color: 'white'
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
            }
            Item{
                width: apps.pointerLineWidth*4
                height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 0-width*0.3
                rotation: 90
                Image{
                    id: imgFlecha
                    source: '../../resources/imgs/flecha.svg'
                    width: parent.width
                    height: width
                    anchors.centerIn: parent
                    visible: false
                }
                ColorOverlay {
                    id: co3
                    anchors.fill: imgFlecha
                    source: imgFlecha
                    color: rectData.border.color
                    antialiasing: true
                }
            }
        }
    }
}
