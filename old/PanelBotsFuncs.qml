import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "./comps" as Comps
import "./js/Funcs.js" as JS
Rectangle {
    id: r
    color: apps.backgroundColor
    width: parent.width
    height: parent.height
    border.width: 2
    border.color: apps.fontColor
    clip: true
    property string htmlFolder: ''
    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property int numSign: 0
    property int numDegree: 0
    property int fs: width*0.025
    property real factorZoomByRes: 1.5
    property int currentInterpreter: 0

    property string uSAM: ''

    property int itemIndex: -1
    visible: itemIndex===sv.currentIndex

    Behavior on x{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Flickable{
        id: flk
        width: r.width
        height: r.height
        contentWidth: r.width
        contentHeight: rowTit.height+app.fs*3
        Behavior on contentY{NumberAnimation{duration: 250}}
        Column{
            id: rowTit
            spacing: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            Item{width: 1;height: app.fs}
            Text{
                text: '<b>Controles Adicionales</b>'
                font.pixelSize: app.fs
                color: apps.fontColor
                width: parent.width-app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Text.RichText
                wrapMode: Text.WordWrap
                onLinkActivated: Qt.openUrlExternally(link)
            }

            //Botones adicionales
            Rectangle{
                width: r.width-app.fs*0.5
                height: col1.height+app.fs*0.5
                color: 'transparent'
                border.width: 1
                border.color: apps.fontColor
                radius: app.fs*0.25
                Column{
                    id: col1
                    spacing: app.fs*0.25
                    anchors.centerIn: parent
                    Text{
                        text: 'Funciones'
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                        width: parent.parent.width-app.fs*0.5
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Column{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            text: app.ev?'Ocultar Exterior':'Ver Exterior'
                            font.pixelSize: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: app.ev=!app.ev
                        }
//                        Button{
//                            text: 'Eliminar Exterior'
//                            font.pixelSize: app.fs*0.5
//                            anchors.horizontalCenter: parent.horizontalCenter
//                            onClicked: {
//                                log.ls('apps.url: '+apps.url, 0, 500)
//                                log.ls('json: '+app.currentData, 0, 500)
//                            }
//                        }
                    }
                }
            }

            //Crear Archivo Carta Mundial de Ahora
            Rectangle{
                width: r.width-app.fs*0.5
                height: col2.height+app.fs*0.5
                color: 'transparent'
                border.width: 1
                border.color: apps.fontColor
                radius: app.fs*0.25
                Column{
                    id: col2
                    spacing: app.fs*0.25
                    anchors.centerIn: parent
                    Text{
                        text: 'Cargar archivo de Carta Mundial'
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                        width: parent.parent.width-app.fs*0.5
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Column{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            text: 'Cargar'
                            font.pixelSize: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: {
                                var offset = new Date().getTimezoneOffset();
                                //console.log('Zool GMT Client: '+offset);
                                let date0=new Date(Date.now())
                                date0=date0.setMinutes(date0.getMinutes()+offset)
                                //let d1=new Date.UTC(2021,7,20,11,34,0)
                                var date = new Date(date0);
                                var now_utc =  Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate(),
                                                        date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds());

                                let d1=new Date(now_utc);
                                //console.log('Zool United KIngston Hour: '+d1.toString());
                                JS.loadFromArgs(d1.getDate(), parseInt(d1.getMonth() +1),d1.getFullYear(), d1.getHours(), d1.getMinutes(), 0.0,53.4543314,-2.113293483429562,6, "United Kingston "+d1.getDate()+"-"+parseInt(d1.getMonth() +1)+"-"+d1.getFullYear(), "United Kingston England", "vn", false)
                            }
                        }
                        Button{
                            text: 'Cargar en el Exterior'
                            font.pixelSize: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: {
                                var offset = new Date().getTimezoneOffset();
                                //console.log('Zool GMT Client: '+offset);
                                let date0=new Date(Date.now())
                                date0=date0.setMinutes(date0.getMinutes()+offset)
                                //let d1=new Date.UTC(2021,7,20,11,34,0)
                                var date = new Date(date0);
                                var now_utc =  Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate(),
                                                        date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds());

                                let d1=new Date(now_utc);
                                //console.log('Zool United KIngston Hour: '+d1.toString());
                                JS.loadFromArgsBack()(d1.getDate(), parseInt(d1.getMonth() +1),d1.getFullYear(), d1.getHours(), d1.getMinutes(), 0.0,53.4543314,-2.113293483429562,6, "United Kingston "+d1.getDate()+"-"+parseInt(d1.getMonth() +1)+"-"+d1.getFullYear(), "United Kingston England", "vn", false)
                            }
                        }
                    }
                }
            }

            //Astromedicina
            Rectangle{
                width: r.width-app.fs*0.5
                height: col3.height+app.fs*0.5
                color: 'transparent'
                border.width: 1
                border.color: apps.fontColor
                radius: app.fs*0.25
                Column{
                    id: col3
                    spacing: app.fs*0.25
                    anchors.centerIn: parent
                    Text{
                        text: 'Astromedicina'
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                        width: parent.parent.width-app.fs*0.5
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    //Información General de Astromedicina.
                    Button{
                        text: 'Ver Información'
                        font.pixelSize: app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            xInfoData.loadData('./resources/astromedicina.html')
                        }
                    }
                }
            }

        }
    }
}
