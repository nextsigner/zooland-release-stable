import QtQuick 2.7
import QtQuick.Controls 2.12

Rectangle {
    id: r
    width: parent.width
    height: app.fs*1.5
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    property string stringMiddleSeparator: 'VN'
    property url uItemGrabber
    property int fs: app.fs*0.5
    property var atLeft: []
    property var atRight: []
    onAtLeftChanged: {
        //setDataView(r.stringMiddleSeparator, r.atLeft, r.atRight)
    }
    onAtRightChanged: {
        //setDataView(r.stringMiddleSeparator, r.atLeft, r.atRight)
    }
    Rectangle{
        width: txtLoading.contentWidth+app.fs*0.3
        height: txtLoading.contentHeight+app.fs*0.3
        color: apps.backgroundColor
        border.width: 2
        border.color: apps.fontColor
        radius: app.fs*0.1
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
        spacing: app.fs*0.15
        anchors.centerIn: parent
        visible: !tResizeFs.running
        Rectangle{
            id: circuloSave
            width: app.fs*0.5
            height: width
            radius: width*0.5
            color: app.fileData===app.currentData?'gray':'red'
            border.width: 2
            border.color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            //y:(parent.height-height)/2
            visible:  !app.ev
            MouseArea{
                anchors.fill: parent
                enabled: app.titleData!==app.currentData
                onClicked: {
                    app.j.saveJson()
                }
            }
        }
        Row{
            id: rowDataLeft
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
        }
        Item{
            id: xSep
            width: txtSep.contentWidth+app.fs*0.3
            height: txtSep.contentHeight+app.fs*0.3
            anchors.verticalCenter: parent.verticalCenter
            visible: r.atRight.length>0
            z:-100
            Rectangle{
                anchors.fill: parent
                color: apps.fontColor
                border.width: 2
                border.color: apps.backgroundColor
                radius: app.fs*0.1
                z:10
            }
            Text{
                id: txtSep
                text: '<b>'+r.stringMiddleSeparator+'<b>'
                font.pixelSize: r.height*0.5
                color: apps.backgroundColor
                anchors.centerIn: parent
                z:11
            }
        }
        Row{
            id: rowDataRight
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Rectangle{
        anchors.fill: row
        border.width: 4
        border.color: 'red'
        color: 'transparent'
        visible: app.dev
    }
    Component{
        id: compCellData
        Rectangle{
            width: txtRow.contentWidth+app.fs*0.3
            height: txtRow.contentHeight+app.fs*0.3
            color: apps.backgroundColor
            border.width: 2//modelData==='@'?0:1
            border.color: apps.fontColor
            radius: app.fs*0.1
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
//    Timer{
//        id: tWaitUpdateData
//        running: false
//        repeat: false
//        interval: 1500
//        onTriggered: {
//            if(row.width>app.fs*53){
//                //tResizeFs.start()
//            }else{
//                //tResizeFs.stop()
//                //row.visible=true
//            }
//        }
//    }
    Timer{
        id: tResizeFs
        running: row.width>xApp.width
        repeat: true
        interval: 50
        onTriggered: {
            r.fs-=1
//            //if(row.width<r.width-app.fs){
//            if(row.width<app.fs*53){
//                //stop()
//                row.visible=true
//            }
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

}
