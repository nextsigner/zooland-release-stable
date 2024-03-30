import QtQuick 2.0
import ZoolandMap.ZoolMapChart 1.0

Item{
    id: r
    anchors.fill: parent
    property var aNakshatra:['Ashwini',
'Bharani',
'Krittika',
'Rohini',
'Mrigashira',
'Ardra',
'Punarvasu',
'Pushya',
'Ashlesha',
'Magha',
'Purva Phalguni',
'Uttara Phalguni',
'Hasta',
'Chitra',
'Swati',
'Vishakha',
'Anuradha',
'Jyeshtha',
'Mula',
'Purva Ashadha',
'Uttara Ashadha',
'Shravana',
'Dhanishta',
'Shatabhisha',
'Purva Bhadrapada',
'Uttara Bhadrapada',
'Revati']
//    Rectangle{
//        width: r.width
//        height: width
//        anchors.centerIn: parent
//        color: '#ff8833'
//        border.width: 10
//        border.color: 'red'
//    }
//    ZoolMapChart{
//        //anchors.fill: parent
//    }
    function getNakshatraName(i){
        return r.aNakshatra[i]
    }
    function getIndexNakshatra(gdec){
        let index=0
        let g=0.0
        for(var i=0;i<27;i++){
            g = g + 13.33 //En grados decimales. Si fuesen sexagecimales sería °13 '02 ''00
            if (g > parseFloat(gdec)){
                break
            }
            index = index + 1
        }
        return index
    }
}
