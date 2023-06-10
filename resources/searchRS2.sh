#!/bin/bash

#Parámetros esperados: "-58.57338|-34.61575|0|20|02|10|11|11|2020|12|11|2020|13|11|2020|-3" el gmt tiene que llegar invertido
#Explicación de parámetros: "longitud|latitud|altitud|grado|minuto|segundo|dia 1|mes 1|año 1|dia 2|mes 2|año 2|día 3|mes 3|año 3|gmt"

#echo "Iniciando busqueda de grado de revolución solar..."

LON=$(echo $1 | cut -f1 -d'|')
LAT=$(echo $1 | cut -f2 -d'|')
ATL=$(echo $1 | cut -f3 -d'|')
GRADOSOL=$(echo $1 | cut -f4 -d'|')
MINUTOSOL=$(echo $1 | cut -f5 -d'|')
SEGUNDOSOL=$(echo $1 | cut -f6 -d'|')

#Primer día
PDIA=$(echo $1 | cut -f7 -d'|')
PMES=$(echo $1 | cut -f8 -d'|')
PANIO=$(echo $1 | cut -f9 -d'|')

#Segundo día
SDIA=$(echo $1 | cut -f10 -d'|')
SMES=$(echo $1 | cut -f11 -d'|')
SANIO=$(echo $1 | cut -f12 -d'|')

#Tercer día
TDIA=$(echo $1 | cut -f13 -d'|')
TMES=$(echo $1 | cut -f14 -d'|')
TANIO=$(echo $1 | cut -f15 -d'|')

#GMT (Astrolog lo toma invertido)
GMT=$(echo $1 | cut -f16 -d'|')

#echo "Buscando grado del sol °"$GRADOSOL" '"$MINUTOSOL" ''"$SEGUNDOSOL
#echo "Longitud: "$LON" Latitud:"$LAT
#echo "Fecha 1: "$PDIA"/"$PMES"/"$PANIO
#echo "Fecha 2: "$SDIA"/"$SMES"/"$SANIO
#echo "Fecha 3: "$TDIA"/"$TMES"/"$TANIO

FDIA=""
FMES=""
FANIO=""


function isDigit(){
re='^[0-9]+$'
if ! [[ $1 =~ $re ]] ; then
    return 1
else
    return 0
fi
}

