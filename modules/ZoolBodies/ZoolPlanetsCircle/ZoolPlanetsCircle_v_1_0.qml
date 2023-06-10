import QtQuick 2.0


import ZoolBodies.ZoolAs 3.5
Item{
    id: r
    property bool expand: false
    property var cAs: r
    property int planetSize: sweg.fs*0.75

    property int totalPosX: 0

    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var objSigns: [0,0,0,0,0,0,0,0,0,0,0,0]

    signal cnLoaded(string nombre, string dia, string mes, string anio, string hora, string minuto, string lon, string lat, string ciudad)
    signal doubleClick
    signal posChanged(int px, int py)
    state: sweg.state
    states: [
        State {
            name: sweg.aStates[0]
            PropertyChanges {
                target: r
                //width: housesCircle.parent.objectName==='sweg'?(sweg.width-sweg.fs*2.5-sweg.fs):(sweg.width-sweg.fs*3.5)
            }
        },
        State {
            name: sweg.aStates[1]
            PropertyChanges {
                target: r
                //width: housesCircle.parent.objectName==='sweg'?(sweg.width-sweg.fs*6-sweg.fs):(sweg.width-sweg.fs*4)
            }
        },
        State {
            name: sweg.aStates[2]
            PropertyChanges {
                target: r
                //width: housesCircle.parent.objectName==='sweg'?(sweg.width-sweg.fs*2-sweg.fs):(sweg.width-sweg.fs*2)
            }
        }
    ]
    Repeater{
        model: app.planetasRes
        ZoolAs{fs:r.planetSize;astro:modelData;numAstro: index}
    }
    function pressed(o){
        if(app.currentPlanetIndex!==o.numAstro){
            app.currentPlanetIndex=o.numAstro
            app.currentHouseIndex=o.ih
        }else{
            app.currentPlanetIndex=-1
            app.currentHouseIndex=-1
        }
        //unik.speak(''+app.planetas[o.numAstro]+' en '+app.signos[o.objData.ns]+' en el grado '+o.objData.g+' en la casa '+o.objData.h)
    }
    function doublePressed(o){

    }

    function loadJson(json){
        r.totalPosX=-1
        r.objSigns = [0,0,0,0,0,0,0,0,0,0,0,0]
        let jo
        let o
        var houseSun=-1
        for(var i=0;i<15;i++){
            var objAs=r.children[i]
            jo=json.pc['c'+i]
            let degRed=0.0
            if(jo.mdeg>=10&&jo.mdeg<=20){
                degRed=0.2
            }
            if(jo.mdeg>=20&&jo.mdeg<=30){
                degRed=0.4
            }
            if(jo.mdeg>=30&&jo.mdeg<=40){
                degRed=0.6
            }
            if(jo.mdeg>=40&&jo.mdeg<=50){
                degRed=0.8
            }
            if(jo.mdeg>=50){
                degRed=1.0
            }
            objAs.rotation=signCircle.rot-jo.gdeg-(jo.mdeg/60)//+degRed
            if(i===0)app.currentRotationxAsSol=objAs.rotation
            o={}
            o.p=objSigns[jo.is]
            if(r.totalPosX<o.p){
                r.totalPosX=o.p
            }
            o.ns=objSignsNames.indexOf(jo.is)
            o.ih=sweg.objHousesCircle.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)//jo.ih

            o.rsg=jo.rsgdeg
            o.g=jo.gdeg
            o.m=jo.mdeg
            //o.h=jo.h
            o.ih=sweg.objHousesCircle.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)
            o.rsg=jo.rsgdeg
            o.gdec=jo.gdec

            if(o.gdec>=360.000)o.gdec-=360.000
            o.g=jo.gdeg
            o.m=jo.mdeg
            o.s=jo.sdeg
            o.ih=sweg.objHousesCircle.getHousePos(o.gdec, json.ph.h1.gdec, i, jo.ih)
            o.is=jo.is

            if(i!==10&&i!==11)o.retro=jo.retro
            objAs.is=jo.is
            objAs.ih=o.ih
            objAs.objData=o
            objSigns[jo.is]++
            if(i===0){
                app.currentAbsolutoGradoSolar=jo.rsgdeg
                app.currentGradoSolar=jo.gdeg
                app.currentMinutoSolar=jo.mdeg
                app.currentSegundoSolar=jo.sdeg
                houseSun=jo.ih
            }
        }

        //Fortuna
        //        let joHouses=json.ph['h1']
        //        let joSol=json.pc['c0']
        //        let joLuna=json.pc['c1']
        //        objAs=r.children[15]
        //        var gf
        //        if(houseSun>=6){
        //            //Fortuna en Carta Diurna
        //            //Calculo para Fortuna Diurna Asc + Luna - Sol
        //            gf=joHouses.gdec+joLuna.gdec - joSol.gdec
        //            if(gf>=360)gf=gf-360
        //            objAs.rotation=signCircle.rot-gf
        //        }else{
        //            //Fortuna en Carta Nocturna
        //            //Calculo para Fortuna Nocturna Asc + Sol - Luna
        //            gf=joHouses.gdec+joSol.gdec - joLuna.gdec
        //            if(gf>=360)gf=gf-360
        //            objAs.rotation=signCircle.rot-gf
        //        }
        //        //console.log('gf: '+JS.deg_to_dms(gf))
        //        var arrayDMS=JS.deg_to_dms(gf)
        //        o={}
        //        o.g=arrayDMS[0]
        //        o.m=arrayDMS[1]
        //        var rsDegSign=gf
        //        for(var i2=1;i2<13;i2++){
        //            if(i2*30<gf){
        //                objAs.is=i2
        //                rsDegSign-=30
        //                o.p=objSigns[i2]
        //            }

        //            if(json.ph['h'+i2].gdec<gf){
        //                o.h=i2
        //                o.ih=i2
        //            }
        //        }
        //        if(r.totalPosX<o.p){
        //            r.totalPosX=o.p
        //        }
        //        o.ns=objSignsNames.indexOf(o.is)
        //        o.rsg=rsDegSign
        //        objAs.objData=o
        //        objSigns[o.is]++

        /*
        //Infortunio
        //Diurna Ascendente + Marte - Saturno
        //Nocturna Ascendente + Saturno - Marte
        //joHouses=json.ph['h1']
        let joMarte=json.pc['c4']
        let joSaturno=json.pc['c6']
        objAs=r.children[15]
        //var gf
        if(houseSun>=6){
            //Fortuna en Carta Diurna
            //Calculo para Fortuna Diurna Asc + Luna - Sol
            gf=joHouses.gdec + joMarte.gdec - joSaturno.gdec
            if(gf>=360)gf=gf-360
            if(gf<0)gf=360-gf
            objAs.rotation=signCircle.rot-gf
        }else{
            //Fortuna en Carta Nocturna
            //Calculo para Fortuna Nocturna Asc + Sol - Luna
            gf=joHouses.gdec + joSaturno.gdec - joMarte.gdec
            if(gf>=360)gf=gf-360
            if(gf<0)gf=360-gf
            objAs.rotation=signCircle.rot-gf
        }
        arrayDMS=JS.deg_to_dms(gf)
        o={}
        o.g=arrayDMS[0]
        o.m=arrayDMS[1]
        rsDegSign=gf
        for(var i2=1;i2<13;i2++){
            if(i2*30<gf){
                objAs.is=i2
                rsDegSign-=30
                o.p=objSigns[i2]
            }

            if(json.ph['h'+i2].gdec<gf){
                o.h=i2
                o.ih=i2
            }
        }
        if(r.totalPosX<o.p){
            r.totalPosX=o.p
        }
        o.ns=objSignsNames.indexOf(o.is)
        o.rsg=rsDegSign
        objAs.objData=o
        objSigns[o.is]++*/
    }

}
