import QtQuick 2.0

Item {
    id: r
    //anchors.fill: parent
    property int num: -1
    property color c: 'gray'
    property color bgc: 'transparent'
    property real op: 1.0
    signal enter()
    signal left()
    signal right()
    signal up()
    signal down()

    Rectangle{
       width: r.width/3
       height: width
       color: r.bgc
       radius: width*0.5
       anchors.centerIn: parent
    }
    Grid{
        spacing: 0//r.width/40
        columns: 3
        anchors.centerIn: r
        Repeater{
            model: 9
            Rectangle{
               width: r.width/3
               height: width
               border.width: 0
               border.color: 'red'
               opacity: index===1 || index===3 || index===4 || index===5 || index===7?r.op:0.0
               color: 'transparent'
               MouseArea{
                anchors.fill: parent
                onClicked: {
                    //app.currentMando=r.num
                    if(index===1){
                        //app.runToUp()
                        r.up()
                        return
                    }
                    if(index===3){
                        //app.runToLeft()
                        r.left()
                        return
                    }
                    if(index===4){
                        //app.runEnter()
                        r.enter()
                        return
                    }
                    if(index===5){
                        //app.runToRight()
                        r.right()
                        return
                    }
                    if(index===7){
                        //app.runToDown()
                        r.down()
                        return
                    }
                }
               }
               Rectangle{
                  width: parent.width*0.8
                  height: width
                  color: r.c
                  radius: width*0.5
                  opacity: r.op
                  anchors.centerIn: parent
                  visible: index===4
               }
               Canvas {
                   width: parent.width*0.8
                   height: width
                   anchors.centerIn: parent
                   opacity: r.op
                   visible: index!==4
                   onPaint: {
                       var ctx = getContext("2d")
                       ctx.fillStyle = "red"
                       ctx.beginPath();
                       ctx.moveTo(width*0.5, 0);
                       ctx.lineTo(width, height);
                       ctx.lineTo(0, height);
                       ctx.closePath();

                       context.fillStyle = r.c;
                       context.fill();
                       //ctx.fillRect(0, 0, width, height)

                   }
               }

//               Text {
//                   id: txt1
//                   text: index
//                   font.pixelSize: app.fs
//                   color: 'yellow'
//                   anchors.centerIn: parent
//               }

               Component.onCompleted: {
                    if(index===3){
                        rotation=-90
                    }
                    if(index===5){
                        rotation=90
                    }
                    if(index===7){
                        rotation=180
                    }
                }
            }
        }
    }
    Rectangle{
        anchors.fill: parent
        color: 'transparent'
        border.width: 3
        border.color: 'red'
        visible: false
    }
    function toEnter(){
        r.enter()
    }
    function toLeft(){
        r.left()
    }
    function toRight(){
        r.right()
    }
    function toDown(){
        r.down()
    }
    function toUp(){
        r.up()
    }
}
