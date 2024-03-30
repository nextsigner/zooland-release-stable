import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../comps" as Comps

import ZoolSabianos.ZoolSabianosView 1.0
import ZoolButton 1.1
import ZoolText 1.0

Rectangle {
    id: r
    color: 'white'
    width: parent.width
    height: parent.height
    clip: true

    property alias view: sabianosView

    property string folderData: './modules/ZoolSabianos/data'

    property bool showSource: false
    property string htmlFolder: ''
    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property int numSign: 0
    property int numDegree: 0
    property int fs: width*0.025
    property real factorZoomByRes: 1.5
    property int currentInterpreter: 0

    property string uSAM: ''

    property int itemIndex: -1

    property string prevZFocus: ''

    visible: zsm.aPanelsIds.indexOf(app.j.qmltypeof(r))===zsm.currentIndex

    onVisibleChanged: {
        //if(visible)zoolVoicePlayer.stop()
        if(visible)zoolVoicePlayer.speak('Sección de Simbología de los 360 grados del zodíaco.', true)
    }
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
            spacing: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                id: sourceData
                text: getSource()
                width: r.width-app.fs
                wrapMode: Text.WordWrap
                font.pixelSize: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                visible: r.showSource
                MouseArea{
                    anchors.fill: parent
                    onClicked: r.showSource=false
                }
            }
            Text {
                id: currentSign
                text: '<b>LOS 360 GRADOS DEL ZODIACO SIMBOLIZADOS</b>'
                width: r.width-app.fs
                wrapMode: Text.WordWrap
                font.pixelSize: app.fs*0.75*apps.panelSabianosFz
                anchors.horizontalCenter: parent.horizontalCenter
                visible: !r.showSource
                MouseArea{
                    anchors.fill: parent
                    onClicked: r.showSource=true
                }
            }
            Row{
                spacing: app.fs*0.5
                visible: !r.showSource
                Text {
                    text:'<b>'+r.signos[r.numSign]+'</b>'
                    font.pixelSize: app.fs*0.75*apps.panelSabianosFz
                    anchors.verticalCenter: parent.verticalCenter
                }
                Item {
                    id: xSigno
                    width: app.fs*apps.panelSabianosFz
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle{
                        anchors.fill: xSigno
                        radius: app.fs*0.25
                        color: 'white'
                        border.width: 2
                        border.color: 'black'
                        Image {
                            id: sign
                            source: "../../resources/imgs/signos/"+r.numSign+".svg"
                            width: xSigno.width*0.8
                            fillMode: Image.PreserveAspectFit
                            anchors.centerIn: parent
                        }
                    }
                }
            }
            Text{
                id: data
                width: r.width-app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.top: rowTit.bottom
                //anchors.topMargin: app.fs*0.5
                text: '<h1>Los Sabianos</h1>'
                font.pixelSize: app.fs*0.5*apps.panelSabianosFz
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                visible: !r.showSource
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onMouseXChanged: {
                        rowBtns.opacity=1.0
                        tHideRowBtns.restart()
                    }
                    onMouseYChanged: {
                        rowBtns.opacity=1.0
                        tHideRowBtns.restart()
                    }
                    onEntered: rowBtns.opacity=1.0
                    onDoubleClicked: {
                        r.prevZFocus=apps.zFocus
                        apps.zFocus='xLatIzq'
                        sabianosView.numSign=r.numSign
                        sabianosView.numDegree=r.numDegree
                        sabianosView.visible=true
                        sabianosView.loadData()
                    }
                }
            }
        }
    }
    ZoolText{
        id: currentDegree
        property string sd: '?'
        text: '<b>'+sd+'</b>'//+' ci:'+r.currentInterpreter+' ad:'+r.numDegree+' cs:'+r.numSign
        font.pixelSize: r.fs*2
        //color: 'white'
        anchors.bottom: parent.bottom
        visible: false
    }
    Rectangle{
        width: app.fs*0.5
        height: width
        color: 'black'
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
        MouseArea{
            anchors.fill: parent
            onClicked: r.state='hide'
        }
        Text {
            text: 'X'
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.width*0.6
            color: 'white'
            anchors.centerIn: parent
        }
    }
    Row{
        id: rowBtns
        spacing: app.fs*0.25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        opacity: 0.0
        Timer{
            id: tHideRowBtns
            running: rowBtns.opacity===1.0
            repeat: false
            interval: 5000
            onTriggered: parent.opacity=0.0
        }
        Behavior on opacity{NumberAnimation{duration: 500}}
        Button{
            text: 'Copiar HTML'
            onClicked: {
                let d = '<!DOCTYPE html><html>'
                d+='<head>Simbología de los Sabianos<title></title><meta charset="utf-8"></head>'
                d+='<body>'
                d += '<h1>Simbología de los Sabianos</h1>'
                d+='<b>'+r.signos[r.numSign]+'</b><br />'
                d+=getData()
                d+='<br /><h3>Fuente: Universidad Norbert Wiener - Perú</h3><br />'
                d+='</body></html>'
                clipboard.setText(d)
                tHideRowBtns.restart()
            }
        }
        //Graba 3 archivos SAM separados
        ZoolButton{
            //width:app.fs*3
            fs:app.fs
            text: '\uf0c7'
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                //Ascendente
                let d = ''
                d+='<b>Ascendente '+r.signos[app.currentJson.ph.h1.is]+'</b><br />\n\n'
                d+=getDataSAM('ASC', parseInt(app.currentJson.ph.h1.rsgdeg - 1), app.currentJson.ph.h1.is)
                d=d.replace(/<[^>]*>/g, '')
                d=d.replace(/&nbsp;/g, ' ')
                let sdel=''+app.currentJson.ph.h1.rsgdeg+'°: '
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                let fileNameOutPut=apps.jsonsFolder+'/caps/'+app.currentNom.replace(/ /g, '_')+'/'
                //log.lv('app.currentJson.ph.h1: '+JSON.stringify(app.currentJson.ph.h1, null, 2))
                let gAsc=''+app.currentJson.ph.h1.rsgdeg
                //if(app.dev)log.lv('Sabianos gAsc: '+gAsc)
                fileNameOutPut+='Sabianos_Ascendente_en_'+r.signos[app.currentJson.ph.h1.is]+'_Grado_'+gAsc+'.txt'
                //if(app.dev)log.lv('Sabianos Asc: '+d)
                //unik.setFile(fileNameOutPut, d)
                //if(app.dev)log.lv('Sabianos OutPut fileName: sale por console.log()')
                console.log('Sabianos Asc fileNameOutPut: '+fileNameOutPut)

                //Medio Cielo
                d = ''
                d+='<b>Medio Cielo '+r.signos[app.currentJson.ph.h10.is]+'</b><br />\n\n'
                d+=getDataSAM('MC', parseInt(app.currentJson.ph.h10.rsgdeg - 1), app.currentJson.ph.h1.is)
                d=d.replace(/<[^>]*>/g, '')
                d=d.replace(/&nbsp;/g, ' ')
                sdel=''+app.currentJson.ph.h10.rsgdeg+'°: '
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                fileNameOutPut=apps.jsonsFolder+'/caps/'+app.currentNom.replace(/ /g, '_')+'/'
                //log.lv('app.currentJson.ph.h10: '+JSON.stringify(app.currentJson.ph.h10, null, 2))
                let gMc=''+app.currentJson.ph.h10.rsgdeg
                //if(app.dev)log.lv('Sabianos gMc: '+gMc)
                fileNameOutPut+='Sabianos_Medio_Cielo_en_'+r.signos[app.currentJson.ph.h10.is]+'_Grado_'+gMc+'.txt'
                //if(app.dev)log.lv('Sabianos Medio Cielo: '+d)
                //unik.setFile(fileNameOutPut, d)
                //if(app.dev)log.lv('Sabianos OutPut fileName: sale por console.log()')
                console.log('Sabianos Mc fileNameOutPut: '+fileNameOutPut)

                //Sol
                d = ''
                d+='<b>Sol en el grado '+r.signos[app.currentJson.pc.c0.is]+'</b><br />\n\n'
                d+=getDataSAM('MC', parseInt(app.currentJson.pc.c0.rsgdeg - 1), app.currentJson.pc.c0.is)
                d=d.replace(/<[^>]*>/g, '')
                d=d.replace(/&nbsp;/g, ' ')
                sdel=''+app.currentJson.pc.c0.rsgdeg+'°: '
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                fileNameOutPut=apps.jsonsFolder+'/caps/'+app.currentNom.replace(/ /g, '_')+'/'
                //log.lv('app.currentJson.pc.c0: '+JSON.stringify(app.currentJson.pc.c0, null, 2))
                let gSol=''+app.currentJson.pc.c0.rsgdeg
                //if(app.dev)log.lv('Sabianos gSol: '+gSol)
                fileNameOutPut+='Sabianos_Sol_en_'+r.signos[app.currentJson.pc.c0.is]+'_Grado_'+gSol+'.txt'
                //if(app.dev)log.lv('Sabianos Sol: '+d)
                //unik.setFile(fileNameOutPut, d)
                //if(app.dev)log.lv('Sabianos OutPut fileName: sale por console.log()')
                console.log('Sabianos Sol fileNameOutPut: '+fileNameOutPut)

                tHideRowBtns.restart()
            }
            ZoolText{
                text: '<b>3</b>'
                color: 'red'
                fs:app.fs*0.8
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: app.fs*0.3
                anchors.verticalCenterOffset: 0-app.fs*0.3
            }
        }

        //Graba 3 archivos SAM unidos en 1
        ZoolButton{
            //width:app.fs*3
            fs:app.fs
            text: '\uf0c7'
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                let sf=''

                //Ascendente
                let d = ''
                d+='<b>Ascendente en '+r.signos[app.currentJson.ph.h1.is]+' en °'+app.currentJson.ph.h1.rsgdeg+'</b><br />\n\n'
                d+=getDataSAM('ASC', parseInt(app.currentJson.ph.h1.rsgdeg - 1), app.currentJson.ph.h1.is)
                d=d.replace(/<[^>]*>/g, '')
                d=d.replace(/&nbsp;/g, ' ')
                let sdel=''+app.currentJson.ph.h1.rsgdeg+'°: '
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                let fileNameOutPut=apps.jsonsFolder+'/caps/'+app.currentNom.replace(/ /g, '_')+'/'
                //log.lv('app.currentJson.ph.h1: '+JSON.stringify(app.currentJson.ph.h1, null, 2))
                let gAsc=''+app.currentJson.ph.h1.rsgdeg
                //if(app.dev)log.lv('Sabianos gAsc: '+gAsc)
                fileNameOutPut+='Sabianos_Asc_'+r.signos[app.currentJson.ph.h1.is]+'_'+gAsc
                //if(app.dev)log.lv('Sabianos Asc: '+d)
                sf+='\n'+d
                //if(app.dev)log.lv('Sabianos OutPut fileName: sale por console.log()')
                console.log('Sabianos Asc fileNameOutPut: '+fileNameOutPut)

                //Medio Cielo
                d = ''
                d+='<b>Medio Cielo en '+r.signos[app.currentJson.ph.h10.is]+' en °'+app.currentJson.ph.h10.rsgdeg+'</b><br />\n\n'
                d+=getDataSAM('MC', parseInt(app.currentJson.ph.h10.rsgdeg - 1), app.currentJson.ph.h1.is)
                d=d.replace(/<[^>]*>/g, '')
                d=d.replace(/&nbsp;/g, ' ')
                sdel=''+app.currentJson.ph.h10.rsgdeg+'°: '
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                //log.lv('app.currentJson.ph.h10: '+JSON.stringify(app.currentJson.ph.h10, null, 2))
                let gMc=''+app.currentJson.ph.h10.rsgdeg
                //if(app.dev)log.lv('Sabianos gMc: '+gMc)
                fileNameOutPut+='_Mc_'+r.signos[app.currentJson.ph.h10.is]+'_'+gMc
                //if(app.dev)log.lv('Sabianos Medio Cielo: '+d)
                sf+='\n'+d
                //if(app.dev)log.lv('Sabianos OutPut fileName: sale por console.log()')
                console.log('Sabianos Mc fileNameOutPut: '+fileNameOutPut)

                //Sol
                d = ''
                d+='<b>Sol en '+r.signos[app.currentJson.pc.c0.is]+' en °'+app.currentJson.pc.c0.rsgdeg+'</b><br />\n\n'
                d+=getDataSAM('MC', parseInt(app.currentJson.pc.c0.rsgdeg - 1), app.currentJson.pc.c0.is)
                d=d.replace(/<[^>]*>/g, '')
                d=d.replace(/&nbsp;/g, ' ')
                sdel=''+app.currentJson.pc.c0.rsgdeg+'°: '
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                d=d.replace(sdel, '')
                //log.lv('app.currentJson.pc.c0: '+JSON.stringify(app.currentJson.pc.c0, null, 2))
                let gSol=''+app.currentJson.pc.c0.rsgdeg
                //if(app.dev)log.lv('Sabianos gSol: '+gSol)
                fileNameOutPut+='_Sol_'+r.signos[app.currentJson.pc.c0.is]+'_'+gSol+'.txt'
                //if(app.dev)log.lv('Sabianos Sol: '+d)
                sf+='\n'+d
                //if(app.dev)log.lv('Sabianos OutPut fileName: sale por console.log()')
                console.log('Sabianos Sol fileNameOutPut: '+fileNameOutPut)

                unik.setFile(fileNameOutPut, sf)

                tHideRowBtns.restart()
            }
            ZoolText{
                text: '<b>1</b>'
                color: 'red'
                fs:app.fs*0.8
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: app.fs*0.3
                anchors.verticalCenterOffset: 0-app.fs*0.3
            }
        }

        Comps.ButtonIcon{
            text: '\uf010'
            width: apps.botSize
            height: width
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                if(apps.panelSabianosFz>0.5)apps.panelSabianosFz-=0.1
                rowBtns.opacity=1.0
                tHideRowBtns.restart()
            }
        }
        Comps.ButtonIcon{
            text: '\uf00e'
            width: apps.botSize
            height: width
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                if(apps.panelSabianosFz<2.0)apps.panelSabianosFz+=0.1
                rowBtns.opacity=1.0
                tHideRowBtns.restart()
            }
        }
        Comps.ButtonIcon{
            text: '\uf06e'
            width: apps.botSize*2
            height: width
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                apps.sabianosAutoShow=!apps.sabianosAutoShow
                tHideRowBtns.restart()
            }
            Text{
                text:apps.sabianosAutoShow?'\uf023':'\uf13e'
                font.pixelSize: parent.width*0.5
                anchors.right:parent.right
            }
        }
    }
    ZoolSabianosView{
        id: sabianosView
        folderData: r.folderData
        parent: capa101
        //Component.onCompleted: xSabianos=sabianosView
    }
    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Sabianos')
    }
    function ctrlDown(){
        if(r.numSign<11){
            r.numSign++
        }else{
            r.numSign=0
            r.currentInterpreter=0
        }
        loadData()
    }
    function ctrlUp(){
        if(r.numSign>0){
            r.numSign--
        }else{
            r.numSign=11
            r.currentInterpreter=0
        }
        loadData()
    }
    function todown(){
        if(r.numDegree<30){
            r.numDegree++
        }else{
            r.numDegree=0
            r.currentInterpreter=0
        }
        loadData()
    }
    function toup(){
        if(r.numDegree>0){
            r.numDegree--
        }else{
            r.numDegree=30
            r.currentInterpreter=0
        }
        loadData()
    }
    function toleft(){
        if(r.currentInterpreter>0){
            r.currentInterpreter--
        }else{
            r.currentInterpreter=2
            if(r.numDegree>0){
                r.numDegree--
            }else{
                r.numDegree=29
                r.currentInterpreter=2
                if(r.numSign>0){
                    r.numSign--
                }else{
                    r.numSign=11
                }
            }
        }
        loadData()
    }
    function toright(){
        if(r.currentInterpreter<2){
            r.currentInterpreter++
        }else{
            r.currentInterpreter=0
            if(r.numDegree<29){
                r.numDegree++
            }else{
                r.numDegree=0
                r.currentInterpreter=0
                if(r.numSign<11){
                    r.numSign++
                }else{
                    r.numSign=0
                }
            }
        }
        loadData()
    }
    function loadData(){
        //data.font.pixelSize=app.fs*0.5*apps.panelSabianosFz
        let df=r.numDegree
        let sf=r.numSign
        if(r.numDegree===-1){
            df=29
            r.numDegree=df
            sf--
            r.numSign--
            if(r.numSign<0){
                sf=0
                r.numSign=11
            }
        }
        //let fileUrl='"'+unik.currentFolderPath()+'/resources/sab'+r.numSign+'.json'+'"'
        let fileUrl=r.folderData+'/sab'+r.numSign+'.json'
        fileUrl=fileUrl.replace(/\"/g, '')
        let fileData=''+unik.getFile(fileUrl)
        let json=JSON.parse(fileData.replace(/\n/g, ''))
        //console.log('df:'+df)
        //console.log('sf:'+sf)
        data.text=json['g'+df]['p1'].text
        data.text+=json['g'+df]['p2'].text
        data.text+=json['g'+df]['p3'].text
        flk.contentY=0
    }
    function getData(){
        let df=r.numDegree
        let sf=r.numSign
        if(r.numDegree===-1){
            df=29
            r.numDegree=df
            sf--
            r.numSign--
            if(r.numSign<0){
                sf=0
                r.numSign=11
            }
        }
        //let fileUrl='"'+unik.currentFolderPath()+'/resources/sab'+r.numSign+'.json'+'"'
        let fileUrl='"'+unik.currentFolderPath()+'/modules/ZoolSabianos/data/sab'+r.numSign+'.json'+'"'
        fileUrl=fileUrl.replace(/\"/g, '')
        let fileData=''+unik.getFile(fileUrl)
        let json=JSON.parse(fileData.replace(/\n/g, ''))
        let rd=json['g'+df]['p1'].text
        rd+=json['g'+df]['p2'].text
        rd+=json['g'+df]['p3'].text
        return rd
    }
    function getDataSAM(typeSAM, rsgdeg, is){
        let df=rsgdeg
        let sf=is
        /*if(rsgdeg===-1){
            df=29
            rsgdeg=df
            sf--
            r.numSign--
            if(r.numSign<0){
                sf=0
                r.numSign=11
            }
        }*/
        //let fileUrl='"'+unik.currentFolderPath()+'/resources/sab'+r.numSign+'.json'+'"'
        let fileUrl='"'+unik.currentFolderPath()+'/modules/ZoolSabianos/data/sab'+r.numSign+'.json'+'"'
        fileUrl=fileUrl.replace(/\"/g, '')
        let fileData=''+unik.getFile(fileUrl)
        let json=JSON.parse(fileData.replace(/\n/g, ''))
        let rd='Videncia 1: '+json['g'+df]['p1'].text
        rd+='\n'
        rd+='Videncia 2: '+json['g'+df]['p2'].text
        rd+='\n'
        rd+='Videncia 3 - Análisis contextual de la personalidad: '+json['g'+df]['p3'].text
        return rd
    }
    function getHtmlData(s, g, item){
        let fileData=''+unik.getFile('360.html')
        let dataSign=fileData.split('---')
        let stringSplit=''
        if(g<=8){
            stringSplit='0'+parseInt(g+1)+'°:'
        }else{
            stringSplit=''+parseInt(g+1)+'°:'
        }
        let signData=''+dataSign[s+1]
        //console.log('\n\n\nAries---->>'+signData+'\n\n\n')
        let dataDegree=signData.split('<p ')
        let htmlPrevio=''
        let cp=0
        currentDegree.sd=stringSplit
        for(var i=0;i<dataDegree.length;i++){
            //console.log('\n\n\n\n'+stringSplit+'----------->>'+dataDegree[i])
            if(dataDegree[i].indexOf(stringSplit)>0){
                htmlPrevio+='<p '+dataDegree[i]
                cp++
                //console.log('\n\n----------->>'+htmlPrevio)
            }
        }
        let mapHtmlDegree=htmlPrevio.split('<p ')
        let dataFinal=item===0?'<h3> Grado °'+parseInt(g + 1)+' de '+r.signos[s]+'</h3>\n':''
        dataFinal+='<p '+mapHtmlDegree[item + 1]
        if(rs.bgColor!=='#ffffff'){
            if(dataFinal.indexOf('<p class="entry-excerpt" style="text-align: left;"><strong><span style="color:')<0&&dataFinal.indexOf('<p class="entry-excerpt" style="text-align: left;"><span>strong style="color:')<0){
                dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><strong>','<p class="entry-excerpt" style="text-align: left;color:#ffffff"><strong>')
                dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><span ','<p class="entry-excerpt" style="text-align: left;color:#ffffff"><span ')
                dataFinal=dataFinal.replace('style="color: rgb(0, 0, 255);','style="color: rgb(255, 255, 255);')
            }else{
                if(dataFinal.indexOf('<p class="entry-excerpt" style="text-align: left;"><strong><span style="color: rgb(255, 0, 0);">'>=0)){
                    dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><strong>','<p class="entry-excerpt" style="text-align: left;color:red"><strong>')
                }else{
                    dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><strong>','<p class="entry-excerpt" style="text-align: left;color:green"><strong>')
                }
            }
        }
        return dataFinal.replace(/style=\"text-align: justify;\"/g,'').replace(/&nbsp; /g, ' ')
    }
    function setHtml(html, nom){
        let htmlFinal='<DOCTYPE html>
<html>
<head>
    <title>'+nom+'</title>
</head>
    <body style="background-color:#ffffff;">
        <h1>Ajustando hora de nacimiento de '+nom+'</h1>
        <p>En esta página hay 3 grupos con 3 textos. Tenés que avisar cuál de todos estos grupos te parece que tiene más que ver con tu vida o tu forma de ser.</p>
        <p>Los textos que vas a leer a continuación, son como descripciones de imágenes que simbolizan una escena de algo que se puede presentar en tu vida de algn modo parecido o similar.</p>
        <p><b>Aviso: </b>Los textos en color rojo son algo negativos. Tantos los textos azules o rojos puede ser que aún no se hayan producido.</p>
        <br/>
        <h2>¿Cuál de los siguientes grupos de textos pensas que hablan de cosas más parecidas a tu vida o forma de ser?</h2>
        <br/>\n'
+html+
'<br />
         <br />
    </body>
</html>'
        unik.setFile('/home/ns/nsp/uda/nextsigner.github.io/sabianos/'+nom+'.html', htmlFinal)
    }
    function setJsonZoom(numSign, numDegree, numItem, zoom){
        let jsonFile='../../modules/ZoolSabianos/sabianosJsonZoom.json'
        let existe=unik.fileExist(jsonFile)
        let jsonString=''
        let newJsonString=''
        if(existe){
            jsonString=unik.getFile(jsonFile)
        }
        let arrayLines=jsonString.split('\n')
        let nomItem='pos_'+numSign+'_'+numDegree+'_'+numItem
        let e=false
        for(var i=0;i<arrayLines.length;i++){
            if(arrayLines[i].indexOf(nomItem)<0&&arrayLines[i].indexOf('pos_')>=0){
                newJsonString+=arrayLines[i]+'\n'
            }
        }
        //if(!e){
        newJsonString+=nomItem+'='+zoom+'\n'
        //}
        unik.setFile(jsonFile, newJsonString)
    }
    function getJsonZoom(numSign, numDegree, numItem){
        let jsonFile='./sabianosJsonZoom.json'
        let existe=unik.fileExist(jsonFile)
        let jsonString=''
        if(existe){
            jsonString=unik.getFile(jsonFile)
        }
        let arrayLines=jsonString.split('\n')
        let nomItem='pos_'+numSign+'_'+numDegree+'_'+numItem
        let zoom="1.0"
        for(var i=0;i<arrayLines.length;i++){
            if(arrayLines[i].indexOf(nomItem)>=0){
                zoom=""+arrayLines[i].split('=')[1]
                break
            }
        }
        return zoom
    }
    function zoomDown(){
        let gz=getJsonZoom(r.numSign, r.numDegree, r.currentInterpreter)
        console.log('gz baja:'+gz)
        let zoom=parseFloat(gz).toFixed(1)
        console.log('Z1:'+zoom)
        if(zoom==='NaN'){
            console.log('NaN! :'+zoom)
            return
        }
        apps.panelSabianosFz-=0.1
        if(apps.panelSabianosFz<0.01){
            apps.panelSabianosFz=0.01
        }
        zoom=parseFloat(apps.panelSabianosFz).toFixed(1)
        //unik.speak('Sube '+zoom)


        //data.font.pixelSize=r.fs*2*apps.panelSabianosFz
        console.log('SETZOOM:'+zoom)
        setJsonZoom(r.numSign, r.numDegree, r.currentInterpreter, zoom)
        r.loadData()
    }
    function zoomUp(){
        let gz=getJsonZoom(r.numSign, r.numDegree, r.currentInterpreter)
        console.log('gz sube:'+gz)
        let zoom=parseFloat(gz).toFixed(1)
        console.log('Z1:'+zoom)
        if(zoom==='NaN'){
            console.log('NaN! :'+zoom)
            return
        }
        apps.panelSabianosFz+=0.1
        zoom=parseFloat(apps.panelSabianosFz).toFixed(1)
        //unik.speak('Baja '+zoom)
        /*if(zoom<1.0){
                zoom=parseFloat(1).toFixed(1)
            }*/
        //data.font.pixelSize=r.fs*2*apps.panelSabianosFz
        console.log('SETZOOM:'+zoom)
        setJsonZoom(r.numSign, r.numDegree, r.currentInterpreter, zoom)
        r.loadData()
    }
    function getSource(){
        let d='<b>LOS 360 GRADOS DEL ZODIACO SIMBOLIZADOS</b><br>'
        d+='<p>Aplicacion de los simbolismos de los 360° del zodiaco, segun Charubel, La Volasfera, Sepharial y los Sabianos.</p>

<h3>CHARUBEL</h3>
<p>Charubel, seudonimo de John Thomas</p>
<h3>LA VOLASFERA</h3>
<p>La Volasfera, seudonimo de Antonio Borelli, Interpretados por</p>
<h3>SEPHARIAL</h3>
<p>Sepharial, Seudonimo de Walter E. Gorn Old</p>
<h3>LOS SABIANOS</h3>
<p>Sabianos (nombre de una antigua raza de alquimistas de Mesopotamia ), es un trabajo de Elsie May Wheeler y Marc Edmund Jones. (Las alegorias de los Sabianos las hallamos, tambien, en Astroloqia de la Personalidad de Dane Rudhyar, publicacion realizada con permiso de los autores).</p>
<p>Desde 1898, fecha en que apareciera por vez primera la edicion de los Grados Simbolizados de Charubel, cientos de copias son utilizadas diariamente por estudiantes acuciosos en todo el mundo.</p>
<p>Traduccion de la Version Inglesa por R. Lidid</p>
<p><b>Nota de Ricardo Martín Pizarro: </b>Debido posiblemente a un error de traducción del ingles al español por R. Lidid, los antiguos alquimistas de la mesopotamia se llamaban SABEANOS, no los Sabianos.</p>
'
        return d
    }
}

