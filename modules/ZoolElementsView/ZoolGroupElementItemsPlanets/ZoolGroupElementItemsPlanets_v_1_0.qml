import QtQuick 2.0
import ZoolElementsView.ZoolGroupElementItemsPlanets.ZoolElementItemPlanet 1.0


Rectangle{
    id: r
    width: r.fs*6
    height: col.height//app.fs*4
    border.width: 0
    border.color: 'red'
    color: 'transparent'
    anchors.right: parent.right
    property int fs: app.fs*3
    property bool isBack: false
    property bool showTitle: false
    Column{
        id: col
        anchors.right: parent.right
        ZoolElementItemPlanet{id: itemSpacingTitle; fs: r.fs; numElement: 0; visible: r.showTitle}
        ZoolElementItemPlanet{id: itemSpacingTitle2; fs: r.fs; numElement: 0; visible: r.showTitle && r.isBack}
        ZoolElementItemPlanet{id: itemFuego; fs: r.fs; numElement: 0}
        ZoolElementItemPlanet{id: itemTierra; fs: r.fs; numElement: 1}
        ZoolElementItemPlanet{id: itemAire; fs: r.fs; numElement: 2}
        ZoolElementItemPlanet{id: itemAgua; fs: r.fs; numElement: 3}
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
        itemFuego.arrayPlanets=v1
        itemTierra.arrayPlanets=v2
        itemAire.arrayPlanets=v3
        itemAgua.arrayPlanets=v4

        //setUImgGrabber()
    }
}
