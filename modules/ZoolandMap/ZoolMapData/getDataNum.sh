#!/bin/bash
CANT=$(cat $1 | jq .vibracion_$2.manifestaciones | jq keys | jq length)
titulo="Vibracion $2"
HTML="<h1>$titulo</h1>"
HTML=$HTML"<h3>Manifestaciones</h3>"
HTML=$HTML"<ul>"
for (( c=0; c<$CANT; c++ ))
do
    ITEMNAME=$(cat $1 | jq .vibracion_$2.manifestaciones | jq keys | jq .[$c])
    #echo "Hay $ITEMNAME"

    titulo=$(echo $ITEMNAME | sed 's/"//g' | sed 's/_/ /g')
    titulo="${titulo^}"
    #echo $titulo
    HTML=$HTML"<li><b>$titulo:</b>"
    des=$(cat $1 | jq .vibracion_$2.manifestaciones | jq '.['$ITEMNAME']'  | sed 's/"//g')
    HTML=$HTML" $des</li>"
    #echo $des
done
HTML=$HTML"</ul>"

echo $HTML
