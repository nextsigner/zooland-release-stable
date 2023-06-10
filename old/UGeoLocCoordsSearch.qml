import QtQuick 2.0
import QtWebView 1.1

WebView {
    id: r
    signal coordsLoaded(string latitude, string longitude, string altitude)
    onUrlChanged:{
        let m0=(''+url).split('/@')
        if(m0.length>1){
            let m1=m0[1].split('/')
            if(m1.length>1){
                let m2=m1[0].split(',')
                if(m2.length===3){
                    r.coordsLoaded(m2[0],m2[1],m2[2])
                    r.destroy(3000)
                }else{
                    r.coordsLoaded('null', 'null', 'null')
                    r.destroy(3000)
                }
            }
        }
//        }else{
//            r.coordsLoaded('null', 'null', 'null')
//            r.destroy(3000)
//        }
        //console.log('Url: '+url)
    }
}
