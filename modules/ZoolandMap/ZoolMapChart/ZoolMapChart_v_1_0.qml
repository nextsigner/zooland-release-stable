import QtQuick 2.0
import QtCharts 2.0

Item {
    id: r
    anchors.fill: parent
    property var colors: ['red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6']
    property int currentIndex: zm.currentIndexSign

    onCurrentIndexChanged: {
        for(var i=0;i<12;i++){
            pieSeries.find(zm.signos[i]).exploded = false;
        }
        pieSeries.find(zm.signos[r.currentIndex]).exploded = true;
    }

    ChartView {
        id: chart
        width: r.parent.width*1.43//zm.width*1.4-(zm.housesNumWidth*2)-(zm.housesNumMargin*2)
        height: width
        legend.alignment: Qt.AlignBottom
        legend.visible: false
        antialiasing: true
        margins.top: 0
        margins.bottom: 0
        margins.left: 0
        margins.right: 0
        //implicitWidth: zm.width
        enabled: false
        backgroundColor: 'transparent'
        anchors.centerIn: parent
        PieSeries {
            id: pieSeries
            PieSlice { value: 30.0; color: r.colors[8]; label: zm.signos[8]}
            PieSlice { value: 30.0; color: r.colors[7]; label: zm.signos[7]}
            PieSlice { value: 30.0; color: r.colors[6]; label: zm.signos[6]}
            PieSlice { value: 30.0; color: r.colors[5]; label: zm.signos[5]}
            PieSlice { value: 30.0; color: r.colors[4]; label: zm.signos[4]}
            PieSlice { value: 30.0; color: r.colors[3]; label: zm.signos[3]}
            PieSlice { value: 30.0; color: r.colors[2]; label: zm.signos[2]}
            PieSlice { value: 30.0; color: r.colors[1]; label: zm.signos[1]}
            PieSlice { value: 30.0; color: r.colors[0]; label: zm.signos[0]}
            PieSlice { value: 30.0; color: r.colors[11]; label: zm.signos[11]}
            PieSlice { value: 30.0; color: r.colors[10]; label: zm.signos[10]}
            PieSlice { value: 30.0; color: r.colors[9]; label: zm.signos[9]}
        }
    }
}
