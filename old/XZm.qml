import QtQuick 2.0
import QtMultimedia 5.12
import "Funcs.js" as JS

Rectangle{
    id: r
    width: panelZonaMes.width-r.border.width*2
    height: txtData.contentHeight+app.fs//index!==lv.currentIndex?app.fs*1.5:app.fs*3.5//txtData.contentHeight+app.fs*0.1
    //color: r.selected?'white':'black'
    opacity: r.selected?1.0:0.5
    property int currentIndexSign: -1
    property bool isReady: false
    property bool selected: panelZonaMes.currentIndex===index
    property int is: -1
    anchors.horizontalCenter: parent.horizontalCenter
    //onHeightChanged: lv.height=height
    onSelectedChanged: if(selected)loadJsonTask()
    signal taskFinished(int itemIndex)
    Behavior on opacity{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    onCurrentIndexSignChanged: {
        let joPar=app.currentJsonSignData.params
        if(!app.currentJsonSignData.fechas)return
        let jo=app.currentJsonSignData.fechas['is'+r.currentIndexSign]
        //let s = app.signos[i]+ ' '+jo.d+'/'+jo.m+'/'+jo.a+' '+jo.h+':'+jo.min
        let d1=new Date(jo.a, jo.m - 1, jo.d, jo.h, jo.min)
        d1 = d1.setMinutes(d1.getMinutes() + 4)
        let d2=new Date(d1)
        let d=d2.getDate()
        let m=d2.getMonth() + 1
        let a=d2.getFullYear()
        let h=d2.getHours()
        let min=d2.getMinutes()
        let signo=app.signos[currentIndexSign]
        let name=''+json.id+'_'+s.currentQ+'_'+s.currentMonth+'_'+s.currentYear
        let fileNamePathJsonPl='./jsons/hm/'+json.id+'/q'+s.currentQ+'_'+s.currentMonth+'_'+s.currentYear+'.json'
        let fileName=name.replace(/ /g, '_')+'.json'
        let dms=new Date(Date.now())
        let fileNamePath='./jsons/'+fileName
        let jsonCode='{"params":{"tipo":"pron", "fileNamePath": "'+fileNamePathJsonPl+'", "ms":'+dms.getTime()+',"n":"'+name+'","d":'+d+',"m":'+m+',"a":'+a+',"h":'+h+',"min":'+min+',"gmt":'+joPar.gmt+',"lat":'+joPar.lat+',"lon":'+joPar.lon+',"ciudad":"'+panelZonaMes.currentCity+'"}}'
        if(!unik.fileExist(fileNamePath)){
            unik.setFile(fileNamePath, jsonCode)
            //unik.speak('Grabando...')
        }
        let sc='Pronóstico Astrológico para '+signo+' '+panelZonaMes.currentCity
        JS.setTitleData(sc, s.currentQ===1?1:15, s.currentMonth, s.currentYear, jo.h, jo.min, joPar.gmt, '', joPar.lat, joPar.lon, 2)
        console.log('jsonCode:'+jsonCode)
        app.currentData=jsonCode
        JS.runJsonTemp()
    }
    Audio {
        id: mp;
        property int currentIndex: -1
        property var arrayLanguages: ["es-ES_EnriqueVoice", "es-ES_EnriqueV3Voice", "es-ES_LauraVoice", "es-ES_LauraV3Voice", "es-LA_SofiaVoice","es-LA_SofiaV3Voice","es-US_SofiaVoice","es-US_SofiaV3Voice" ]
        onPlaybackStateChanged:{
            if(mp.playbackState===Audio.StoppedState){
                //playlist.removeItem(0)

            }
            if(mp.playbackState===Audio.PlayingState){

            }
        }
        playlist: Playlist {
            id: playlist
            onCurrentIndexChanged:{
                //if(currentIndex===0)return
                if(currentIndex===-1){
                    if(panelZonaMes.currentIndex<panelZonaMes.listModel.count-1){
                        panelZonaMes.currentIndex++
                    }else{
                        panelZonaMes.currentIndex=0
                    }
                    return
                }
                checkSource()
            }
            onCurrentItemSourceChanged:{
                if((''+playlist.currentItemSource).indexOf('&isFZ=true')>=0)checkSource()
            }
            function checkSource(){
                //unik.speak('check')
                if((''+playlist.currentItemSource).indexOf('&isFS=true')>=0){
                    if(panelZonaMes.state==='show')panelDataBodies.state='hide'
                    //r.currentIndexSign++
                    if(r.currentIndexSign<11){
                        r.currentIndexSign++
                    }else{
                        r.currentIndexSign=0
                        //r.currentIndex=0
                    }
                    panelControlsSign.enableLoadSign=false
                    panelControlsSign.currentIndex=r.currentIndexSign
                }
                if((''+playlist.currentItemSource).indexOf('&isFZ=true')>=0){
                    if(panelZonaMes.currentIndex<panelZonaMes.listModel.count-1){
                        panelZonaMes.currentIndex++
                    }else{
                        panelZonaMes.currentIndex=0
                    }
                }
            }
        }
        function addText(text, voice, tipoLinea){
            let t=text
            t=t.replace(/ /g, '%20').replace(/_/g, ' ')
            //console.log('MSG: '+msg)
            let v=mp.arrayLanguages[voice]
            let s='https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+t+'&voice='+v+'&download=true&accept=audio%2Fmp3'
            if(tipoLinea===1)s+='&isFS=true'
            if(tipoLinea===2)s+='&isFZ=true'
            playlist.addItem(s)
        }
    }
    Column{
        anchors.centerIn: parent
        Rectangle{
            id: txtInfoZona
            width: r.width-app.fs*0.5
            height: txtData.contentHeight+app.fs*0.25
            //color: !r.selected?'white':'black'
            border.width: 1
            border.color: 'white'
            radius: app.fs*0.1
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.verticalCenter: parent.verticalCenter
            XText {
                id: txtData
                //text: (r.is!==-1?'<b>Ascendente '+app.signos[r.is]+'</b><br />':'')+dato
                font.pixelSize: app.fs*0.35
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                horizontalAlignment: Text.AlignHCenter
                //color:r.selected?'white':'black'
                anchors.centerIn: parent
            }
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            lv.currentIndex=index
            r.currentIndexSign=-1
            playlist.currentIndex=0
        }
    }
    function loadJsonTask(){
        if(panelZonaMes.state==='hide')return
        panelZonaMes.currentCity=json.nom
        panelZonaMes.currentLat=json.lat
        panelZonaMes.currentLon=json.lon
        panelZonaMes.currentGmt=json.gmt
        mp.stop()
        playlist.clear()
        let fileName='./jsons/hm/'+json.id+'/q'+s.currentQ+'_'+s.currentMonth+'_'+s.currentYear+'.json'
        if(!unik.fileExist(fileName)){
            console.log('El archivo '+fileName+' no está disponible.')
            r.isReady=false
            let txtSinDatos='El horóscopo para la región '+json.nom+' aún no está listo.'
            mp.addText(txtSinDatos, 0,2)
            mp.play()
            return
        }else{

            //JS.setTitleData(json.nom, s.currentQ===1?1:15, s.currentMonth, s.currentYear, 0, 0, 0, json.des, json.lat, json.lon, 0)
            //let j3='{"params":{"tipo": "pl", "ms":0,"n":"'+r.currentCity+'","d":1,"m":'+s.currentMonth+',"a":'+s.currentYear+',"h":0,"min":1,"gmt":'+json.gmt+',"lat":'+r.currentLat+',"lon":'+r.currentLon+',"ciudad":"'+r.currentCity+'"}}'
            //sweg.loadSign(JSON.parse(j3))
            let cant=0
            let txtCab='Cargando signo'
            mp.addText(txtCab, 0,1)
            let jsonData=unik.getFile(fileName)
            let j=JSON.parse(jsonData)
            console.log('json task: '+JSON.stringify(j))
            for(var i=0;i<Object.keys(j.signos).length;i++){
                let title='Pronóstico Astrológico para '+json.nom+' bajo el signo solar o ascendente '+app.signos[i]+' para el mes de '+app.meses[s.currentMonth - 1]+' de '+s.currentYear
                mp.addText(title, 0,0)
                let t=j.signos['s'+parseInt(i + 1)].h
                let pf=t.split('.')
                for(var i2=0;i2<pf.length;i2++){
                    mp.addText(pf[i2], 6, false)
                    /*if(i2!==pf.length-1){
                        mp.addText(pf[i2], false)
                    }else{
                        mp.addText(pf[i2], true)
                    }*/
                    cant++
                }
                let txtPie='Próximo signo'
                if(i!==11){
                    txtPie='Próximo signo'
                    mp.addText(txtPie, 0,1)
                }else{
                    txtPie='Fin del Pronóstico Astrológico para '+json.nom+' bajo el signo solar o ascendente '+app.signos[i]+' para el mes de '+app.meses[s.currentMonth - 1]+' de '+s.currentYear
                    mp.addText(txtPie, 2)
                }
            }
            if(cant>=1)r.isReady=true

        }
        sweg.loadSign(r.mkJsonSign(json))
        panelZonaMes.currentIdZona=json.id
        //tPlay.start()
    }

    Component.onCompleted: {
        //console.log('index '+index+': '+JSON.stringify(json))
        let fs1=parseInt(app.fs*0.75)
        let fs2=parseInt(fs1*0.6)
        let fs3=parseInt(fs1*1.2)
        let data='<h1 style="font-size:'+fs1+'px; color: #ff8833; background-color: black;">'+json['nom']+'</h1>'
            +'<h2 style="font-size:'+fs2+'px; color: red;">Pronósticos para estos países o zonas cercanas:</h2>'
        let arrayPaises=json['des'].split(',')
        for(var i=0;i<arrayPaises.length;i++){
            data+='<b style="font-size:'+fs3+'px;  color: #ffffff; background-color: black;">'+arrayPaises[i]+'</b> '
        }
        txtData.text=data
        if(index===0&&panelZonaMes.state==='show')loadJsonTask()
    }
    Rectangle{
        width: infoTXT.contentWidth+4
        height: infoTXT.contentHeight+4
        color: 'black'
        //anchors.centerIn: parent
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        visible: false
        XText {
            id: infoTXT
            text: '<b>LV:'+panelZonaMes.currentIndex+'<b> IS:'+r.currentIndexSign+' PLI:'+playlist.currentIndex+'</b>'
            font.pixelSize: app.fs*0.25
            color: 'red'
            anchors.centerIn: parent
        }
    }
    function mkJsonSign(json){
        let dd = new Date(Date.now())
        let ms=dd.getTime()
        let nom='Centro de Argentina'
        let d=s.currentQ===1?1:15
        let m=s.currentMonth
        let a=s.currentYear
        let h=0
        let min=0
        let lat=json.lat
        let lon=json.lon
        let gmt=json.gmt
        let ciudad=' '
        let j='{"params":{"tipo": "pl", "ms":'+ms+',"n":"'+nom+'","d":'+d+',"m":'+m+',"a":'+a+',"h":'+h+',"min":'+min+',"gmt":'+gmt+',"lat":'+lat+',"lon":'+lon+',"ciudad":"'+ciudad+'"}}'
        return JSON.parse(j)
    }
    function pause(){
        if(mp.pauded){
            mp.pause()
        }else{
            mp.play()
        }
    }
    function play(){
        mp.play()
    }
    function stop(){
        mp.stop()
    }
    function detener(){
        mp.stop()
        r.currentIndexSign=-1
        playlist.currentIndex=-1
    }
}
