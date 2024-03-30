import QtQuick 2.12

Rectangle {
    id: r
    //width: planetsCircle.width-((planetsCircle.totalPosX*planetsCircle.planetSize)*2)-sweg.fs*2-(apps.showNumberLines?sweg.fs:0)
    width: planetsCircle.width-((planetsCircle.totalPosX*sweg.fs*0.5)*2)-sweg.fs*2-(apps.showNumberLines+ew?sweg.fs+ew:0+ew)
    height: width
    radius: width*0.5
    color: 'red'//'transparent'
    border.width: 2
    border.color: 'white'
    anchors.centerIn: parent
    antialiasing: true
    property int currentAspSelected: -1
    property int currentAspSelectedBack: -1
    property int widthNodosAspSelected: 8
    property var aAspStr1: []
    property var aAspStr2: []

    property int ew: 0

    onWidthChanged: {
        currentAspSelected=-1
        currentAspSelectedBack=-1
        tLoadJson.restart()
        tLoadJsonBack.restart()
    }
    Behavior on opacity {
        NumberAnimation{
            duration: sweg.speedRotation
            easing.type: Easing.InOutQuad
        }
    }
//    Behavior on rotation {
//        enabled: apps.enableFullAnimation
//        NumberAnimation{
//            duration: sweg.speedRotation
//            easing.type: Easing.InOutQuad
//        }
//    }
    Rectangle{
        id: bg
        width: r.width
        height: width
        color: apps.backgroundColor
        border.width: 1
        border.color: 'yellow'

        radius: width*0.5
        anchors.centerIn: r
        //visible: !app.ev?apps.showAspCircle:(apps.showAspCircle && apps.showAspCircleBack)
    }
    Rectangle{
        id: bgTotalBack
        width: r.width
        height: width
        //color: app.ev?'red':'blue'//apps.backgroundColor//'black'
        color: apps.backgroundColor
        //border.width: 10
        //border.color: 'yellow'
        radius: width*0.5
        anchors.centerIn: r
        property var json
        onJsonChanged: tLoadJsonBack.restart()
        visible: apps.showAspCircleBack
        Timer{
            id: tLoadJsonBack
            running: false
            repeat: false
            interval: 500
            onTriggered: {
                clearSL(bgTotalBack)
                var x = bgTotalBack.width*0.5;
                var y = bgTotalBack.height*0.5;
                var radius=bgTotalBack.width*0.5
                var cx=bgTotalBack.width*0.5
                var cy=bgTotal.height*0.5
                if(bgTotalBack.json&&bgTotalBack.json.asps){
                    let asp=bgTotalBack.json.asps
                    for(var i=0;i<Object.keys(asp).length;i++){
                        if(asp['asp'+parseInt(i +1)]){
                            if((asp['asp'+parseInt(i +1)].ic1===10 && asp['asp'+parseInt(i +1)].ic2===11)||(asp['asp'+parseInt(i +1)].ic1===11 && asp['asp'+parseInt(i +1)].ic2===10)){
                                continue
                            }else{
                                let a=asp['asp'+parseInt(i +1)]
                                let colorAsp='black'
                                //# -1 = no hay aspectos. 0 = oposición. 1 = cuadratura. 2 = trígono
                                if(a.ia===0){
                                    colorAsp='red'
                                }
                                if(a.ia===1){
                                    colorAsp='#ff8833'
                                }
                                if(a.ia===2){
                                    colorAsp='green'
                                }
                                if(a.ia===3){
                                    colorAsp='blue'
                                }
                                drawAsp(cx, cy, a.gdeg1, a.gdeg2, colorAsp, i, bgTotalBack, true)
                            }
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        id: bgTotal
        width: r.width
        height: width
        color: 'transparent'//apps.backgroundColor//'black'
        radius: width*0.5
        anchors.centerIn: r
        property var json
        onJsonChanged: tLoadJson.restart()
        visible: apps.showAspCircle
        Timer{
            id: tLoadJson
            running: false
            repeat: false
            interval: 500
            onTriggered: {
                clearSL(bgTotal)
                var x = bgTotal.width*0.5;
                var y = bgTotal.height*0.5;
                var radius=bgTotal.width*0.5
                var cx=bgTotal.width*0.5
                var cy=bgTotal.height*0.5
                if(bgTotal.json&&bgTotal.json.asps){
                    let asp=bgTotal.json.asps
                    for(var i=0;i<Object.keys(asp).length;i++){
                        if(asp['asp'+parseInt(i +1)]){
                            if((asp['asp'+parseInt(i +1)].ic1===10 && asp['asp'+parseInt(i +1)].ic2===11)||(asp['asp'+parseInt(i +1)].ic1===11 && asp['asp'+parseInt(i +1)].ic2===10)){
                                continue
                            }else{
                                let a=asp['asp'+parseInt(i +1)]
                                let colorAsp='black'
                                //# -1 = no hay aspectos. 0 = oposición. 1 = cuadratura. 2 = trígono
                                if(a.ia===0){
                                    colorAsp='red'
                                }
                                if(a.ia===1){
                                    colorAsp='#ff8833'
                                }
                                if(a.ia===2){
                                    colorAsp='green'
                                }
                                if(a.ia===3){
                                    colorAsp='blue'
                                }
                                drawAsp(cx, cy, a.gdeg1, a.gdeg2, colorAsp, i, bgTotal, false)
                            }
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        id: borde
        width: r.width
        height: width
        color: 'transparent'
        border.width: 2
        border.color: apps.fontColor
        radius: width*0.5
        anchors.centerIn: r
    }
    function drawAsp(cx, cy, gdeg1, gdeg2, c, i, item, isBack){
        var angulo= gdeg1
        var coords=gCoords(radius, angulo)
        var px1 = coords[0]
        var py1 = coords[1]
        angulo= gdeg2
        coords=gCoords(radius, angulo)
        var px2 = coords[0]
        var py2 = coords[1]
        drawAspRect(px1+cx, py1+cy, px2+cx, py2+cy, c, i, item, isBack)
    }
    function drawAspRect(sx, sy, px, py, c, i, item, isBack){
        var s='s'+sx+'-'+sy+'-'+px+'-'+py
        var comp
        if(!isBack && r.aAspStr1.indexOf(s)<0){
            comp=Qt.createComponent("../../comps/AspShapeLine.qml")
            var obj=comp.createObject(item,{sx: sx, sy: sy, px: px, py: py, c: c, n:i, isBack: isBack})
            r.aAspStr1.push(s)
        }
        if(isBack && r.aAspStr2.indexOf(s)<0){
            //let comp=Qt.createComponent("./comps/AspShapeLine.qml")
            comp=Qt.createComponent("../../comps/AspShapeLine.qml")
            var obj=comp.createObject(item,{sx: sx, sy: sy, px: px, py: py, c: c, n:i, isBack: isBack})
            r.aAspStr2.push(s)
        }
    }
    function gCoords(radius, angle) {
        var d = Math.PI/180 //to convert deg to rads
        var deg
        var x
        var y
        deg = (360 - angle - 90) * d
        x = radius * Math.cos(deg)
        y = radius * Math.sin(deg)
        return [ x, y ];
    }
    function load(json){
        clearSL(bgTotal)
        r.aAspStr1=[]
        bgTotal.json=json
    }
    function add(json){
        //console.log('Json Asp Back: '+JSON.stringify(json))
        clearSL(bgTotalBack)
        r.aAspStr2=[]
        bgTotalBack.json=json
    }
    function clear(){
        clearSL(bgTotal)
        clearSL(bgTotalBack)
    }
    function clearSL(item){
        for(var i=0;i<item.children.length;i++){
            item.children[i].destroy(1)
        }
    }
    function rotate_point(pointX, pointY, originX, originY, angle) {
        angle = angle * Math.PI / 180.0;
        return {
            x: Math.cos(angle) * (pointX-originX) - Math.sin(angle) * (pointY-originY) + originX,
            y: Math.sin(angle) * (pointX-originX) + Math.cos(angle) * (pointY-originY) + originY
        };
    }
    function angle(cx, cy, ex, ey) {
        var dy = ey - cy;
        var dx = ex - cx;
        var theta = Math.atan2(dy, dx); // range (-PI, PI]
        theta *= 180 / Math.PI; // rads to degs, range (-180, 180]
        //if (theta < 0) theta = 360 + theta; // range [0, 360)
        return theta;
    }
}
