import QtQuick 2.7
import QtQuick.Controls 2.12

Rectangle {
    id: r
    width: parent.width
    height: vars.fs*1.5
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    property string stringMiddleSeparator: 'VN'
    property url uItemGrabber
    property int fs: vars.fs*0.5
    property var atLeft: []
    property var atRight: []
    property string uExtIdLoaded: ''
    onAtLeftChanged: {
        //setDataView(r.stringMiddleSeparator, r.atLeft, r.atRight)
    }
    onAtRightChanged: {
        //setDataView(r.stringMiddleSeparator, r.atLeft, r.atRight)
    }
    Rectangle{
        width: txtLoading.contentWidth+vars.fs*0.3
        height: txtLoading.contentHeight+vars.fs*0.3
        color: apps.backgroundColor
        border.width: 2
        border.color: apps.fontColor
        radius: vars.fs*0.1
        anchors.centerIn: parent
        visible: !row.visible
        Text{
            id: txtLoading
            text: '<b>Cargando...<b>'
            font.pixelSize: r.height*0.5
            color: apps.fontColor
            anchors.centerIn: parent
        }
    }
    Row{
        anchors.centerIn: parent
        //anchors.horizontalCenterOffset: r.width*0.5-row.width*0.5-()
        parent: xSep
        z:9
        visible: r.atRight.length>0
        Rectangle{
            width: r.width
            height: r.height
            color: apps.houseColor
        }
        Rectangle{
            width: r.width
            height: r.height
            color: apps.houseColorBack
        }
    }
    Row{
        id: row
        width: rowDataLeft.width+xSep.width+rowDataRight.width+spacing*2
        spacing: vars.fs*0.15
        anchors.centerIn: parent
        visible: !tResizeFs.running
        Rectangle{
            id: circuloSave
            width: vars.fs*0.5
            height: width
            radius: width*0.5
            color: vars.fileData===vars.currentData?'gray':'red'
            border.width: 2
            border.color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            //y:(parent.height-height)/2
            visible:  !vars.ev
            MouseArea{
                anchors.fill: parent
                //enabled: vars.titleData!==app.currentData
                onClicked: {
                    app.j.saveJson()
                }
            }
        }
        Row{
            id: rowDataLeft
            spacing: vars.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
        }
        Item{
            id: xSep
            width: txtSep.contentWidth+vars.fs*0.3+border.width
            height: txtSep.contentHeight+vars.fs*0.3+border.width
            anchors.verticalCenter: parent.verticalCenter
            visible: r.atRight.length>0
            z:-100
            Rectangle{
                id: bgSep
                anchors.fill: parent
                color: apps.fontColor
                border.width: 1//vars.backIsSaved?2:6
                border.color: apps.backgroundColor
                radius: vars.fs*0.1
                z:10
                SequentialAnimation on border.color {
                    running: false//!app.backIsSaved
                    loops: Animation.Infinite
                    ColorAnimation {
                        from: apps.fontColor
                        to: apps.backgroundColor
                        duration: 400
                    }
                    ColorAnimation {
                        from: apps.backgroundColor
                        to: apps.fontColor
                        duration: 400
                    }

                }
            }
            Text{
                id: txtSep
                text: '<b>'+r.stringMiddleSeparator+'</b>'
                //font.pixelSize: !app.backIsSaved?r.height*0.35:r.height*0.5
                font.pixelSize: r.height*0.5
                color: apps.backgroundColor
                anchors.centerIn: parent
                z:11
            }
            Rectangle{
                id: xTxtSG
                width: txtSG.contentWidth+app.fs*0.3+border.width
                height: txtSG.contentHeight+border.width
                color: apps.fontColor
                border.width: 1
                border.color: bgSep.border.color
                radius: vars.fs*0.1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.bottom
                z: txtSep.z+1
                //visible: !app.backIsSaved
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        let isSaved=zfdm.saveExtToJsonFile(r.uExtIdLoaded)
                        //app.backIsSaved=isSaved
                        //if(vars.dev)log.lv('Guardado desde zoolDataView: '+app.backIsSaved)
                    }
                }
                Text{
                    id: txtSG
                    text: '<b>Sin guardar</b>'
                    font.pixelSize: r.height*0.2
                    color: apps.backgroundColor//bgSep.border.color
                    anchors.centerIn: xTxtSG
                    //visible: xTxtSG.visible
                }
            }


        }
        Row{
            id: rowDataRight
            spacing: vars.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Rectangle{
        anchors.fill: row
        border.width: 4
        border.color: 'red'
        color: 'transparent'
        visible: vars.dev
    }
    Component{
        id: compCellData
        Rectangle{
            width: txtRow.contentWidth+vars.fs*0.3
            height: txtRow.contentHeight+vars.fs*0.3
            color: apps.backgroundColor
            border.width: 2//modelData==='@'?0:1
            border.color: apps.fontColor
            radius: vars.fs*0.1
            anchors.verticalCenter: parent.verticalCenter
            property string txtData: 'txtData'

            Rectangle{
                id: bgCell
                anchors.fill: parent
                color: apps.backgroundColor
                radius: parent.radius
                border.width: 1//modelData==='@'?0:1
                border.color: apps.fontColor
            }
            Text{
                id: txtRow
                //text: modelData!=='@'?modelData:r.stringMiddleSeparator//.replace(/_/g, ' ')
                text: txtData
                font.pixelSize: r.fs
                color: apps.fontColor
                anchors.centerIn: parent
            }
        }
    }
    Timer{
        id: tResizeFs
        running: row.width>xApp.width
        repeat: true
        interval: 50
        onTriggered: {
            r.fs-=1
        }
    }
    function setDataView(sep, aL, aR){
        //row.visible=false
        r.fs=r.height*0.5
        r.stringMiddleSeparator=sep
        r.atLeft=aL
        r.atRight=aR
        //if(app.dev)log.lv('zoolDataView.setDataView(sep, aL, aR): '+aL.toString()+' \n'+aR.toString())
        updateDataView()
    }
    function updateDataView(){
        for(var i=0; i < rowDataLeft.children.length;i++){
            rowDataLeft.children[i].destroy(1)
        }
        for(i=0; i < rowDataRight.children.length;i++){
            rowDataRight.children[i].destroy(1)
        }
        let aL=r.atLeft
        let aR=r.atRight
        for(i=0; i < aL.length;i++){
            var obj=compCellData.createObject(rowDataLeft, {txtData:aL[i]})
        }
        for(i=0; i < aR.length;i++){
            obj=compCellData.createObject(rowDataRight, {txtData:aR[i]})
        }
        //tWaitUpdateData.start()
    }
    function clear(){
        r.atLeft=[]
        r.atRight=[]
        r.stringMiddleSeparator='VN'
    }
}
