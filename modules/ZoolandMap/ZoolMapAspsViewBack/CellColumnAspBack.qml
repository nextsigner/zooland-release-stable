import QtQuick 2.0

Item {
    id: r
    width: colCellsPlanets.width
    height:  cellWidth
    property int cellWidth: 10
    property int planet: -1
    property alias col: colCells
    Column{
        id: colCellsPlanets
        Repeater{
            model:20
            CellPlanetAspBack{
                width: r.cellWidth
                indexPlanet: r.planet
                opacity: r.planet===index?1.0:0.0
                rotation: 180
            }
        }
    }
    Column{
        id: colCells
        Repeater{
            model:20
            CellAspBack{
                objectName: 'cellAsp_'+index
                width: r.cellWidth
                opacity: index>planet&&r.planet!==index?1.0:0.0
                //indexAsp: 2
            }
        }
    }
    function clear(){
        for(var i=0;i<15;i++){
            let cellRow=colCells.children[i]
            cellRow.indexAsp=-1
            cellRow.indexPosAsp=-1
        }
    }
}
