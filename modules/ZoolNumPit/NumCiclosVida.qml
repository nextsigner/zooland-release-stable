import QtQuick 2.12
import QtQuick.Controls 2.12
import "../"
import "../../Funcs.js" as JS

Rectangle {
    id: r
    color: apps.backgroundColor
    visible: false
    property string jsonNum: ''
    property var aDes: ['dato1', 'dato2', 'dato3', 'dato4', 'dato5', 'dato6', 'dato7', 'dato8', 'dato9']

    property alias currentDate: controlTimeDateNac.currentDate
    property int currentNum: 0

    property color borderColor: apps.fontColor
    property int borderWidth: app.fs*0.15
    property int dir: -1
    property int uRot: 0

    property int currentNumKarma: -1
    property int currentNumAnioPersonal: -1
    property bool esMaestro: false

    onCurrentNumAnioPersonalChanged: {
        currentNum=currentNumAnioPersonal-1
    }
    onCurrentDateChanged: {
        let d = currentDate.getDate()
        let m = currentDate.getMonth() + 1
        let a = currentDate.getFullYear()
        let f = d + '/' + m + '/' + a
        let aGetNums=JS.getNums(f)
        currentNumKarma=aGetNums[0]
        txtDataDia.text=d
    }
    MouseArea{
        anchors.fill: parent
    }
    Row{
        spacing: app.fs*0.5
        anchors.centerIn: parent
        Item{
            id: xForm
            width: app.fs*16
            height: r.height
            Column{
                spacing: app.fs*0.25
                Rectangle{
                    id: xFN
                    width: xForm.width
                    height: colFN.height+app.fs
                    color: 'transparent'
                    border.width: 2
                    border.color: apps.fontColor
                    radius: app.fs*0.2
                    Column{
                        id: colFN
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        Text{
                            text: '<b>Fecha de Nacimiento</b>'
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.5
                            //anchors.verticalCenter: parent.verticalCenter
                        }
                        ControlsTimeDate{
                            id: controlTimeDateNac
                            //anchors.verticalCenter: parent.verticalCenter
                            onCurrentDateChanged: {
                                if(controlTimeYear.currentDate){
                                    let d=currentDate.getDate()
                                    let m=currentDate.getMonth() + 1
                                    let a = currentDate.getFullYear()
                                    let sf=''+d+'/'+m+'/'+a
                                    let aGetNums=JS.getNums(sf)
                                    currentNumKarma=aGetNums[0]
                                    let dateP = new Date(controlTimeYear.currentDate.getFullYear(), m - 1, d, 0, 1)
                                    controlTimeYear.currentDate=dateP
                                    let msfd=(''+d).split('')
                                    let sfd=''+msfd[0]
                                    if(msfd.length>1){
                                        sfd +='+'+msfd[1]
                                    }
                                    let msfm=(''+m).split('')
                                    let sfm=''+msfm[0]
                                    if(msfm.length>1){
                                        sfm +='+'+msfm[1]
                                    }
                                    //let msform=(''+a).split('')
                                    let msfa=(''+a).split('')
                                    let sfa=''+msfa[0]
                                    if(msfa.length>1){
                                        sfa +='+'+msfa[1]
                                    }
                                    if(msfa.length>2){
                                        sfa +='+'+msfa[2]
                                    }
                                    if(msfa.length>3){
                                        sfa +='+'+msfa[3]
                                    }
                                    let sform= sfd + '+' + sfm + '+' + sfa//msform[0] + '+' + msform[1] + '+'  + msform[2]+ '+'  + msform[3]
                                    let sum=0
                                    let mSum=sform.split('+')
                                    for(var i=0;i<mSum.length;i++){
                                        sum+=parseInt(mSum[i])
                                    }
                                    let mCheckSum=(''+sum).split('')
                                    if(mCheckSum.length>1){
                                        if(sum===11||sum===22||sum===33){
                                            //r.esMaestro=true
                                        }
                                        let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
                                        sform+='='+sum+'='+dobleDigSum
                                        let mCheckSum2=(''+dobleDigSum).split('')
                                        if(mCheckSum2.length>1){
                                            let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                                            sform+='='+dobleDigSum2
                                            currentNumKarma=dobleDigSum2
                                        }else{
                                            currentNumKarma=dobleDigSum
                                        }

                                    }else{
                                        currentNumKarma=sum
                                    }
                                    f0.text=sform
                                    //                                    if(panelLog.visible){
                                    //                                        let edad=a - controlTimeDateNac.currentDate.getFullYear()

                                    //                                        let sp='Período: Desde el cumpleaños del día '+d+'/'+m+'/'+a+' hasta el día '+d+'/'+m+'/'+parseInt(a + 1)
                                    //                                        panelLog.l('Año: '+a+' - Edad: '+edad+' - Ciclo: '+parseInt(r.currentNum +1)+'\n'+sp+'\nCálculo: '+f1.text+'\n'+aDes[r.currentNum]+'\n')
                                    //                                    }
                                }
                            }
                        }
                        Text{
                            id: f0
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.8
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Row{
                            spacing: app.fs*0.5
                            anchors.horizontalCenter:  parent.horizontalCenter
                            Text{
                                text: '<b>N° Destino/Karma</b>: '
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Rectangle{
                                id: xNumKarma
                                width: app.fs*2
                                height: width
                                radius: width*0.5
                                border.width: app.fs*0.2
                                border.color: apps.fontColor
                                //rotation: 360-parent.rotation
                                color: apps.backgroundColor
                                anchors.verticalCenter: parent.verticalCenter
                                Text{
                                    text: '<b>'+r.currentNumKarma+'</b>'
                                    font.pixelSize: parent.width*0.8
                                    color: apps.fontColor
                                    anchors.centerIn: parent
                                }
                            }
                            Button{
                                text:  'Mostrar'
                                onClicked: {
                                    if(checkBoxFormula.checked){
                                        panelLog.l('Fórmula: '+f0.text+'\n')
                                        panelLog.l('Número de Nacimiento/Karma '+r.currentNumKarma+'\n')
                                        panelLog.l('¿Como es su vibración o karma de nacimiento '+r.currentNumKarma+'?\n')
                                        panelLog.l(getItemJson('per'+r.currentNumKarma))
                                    }else{
                                        panelLog.l('¿Como es su vibración o karma de nacimiento '+r.currentNumKarma+'?\n')
                                        panelLog.l(getItemJson('per'+r.currentNumKarma))
                                    }
                                }
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
                Rectangle{
                    id: xFormNom
                    width: xForm.width
                    height: colNom.height+app.fs
                    color: 'transparent'
                    border.width: 2
                    border.color: apps.fontColor
                    radius: app.fs*0.2
                    Column{
                        id: colNom
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        Text{
                            text: '<b>Calcular Nombre</b>'
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Rectangle{
                            id:xTiNombre
                            width: xForm.width-app.fs*0.5
                            height: app.fs*1.2
                            color: apps.backgroundColor
                            border.width: 2
                            border.color: apps.fontColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text{
                                text: '<b>Nombre:</b>'
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.25
                                anchors.bottom: parent.top
                                anchors.bottomMargin: app.fs*0.25
                            }
                            TextInput {
                                id: txtDataSearchNom
                                text: ''
                                font.pixelSize: app.fs*0.5
                                width: parent.width-app.fs*0.2
                                wrapMode: Text.WordWrap
                                color: apps.fontColor
                                focus: false
                                anchors.centerIn: parent
                                Keys.onReturnPressed: {
                                    if(text==='')return
                                    panelLog.l(getNumNomText(text))
                                }
                                onTextChanged: {
                                    //updateList()
                                }
                                onFocusChanged: {
                                    if(focus)selectAll()
                                }
                                Rectangle{
                                    width: parent.width+app.fs
                                    height: parent.height+app.fs
                                    color: 'transparent'
                                    //border.width: 2
                                    //border.color: 'white'
                                    z: parent.z-1
                                    anchors.centerIn: parent
                                }
                            }
                        }
                        Row{
                            spacing: app.fs*0.5
                            Text{
                                text: '<b>Mostrar cálculo</b>'
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.25
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            CheckBox{
                                id: checkBoxFormula
                                checked: false
                                anchors.verticalCenter: parent.verticalCenter
                                //onCheckedChanged: panelLog.visible=checked
                            }
                        }
                        Row{
                            spacing: app.fs*0.5
                            Text{
                                text: '<b>Día:</b>'
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.25
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            CheckBox{
                                id: checkBoxDia
                                checked: false
                                anchors.verticalCenter: parent.verticalCenter
                                //onCheckedChanged: panelLog.visible=checked
                            }
                            Rectangle{
                                id:xTiDia
                                width: app.fs
                                height: app.fs*1.2
                                color: apps.backgroundColor
                                border.width: 2
                                border.color: apps.fontColor
                                anchors.verticalCenter: parent.verticalCenter
                                visible: checkBoxDia.checked

                                TextInput {
                                    id: txtDataDia
                                    text: ''
                                    font.pixelSize: app.fs*0.5
                                    width: parent.width-app.fs*0.2
                                    wrapMode: Text.WordWrap
                                    color: apps.fontColor
                                    focus: false
                                    anchors.centerIn: parent
                                    validator: IntValidator {
                                        bottom: 1
                                        top: 31
                                    }
                                    onFocusChanged: {
                                        if(focus)selectAll()
                                    }
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        visible=false
                                        showTiMaDia.restart()
                                    }
                                    onWheel: {
                                        let n=parseInt(txtDataDia.text)
                                        if(wheel.angleDelta.y>=0){
                                            if(n<31){
                                                n++
                                            }else{
                                                n=1
                                            }
                                        }else{
                                            if(n>1){
                                                n--
                                            }else{
                                                n=31
                                            }
                                        }
                                        txtDataDia.text=n
                                    }

                                    Timer{
                                        id: showTiMaDia
                                        repeat: false
                                        running: false
                                        interval: 5000
                                        onTriggered: parent.visible=true
                                    }
                                }
                            }
                            Button{
                                text:  'Calcular'
                                onClicked: {
                                    if(txtDataSearchNom.text==='')return
                                    panelLog.l(getNumNomText(txtDataSearchNom.text))
                                }
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
                Row{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: checkBoxLog.checked?'<b>Ocultar texto</b>':'<b>Mostrar texto.</b>'
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    CheckBox{
                        id: checkBoxLog
                        checked: panelLog.visible
                        anchors.verticalCenter: parent.verticalCenter
                        onCheckedChanged: panelLog.visible=checked
                    }
                }
                }
        }
        Rectangle{
            id: xFormNumCiclo
            width: xNums.width+app.fs
            height: xApp.height
            color: 'transparent'
            //border.width: 2
            //border.color: apps.fontColor
            //radius: app.fs*0.2
            anchors.verticalCenter: parent.verticalCenter
            Column{
                spacing: app.fs*0.25
                anchors.centerIn: parent
                Rectangle{
                    id: xAP
                    width: parent.width//-app.fs*0.5
                    height: colAP.height+app.fs
                    color: 'transparent'
                    border.width: 2
                    border.color: apps.fontColor
                    radius: app.fs*0.2
                    anchors.horizontalCenter: parent.horizontalCenter
                    Column{
                        id: colAP
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        Row{
                            spacing: app.fs
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text{
                                text: '<b>N° Año Personal</b>'
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            ControlsTimeFullYear{
                                id: controlTimeYear
                                anchors.verticalCenter: parent.verticalCenter
                                onCurrentDateChanged: {
                                    r.esMaestro=false
                                    let d = currentDate.getDate()
                                    let m = currentDate.getMonth() + 1
                                    let a = currentDate.getFullYear()
                                    let sf=''+d+'/'+m+'/'+a
                                    //let aGetNums=JS.getNums(sf)
                                    //currentNumAnioPersonal=aGetNums[0]
                                    let msfd=(''+d).split('')
                                    let sfd=''+msfd[0]
                                    if(msfd.length>1){
                                        sfd +='+'+msfd[1]
                                    }
                                    let msfm=(''+m).split('')
                                    let sfm=''+msfm[0]
                                    if(msfm.length>1){
                                        sfm +='+'+msfm[1]
                                    }
                                    //let msform=(''+a).split('')
                                    let msfa=(''+a).split('')
                                    let sfa=''+msfa[0]
                                    if(msfa.length>1){
                                        sfa +='+'+msfa[1]
                                    }
                                    if(msfa.length>2){
                                        sfa +='+'+msfa[2]
                                    }
                                    if(msfa.length>3){
                                        sfa +='+'+msfa[3]
                                    }
                                    let sform= sfd + '+' + sfm + '+' + sfa//msform[0] + '+' + msform[1] + '+'  + msform[2]+ '+'  + msform[3]
                                    let sum=0
                                    let mSum=sform.split('+')
                                    for(var i=0;i<mSum.length;i++){
                                        sum+=parseInt(mSum[i])
                                    }
                                    let mCheckSum=(''+sum).split('')
                                    if(mCheckSum.length>1){
                                        if(sum===11||sum===22||sum===33){
                                            r.esMaestro=true
                                        }
                                        let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
                                        sform+='='+sum+'='+dobleDigSum
                                        let mCheckSum2=(''+dobleDigSum).split('')
                                        if(mCheckSum2.length>1){
                                            let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                                            sform+='='+dobleDigSum2
                                            currentNumAnioPersonal=dobleDigSum2
                                        }else{
                                            currentNumAnioPersonal=dobleDigSum
                                        }

                                    }else{
                                        currentNumAnioPersonal=sum
                                    }
                                    f1.text=sform
                                    if(panelLog.visible){
                                        let edad=a - controlTimeDateNac.currentDate.getFullYear()

                                        let sp='Período: Desde el cumpleaños del día '+d+'/'+m+'/'+a+' hasta el día '+d+'/'+m+'/'+parseInt(a + 1)
                                        panelLog.l('Año: '+a+' - Edad: '+edad+' - Ciclo: '+parseInt(r.currentNum +1)+'\n'+sp+'\nCálculo: '+f1.text+'\n'+aDes[r.currentNum]+'\n')
                                    }
                                }
                            }
                            Row{
                                spacing: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                                Text{
                                    text: '<b>Año:</b> '
                                    color: apps.fontColor
                                    font.pixelSize: app.fs*0.5
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Rectangle{
                                    id: xNumAP
                                    width: app.fs*2
                                    height: width
                                    radius: width*0.5
                                    border.width: app.fs*0.2
                                    border.color: apps.fontColor
                                    //rotation: 360-parent.rotation
                                    color: apps.backgroundColor
                                    anchors.verticalCenter: parent.verticalCenter
                                    Text{
                                        text: '<b>'+r.currentNumAnioPersonal+'</b>'
                                        font.pixelSize: parent.width*0.8
                                        color: apps.fontColor
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                        }
                        Text{
                            id: f1
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.8
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                    }
                }
                Rectangle{
                    id: xNums
                    width: xApp.height-xAP.height-xBtns.height-app.fs*0.5
                    height: width
                    border.width: r.borderWidth
                    border.color: r.borderColor
                    color: apps.backgroundColor
                    radius: width*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    Behavior on rotation{NumberAnimation{duration: 500}}
                    MouseArea{
                        anchors.fill: parent
                        onWheel: {
                            if(wheel.angleDelta.y>=0){
                                r.dir=1
                                if(r.currentNum<8){
                                    r.currentNum++
                                }else{
                                    r.currentNum=0
                                }
                            }else{
                                r.dir=0
                                if(r.currentNum>0){
                                    r.currentNum--
                                }else{
                                    r.currentNum=8
                                }
                            }
                        }
                    }
                    Repeater{
                        id: rep
                        model: r.aDes
                        Item{
                            width: 1
                            height: parent.width-parent.border.width*2
                            anchors.centerIn: parent
                            rotation: 360/9*index//+90
                            Rectangle{
                                width: r.borderWidth
                                height: parent.parent.height*0.5-xNum.width-xData.width*0.5-canvasSen.width*0.5
                                color: apps.fontColor
                                opacity: r.currentNum!==index?0.5:1.0
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin:  xNum.width
                                visible: r.currentNum===index
                                Canvas {
                                    id:canvasSen
                                    width: app.fs
                                    height: width
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    //anchors.verticalCenter: parent.verticalCenter
                                    //anchors.left: parent.right
                                    antialiasing: true
                                    rotation: -90
                                    onPaint:{
                                        var ctx = canvasSen.getContext('2d');
                                        ctx.beginPath();
                                        ctx.moveTo(0, canvasSen.width*0.5);
                                        ctx.lineTo(canvasSen.width, 0);
                                        ctx.lineTo(canvasSen.width, canvasSen.width);
                                        ctx.lineTo(0, canvasSen.width*0.5);
                                        ctx.strokeStyle = r.currentNum===index?apps.fontColor:apps.backgroundColor
                                        ctx.lineWidth = 3//canvasSen.parent.height;
                                        ctx.fillStyle = r.currentNum===index?apps.backgroundColor:apps.fontColor
                                        ctx.fill();
                                        ctx.stroke();
                                    }
                                }
                            }
                            Rectangle{
                                id: xNum
                                width: app.fs*3
                                height: width
                                radius: width*0.5
                                border.width: app.fs*0.2
                                border.color: r.currentNum===index?apps.fontColor:apps.backgroundColor
                                //rotation: 360-parent.rotation
                                color: r.currentNum===index?apps.fontColor:apps.backgroundColor
                                rotation: 360-parent.rotation-parent.parent.rotation//-360/9*r.currentNum-90
                                anchors.horizontalCenter: parent.horizontalCenter
                                opacity: r.currentNum!==index?0.5:1.0
                                Timer{
                                    running: r.visible
                                    repeat: true
                                    interval: 500
                                    onTriggered: {
                                        if(index===1){
                                            txtNum.text=r.esMaestro&&index===r.currentNumAnioPersonal-1?'<b>11</b>':'<b>2</b>'
                                        }else if(index===3){
                                            txtNum.text=r.esMaestro&&index===r.currentNumAnioPersonal-1?'<b>22</b>':'<b>4</b>'
                                        }else if(index===5){
                                            txtNum.text=r.esMaestro&&index===r.currentNumAnioPersonal-1?'<b>33</b>':'<b>6</b>'
                                        }else{
                                            txtNum.text='<b>'+parseInt(index + 1)+'</b>'
                                        }
                                    }
                                }
                                Text{
                                    id: txtNum
                                    text: '<b>'+index+'</b>'
                                    font.pixelSize: parent.width*0.75
                                    color: r.currentNum===index?apps.backgroundColor:apps.fontColor
                                    anchors.centerIn: parent
                                    Component.onCompleted: {
                                        if(index===1){
                                            text='<b>11</b>'
                                        }else{
                                            text='<b>'+parseInt(index + 1)+'</b>'
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: xData
                        width: parent.width*0.4
                        height: width
                        border.width: r.borderWidth
                        border.color: r.borderColor
                        color: 'transparent'//apps.backgroundColor
                        radius: width*0.5
                        anchors.centerIn: parent
                        Text{
                            id: data
                            text : ''+r.aDes[r.currentNum]
                            width: parent.width-app.fs
                            font.pixelSize: parent.width*0.08
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            anchors.centerIn: parent
                            color: apps.fontColor
                        }
                    }
                }
                Rectangle{
                    id: xBtns
                    width: parent.width//-app.fs*0.5
                    height: colBtns.height+app.fs
                    color: 'transparent'
                    border.width: 2
                    border.color: apps.fontColor
                    radius: app.fs*0.2
                    anchors.horizontalCenter: parent.horizontalCenter
                    Column{
                        id: colBtns
                        spacing: app.fs
                        anchors.centerIn: parent
                        Row{
                            spacing: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: checkBoxLog.checked
                            Button{
                                text:  'Limpiar'
                                onClicked: panelLog.clear()
                                anchors.verticalCenter: parent.verticalCenter
                                visible: checkBoxLog.checked
                            }
                            Button{
                                text:  'Copiar'
                                onClicked: {
                                    clipboard.setText(panelLog.text)
                                }
                                anchors.verticalCenter: parent.verticalCenter
                                visible: checkBoxLog.checked
                            }
                            Button{
                                text:  'Crear Lista'
                                onClicked: mkDataList()
                                anchors.verticalCenter: parent.verticalCenter
                                visible: checkBoxLog.checked
                            }
                        }
                    }
                }
            }
        }
        PanelLog{
            id: panelLog
            width: xApp.width-xFormNumCiclo.width-xForm.width-parent.spacing*2
            height: parent.height
            visible: true
        }
    }
    Button{
        text:  'Cerrar'
        width: app.fs*3
        height: app.fs
        anchors.bottom: parent.bottom
        onClicked: {
            r.visible=false
        }
    }
    Component.onCompleted: {
        let a =[]
        let d = 'INICIOS, VIDA NUEVA, RENOVACIONES'
        a.push(d)
        d = 'TOMA DE DESICIONES, SALIR DE TUS FRONTERAS, LA REALIDAD SE TE PONE CARA A CARA, NO PODES ESQUIVARLA, MOMENTO DE HACERSE CARGO, ACEPTAR LA REALIDAD'
        a.push(d)
        d = 'NOTORIEDAD, BRILLO, OPCIONES, OPORTUNIDADES'
        a.push(d)
        d = 'CONSTRUCCIÓN, DISCIPLINA, TIEMPO DE PONER ORDEN EN TU VIDA'
        a.push(d)
        d = 'PROGRESO, MOVIMIENTO, SALIR DE LA ZONA DE CONFORT'
        a.push(d)
        d = 'TRABAJO EN RELACIONES, PRODUCTIVIDAD, GENERACIÓN'
        a.push(d)
        d = 'RESPONSABILIDAD Y ESTRUCTURA, ASUMIR LA PROPIA REALIDAD'
        a.push(d)
        d = 'COSECHA Y LOGROS, RETO Y CONQUISTA A SUPERAR'
        a.push(d)
        d = 'AUTOSUFICIENCIA, CONSOLIDACIÓN, CIERRE DE CICLO'
        a.push(d)
        r.aDes=a
        rep.model=a
        //xNums.rotation=90
    }
    function getNumNomText(text){
        let ret=''
        let t=text.toUpperCase().replace(/ /g, '')
        let av=[]
        let ac=[]
        let ml=t.split('')
        for(var i=0;i<ml.length;i++){
            let l=ml[i]
            if(l==='A'||l==='E'||l==='I'||l==='O'||l==='U'||l==='Á'||l==='É'||l==='Í'||l==='Ó'||l==='Ú'){
                av.push(l)
            }else{
                ac.push(l)
            }
        }
        let vtv=0
        let vtc=0
        let sfv=''
        let sfc=''
        let rc=0
        for(i=0;i<av.length;i++){
            rc=gvl(av[i])
            vtv+=rc
            if(i===0){
                sfv+=rc
            }else{
                sfv+='+'+rc
            }
        }
        sfv+='='+vtv
        for(i=0;i<ac.length;i++){
            rc=gvl(ac[i])
            vtc+=rc
            if(i===0){
                sfc+=rc
            }else{
                sfc+='+'+rc
            }
        }
        sfc+='='+vtc
        let m0

        let dataInt=''
        let dataExt=''
        let st='int'
        let st2='ext'
        let resM1=-1
        let resM2=-1
        if(vtv===11||vtv===33){
            dataInt='En su interior nació con el número Maestro '+vtv+'\n'
            dataInt+=getDataNum('intm', vtv)+'\n\n'
            //vtv=1
        }
        if(vtv===22||vtv===44){
            dataInt='En su interior nació con el número Maestro '+vtv+'\n'
            dataInt+=getDataNum('intm', vtv)+'\n\n'
            //vtv=2
        }
        if(vtc===11||vtc===33){
            dataExt='En su exterior nació con el número Maestro '+vtc+'\n'
            dataExt+=getDataNum('extm', vtc)+'\n\n'
            //vtc=1
        }
        if(vtc===22||vtc===44){
            dataExt='En su exterior nació con el número Maestro '+vtc+'\n'
            dataExt+=getDataNum('extm', vtc)+'\n\n'
            //vtc=2
        }
        if(vtv>9){
            m0=(''+vtv).split('')
            vtv=parseInt(m0[0])+parseInt(m0[1])
            sfv+='='+vtv
        }
        if(vtv>9){
            m0=(''+vtv).split('')
            vtv=parseInt(m0[0])+parseInt(m0[1])
            sfv+='='+vtv
        }
        if(vtc>9){
            m0=(''+vtc).split('')
            vtc=parseInt(m0[0])+parseInt(m0[1])
            sfc+='='+vtc
        }
        if(vtc>9){
            m0=(''+vtc).split('')
            vtc=parseInt(m0[0])+parseInt(m0[1])
            sfc+='='+vtc
        }
        //panelLog.l('st:'+st+' vtv:'+vtv)
        dataInt+=getDataNum(st, vtv)
        //panelLog.l('st2:'+st2+' vtc: '+vtc)
        dataExt+=getDataNum(st2, vtc)
        if(checkBoxFormula.checked){
            ret+='Vocales: '+av.toString()+'\n'
            ret+='Fórmula de Vocales: '+sfv+'\n'
            ret+='Vibración '+dataInt+'\n'
            ret+='\n'
            ret+='Consonantes: '+ac.toString()+'\n'
            ret+='Fórmula de Consonantes: '+sfc+'\n'
            ret+='Vibración '+dataExt+'\n'
        }else{
            ret+='¿Cómo es la forma de ser de '+txtDataSearchNom.text+' por dentro?\n\n'+dataInt+'\n\n'
            ret+='¿Cómo es la forma de ser de '+txtDataSearchNom.text+' hacia afuera?\n\n'+dataExt+'\n\n'
        }
        let stringDia=''
        if(checkBoxDia.checked){
            let dia=parseInt(txtDataDia.text)
            if(dia>0&&dia<=31){
                stringDia=getDataNumDia(dia)
                ret+='Natalicio en día '+dia+': '+stringDia
            }
        }
        return ret
    }
    function getDataNum(t, v){
        //panelLog.l('t:'+t)
        //panelLog.l('v:'+v)
        let ret='?'
        let jsonString
        if(r.jsonNum===''){
            r.jsonNum=unik.getFile('./resources/num.json')
        }
        jsonString=r.jsonNum.replace(/\n/g, ' ')
        let json=JSON.parse(jsonString)

        ret=json[''+t+''+v]
        return ret
    }
    function getDataNumDia(dia){
        let ret='?'
        let jsonString
        if(r.jsonNum===''){
            r.jsonNum=unik.getFile('./resources/num.json')
        }
        jsonString=r.jsonNum.replace(/\n/g, ' ')
        let json=JSON.parse(jsonString)

        ret=json['d'+dia]
        return ret
    }
    function getItemJson(i){
        let ret='?'
        let jsonString
        if(r.jsonNum===''){
            r.jsonNum=unik.getFile('./resources/num.json')
        }
        jsonString=r.jsonNum.replace(/\n/g, ' ')
        let json=JSON.parse(jsonString)

        ret=json[i]
        return ret
    }
    function gvl(l){
        let r=-1
        let col1=['A', 'J', 'R']
        let col2=['B', 'K', 'S']
        let col3=['C', 'L', 'T']
        let col4=['D', 'M', 'U']
        let col5=['E', 'N', 'V']
        let col6=['F', 'Ñ', 'W']
        let col7=['G', 'O', 'X']
        let col8=['H', 'P', 'Y']
        let col9=['I', 'Q', 'Z']
        if(col1.indexOf(l)>=0){
            r=1
        }else if(col2.indexOf(l)>=0){
            r=2
        }else if(col3.indexOf(l)>=0){
            r=3
        }else if(col4.indexOf(l)>=0){
            r=4
        }else if(col5.indexOf(l)>=0){
            r=5
        }else if(col6.indexOf(l)>=0){
            r=6
        }else if(col7.indexOf(l)>=0){
            r=7
        }else if(col8.indexOf(l)>=0){
            r=8
        }else if(col9.indexOf(l)>=0){
            r=9
        }else{
            r=9
        }
        return r
    }
    function mkDataList(){
        var ai=r.currentDate.getFullYear()
        var d = currentDate.getDate()
        var m = currentDate.getMonth() + 1
        var sformTodo='Ciclo de Vida Numerológico\n\n'
        //return
        for(var i=ai;i<ai+101;i++){
            var currentNumAP=-1
            var sform=''
            let a = i
            let sf=''+d+'/'+m+'/'+a
            //let aGetNums=JS.getNums(sf)
            //currentNumAnioPersonal=aGetNums[0]
            let msfd=(''+d).split('')
            let sfd=''+msfd[0]
            if(msfd.length>1){
                sfd +='+'+msfd[1]
            }
            let msfm=(''+m).split('')
            let sfm=''+msfm[0]
            if(msfm.length>1){
                sfm +='+'+msfm[1]
            }
            //let msform=(''+a).split('')
            let msfa=(''+a).split('')
            let sfa=''+msfa[0]
            if(msfa.length>1){
                sfa +='+'+msfa[1]
            }
            if(msfa.length>2){
                sfa +='+'+msfa[2]
            }
            if(msfa.length>3){
                sfa +='+'+msfa[3]
            }
            let sform= sfd + '+' + sfm + '+' + sfa//msform[0] + '+' + msform[1] + '+'  + msform[2]+ '+'  + msform[3]
            let sum=0
            let mSum=sform.split('+')
            for(var i2=0;i2<mSum.length;i2++){
                sum+=parseInt(mSum[i2])
            }
            let mCheckSum=(''+sum).split('')
            if(mCheckSum.length>1){
                let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
                sform+='='+sum+'='+dobleDigSum
                let mCheckSum2=(''+dobleDigSum).split('')
                if(mCheckSum2.length>1){
                    let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                    sform+='='+dobleDigSum2
                    currentNumAP=dobleDigSum2
                }else{
                    currentNumAP=dobleDigSum
                }
            }else{
                currentNumAP=sum
            }
            let edad=a - ai
            var sp
            if(edad===0){
                sp='Período: Desde el nacimiento '+d+'/'+m+'/'+a+' hasta el día '+d+'/'+m+'/'+parseInt(a + 1)
            }else{
                sp='Período: Desde el cumpleaños del día '+d+'/'+m+'/'+a+' hasta el día '+d+'/'+m+'/'+parseInt(a + 1)
            }
            //sformTodo+='Año: '+i+' - Edad: '+edad+' - Ciclo: '+parseInt(currentNumAP)+'\n'+sp+'\nCálculo: '+sform+'\n'+aDes[currentNumAP - 1]+'\n\n'
            sformTodo+='Año: '+i+' - Edad: '+edad+'\nAño personal de ciclo: '+parseInt(currentNumAP)+'\n'+sp+'\nCálculo: '+sform+'\n'+aDes[currentNumAP - 1]+'\n\n'
        }
        if(panelLog.visible){
            panelLog.l(sformTodo)
        }
    }
    function printData(nom, date){
        txtDataSearchNom.text=nom
        let d = date.getDate()
        let m = date.getMonth() + 1
        let a = date.getFullYear()
        let f = d + '/' + m + '/' + a
        let aGetNums=JS.getNums(f)
        let vCurrentNumKarma=aGetNums[0]
        panelLog.l('Número de Karma '+vCurrentNumKarma+'\n')
        panelLog.l(getNumNomText(nom))
        panelLog.l('¿Cómo es su personalidad?\n')
        panelLog.l(getItemJson('per'+vCurrentNumKarma))
    }
}
