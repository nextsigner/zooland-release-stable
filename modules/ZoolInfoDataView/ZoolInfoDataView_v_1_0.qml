import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: r
    visible: false
    color: 'black'
    anchors.fill: parent
    property bool markDown: false
    onVisibleChanged: {
        if(!visible)r.markDown=false
    }
    Flickable{
        width: r.width
        height: r.height
        contentWidth: r.width
        contentHeight: data.contentHeight+app.fs*2
        Text{
            id: data
            width: r.width-app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.5
            text: '<h1>InfoData</h1>'
            color: 'white'
            font.pixelSize: app.fs*0.5
            wrapMode: Text.WordWrap
            textFormat: r.markDown?Text.MarkdownText:Text.RichText
        }
    }
    function loadData(file){
        //log.l('XInfoData file: '+file)
        //log.visible=true
        let fileData=''+unik.getFile(file)
        if(r.markDown){
            let nfd=''
            let m0=fileData.split('\n')
            for(var i=0;i<m0.length;i++){
                if(m0[i].length===0){
                    nfd+=m0[i]+'<br/><br/>\n\n'
                }else{
                    nfd+=m0[i]+'\n\n'
                }
            }
            data.text=nfd
        }else{
            data.text=fileData
        }
        r.visible=true
    }
}
