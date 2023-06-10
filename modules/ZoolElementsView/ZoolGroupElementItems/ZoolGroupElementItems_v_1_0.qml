import QtQuick 2.0
import ZoolElementsView.ZoolGroupElementItems.ZoolElementItem 1.0
import "./ZoolElementItem"


Rectangle{
    id: r
    width: r.fs*6
    height: col.height//app.fs*4
    border.width: 0
    border.color: 'red'
    color: 'transparent'
    property int fs: app.fs*3
    property bool isBack: false
    property bool showTitle: false
    property int firstItemHeight: itemFuego.height
    Column{
        id: col
        anchors.centerIn: parent
        ZoolElementItemTitle{fs: r.fs; isBack: r.isBack; visible: r.showTitle}
        ZoolElementItem{id: itemFuego; fs: r.fs; numElement: 0}
        ZoolElementItem{id: itemTierra; fs: r.fs; numElement: 1}
        ZoolElementItem{id: itemAire; fs: r.fs; numElement: 2}
        ZoolElementItem{id: itemAgua; fs: r.fs; numElement: 3}
        ZoolElementItemNumPit{id: numPit; fs: r.fs; isBack: r.isBack}
    }
    function load(j){
        //r.maxPlanetsListWith=0
        let cFuego=0
        let cTierra=0
        let cAire=0
        let cAgua=0
        let cTotal=0
        let v1=''
        let v2=''
        let v3=''
        let v4=''
        for(var i=0;i<12;i++){
            //console.log('-------->'+j.pc['c'+i].is)
            if(j.pc['c'+i].is===0||j.pc['c'+i].is===4||j.pc['c'+i].is===8){
                cFuego++
                if(v1===''){
                    v1+=''+i
                }else{
                    v1+='|'+i
                }
            }
            if(j.pc['c'+i].is===1||j.pc['c'+i].is===5||j.pc['c'+i].is===9){
                cTierra++
                if(v2===''){
                    v2+=''+i
                }else{
                    v2+='|'+i
                }
            }
            if(j.pc['c'+i].is===2||j.pc['c'+i].is===6||j.pc['c'+i].is===10){
                cAire++
                if(v3===''){
                    v3+=''+i
                }else{
                    v3+='|'+i
                }
            }
            if(j.pc['c'+i].is===3||j.pc['c'+i].is===7||j.pc['c'+i].is===11){
                cAgua++
                if(v4===''){
                    v4+=''+i
                }else{
                    v4+='|'+i
                }
            }
            //let rFuego=
            cTotal++
        }
        if(j.ph['h1'].is===0||j.ph['h1'].is===4||j.ph['h1'].is===8){
            cFuego++
        }
        if(j.ph['h1'].is===1||j.ph['h1'].is===5||j.ph['h1'].is===9){
            cTierra++
        }
        if(j.ph['h1'].is===2||j.ph['h1'].is===6||j.ph['h1'].is===10){
            cAire++
        }
        if(j.ph['h1'].is===3||j.ph['h1'].is===7||j.ph['h1'].is===11){
            cAgua++
        }
        cTotal++
        let rFuego=cFuego/cTotal*100
        let rTierra=cTierra/cTotal*100
        let rAire=cAire/cTotal*100
        let rAgua=cAgua/cTotal*100
        let af=[parseFloat(rFuego).toFixed(1), parseFloat(rTierra).toFixed(1), parseFloat(rAire).toFixed(1), parseFloat(rAgua).toFixed(1)]

        itemFuego.porc=af[0]
        itemTierra.porc=af[1]
        itemAire.porc=af[2]
        itemAgua.porc=af[3]

        numPit.updateNumPit()
        //setUImgGrabber()
    }
}
