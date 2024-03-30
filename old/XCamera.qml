import QtQuick 2.0
import QtQuick.Controls 2.0
import QtMultimedia 5.9

Item {
    id: r
    width: 640
    height: 360
    Rectangle{width: 100;height: 100; color:"green"; z: parent.z-1;border.width: 4;border.color: 'yellow'}
    //apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio

    MediaPlayer{
        id: mp
        //source:'/tmp/camera.flv'
        autoPlay: true
        autoLoad: true

    }
    Timer{
        id: timer
        running: true
        repeat: true
        interval: 1000
        property string fileName
        onTriggered: {
            if(unik.fileExist(fileName)){
                mp.source=fileName
                mp.seek(mp.duration-100)
                timer.stop()
            }else{
                //timer.st
            }
        }
    }
    VideoOutput {
        source: mp
        width: 640
        height: 360
        //anchors.fill: parent
        //focus : visible // to receive focus and capture key events when visible
    }
    Button {
        id: button
        //x: 477
        //y: 150
        text: qsTr("STOP")
        onClicked: {
            let d = new Date(Date.now())
            let fileName='/tmp/video_'+d.getTime()+'.flv'
            let finalCmd=''
            +'ffmpeg -re -f v4l2 -i /dev/video4 -c:v libx264 -preset veryfast -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -an -f flv '+fileName
            console.log('CMD FFmpeg: '+finalCmd)
            let c='console.log(logData)\n'
            timer.fileName=fileName
            timer.start()
            //mp.source=fileName
            xBottomBar.objPanelCmd.mkCmd(finalCmd, c, button)
        }
    }
    Component.onCompleted: {
        //console.log('Camara Hablititada: '+camera.availability)
        //console.log(' QtMultimedia.availableCameras:'+ QtMultimedia.availableCameras())
    }
}
