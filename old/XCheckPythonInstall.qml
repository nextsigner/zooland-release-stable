import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import unik.UnikQProcess 1.0

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

//    Connections{
//        target: unik
//        onLog:{
//            app.color='green'
//        }
//        onUkStdChanged:{
//                //app.color='blue'
//            txt.text=unik.getUkStd()
//        }
//        onUkStdErrChanged:{
//                app.color='yellow'
//            //txt.text=unik.getUkStd()
//        }
//        Component.onCompleted: {
//            unik.run('dir')
//            //unik.run('python ./py/astrologica_swe.py')
//        }
//    }

    //    UnikQProcess{
//        id: uqp
//        onLogDataChanged: {
//            console.log('UQP LogData: '+logData)
//            txt.text=logData
//        }

//    }
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
            text: (isPythonInPath?'Código de error: 101':'Código de error: 100')+'\n\nEsta aplicación requiere que tengas instalador Python en tu ordenador para que Zool pueda realizar los cálculos y operaciones.\n\nConjuntamente con el instalador de esta aplicación se provee un instalador de Python rápido y sensillo.\n\nDescárgalo, instálalo y todo funcionará correctamente.\n\nSi necesitas ayuda contáctame al correo nextsigner@gmail.com.\n\nAtentamente Ricardo Martín Pizarro Whatsapp +549 11 3802 4370'
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
                    let url='https://raw.githubusercontent.com/nextsigner/zool/main/python_download_url'
                    url+='?r='+d.getTime()
                    Qt.openUrlExternally(url)
                }
            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Component.onCompleted: {
        let d=new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        let json=(\'\'+logData).replace(/\\n/g, \'\')\n'
        //c+='            txt.text=logData\n'
        //c+='            console.log(logData)\n'
        c+='        uqp'+ms+'.destroy(0)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        //c+='        run(\'E:/zool/Python/python.exe E:/zool/py/astrologica_swe_search_asc_aries.py '+20+' '+6+' '+1975+' '+23+' '+4+' -3 -58 -34 E:/zool/py\')\n'
        //c+='        run(\'where python.exe\')\n'
        c+='        run(\'cmd /c echo %PATH%\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, app, 'uqpcodesign')
    }
}