function is(){
    IFS=$'\n'
    for i in "$1" ;
    do
    #20 sc  3'16.3262
    #p1=$(echo "$i" | grep 'Sun : ')
    #echo "p1:--->"$p1
    p2=$(echo $i | cut -f1 -d' ')
    grado=$(echo $i | cut -f1 -d' ')
    signo=$(echo $i | cut -f2 -d' ')

    pmin1=$(echo $i | cut -f3 -d' ')
    if [[ $pmin1 == "" ]]; then
        pmin1=$(echo $i | cut -f4 -d' ')
        #echo "PMIN:--->"$I
        #psegundo=$(echo $pmin1 | cut -f1 -d"'")
    fi
    minuto=$(echo $pmin1 | cut -f1 -d"'")
    psegundo=$(echo $pmin1 | cut -f2 -d"'")
    desminutos=$(echo $pmin1 | cut -f2 -d"'")
    #echo "desminutos["$desminutos"]"
    p100="${desminutos:1:1}"
    #echo "p100["$p100"]"
    #if [[ $var == [[:space:]]; then
    if [[ $p100 == "" ]]; then
        #echo "Espacio!"
        psegundo0=$(echo $i | cut -f2 -d"'")
        psegundo=$(echo $psegundo0 | cut -f2 -d' ')
        #echo "Segundo!"$psegundo
    fi
    segundo=$(echo $psegundo | cut -f1 -d".")
    #echo "grado:--->"$grado
    #echo "minuto:--->"$minuto
    #echo "segundo:--->"$segundo
    #echo "signo:--->"$signo

    #p5=${p4// /}
    #p6="${p5:1:1}"

    GRADODETECTADO="${grado// /}"
    MINUTODETECTADO="${minuto// /}"
    SEGUNDODETECTADO=${segundo// /}
    SIGNODETECTADO="$signo"

    #echo "GRADODETECTADO: "$GRADODETECTADO
    #echo "MINUTODETECTADO: "$MINUTODETECTADO
    #echo "SEGUNDODETECTADO: ["$SEGUNDODETECTADO"]["$SEGUNDOSOL"]"
    #echo "SIGNODETECTADO: "$SIGNODETECTADO

    #echo "EEE#####################---->p6:["$p6"]"
    #echo "EEE#####################---->p5: "$p5
    #if [[ $GRADODETECTADO =~ "$GRADOSOL" && $MINUTODETECTADO =~ "$MINUTOSOL" ]]; then
    if [[ $GRADODETECTADO =~ "$GRADOSOL" && $MINUTODETECTADO =~ "$MINUTOSOL" && (( $SEGUNDODETECTADO -ge $SEGUNDOSOL)) ]]; then
        echo "=" #$GRADODETECTADO" MINUTOSOL: "$MINUTODETECTADO" SEGUNDOSOL: "$SEGUNDODETECTADO
    fi
    done
echo ""
}

getGMS(){
    #echo "getGMS..."
    FDIA=$1
    FMES=$2
    FANIO=$3
    horas=''
    for (( var=0; var<=23; var++ )) #poner en 23
    do
        if(($var<10))
        then
            horas=$horas' 0'$var
        else
            horas=$horas' '$var
        fi
    done

    horasComp=''
    for hora in $horas
    do
        GD=""
        for (( min=0; min<=59; min+=1 ))
        do
            if(($min<10))
            then
                horasComp=$hora':0'$min
            else
                horasComp=$hora':'$min
            fi

            #datos=$(swetest -p0 -j2442584.4583333335 -geopos-69.61535,-35.47857,1420 -head -fZ>&1)
            jd=$(python3 /home/ns/nsp/uda/astrologica/resources/jday2.py $1 $2 $3 $hora $min >&1)

            datos=$(swetest -p0 -j$jd -geopos$LON,$LAT,$ALT -topo$LON,$LAT,$ALT -head -fZ >&1)

            #echo "$datos"
            GD=$(is "$datos") # Grado Detectado
            echo "$GD"
            if [[ $GD != "" ]]; then
                echo "$FDIA $FMES $FANIO $hora $min"
                break
            fi
        done
        if [[ $GD != "" ]]; then
            #echo "$FDIA $FMES $FANIO $horasComp"
            break
        fi
    done
    echo ""
}

#datos=$(python3 /home/ns/nsp/uda/astrologica/resources/jday2.py 20 6 1975 23 00 >&1)
#echo "$datos"
#exit();

#prueba=$(getGMS 11 11 2020)
#pru|-34.61575|20|10|12|11|11|2020|12|11|2020|13|11|2020|3"eba=$(getGMS 12 11 2020)
#res1=$(echo $prueba | cut -f2 -d'=')
#echo "$res1"
#exit;

momento=""

DD1=$(getGMS $PDIA $PMES $PANIO) #Detectando día 1
if [[ $DD1 != "" ]]; then
    #echo "Finalizado en día 1."
    res1=$(echo $DD1 | cut -f2 -d'=')
    #echo "$res1"
    momento="$res1"
else
    #echo "Día 1 sin coincidencia."
    DD2=$(getGMS $SDIA $SMES $SANIO) #Detectando día 2
    if [[ $DD2 != "" ]]; then
        #echo "Finalizado en día 2."
        res1=$(echo $DD2 | cut -f2 -d'=')
        #echo "$res1"
        momento="$res1"
    else
        #echo "Día 2 sin coincidencia."
        DD3=$(getGMS $TDIA $TMES $TANIO) #Detectando día 3
        if [[ $DD3 != "" ]]; then
            #echo "Finalizado en día 3."
            #echo "DD3=$DD3"
            res1=$(echo $DD3 | cut -f2 -d'=')
            #echo "$res1"
            momento="$res1"
        else
            echo "null"
        fi
    fi
fi
#echo "[$momento"
horaFinal=$(python3 /home/ns/nsp/uda/astrologica/resources/setGmtHour.py $momento $GMT >&1)
echo "$horaFinal"



#getGMS 2 22 2021
exit;
