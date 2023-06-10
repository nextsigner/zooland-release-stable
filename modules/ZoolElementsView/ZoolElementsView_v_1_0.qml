import QtQuick 2.0
import ZoolElementsView.ZoolGroupElementItems 1.0
import ZoolElementsView.ZoolGroupElementItemsPlanets 1.0
import Qt.labs.settings 1.0

Rectangle{
    id: r
    width: colZoolGroupElementItems.width+colZoolGroupElementItemsPlanets.width//+app.fs
    height: colZoolGroupElementItems.height+app.fs
    anchors.right: parent.right
    anchors.rightMargin: 0-width*0.75
    border.width: 0
    border.color:'yellow'
    color: 'transparent'
    property int fs: app.fs*2*s.zoom
    property alias settings: s
    property bool showBack: false
    property url uItemGrabber
    transform: Scale {
        id: tform2
        xScale: 0.25
        yScale: 0.25
    }
    Settings{
        id: s
        fileName: './modules/ZoolElementsView/ZoolElementsView.cfg'
        property real zoom: 1.0
    }

    Row{
        anchors.centerIn: parent
        Column{
            id: colZoolGroupElementItemsPlanets
            spacing: app.fs*0.5
            anchors.top: parent.top
            opacity: !app.capturing?0.0:1.0
            Behavior on opacity{NumberAnimation{duration:!app.capturing?250:0}}
            ZoolGroupElementItemsPlanets{id: groupFrontPlanets; fs: r.fs; showTitle: r.showBack}
            ZoolGroupElementItemsPlanets{id: groupBackPlanets; fs: r.fs; isBack: true; showTitle: r.showBack; visible: r.showBack}
        }
        Column{
            id: colZoolGroupElementItems
            spacing: app.fs*0.5
            anchors.verticalCenter: parent.verticalCenter
            ZoolGroupElementItems{id: groupFront; fs: r.fs; showTitle: r.showBack}
            ZoolGroupElementItems{id: groupBack; fs: r.fs; isBack: true; visible: r.showBack; showTitle: r.showBack}
        }
    }
    function load(json, isBack){
        r.showBack=false
        if(!isBack){
            groupFront.load(json)
            groupFrontPlanets.load(json)
        }else{
            groupBack.load(json)
            groupBackPlanets.load(json)
            if(app.mod==='vn' || app.mod==='dirprim'){
                r.showBack=false
            }else{
                r.showBack=true
            }
        }
        setUImgGrabber()
    }
    function tooglePlanetsOpacity(){
        if(colZoolGroupElementItemsPlanets.opacity===0.0){
           colZoolGroupElementItemsPlanets.opacity=1.0
        }else{
            colZoolGroupElementItemsPlanets.opacity=0.0
        }
    }
    function setUImgGrabber(){
        r.grabToImage(function(result) {
            //result.saveToFile(folder+"/"+imgFileName);
            r.uItemGrabber=result.url
        });
    }
}
