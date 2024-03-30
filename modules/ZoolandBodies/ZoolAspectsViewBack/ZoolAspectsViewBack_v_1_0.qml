import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: r
    width: cellWidth*15
    height: cellWidth*15
    color: 'transparent'
    antialiasing: true
    property url uItemGrabber
    property int cellWidth: vars.fs*0.45
    Row{
        id: row
        visible: apps.showAspPanelBack
        Repeater{
            model: r.visible?20:0
            CellColumnAspBack{planet: index;cellWidth: r.cellWidth; objectName: 'cellRowAsp_'+index}
        }
    }
    MouseArea{
        anchors.fill: r
        //enabled: sweg.state!==sweg.aStates[2]
        onClicked: {
            sweg.state=sweg.aStates[2]
            //swegz.sweg.state=sweg.aStates[2]
        }
        //Rectangle{anchors.fill: parent; color: 'red';opacity:0.5}
    }
    Rectangle{
        width: r.cellWidth
        height: width
        color: apps.fontColor
        anchors.bottom: apps.showAspPanelBack?parent.top:parent.bottom
        border.width: 1
        border.color: apps.backgroundColor
        //rotation: 180
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (mouse.modifiers & Qt.ControlModifier) {
                    apps.showAspCircleBack=!apps.showAspCircleBack
                    //if(vars.dev)log.ls('apps.showAspCircleBack:'+apps.showAspCircleBack, 0, log.width)
                    return
                }
                apps.showAspPanelBack=!apps.showAspPanelBack
            }
        }
        Text{
            text:  apps.showAspCircle?'\uf06e':'\uf070'
            font.family: "FontAwesome"
            font.pixelSize: r.cellWidth*0.8
            color: apps.backgroundColor
            opacity: apps.showAspCircle?1.0:0.65
            anchors.centerIn: parent
            rotation: 180
        }
        Text{
            text:  'Aspextos'
            font.pixelSize: vars.fs*0.25
            color: apps.fontColor
            opacity: apps.showAspPanelBack?0.0:1.0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: contentHeight
            anchors.left: parent.right
            transform: Scale{ yScale: -1 }
            anchors.leftMargin: vars.fs*0.1
        }
    }
    function clear(){
        if(!r.visible)return
        for(var i=0;i<15;i++){
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
        //console.log('PanelAspectsBack jsonData: '+JSON.stringify(jsonData))
        clear()
        if(!jsonData.asps)return
        let asp=jsonData.asps
        for(var i=0;i<Object.keys(asp).length;i++){
            if(asp['asp'+parseInt(i +1)]){
                if(asp['asp'+parseInt(i +1)]){
                    if((asp['asp'+parseInt(i +1)].ic1===10 && asp['asp'+parseInt(i +1)].ic2===11)||(asp['asp'+parseInt(i +1)].ic1===11 && asp['asp'+parseInt(i +1)].ic2===10)){
                        continue
                    }else{
                        let a=asp['asp'+parseInt(i +1)]
                        setAsp(a.ic1, a.ic2, a.ia,i)
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
