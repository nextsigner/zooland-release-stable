import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.1

ApplicationWindow {
    id: app
    visible: true
    visibility: "Maximized"
    color: 'black'
    width: Screen.width
    height: Screen.height
    property int fs: width*0.02
    Settings{
        id: apps
        fileName:'/tmp/zool_'+Qt.platform.os+'.cfg'
        property string host: 'http://localhost'
        property bool newClosed: false

        property string url: ''
        property string urlBack: ''
        property bool showTimes: false
        property bool showLupa: false
        property bool showSWEZ: true
        property bool showDec: false

        //Houses
        property string defaultHsys: 'T'
        property string currentHsys: 'T'
        property string houseColor: "#2CB5F9"
        property string houseColorBack: 'red'
        property bool showHousesAxis: false
        property int widthHousesAxis: 3.0
        property string houseLineColor: 'white'
        property string houseLineColorBack: 'red'

        //XAs
        property color xAsColor: 'white'
        property color xAsColorBack: 'black'
        property color xAsBackgroundColorBack: 'white'
        property real xAsBackgroundOpacityBack: 0.5
        property bool anColorXAs: false

        //Swe
        property string swegMod: 'ps'
        property bool showNumberLines: true
        property int sweFs: Screen.width*0.02
        property bool showAspCircle: true
        property bool showAspCircleBack: true

        //GUI
        property bool showLog: false
        property bool showMenuBar: true
        property bool enableBackgroundColor: false
        property string backgroundColor: "black"
        property string fontFamily: "ArialMdm"
        property string fontColor: "white"
        property int fontSize: app.fs*0.5
        property int botSize: app.fs*0.5
        property int botSizeSpinBoxValue: 50
        property real elementsFs: Screen.width*0.02

        property int lupaMod: 2
        property int lupaBorderWidth: 3
        property string lupaColor: "white"
        property real lupaOpacity: 0.5
        property int lupaRot: 0
        property int lupaX: Screen.width*0.5
        property int lupaY: Screen.height*0.5
        property int lupaAxisWidth: 1
        property int lupaCenterWidth: 20

        property int editorFs: Screen.width*0.01
        property bool editorShowNumberLines: false
        property int editorTextFormat: 0

        //Panel AspTrans
        property int currentIndexP1: 0
        property int currentIndexP2: 0
        property int currentIndexAsp: 0
        property int currentAspCantAniosSearch: 20

        property bool chat: false

        property bool backgroundImagesVisible: false
        property bool lt:false
        property bool enableFullAnimation: false

        property string jsonsFolder: documentsPath
        onEnableBackgroundColorChanged: {
            if(enableBackgroundColor){
                ip.hideSS()
            }else{
                ip.showSS()
            }
        }
        Component.onCompleted: {
            //fontSize=app.fs*0.5
            //fontColor='red'
            //backgroundColor='yellow'
            /*if(!jsonsFolder){
                console.log('Seteando jsonsFolder...')
                let docFolder=unik.getPath(3)
                let jsonsFolderString=docFolder+'/Zool/jsons'
                if(!unik.folderExist(jsonsFolderString)){
                    console.log('Creando carpeta '+jsonsFolderString)
                    unik.mkdir(jsonsFolderString)
                }else{
                    console.log('Definiendo carpeta '+jsonsFolderString)
                }
                apps.jsonsFolder=jsonsFolderString
            }
            //fileName=jsonsFolder+'/zool_'+Qt.platform.os+'.cfg'*/
        }
    }

    NumCiclosVida{
        id: numCiclosVida
        anchors.fill: parent
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: app.close()//Qt.quit()
    }
}
