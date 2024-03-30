import QtQuick 2.12

Rectangle{
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property int svIndex: zsm.currentIndex
    property int itemIndex: -1
    property bool noFoundFileExistNofify: false
    property bool fileInitLoaded: false
    property int fs: app.fs*0.75
    property bool showAreaVideo: true
    property alias text: txtAboutZool.text
    property alias fontSize: txtAboutZool.font.pixelSize
    property string uFile: ''
    property string uData: ''
    property alias areaCamera: cameraArea
    onVisibleChanged: {
        //if(visible)zoolVoicePlayer.stop()
        if(visible)zoolVoicePlayer.speak('Sección de Información', true)
    }
    Column{
        id: col0
        anchors.centerIn: parent
        Rectangle{
            id: xTxtAboutZool
            width: r.width
            height: r.height-cameraArea.height
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            clip: true
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if (mouse.button === Qt.RightButton) {
                        tTxtAboutZool.running=false
                        if(tTxtAboutZool.v<txtAboutZool.aData.length-1){
                            tTxtAboutZool.v++
                        }else{
                            tTxtAboutZool.v=0
                        }
                        txtAboutZool.text=txtAboutZool.aData[tTxtAboutZool.v]
                        txtAboutZool.setTxt()
                    }else{
                        tTxtAboutZool.running=!tTxtAboutZool.running
                    }
                }
            }
            Text{
                id: txtAboutZool
                text: (''+aData[0]).indexOf('import ')<0?aData[0]:aData[1]
                font.pixelSize: r.fs
                color: 'white'
                width: r.width-app.fs
                anchors.centerIn: parent
                //textFormat: Text.MarkdownText
                wrapMode: Text.WordWrap
                //onLinkActivated: Qt.openUrlExternally(link)
                property var aData: []
                property real nextFS: 1.0
                Behavior on opacity{NumberAnimation{duration: 1500}}
                onOpacityChanged: {
                    if(opacity===0.0){
                        setTxt()
                    }
                }
                function setTxt(){
                    txtAboutZool.font.pixelSize=app.fs*nextFS
                    if(txtAboutZool.aData[tTxtAboutZool.v].indexOf('import')===0){

                        let comp=Qt.createQmlObject(txtAboutZool.aData[tTxtAboutZool.v], app, 'qmlcodeargFs')
                        //tTxtAboutZool.v++
                        txtAboutZool.text=txtAboutZool.aData[tTxtAboutZool.v]
                        tTxtAboutZool.running=true
                        txtAboutZool.opacity=1.0
                    }else{
                        txtAboutZool.text=txtAboutZool.aData[tTxtAboutZool.v]
                        tTxtAboutZool.running=true
                        txtAboutZool.opacity=1.0
                    }
                }
                Timer{
                    id: tDataChangedCheck
                    running: tTxtAboutZool.running
                    repeat: true
                    interval: 3000
                    onTriggered: {
                        let data=unik.getFile(r.uFile)
                        if(r.uData!==data){
                            //log.ls('Diferente', 300, 500)
                            //tTxtAboutZool.stop()
                            //tTxtAboutZool.v=0
                            //loadZoolText()
                        }else{
                            //log.ls('Igual', 300, 500)
                        }
                    }
                }
                Timer{
                    id: tTxtAboutZool
                    running: zsm.currentIndex===0 && aTimes.length>0
                    repeat: true
                    interval: aTimes[0]
                    property int v: 0
                    property var aTimes: []
                    property var aFs: []
                    onVChanged: {
                        if(!aTimes[v])return
                        interval=aTimes[v]
                        txtAboutZool.nextFS=parseFloat(aFs[v])
                        //txtAboutZool.font.pixelSize=app.fs*parseFloat(aFs[v])
                    }
                    onTriggered: {
                        if(v<txtAboutZool.aData.length-1){
                            v++
                        }else{
                            loadZoolText()
                            v=0
                        }
                        txtAboutZool.opacity=0.0
                        running=false
                    }
                }
            }
        }

        Rectangle{
            id: cameraArea
            width: r.width
            height: r.showAreaVideo?apps.currentZoolTextRectCamHeight:1
            color: apps.backgroundColor
            border.width: cameraArea.height===1?0:1
            border.color: apps.fontColor
            MouseArea{
                width: cameraArea.width
                height: cameraArea.height===1?app.fs:cameraArea.height
                anchors.bottom: parent.bottom
                //anchors.topMargin: cameraArea.height===0?0-app.fs:0
                onWheel: {
                    if(wheel.angleDelta.y>=0){
                        if(apps.currentZoolTextRectCamHeight<xApp.height*0.5){
                            apps.currentZoolTextRectCamHeight++
                        }
                    }else{
                        if(apps.currentZoolTextRectCamHeight>app.fs*3){
                            apps.currentZoolTextRectCamHeight--
                        }
                    }
                }
                onClicked: {
                    if (mouse.modifiers & Qt.ControlModifier) {
                        apps.repLectW=r.width-r.border.width*2
                        apps.repLectH=cameraArea.height
                        apps.repLectX=r.border.width
                        apps.repLectY=xApp.height-apps.repLectH
                        return
                    }
                    if(cameraArea.height===1){
                        cameraArea.height=apps.currentZoolTextRectCamHeight
                    }else{
                        cameraArea.height=1
                    }
                }
            }
            Timer{
                running: apps.repLectX>r.width-app.fs*2 || apps.repLectY>xApp.height-app.fs*2
                repeat: false
                interval: 3000
                onTriggered: {
                    apps.repLectW=r.width-r.border.width*2
                    apps.repLectH=cameraArea.height
                    apps.repLectX=r.border.width
                    apps.repLectY=xApp.height-apps.repLectH
                }
            }
        }
    }
    //    Text{
    //        text: 'I: '+tTxtAboutZool.interval+' v: '+tTxtAboutZool.v+' fs: '+tTxtAboutZool.aFs[tTxtAboutZool.v]
    //        font.pixelSize: 30
    //        color: 'red'
    //    }
    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Información')
        let currentFileZoolText='./resources/zooltext.txt'
        let appArgs=Qt.application.arguments
        let arg=''
        for(var i=0;i<appArgs.length;i++){
            let a=appArgs[i]
            if(a.indexOf('tempzooltext')>=0){
                let ma=a.split('=')
                if(ma.length>1){
                    arg=ma[1]
                }
            }
        }
        if(arg!==''){
            if(!unik.fileExist(arg)&&!r.noFoundFileExistNofify){
                r.noFoundFileExistNofify=true
                log.l('El archivo ingresado mediante el parámetro tempzooltext no existe.')
                log.l('Archivo tempzooltex: '+arg)
                log.l('Cargando archivo por defecto tempzooltex: '+fp)
                log.visible=true
                //data=unik.getFile(fp)
            }
            currentFileZoolText=arg
        }
        //log.ls('Loading ZoolDataText: '+currentFileZoolText, 0, 500)
        setFilePath(currentFileZoolText)
        //log.ls('uFile: '+r.uFile, 0, 500)
        loadZoolText()
    }
    function setFilePath(newFilePath){
        r.uFile=newFilePath
    }
    function loadZoolText(){
        let fp
        let data=unik.getFile(r.uFile)
        //log.ls('Data of ZoolDataText: '+data, 0, 500)
        r.uData=data
        var aD=[]
        var aT=[]
        var aF=[]
        var aS=data.split('---')
        for(var i=0;i<aS.length;i++){
            let dato=aS[i]
            let code=''
            let mAC
            if(dato.indexOf('time=')<0&&dato.indexOf('qml=')<0&&dato.indexOf('zfs=')<0){
                aD.push(aS[i])
            }else if(dato.indexOf('zfs=')>=0){
                code='import QtQuick 2.0\n'
                code+='Item{\n'
                code+=' Component.onCompleted:{\n'
                let mLines=aS[i].split('\n')
                let mTime
                if(i===0){
                    mAC=mLines[0].split('zfs=')
                    mTime=mLines[1].split('time=')
                }else{
                    mAC=mLines[1].split('zfs=')
                    mTime=mLines[2].split('time=')
                }
                if(mAC.length>1 && mTime.length > 1){
                    //code=mAC[1]
                    aT.push(parseInt(mTime[1]))
                    code+='     panelZoolText.fontSize='+mAC[1]+'\n'
                    code+=' }\n'
                    code+='}\n'
                    aF.push(mAC[1])
                    //aD.push(code)
                    //log.ls('Code: '+code, 0, 500)
                    //let comp=Qt.createQmlObject(code, app, 'qmlcodeargFs')
                }else{
                    log.l('Error en carga de código qml en archivo '+arg)
                    log.l('mLines:'+mLines.toString())
                    log.visible=true
                }
            }else if(dato.indexOf('qml=')>=0){
                code=''
                mAC=aS[i].split('qml=')
                if(mAC.length>1){
                    code=mAC[1]
                    let comp=Qt.createQmlObject(code, app, 'qmlcodearg')
                }else{
                    log.l('Error en carga de código qml en archivo '+arg)
                    log.visible=true
                }
            }else{
                let mAT=aS[i].split('=')
                if(mAT.length>1){
                    aT.push(parseInt(mAT[1]))
                }else{
                    aT.push(12000)
                }
            }
        }

        //Se agrega vacio al final
        aD.push('')
        aT.push(100)
        aF.push(0.0)

        txtAboutZool.aData=aD
        tTxtAboutZool.aTimes=aT
        tTxtAboutZool.aFs=aF
        tTxtAboutZool.interval=aT[0]
        txtAboutZool.font.pixelSize=app.fs*parseFloat(aF[0])
    }
}
