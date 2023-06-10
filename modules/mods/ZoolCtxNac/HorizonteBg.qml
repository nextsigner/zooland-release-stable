import QtQuick 2.0

Item {
    id: r
    width: xApp.width
    height: width
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    property int posSol: 3
    onPosSolChanged: {
//        bgSol3.visible=false
//        bgSol0y2.visible=false
//        bgSol1.visible=false
//        if(posSol===3){
//            bgSol3.visible=true
//            bgSol0y2.visible=false
//            bgSol1.visible=false
//        }
//        if(posSol===1){
//            bgSol3.visible=false
//            bgSol0y2.visible=false
//            bgSol1.visible=true
//        }
    }
    Rectangle{
        id: bgSol0y2
        visible: r.posSol===0  || r.posSol===2
        anchors.fill: parent
        rotation: 180
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#b78806";
            }
            GradientStop {
                position: 0.20;
                color: "#009dff";
            }
            GradientStop {
                position: 1.00;
                color: "#009dff";
            }
        }
        //anchors.centerIn: parent
    }
    Rectangle{
        id: bgSol1
        visible: r.posSol===1
        anchors.fill: r//parent
        rotation: 180
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#ffffff";
            }
            GradientStop {
                position: 0.20;
                color: "#009dff";
            }
            GradientStop {
                position: 1.00;
                color: "#009dff";
            }
        }
        //anchors.centerIn: parent
    }
    Rectangle{
        id: bgSol3
        visible: r.posSol===3
        anchors.fill: r//parent
        rotation: 180
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#184fa8";
            }
            GradientStop {
                position: 0.10;
                color: "#0a496d";
            }
            GradientStop {
                position: 1.00;
                color: "#000000";
            }
        }
        //anchors.centerIn: parent
    }

    //-->Cesped
    Row{
        spacing: app.fs*1.5
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.bottomMargin: app.fs*0.5
        //rotation: 180
        Repeater{
            model: 20
            Item{
                width: app.fs*0.5
                height: width
                //rotation: index===2 || index===6 || index===9 || index===12 || index===15 || index===20?180:0
                Image {
                    source: "cesped.png"
                    width: app.fs*1.5
                    height: app.fs*0.5
                    fillMode: Image.PreserveAspectFit
                    anchors.bottom: parent.bottom
                    mirror: index===2 || index===6 || index===9 || index===12 || index===15 || index===20?180:0
                }
            }

        }
    }
    Row{
        spacing: app.fs*0.25
        anchors.bottom: r.bottom
        anchors.horizontalCenter: r.horizontalCenter
        Repeater{
            model: 30
            Item{
                width: app.fs*0.75
                height: width
                //rotation: index===2 || index===6 || index===9 || index===12 || index===15 || index===20?180:0
                Image {
                    source: "cesped.png"
                    width: app.fs*0.75
                    height: app.fs*0.5
                    fillMode: Image.PreserveAspectFit
                    anchors.bottom: parent.bottom
                    //mirror: index===2 || index===6 || index===9 || index===12 || index===15 || index===20?180:0
                }
            }

        }
    }
    //<--Cesped

    Row{
        spacing: app.fs*3
        anchors.bottom: r.bottom
        anchors.horizontalCenter: r.horizontalCenter
        anchors.bottomMargin: app.fs*3
        Repeater{
            model: 4
            Item{
                width: app.fs*3+(app.fs*(index + 1))
                height: width
                Image {
                    id: imgNube
                    source: "nube_"+parseInt(index +1)+".svg"
                    width: app.fs*3
                    height: width
                    fillMode: Image.PreserveAspectFit
                    anchors.bottom: parent.bottom
                }
            }

        }
    }
    Row{
        spacing: app.fs*1.5
        anchors.bottom: r.bottom
        anchors.horizontalCenter: r.horizontalCenter
        anchors.bottomMargin: app.fs*3
        rotation: 180
        Repeater{
            model: 4
            Item{
                width: app.fs*1.5+(app.fs*(index + 1))
                height: width
                Image {
                    source: "nube_"+parseInt(index +1)+".svg"
                    width: app.fs*1.5
                    height: width
                    fillMode: Image.PreserveAspectFit
                    anchors.bottom: parent.bottom
                }
            }
        }
    }

}
