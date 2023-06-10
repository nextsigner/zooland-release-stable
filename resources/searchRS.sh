#!/bin/bash

#Parámetros esperados: "-58.57338|-34.61575|20|02|10|11|11|2020|12|11|2020|13|11|2020|3" el gmt tiene que llegar invertido
#Explicación de parámetros: "longitud|latitud|grado|minuto|segundo|dia 1|mes 1|año 1|dia 2|mes 2|año 2|día 3|mes 3|año 3|gmt"

echo "Iniciando busqueda de grado de revolución solar..."


LON=$(echo $1 | cut -f1 -d'|')
LAT=$(echo $1 | cut -f2 -d'|')
GRADOSOL=$(echo $1 | cut -f3 -d'|')
MINUTOSOL=$(echo $1 | cut -f4 -d'|')
SEGUNDOSOL=$(echo $1 | cut -f5 -d'|')

#Primer día
PDIA=$(echo $1 | cut -f6 -d'|')
PMES=$(echo $1 | cut -f7 -d'|')
PANIO=$(echo $1 | cut -f8 -d'|')

#Segundo día
SDIA=$(echo $1 | cut -f9 -d'|')
SMES=$(echo $1 | cut -f10 -d'|')
SANIO=$(echo $1 | cut -f11 -d'|')

#Tercer día
TDIA=$(echo $1 | cut -f12 -d'|')
TMES=$(echo $1 | cut -f13 -d'|')
TANIO=$(echo $1 | cut -f14 -d'|')

#GMT (Astrolog lo toma invertido)
GMT=$(echo $1 | cut -f15 -d'|')

echo "Buscando grado del sol °"$GRADOSOL" '"$MINUTOSOL" ''"$SEGUNDOSOL
echo "Longitud: "$LON" Latitud:"$LAT
echo "Fecha 1: "$PDIA"/"$PMES"/"$PANIO
echo "Fecha 2: "$SDIA"/"$SMES"/"$SANIO
echo "Fecha 3: "$TDIA"/"$TMES"/"$TANIO

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
    p1=$(echo "$i" | grep 'Sun : ')
    #echo "p1:--->"$p1
    p2=$(echo $p1 | cut -f2 -d':')
    #echo "p2:--->"$p2
    p3=$(echo $p2 | cut -f1 -d'+')
    p4=$(echo $p3 | cut -f1 -d'-')
    p5=${p4// /}
    p6="${p5:1:1}"

    SIGNODETECTADO=""
    GRADODETECTADO=""
    MINUTODETECTADO=""

    #Comineza comparación para saber si el grado es de 2 digitos
    ISGRADO2DIGITO=false
    if( isDigit $p6)
    then
        #echo "SI 2D"
        GRADODETECTADO="${p5:0:2}"
        MINUTODETECTADO="${p5:5:6}"
        SIGNODETECTADO="${p5:2:3}"
    else
        #echo "NO 2D"
        GRADODETECTADO="${p5:0:1}"
        MINUTODETECTADO="${p5:4:5}"
        SIGNODETECTADO="${p5:1:3}"
    fi

    #echo "GRADODETECTADO: "$GRADODETECTADO
    #echo "MINUTODETECTADO: "$MINUTODETECTADO
    #echo "SIGNODETECTADO: "$SIGNODETECTADO

    #echo "EEE#####################---->p6:["$p6"]"
    #echo "EEE#####################---->p5: "$p5
    if [[ $GRADODETECTADO =~ "$GRADOSOL" && $MINUTODETECTADO =~ "$MINUTOSOL" ]]; then
        echo "EN GRADOSOL: "$GRADODETECTADO" MINUTOSOL: "$MINUTODETECTADO
        echo "$GRADODETECTADO"
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
        for (( min=0; min<=59; min+=1 ))
        do
            if(($min<10))
            then
                horasComp=$hora':0'$min
            else
                horasComp=$hora':'$min
            fi
            #echo $horasComp
            #/home/ns/astrolog/astrolog -qa 2 1 2020 $horasComp 0 0.0 0.0
            datos=$(/home/ns/nsp/uda/astromes/astrolog/astrolog -qa $2 $1 $3 $horasComp $GMT $LON $LAT>&1)
            #echo "$datos"
            GD=$(is "$datos") # Grado Detectado
            #echo "GD=$GD"
            if [[ $GD != "" ]]; then
                echo "$FDIA $FMES $FANIO $horasComp"
                break
            fi
        done
    done
    echo ""
}

DD1=$(getGMS $PDIA $PMES $PANIO) #Detectando día 1
echo "DD1=$DD1"
if [[ $DD1 != "" ]]; then
    echo "Finalizado en día 1."
else
    echo "Día 1 sin coincidencia."
    DD2=$(getGMS $SDIA $SMES $SANIO) #Detectando día 2
    echo "DD2=$DD2"
    if [[ $DD2 != "" ]]; then
        echo "Finalizado en día 2."
    else
        echo "Día 2 sin coincidencia."
        DD3=$(getGMS $TDIA $TMES $TANIO) #Detectando día 3
        echo "DD3=$DD3"
        if [[ $DD3 != "" ]]; then
            echo "Finalizado en día 3."
        else
            echo "Día 3 sin coincidencia."
        fi
    fi
fi



#getGMS 2 22 2021
exit;
