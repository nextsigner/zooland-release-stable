import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

ApplicationWindow {
    id: app
    visible: true
    visibility: "Windowed"
    width: 400
    height: col.height+app.fs
    color: 'black'
    y:50
    x: (Screen.width-app.width)*0.5
    title: 'Información: Python no está instalado.'
    property int fs: Screen.width*0.02
    Column{
        id: col
        spacing: app.fs
        width: app.width
        anchors.centerIn: parent
        Text{
            text: '<h3>Descarga e instala Python 3 en tu equipo!</h3>'
            width: app.width-app.fs
            wrapMode: Text.WordWrap
            font.pixelSize: app.fs*0.5
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text{
            id: txt
            text: 'Esta aplicación requiere que tengas instalador Python en tu ordenador para que Zool pueda realizar los cálculos y operaciones.\n\nConjuntamente con el instalador de esta aplicación se provee un instalador de Python rápido y sensillo.\n\nDescárgalo, instálalo y todo funcionará correctamente.\n\nSitio de Descarga Oficial: http://www.zool.ar\n\nSi necesitas ayuda contáctame al correo nextsigner@gmail.com.\n\nAtentamente Ricardo Martín Pizarro Whatsapp +549 11 3802 4370'
            width: app.width-app.fs
            wrapMode: Text.WordWrap
            font.pixelSize: app.fs*0.5
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Row{
            spacing: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                text: "Cancelar"
                onClicked: Qt.quit()
            }
            Button{
                text: "Ir a la página de descarga"
                onClicked: {
                    let d=new Date(Date.now())
                    let url='http://zool.ar/descargar/'
                    url+='?r='+d.getTime()
                    unik.run('cmd /c start chrome.exe "'+url+'"')
                }
            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
}
