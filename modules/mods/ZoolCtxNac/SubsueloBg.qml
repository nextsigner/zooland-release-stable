import QtQuick 2.0

Item {
    id: r
    width: xApp.width
    height: width
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
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
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

    //-->Suelo subterraneo
    Column{
        //anchors.top: tierra1.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            width: app.width//*0.5
            height: r.width*0.5
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#93710d";
                }
                GradientStop {
                    position: 0.08;
                    color: "#aa8605";
                }
                GradientStop {
                    position: 0.18;
                    color: "#dd8f08";
                }
                GradientStop {
                    position: 0.30;
                    color: "#6d4706";
                }
                GradientStop {
                    position: 1.00;
                    color: "#6d4706";
                }
            }
        }
    }
    //<--Suelo subterraneo
    }
