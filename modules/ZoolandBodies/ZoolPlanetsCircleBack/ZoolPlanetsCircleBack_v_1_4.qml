import QtQuick 2.0

import ZoolandBodies.ZoolAsBack 3.6

Item{
    id: r
    property bool expand: false
    property var cAs: r
    property int planetSize: vars.fs*0.75

    property int totalPosX: 0

    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var objSigns: [0,0,0,0,0,0,0,0,0,0,0,0]

    signal cnLoaded(string nombre, string dia, string mes, string anio, string hora, string minuto, string lon, string lat, string ciudad)
    signal doubleClick
    signal posChanged(int px, int py)
    Repeater{
        model: vars.planetasRes
        ZoolAsBack{fs:r.planetSize;astro:modelData;numAstro: index}
    }
    function pressed(o){
        if(vars.currentPlanetIndexBack!==o.numAstro){
            vars.currentPlanetIndexBack=o.numAstro
        }else{
            vars.currentPlanetIndexBack=-1
            sweg.objHousesCircleBack.currentHouse=-1
        }
    }
    function doublePressed(o){

    }
    function loadJson(json){
        //-->Código no presene en PlanetsCircle
        //housesCircleBack.extraWidth=0
        var pMax=0
        var adeg=[]
        //<--Código no presente en PlanetsCircle

        r.totalPosX=-1
        r.objSigns = [0,0,0,0,0,0,0,0,0,0,0,0]
        let jo
        let o
        var houseSun=-1
        for(var i=0;i<20;i++){
            var objAs=r.children[i]
            jo=json.pc['c'+i]
            let degRed=0.0

            //-->Código no presene en PlanetsCircle
            let npMax=0
            for(var i2=0;i2<adeg.length;i2++){
                if(jo.gdeg<=adeg[i2]+5&&jo.gdeg>=adeg[i2]-5){
                    pMax++
                    npMax++
                }
            }
            adeg.push(jo.gdeg)
            //<--Código no presene en PlanetsCircle

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
            if(vars.mod==='dirprim'){
                objAs.rotation-=sweg.dirPrimRot
            }
            if(i===0)vars.currentRotationxAsSol=objAs.rotation
            o={}
            o.p=objSigns[jo.is]
            if(r.totalPosX<o.p){
                r.totalPosX=o.p
            }
            o.ns=objSignsNames.indexOf(jo.is)
            /*if(i===0||i===1){
                o.ih=getHouseIndex(jo.gdec, json.ph.h1.gdec, i)//jo.ih
            }else{
                o.ih=jo.ih
            }*/
            o.ih=sweg.objHousesCircle.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)//jo.ih

            o.rsg=jo.rsgdeg
            o.gdec=jo.gdec
            if(vars.mod==='dirprim'){
                o.gdec+=sweg.dirPrimRot
            }
            if(o.gdec>=360.000)o.gdec-=360.000
            o.g=jo.gdeg
            o.m=jo.mdeg
            o.s=jo.sdeg
            o.ih=sweg.objHousesCircleBack.getHousePos(o.gdec, json.ph.h1.gdec, i, jo.ih)
            o.is=jo.is
            if(vars.tipo==='dirprim'){
                o.is=sweg.getIndexSign(o.gdec)
            }

            if(i!==10&&i!==11)o.retro=jo.retro
            objAs.is=jo.is
            objAs.objData=o
            objSigns[jo.is]++
            if(i===0){
                vars.currentAbsolutoGradoSolarBack=jo.rsgdeg
                vars.currentGradoSolarBack=jo.gdeg
                vars.currentMinutoSolarBack=jo.mdeg
                vars.currentSegundoSolarBack=jo.sdeg
                houseSun=jo.ih
            }
        }
        let espacio=sweg.width*0.1
        let rp=espacio/pMax
        if(rp*2<sweg.fs*0.75){
            rp=rp*2
        }else{
            rp=sweg.fs*0.75
        }
        r.planetSize=rp

        //housesCircleBack.extraWidth=rp*0.25*pMax+r.planetSize
        //sweg.wapsBack=rp*0.25*pMax+r.planetSize
        sweg.wapsBack=500
    }

    function loadJsonFallado(json){
        //housesCircleBack.extraWidth=0
        sweg.wapsBack=0

        r.totalPosX=-1
        r.objSigns = [0,0,0,0,0,0,0,0,0,0,0,0]
        let jo
        let o
        var pMax=0
        var adeg=[]
        for(var i=0;i<15;i++){
            var objAs=r.children[i]
            jo=json.pc['c'+i]
            let degRed=0.0
            let npMax=0
            for(var i2=0;i2<adeg.length;i2++){
                if(jo.gdeg<=adeg[i2]+5&&jo.gdeg>=adeg[i2]-5){
                    pMax++
                    npMax++
                }
            }
            adeg.push(jo.gdeg)
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
            objAs.rotation=signCircle.rot-jo.gdeg-(jo.mdeg/60)+degRed
//            if(vars.mod==='dirprim'){
//                objAs.rotation+=sweg.dirPrimRot
//                //Qt.quit()
//            }
            o={}
            o.p=npMax
            //o.p=objSigns[jo.is]
            //if(o.p>pMax)pMax=o.p
            if(r.totalPosX<o.p){
                r.totalPosX=o.p
            }
            o.ns=objSignsNames.indexOf(jo.is)
            //o.ih=jo.ih
            o.ih=sweg.objHousesCircleBack.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)
            if(i!==10&&i!==11)o.retro=jo.retro
            o.rsg=jo.rsgdeg
            o.g=jo.gdeg
            o.m=jo.mdeg
            o.h=jo.h
            objAs.is=jo.is
            objAs.objData=o
            objSigns[jo.is]++
            if(i===0){
                vars.currentAbsolutoGradoSolar=jo.rsgdeg
                vars.currentGradoSolar=jo.gdeg
                vars.currentMinutoSolar=jo.mdeg
                vars.currentSegundoSolar=jo.sdeg
                //houseSun=jo.ih
            }

        }

//        if(pMax>3){
//            r.planetSize-=0.5
//        }
        let espacio=sweg.width*0.1
        let rp=espacio/pMax
        if(rp*2<sweg.fs*0.75){
            rp=rp*2
        }else{
            rp=sweg.fs*0.75
        }
        r.planetSize=rp

        //housesCircleBack.extraWidth=rp*0.25*pMax+r.planetSize
        //sweg.wapsBack=rp*0.25*pMax+r.planetSize

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
//        //console.log('gf: '+vars.j.deg_to_dms(gf))
//        var arrayDMS=vars.j.deg_to_dms(gf)
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
        arrayDMS=vars.j.deg_to_dms(gf)
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
