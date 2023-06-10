import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: r
    //width: cellWidth*15
    width: cellWidth*20
    //height: cellWidth*15
    height: cellWidth*20
    color: 'transparent'
    antialiasing: true
    //border.width: 4
    //border.color: 'red'
    property url uItemGrabber
    property int cellWidth: app.fs*0.45
    Row{
        id: row
        visible: apps.showAspPanel
        Repeater{
            //model: r.visible?15:0
            model: r.visible?20:0
            CellColumnAsp{planet: index;cellWidth: r.cellWidth; objectName: 'cellRowAsp_'+index}
        }
    }
    Rectangle{
        width: r.cellWidth
        height: width
        color: apps.fontColor
        anchors.bottom: apps.showAspPanel?parent.top:parent.bottom
        border.width: 1
        border.color: apps.backgroundColor
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (mouse.modifiers & Qt.ControlModifier) {
                    apps.showAspCircle=!apps.showAspCircle
                    return
                }
                apps.showAspPanel=!apps.showAspPanel
            }
        }
        Text{
            text:  apps.showAspCircle?'\uf06e':'\uf070'
            font.family: "FontAwesome"
            font.pixelSize: r.cellWidth*0.8
            color: apps.backgroundColor
            opacity: apps.showAspCircle?1.0:0.65
            anchors.centerIn: parent
        }
        Text{
            text:  'Aspextos'
            font.pixelSize: app.fs*0.25
            color: apps.fontColor
            opacity: apps.showAspPanel?0.0:1.0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: app.fs*0.1
        }
    }
//    Rectangle{
//        anchors.fill: r
//        color: 'transparent'
//        border.width: 2
//        border.color: 'red'
//        visible: app.dev
//    }
    function clear(){
        if(!r.visible)return
        //for(var i=0;i<15;i++){
        for(var i=0;i<20;i++){
            let column=row.children[i]
            column.clear()
        }
    }
    function setAsp2(c1, c2, ia, iPosAsp){
        if(!r.visible)return
        if(!row.children[c2])return
        let column=row.children[c2]
        let cellRow=column.col.children[c1]
        cellRow.indexAsp=ia
        cellRow.indexPosAsp=iPosAsp
    }
    function setAsp(c1, c2, ia, iPosAsp){
        if(!r.visible)return
        setAsp2(c1,c2,ia,iPosAsp)
        setAsp2(c2,c1,ia,iPosAsp)
    }
    function load(jsonData){
        if(!r.visible)return
        clear()
        if(!jsonData.asps)return
        let asp=jsonData.asps
        /*
        log.l(JSON.stringify(asp))
        for(var i=0;i<Object.keys(asp).length;i++){
            log.l('i: '+i)
            if(asp['asp'+parseInt(i )]){
                let a=asp['asp'+parseInt(i )]
                let strAsp=''+app.planetas[a.ic1]+' '+app.planetas[a.ic2]+' '+a.ia
                log.l(strAsp)
                log.visible=true
                if(asp['asp'+parseInt(i )]){
                    if((asp['asp'+parseInt(i )].ic1===10 && asp['asp'+parseInt(i)].ic2===11)||(asp['asp'+parseInt(i )].ic1===11 && asp['asp'+parseInt(i )].ic2===10)){
                        continue
                    }else{
                        //let a=asp['asp'+parseInt(i +1)]
                        setAsp(a.ic1, a.ic2, a.ia,i+1)
                    }
                }
            }
        }
        */
        for(var i=0;i<Object.keys(asp).length;i++){
            if(asp['asp'+parseInt(i +1)]){
                if(asp['asp'+parseInt(i +1)]){
                    if((asp['asp'+parseInt(i +1)].ic1===10 && asp['asp'+parseInt(i +1)].ic2===11)||(asp['asp'+parseInt(i +1)].ic1===11 && asp['asp'+parseInt(i +1)].ic2===10)){
                        continue
                    }else{
                        let a=asp['asp'+parseInt(i +1)]
                        setAsp(a.ic1, a.ic2, a.ia,i)
                        let strAsp='Indefinido'
                        if(a.ia===0){
                            strAsp='Oposición'
                        }else if(a.ia===1){
                            strAsp='Cuadratura'
                        }else if(a.ia===2){
                            strAsp='Trígono'
                        }else{
                            strAsp='Conjunción'
                        }

                        if(sweg.aTexts[a.ic1]===''){
                            sweg.aTexts[a.ic1]+='<b>'+app.planetas[a.ic1]+'</b><br />'+strAsp+' a '+app.planetas[a.ic2]
                        }else{
                            sweg.aTexts[a.ic1]+='<br />'+strAsp+' a '+app.planetas[a.ic2]
                        }
                        let nTexts=sweg.aTexts[a.ic1].split('<br />').sort().join('<br />')
                        sweg.aTexts[a.ic1]=nTexts
                    }
                }
            }
        }
        setItemGrabber()
    }
    function setItemGrabber(){
        r.grabToImage(function(result) {
            //result.saveToFile(folder+"/"+imgFileName);
            r.uItemGrabber=result.url
        });
    }
}
