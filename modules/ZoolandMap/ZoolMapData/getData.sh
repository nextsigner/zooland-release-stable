#!/bin/bash
CANT=$(cat $1 | jq .$2_en_$3.manifestaciones | jq keys | jq length)
CANTH=$(cat $1 | jq .$2_en_$4.manifestaciones | jq keys | jq length)
bodie=$2
sign=$3
sign=${sign^}
house=$4
house=${house^}
titulo="${bodie^}"
h2="$titulo en $sign"
h22="$titulo en $house"
titulo="$titulo en $sign en $house"
titulo=$(echo $titulo | sed 's/_/ /g')
HTML="${titulo^}"
HTML="<h1>$HTML</h1>"
HTML=$HTML"<h3>$h2</h3>"
HTML=$HTML"<ul>"
for (( c=0; c<$CANT; c++ ))
do
    ITEMNAME=$(cat $1 | jq .$2_en_$3.manifestaciones | jq keys | jq .[$c])
    #echo "Hay $ITEMNAME"

    titulo=$(echo $ITEMNAME | sed 's/"//g' | sed 's/_/ /g')
    titulo="${titulo^}"
    #echo $titulo
    HTML=$HTML"<li><b>$titulo:</b>"
    des=$(cat $1 | jq .$2_en_$3.manifestaciones | jq '.['$ITEMNAME']'  | sed 's/"//g')
    HTML=$HTML" $des</li>"
    #echo $des
done
HTML=$HTML"</ul>"

#Houses
HTML=$HTML"<h3>$h22</h3>"
HTML=$HTML"<ul>"
for (( c=0; c<$CANTH; c++ ))
do
    ITEMNAME=$(cat $1 | jq .$2_en_$4.manifestaciones | jq keys | jq .[$c])
    #echo "Hay $ITEMNAME"

    titulo=$(echo $ITEMNAME | sed 's/"//g' | sed 's/_/ /g')
    titulo="${titulo^}"
    #echo $titulo
    HTML=$HTML"<li><b>$titulo:</b>"
    des=$(cat $1 | jq .$2_en_$4.manifestaciones | jq '.['$ITEMNAME']'  | sed 's/"//g')
    HTML=$HTML" $des</li>"
    #echo $des
done
HTML=$HTML"</ul>"

echo $HTML
