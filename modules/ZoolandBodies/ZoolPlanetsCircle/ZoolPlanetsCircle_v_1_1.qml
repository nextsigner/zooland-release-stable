import QtQuick 2.0
import ZoolandBodies.ZoolAs 3.8

Item{
    id: r
    property bool expand: false
    property var cAs: r
    property int planetSize: sweg.fs*1.5//sweg.fs*0.75

    property int totalPosX: 0

    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var objSigns: [0,0,0,0,0,0,0,0,0,0,0,0]

    signal cnLoaded(string nombre, string dia, string mes, string anio, string hora, string minuto, string lon, string lat, string ciudad)
    signal doubleClick
    signal posChanged(int px, int py)
    Repeater{
        //model: 20//vars.planetasRes
        model: vars.planetasRes
        ZoolAs{fs:r.planetSize;astro:modelData;numAstro: index}
    }
    function pressed(o){
        if(vars.currentPlanetIndex!==o.numAstro){
            vars.currentPlanetIndex=o.numAstro
            vars.currentHouseIndex=o.ih
        }else{
            vars.currentPlanetIndex=-1
            vars.currentHouseIndex=-1
        }
        //unik.speak(''+vars.planetas[o.numAstro]+' en '+vars.signos[o.objData.ns]+' en el grado '+o.objData.g+' en la casa '+o.objData.h)
    }
    function doublePressed(o){

    }

    function loadJson(json){
        r.totalPosX=-1
        r.objSigns = [0,0,0,0,0,0,0,0,0,0,0,0]
        let jo
        let o
        var houseSun=-1
        //for(var i=0;i<15;i++){
        for(var i=0;i<20;i++){
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
            if(i===0)vars.currentRotationxAsSol=objAs.rotation
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
                vars.currentAbsolutoGradoSolar=jo.gdeg
                vars.currentGradoSolar=jo.rsgdeg
                vars.currentMinutoSolar=jo.mdeg
                vars.currentSegundoSolar=jo.sdeg
                houseSun=jo.ih
            }
        }        
    }

}
