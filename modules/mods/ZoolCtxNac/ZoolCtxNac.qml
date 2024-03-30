import QtQuick 2.12
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

import ZoolButton 1.2

Item {
    id: r
    width: sweg.objSignsCircle.width*0.5
    height: width
    anchors.centerIn: parent
    parent: sweg
    visible: false
    property string folder: './modules/mods/'+app.j.qmltypeof(r)
    property real o: 0.25
    property string moduleName: 'Contexto de Nacimiento'
    property bool showAsCircle: true
    property bool showBrujula: false
    property bool showTxtInfo: false
    property string txtInfo: "Información"
    property string txtInfoC1: "Información Columna 1"
    property string txtInfoC2: "Información Columna 2"
    property string img1: ""
    property int fsz: app.fs*0.65
    property bool fse: false
    onVisibleChanged: {
        if(visible){
            sweg.centerZoomAndPos()
        }
    }
    MouseArea{
        anchors.fill: parent
        onWheel: {
            //apps.enableFullAnimation=false
            fakeSignCircle.rotation=sweg.objSignsCircle.rot
            let no=r.o
            if (wheel.modifiers & Qt.ControlModifier) {
                if(wheel.angleDelta.y>=0){
                    no+=0.1
                }else{
                    no-=0.1
                }
                r.o=no
            }else{
                //                if(wheel.angleDelta.y>=0){
                ////                    if(reSizeAppsFs.fs<app.fs*2){
                ////                        reSizeAppsFs.fs+=reSizeAppsFs.fs*0.1
                ////                    }else{
                ////                        reSizeAppsFs.fs=app.fs
                ////                    }
                //                    pointerPlanet.pointerRot+=45
                //                }else{
                ////                    if(reSizeAppsFs.fs>app.fs){
                ////                        reSizeAppsFs.fs-=reSizeAppsFs.fs*0.1
                ////                    }else{
                ////                        reSizeAppsFs.fs=app.fs*2
                ////                    }
                //                    pointerPlanet.pointerRot-=45
                //                }
            }
            //reSizeAppsFs.restart()
        }

        onClicked: {
            //horizonteBg.posSol=3
            r.showAsCircle=!r.showAsCircle
        }
        onDoubleClicked: {
            r.visible=false
        }
    }
    Rectangle{
        id: xCircle
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        radius: width*0.5
        visible: !r.showAsCircle
        opacity: r.o
        Item{
            id: xHorBg
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: img1.bottom
            //            HorizonteBg{
            //                id: horizonteBg

            //            }
        }
        SubsueloBg{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: img1.bottom
        }
        Image {
            id: img1
            source: "hospital.png"
            width: app.fs*3
            height: width
            fillMode: Image.PreserveAspectCrop
            //anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            cache: false
            anchors.bottom: parent.verticalCenter
        }
        Image {
            id: img2
            source: "sotano.png"
            width: img1.width
            height: width
            fillMode: Image.PreserveAspectCrop
            //anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            cache: false
            anchors.top:  img1.bottom
            //anchors.bottomMargin: height
        }
        //Arboles
        Image {
            source: "arbol_1.png"
            width: app.fs*6
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: img1.verticalCenter
            anchors.verticalCenterOffset: 0-app.fs*0.35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: img1.width*1.5
        }
        Brujula{
            opacity: r.showBrujula?1.0:0.0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-app.fs*3
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0-app.fs*3
        }
        Rectangle{
            id: xInfoNac
            anchors.horizontalCenter: imgFlecha.horizontalCenter
            anchors.bottom: imgFlecha.top
            anchors.bottomMargin: app.fs*0.5
            width:  r.showAsCircle?app.fs*6:app.fs*10
            height: txt3.contentHeight+app.fs
            border.width: 3
            border.color: 'black'
            radius: app.fs*0.5
            Text {
                id: txt3
                text: 'Lugar de Nacimiento'
                width: parent.width-app.fs
                font.pixelSize: r.showAsCircle?app.fs*0.5:app.fs*0.75
                wrapMode: Text.WordWrap
                anchors.centerIn: parent
            }
        }
        Image {
            id: imgFlecha
            source: "flecha.png"
            width: app.fs*2
            height: width*0.7
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: app.fs*3
            visible: false
        }
        ColorOverlay{
            anchors.fill: imgFlecha
            source: imgFlecha
            color: 'yellow'
            rotation: 90
            SequentialAnimation on color{
                running: true
                loops: Animation.Infinite

                ColorAnimation {
                    from: "red"
                    to: "yellow"
                    duration: 300
                }
                ColorAnimation {
                    from: "yellow"
                    to: "red"
                    duration: 300
                }
            }
        }
        Rectangle{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: app.fs*3
            width:  txt2.contentWidth+app.fs
            height: txt2.contentHeight+app.fs
            border.width: 3
            border.color: 'black'
            radius: app.fs*0.5
            Text {
                id: txt2
                text: '<b>Bajo tierra</b>'
                font.pixelSize: app.fs
                anchors.centerIn: parent
            }
        }
    }
    Rectangle{
        id: xCircleMask
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        radius: width*0.5
        visible: r.showAsCircle
        opacity: r.o
    }
    OpacityMask {
        anchors.fill: xCircle
        source: xCircle
        maskSource: xCircleMask
        visible: r.showAsCircle
        opacity: r.o
    }
    Rectangle{
        id: fakeSignCircle
        anchors.fill: parent
        color: 'transparent'
        radius: width*0.5
        border.width: 0
        border.color: 'blue'
        //Behavior on rotation{NumberAnimation{duration: 500;}}
        Rectangle{
            id: fakeSignCircleAxis1
            width: parent.width*2
            height: 3
            anchors.centerIn: parent
            color: 'transparent'
        }
        Rectangle{
            id: fakeSolAxis
            width: parent.width-app.fs*2
            height: 3
            anchors.centerIn: parent
            color: 'transparent'
            opacity: r.o
            //Behavior on rotation{NumberAnimation{duration: 500;}}
            Rectangle{
                id: xFakeSol
                width: app.fs
                height: width
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: xFakeSol.solTipo>0?"#f38a27":"#333"
                radius: width*0.5
                property int solTipo: 0
                SequentialAnimation on color{
                    running: xFakeSol.solTipo===1 || xFakeSol.solTipo===2
                    loops: Animation.Infinite
                    ColorAnimation {
                        from: "#f38a27"
                        to: "yellow"
                        duration: 200
                    }
                    ColorAnimation {
                        from: "yellow"
                        to: "#f38a27"
                        duration: 200
                    }
                }
                SequentialAnimation on color{
                    running: xFakeSol.solTipo===3 || xFakeSol.solTipo===4
                    loops: Animation.Infinite
                    ColorAnimation {
                        from: "#f38a27"
                        to: "#ff8a27"
                        duration: 200
                    }
                    ColorAnimation {
                        from: "yellow"
                        to: "#ff8a27"
                        duration: 200
                    }
                }
                SequentialAnimation on color{
                    running: xFakeSol.solTipo===0
                    loops: Animation.Infinite
                    ColorAnimation {
                        from: "#000"
                        to: "#ff33ff"
                        duration: 1000
                    }
                    ColorAnimation {
                        from: "#ff33ff"
                        to: "#000"
                        duration: 1000
                    }
                }
                SequentialAnimation on color{
                    running: xFakeSol.solTipo===5
                    loops: Animation.Infinite
                    ColorAnimation {
                        from: "white"
                        to: "yellow"
                        duration: 200
                    }
                    ColorAnimation {
                        from: "yellow"
                        to: "white"
                        duration: 200
                    }
                }

                Repeater{
                    model: 12
                    Rectangle{
                        width: parent.width+app.fs*0.5
                        height: 2
                        color: parent.color
                        anchors.centerIn: parent
                        rotation: index*30
                    }
                }
                Text{
                    text: '<b>SOL</b>'
                    font.pixelSize: parent.width*0.4
                    color: xFakeSol.solTipo>0?"black":"white"
                    anchors.centerIn: parent
                    rotation: 360-fakeSignCircle.rotation-fakeSolAxis.rotation
                }
            }
        }
    }
    //    Text{
    //        text: '-...'+horizonteBg.posSol
    //        font.pixelSize: 80
    //        color: 'red'
    //        anchors.centerIn: parent
    //    }
    Component{
        id: comp
        Rectangle{
            id: xPanel
            //width: zsm.getPanel('ZoolModulesManager').width-app.fs*0.25
            width: xLatIzq.width-app.fs*0.25
            height: col.height+app.fs
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            radius: app.fs*0.25
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            property bool showPanel: false
            Behavior on height{
                NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}
            }
            Column{
                id: col
                anchors.centerIn: parent
                Rectangle{
                    width: xPanel.width-app.fs*0.5
                    height: app.fs*1.5
                    color: apps.fontColor
                    radius: app.fs*0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            xPanel.showPanel=!xPanel.showPanel

                        }
                    }
                    Text{
                        text: r.moduleName
                        font.pixelSize: app.fs
                        color: 'black'//apps.backgroundColor
                        anchors.centerIn: parent
                        opacity: t1.running?0.0:1.0
                        Behavior on opacity{
                            NumberAnimation{duration: 250}
                        }
                        Timer{
                            id: t1
                            running: parent.contentWidth>parent.parent.width-app.fs
                            repeat: true
                            interval: 100
                            onTriggered: parent.font.pixelSize-=1
                        }
                    }
                }
                Rectangle{
                    visible: xPanel.showPanel
                    width: parent.width
                    height: colBtns.height+app.fs*0.5
                    color: apps.backgroundColor
                    Column{
                        id: colBtns
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        ZoolButton{
                            text: r.visible?'Ocultar':'Mostrar'
                            fs: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: r.visible=!r.visible
                        }
                        ZoolButton{
                            visible: r.visible
                            text: r.showTxtInfo?'Ocultar Información':'Mostrar Información'
                            fs: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: r.showTxtInfo=!r.showTxtInfo
                        }
                        ZoolButton{
                            visible: r.visible
                            text: r.showAsCircle?'Mostrar Rectangular':'Mostrar Circulo'
                            fs: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: r.showAsCircle=!r.showAsCircle
                        }
                        ZoolButton{
                            visible: r.visible
                            text: r.showBrujula?'Ocultar Brújula':'Mostrar Brújula'
                            fs: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: r.showBrujula=!r.showBrujula
                        }
                    }

                }
            }


            //            Rectangle{
            //                width: parent.width
            //                height: app.fs*1.5
            //                color: apps.fontColor
            //                Text{
            //                    text: r.moduleName
            //                    font.pixelSize: app.fs
            //                    color: apps.backgroundColor
            //                    anchors.centerIn: parent
            //                    Timer{
            //                        id: t1
            //                        running: parent.contentWidth>parent.parent.width-app.fs
            //                        repeat: true
            //                        interval: 100
            //                        onTriggered: parent.font.pixelSize-=1
            //                    }
            //                }

            //            }


        }
    }
    Component{
        id: compInfo
        Rectangle{
            id: xPanelInfo
            width: !showMaximized?xLatDer.width:xApp.width//-app.fs*0.25
            height: !showMaximized?parent.height:parent.height+zoolDataView.height//+app.fs
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            radius: app.fs*0.25
            clip: true
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: !showMaximized?0:0-zoolDataView.height
            anchors.right: parent.right
            visible: r.showTxtInfo
            property bool showMaximized: false
            property bool objInFullWinPrev
            property bool showPanel: false
            onShowMaximizedChanged:{
                if(showMaximized){
                    if(app.objInFullWin){
                        objInFullWinPrev=app.objInFullWin
                    }
                    app.objInFullWin=xPanelInfo
                }else{
                    if(app.objInFullWinPrev){
                        app.objInFullWin=app.objInFullWinPrev
                    }else{
                        app.objInFullWin=null
                    }
                }
            }
            function capture(){
                xPanelInfo.grabToImage(function(result) {
                    let json=app.currentJson
                    if(!json)return
                    let ih=parseInt(json.pc.c0.ih)
                    let ip=r.folder+"/casa_"+ih+".png"
                    result.saveToFile(ip);
                });
            }
            function escaped(){
                showMaximized=false
            }
            Behavior on height{
                NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}
            }

            Flickable{
                id: flk
                width: parent.width
                height: parent.height
                contentWidth: parent.width
                contentHeight: !xPanelInfo.showMaximized?colTxtInfo.height:(txtInfoC1.contentHeight>colTxtCol2.height?txtInfoC1.contentHeight*1.2:colTxtCol2.height*1.2)
                ScrollBar.vertical: ScrollBar {
                    width: !xPanelInfo.showMaximized?app.fs*0.25:app.fs
                    anchors.right: parent.right
                    policy: ScrollBar.AlwaysOn
                }
                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        if (wheel.modifiers & Qt.ControlModifier) {
                            //log.lv('wheel.angleDelta.y: '+wheel.angleDelta.y)
                            if(wheel.angleDelta.y>=0){
                                r.fsz=r.fsz+1
                            }else{
                                r.fsz=r.fsz-1
                            }
                        }else{

                        }
                    }
                    onClicked: xPanelInfo.showMaximized=!xPanelInfo.showMaximized
                }
                Column{
                    id:colTxtInfo
                    spacing: app.fs*0.5
                    width: parent.width-app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: app.fs*0.5
                    visible: !xPanelInfo.showMaximized
                    Image {
                        id: imgTxt2
                        source: r.img1
                        width: parent.width
                        fillMode: Image.PreserveAspectFit
                    }
                    Text{
                        id: txtInfo
                        text: r.txtInfo
                        font.pixelSize: xPanelInfo.showMaximized?app.fs:app.fs*0.5
                        width: parent.width
                        wrapMode: Text.WordWrap
                        color: apps.fontColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.top: parent.top
                        //anchors.topMargin: app.fs*0.5
                        //visible: !xPanelInfo.showMaximized
                    }
                }
                Row{
                    spacing: app.fs*0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 0-app.fs*0.5
                    anchors.top: parent.top
                    anchors.topMargin: app.fs*0.5
                    visible: xPanelInfo.showMaximized
                    Text{
                        id: txtInfoC1
                        text: r.txtInfoC1
                        font.pixelSize: xPanelInfo.showMaximized?r.fsz:app.fs*0.5
                        width: parent.parent.width*0.5-app.fs//*0.25
                        wrapMode: Text.WordWrap
                        color: apps.fontColor
                        property int fs: font.pixelSize
                        onFsChanged: tCapture.restart()
                        Timer{
                            id: tCapture
                            running: false
                            repeat: false
                            interval: 1500
                            onTriggered: {
                                xPanelInfo.capture()
                            }
                        }
                    }
                    Column{
                        id: colTxtCol2
                        spacing: app.fs*0.25
                        Image {
                            id: imgTxt1
                            source: r.img1
                            width: txtInfoC2.width
                            fillMode: Image.PreserveAspectFit
                        }
                        Text{
                            id: txtInfoC2
                            text: r.txtInfoC2
                            font.pixelSize: xPanelInfo.showMaximized?r.fsz:app.fs*0.5
                            width: parent.parent.width*0.5-app.fs//*0.5
                            wrapMode: Text.WordWrap
                            color: apps.fontColor
                        }
                    }
                }
            }
            ZoolButton{
                text: 'X'
                fs: app.fs*0.5
                anchors.right: parent.right
                anchors.rightMargin: app.fs*0.25
                anchors.top: parent.top
                anchors.topMargin: app.fs*0.25
                onClicked: {
                    r.showTxtInfo=false
                    //xPanelInfo.destroy(0)
                }
            }
        }
    }
    Timer{
        id: tCheck
        running: r.visible || r.uIH<0
        repeat: true
        interval: 1000
        onTriggered: setBgPosSol()
    }
    Timer{
        id: tCheck2
        running: r.showTxtInfo
        repeat: true
        interval: 1000
        onTriggered: setBgPosSol()
    }
    property int uIH: -1
    property int uGS: -1
    Component.onCompleted: {
        let obj=comp.createObject(zsm.getPanel('ZoolModulesManager').c, {})
        let obj2=compInfo.createObject(xLatDer, {})
        setBgPosSol()
    }
    function setBgPosSol(){
        let json=app.currentJson
        //log.ls('json: '+JSON.stringify(json.pc.c0), 0, xLatIzq.width)
        if(!json)return


        let ih=parseInt(json.pc.c0.ih)
        r.uIH=ih
        let gs=parseInt(json.pc.c0.gdec)
        r.uGS=gs
        let txt="<!--ctx-->"
        if(ih===12||ih===7){
            setBg(0)
            xFakeSol.solTipo=3
            if(ih===7){
                r.img1="ocaso.jpg"
                txt+=unik.getFile(r.folder+'/casa_7')
            }
            if(ih===12){
                r.img1="amanecer.jpg"
                txt+=unik.getFile(r.folder+'/casa_12')
            }
        }else if(ih===1||ih===2||ih===3||ih===4||ih===5||ih===6){
            setBg(3)
            xFakeSol.solTipo=0
            //txt+='En casa 1, 2, 3, 4, 5, 6 o 7'
            if(ih===1){
                txt+=unik.getFile(r.folder+'/casa_1')
                r.img1="crepusculo.jpg"
            }
            if(ih===2){
                txt+=unik.getFile(r.folder+'/casa_2')
                r.img1="noche.jpg"
            }
            if(ih===3){
                txt+=unik.getFile(r.folder+'/casa_3')
                r.img1="noche.jpg"
            }
            if(ih===4){
                txt+=unik.getFile(r.folder+'/casa_4')
                r.img1="noche.jpg"
            }
            if(ih===5){
                txt+=unik.getFile(r.folder+'/casa_5')
                r.img1="noche.jpg"
            }
            if(ih===6){
                txt+=unik.getFile(r.folder+'/casa_6')
            }
            //horizonteBg.opacity-=0.05
        }else if(ih===8||ih===9||ih===11){
            setBg(1)
            xFakeSol.solTipo=5
            r.img1="siesta.jpg"
            if(ih===8){
                txt+=unik.getFile(r.folder+'/casa_8')
            }
            if(ih===9){
                txt+=unik.getFile(r.folder+'/casa_9')
            }
            if(ih===11){
                txt+=unik.getFile(r.folder+'/casa_11')
            }
        }else{
            setBg(1)
            xFakeSol.solTipo=1
            if(ih===10){
                txt+=unik.getFile(r.folder+'/casa_10')
            }
        }
        txt=txt.replace('<!--t1-->', '<h3>¿Haz nacido en esta hora o momento del día?</h3><h5>Si es así, la siguiente información te puede resultar muy útil y esclarecedora.</h5>')

        let aCtx=[]
        aCtx.push('ctx 1')
        aCtx.push('ctx 2')
        aCtx.push('ctx 3')
        aCtx.push('ctx 4')
        aCtx.push('ctx 5')
        aCtx.push('ctx 6')
        aCtx.push('ctx 7')
        aCtx.push('Tarde - Horas del atardecer intermedias entre el mediodía y la noche - Sol en Casa 8')
        aCtx.push('Ocaso - 1 o 2 horas previas al anochecer - Sol en Casa 7')
        aCtx.push('ctx 10')
        aCtx.push('ctx 11')
        aCtx.push('ctx 12')
        txt=txt.replace('<!--ctx-->', '<h2>Contexto de Nacimiento: '+aCtx[ih - 1]+'</h2><br />')


        r.txtInfo=txt
        let m0=r.txtInfo.split('<!--break-->')
        if(r.txtInfoC1&&m0[0])r.txtInfoC1=m0[0]
        if(r.txtInfoC2&&m0[1])r.txtInfoC2=m0[1]
        //console.log(txt)
    }
    function setBg(posSol){
        for(var i=0;i<xHorBg.children.length;i++){
            xHorBg.children[i].destroy(1)
        }
        let c='import QtQuick 2.0\nHorizonteBg{\nid: horizonteBg\n}\n'
        let comp=Qt.createComponent('HorizonteBg.qml')
        let obj=comp.createObject(xHorBg, {posSol: posSol})
        fakeSignCircle.rotation=sweg.objSignsCircle.rot
        let gs=app.currentRotationxAsSol-(fakeSignCircle.rotation-360)//r.uGS90
        fakeSolAxis.rotation=gs
        let cd=new Date(app.currentDate)
        let hora=cd.getHours()
        let min=cd.getMinutes()
        txt3.text='Lugar de nacimiento de <b>'+app.currentNom+'</b> el día <b>'+app.currentFecha+'</b> a las <b>'+hora+':'+min+'hs</b> en '+app.currentLugar
    }
}
