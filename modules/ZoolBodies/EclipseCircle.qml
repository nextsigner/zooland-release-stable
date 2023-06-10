import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: r
    anchors.centerIn: parent
    visible: isEclipse!==-1
    property int isEclipse: -1
    property int gdegEclipse: -1
    property int mdegEclipse: -1
    property int house: -1
    property var arrayWg
    property alias typeEclipse: anEclipse.typeEclipse

    state: sweg.state
    states: [
        State {
            name: sweg.aStates[0]
            PropertyChanges {
                target: r
                width: sweg.width
            }
            PropertyChanges {
                target: ejeEclipse
                width: sweg.objSignsCircle.width-app.fs*6
            }
        },
        State {
            name: sweg.aStates[1]
            PropertyChanges {
                target: r
                width: sweg.width-app.fs*5
            }
            PropertyChanges {
                target: ejeEclipse
                width: sweg.objSignsCircle.width-app.fs*4
            }
        },
        State {
            name: sweg.aStates[2]
            PropertyChanges {
                target: r
                width: sweg.width-app.fs
            }
            PropertyChanges {
                target: ejeEclipse
                width: sweg.objSignsCircle.width-app.fs*6
            }
        }
    ]
    Rectangle{
        id: ejeEclipse
        width: sweg.objSignsCircle.width
        height: 1
        anchors.centerIn: parent
        color: 'red'//'transparent'
        antialiasing: true
        //Behavior on width{enabled: apps.enableFullAnimation;NumberAnimation{duration: 500; easing.type: Easing.InOutQuad}}
        Rectangle{
            id: xIconEclipse
            property bool selected: app.currentPlanetIndex===20
            width: selected?app.fs*2:app.fs
            height: width
            radius: width*0.5
            color: 'black'
            border.width: 0//sweg.objHousesCircle.wb
            border.color: 'white'//co.color
            antialiasing: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.left
            //rotation: 0-parent.rotation
            onSelectedChanged:{
                //app.uSon='asc_'+app.objSignsNames[r.isAsc]+'_1'
            }
            Behavior on width{enabled: apps.enableFullAnimation;NumberAnimation{duration: 250;easing.type: Easing.InOutQuad}}
            XEclipse{
                id: anEclipse
                anchors.centerIn: parent
                onWidthChanged: col.width=width
                Column{
                    id: col
                    //anchors.centerIn: co
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: app.fs*0.05
                    Text{
                        text: 'Eclipse '+app.signos[r.isEclipse]
                        font.pixelSize: app.fs*0.5
                        color: 'white'
                        width: contentWidth
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignRight
                        Rectangle{
                            width: parent.contentWidth+3
                            height: parent.contentHeight+3
                            color: 'black'
                            border.width: 1
                            border.color: 'white'
                            radius: app.fs*0.1
                            z: parent.z-1
                            opacity: 0.5
                            antialiasing: true
                            anchors.centerIn: parent
                        }
                    }
                    Item{width: xIconEclipse.width;height: width}
                    Text{
                        text: '°'+r.gdegEclipse+' \''+r.mdegEclipse+' - Casa '+r.house
                        font.pixelSize: app.fs*0.5
                        color: 'white'
                        width: contentWidth
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignRight
                        Rectangle{
                            width: parent.contentWidth+3
                            height: parent.contentHeight+3
                            color: 'black'
                            border.width: 1
                            border.color: 'white'
                            radius: app.fs*0.1
                            z: parent.z-1
                            opacity: 0.5
                            anchors.centerIn: parent
                            antialiasing: true
                        }
                    }
                }
            }
        }
    }
    function setEclipse(gdec, rsgdeg, gdeg, mdeg, is){
        r.isEclipse = is
        r.gdegEclipse = rsgdeg
        r.mdegEclipse = mdeg
        let degs=(30*is)+rsgdeg
        //ejeEclipse.rotation=degs-360-gdeg
        ejeEclipse.rotation=sweg.objSignsCircle.rot-gdeg
        xIconEclipse.rotation=0-ejeEclipse.rotation
        //console.log(JSON.stringify(r.json))
        let j=r.json
        let sum=0
        let h=1
        for(var i=0;i<12;i++){
            sum+=r.arrayWg[i]
            let distAscCeroAries=360-app.uAscDegreeTotal
            if(gdec+distAscCeroAries<sum){
                r.house=h
                break
            }
            h++
        }
        anEclipse.width=anEclipse.parent.width
        app.currentPlanetIndex=-1
        r.visible=true
    }
}
