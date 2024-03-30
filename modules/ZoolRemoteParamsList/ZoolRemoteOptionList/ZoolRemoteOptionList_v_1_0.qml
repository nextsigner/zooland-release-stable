import QtQuick 2.0

Rectangle{
    id: r
    color: apps.backgroundColor
    anchors.fill: parent
    border.width: 1
    border.color: apps.fontColor
    property alias n: txtNom.text
    property var cParams
    onVisibleChanged: {
        if(visible){
            vars.ci=r
        }else{
            vars.ci=r.parent
        }
    }
    Column{
        id: col
        Rectangle{
            id: xItemNom
            width: lv.width-vars.fs*0.5
            height: txtNom.contentHeight
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            radius: vars.fs*0.15
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                id: txtNom
                width: parent.width-vars.fs
                font.pixelSize: vars.fs
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                color: apps.fontColor
            }
        }
        ListView{
            id: lv
            spacing: vars.fs*0.1
            width: r.width
            height: r.height-xItemNom.height
            delegate: compItem
            model: lm
            ListModel{
                id: lm
                function addItem(p){
                    return{
                        params:p
                    }
                }
            }

        }
    }
    Component{
        id: compItem
        Rectangle{
            id: xItem
            width: lv.width-vars.fs*0.5
            height: txt1.contentHeight
            color: selected?apps.fontColor:apps.backgroundColor
            border.width: 1
            border.color: !selected?apps.fontColor:apps.backgroundColor
            radius: vars.fs*0.15
            anchors.horizontalCenter: parent.horizontalCenter
            property bool selected: lv.currentIndex===index
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lv.currentIndex=index
                    r.toEnter()
                }
            }
            Text{
                id: txt1
                //text: JSON.parse(JSON.stringify(params)).params.n
                width: parent.width-vars.fs
                font.pixelSize: vars.fs
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                color: !selected?apps.fontColor:apps.backgroundColor
            }
            Component.onCompleted: {
                let s=''
                s+=params.params.n
                if(index>2){
                    s+='\nFecha: '+params.params.d+'/'+params.params.m+'/'+params.params.a+''
                }
                txt1.text=s
            }
        }
    }
    function load(j){
        r.cParams=j
        lm.clear()
        let p=JSON.parse('{"params":{"n":"Atras"}}')
        lm.append(lm.addItem(p))
        p=JSON.parse('{"params":{"n":"Cargar"}}')
        lm.append(lm.addItem(p))
        p=JSON.parse('{"params":{"n":"Tránsitos de Ahora"}}')
        lm.append(lm.addItem(p))
        let sp=JSON.stringify(j, null, 2)
        //log.lv('sp: '+sp)
        if(!j.exts || j.exts.length === 0 ){
            //log.lv('Sin EXTS')
            //let sp=JSON.stringify(j, null, 2)
            //log.lv('sp: '+sp)
            //zsfdm.loadParamsFromString(sp)
        }else{
            //log.lv('Con EXTS')
            for(var i=0;i<j.exts.length;i++){
                //let sp=JSON.stringify(j, null, 2)
                let np={}
                np.params=j.exts[i]
                lm.append(lm.addItem(np))
            }
        }
        r.visible=true
    }
    //Funciones de Mando

    function toEnter(){
        //log.lv('Datos Externos: '+JSON.stringify(lm.get(lv.currentIndex).params, null, 2))
        if(lv.currentIndex===0){
            r.visible=false
            vars.ci=zsm.getPanel('ZoolRemoteParamsList')
            return
        }
        if(lv.currentIndex===1){
            //zpn.addNot('cParams: '+JSON.stringify(r.cParams.params))
            zsfdm.loadParamsFromString(JSON.stringify(r.cParams))
            return
        }
        if(lv.currentIndex===2){
            let j=JSON.parse(vars.cParams)
            zsfdm.loadParamsFromStringBack(JSON.stringify(vars.j.getParamsNow(j.params.lat, j.params.lon, j.params.alt, j.params.gmt, j.params.ciudad)))
            return
        }
        zsfdm.getZoolandDataBack(lm.get(lv.currentIndex).params)
    }
    function toLeft(){
        r.visible=false
    }
    function toRight(){

    }
    function toDown(){
        if(lv.currentIndex<lm.count-1){
            lv.currentIndex++
        }else{
            lv.currentIndex=0
        }
    }
    function toUp(){
        if(lv.currentIndex>0){
            lv.currentIndex--
        }else{
            lv.currentIndex=lm.count-1
        }
    }


}
