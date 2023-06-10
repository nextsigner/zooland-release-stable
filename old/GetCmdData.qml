import QtQuick 2.0
import unik.UnikQProcess 1.0

Item {
    id: r
    signal gms(int g, int m, int s)
    UnikQProcess{
        id: uqpGetHourGmtZero
        property string currentLon: ''
        property string currentLat: ''
        property string currentAlt: ''
        onLogDataChanged:{
            //console.log('GMT:'+logData)
            //Debería retornar este formato 1981-11-12 15:30:00
            let scorr1=(''+logData).replace(/    /g,' ').replace(/   /g,' ').replace(/  /g,' ')
            let m0=scorr1.split(' ')
            let m1=m0[0].split('-')
            let m2=m0[1].split(':')
            let d=m1[2]
            let m=m1[1]
            let a=m1[0]
            let hora=m2[0]
            let min=m2[2]
            uqpJD.getJd(d, m, a, hora, min, currentLon, currentLat, currentAlt)
            /*console.log('d:'+d)
            console.log('m:'+m)
            console.log('a:'+a)
            console.log('hora:'+hora)
            console.log('min:'+min)*/
        }
    }
    UnikQProcess{
        id: uqpJD
        property string currentLon: ''
        property string currentLat: ''
        property string currentAlt: ''
        onLogDataChanged:{
            //console.log('JD:'+logData)
            uqpGMS.getGMS(logData)
        }
        function getJd(dia, mes, anio, hora, minuto, lon, lat, alt){
            currentLon=lon
            currentLat=lat
            currentAlt=alt
            run('python3 ./resources/jday2.py '+dia+' '+mes+' '+anio+' '+hora+' '+minuto+' '+unik.currentFolderPath())
        }
    }
    UnikQProcess{
        id: uqpGMS
        onLogDataChanged:{
            //console.log('GMS:'+logData)
            let scorr1=(''+logData).replace(/    /g,' ').replace(/   /g,' ').replace(/  /g,' ')
            //console.log('GMS2:'+scorr1)
            let m0=scorr1.split('\'')
            let m1=m0[0].split(' ')
            let m2=m0[1].split('.')
            let g=m1[0]
            let m=m1[2]
            let s=m2[0]
            //console.log('G:'+m1[0])
            //console.log('M:'+m1[2])
            //console.log('S:'+m2[0])
            gms(g,m,s)
        }
        function getGMS(jd){
            run('swetest -p0 -j'+jd+' -geopos'+uqpJD.currentLon+','+uqpJD.currentLat+','+uqpJD.currentAlt+' -head -fZ')

        }
    }
    function getData(d, m, a, h, min, lon, lat, alt, gmt){
        getHourGmtZero(d, m, a, h, min, lon, lat, alt, gmt)
    }
    function getHourGmtZero(d, m, a, h, min, lon, lat, alt, gmt){
        uqpGetHourGmtZero.currentLon=lon
        uqpGetHourGmtZero.currentLat=lat
        uqpGetHourGmtZero.currentAlt=alt
        uqpGetHourGmtZero.run('python3 ./resources/setGmtHour.py '+d+' '+m+' '+a+' '+h+' '+min+' '+Math.abs(gmt))+'  '+unik.currentFolderPath()
    }
    Component.onCompleted: {
        //run('python3 ./resources/jday2.py 20 06 1975 23 00')
        //uqpJD.getJd(20, 06, 1975, 23, 00)
    }
}
