import QtQuick 2.15
import QtMultimedia 5.15
import QtQuick.Controls 2.15

Component
{
    id: videoPlayerComponent

    Video
    {
        id: videoPlayer
        width: 426
        height: 240
        source: srcCamera
        autoPlay: true
        loops: MediaPlayer.Infinite
        anchors.horizontalCenter: parent.horizontalCenter
        MouseArea
        {
                anchors.fill: parent
                onClicked:
                {
                    if (videoPlayer.playbackState === MediaPlayer.PausedState)
                    {
                        videoPlayer.play()
                    }
                    else
                    {
                        videoPlayer.pause()
                    }
                }
        }
        Label
        {
            id: currentTimeLabel
            text: "00:00"
            color: "white"
            font.pixelSize: 14
            anchors.top: videoPlayer.top
            anchors.topMargin: 3
            anchors.right: videoPlayer.right
            anchors.rightMargin: 3

            Timer
            {
                interval: 500
                running: true
                repeat: true
                onTriggered:
                {
                    currentTimeLabel.text = new Date().toLocaleString(Qt.locale("ru_RU"),"hh:mm:ss")
                }
            }
        }
        Label
        {
            id: lifeTimeItemLable
            text: "L.T.I. = 00:00:00"
            color: "white"
            font.pixelSize: 14
            anchors.bottom: videoPlayer.bottom
            anchors.bottomMargin: 3
            anchors.right: videoPlayer.right
            anchors.rightMargin: 3
            Timer
            {
                interval: 500
                running: true
                repeat: true
                onTriggered:
                {
                    printElapsedTime()
                }

                property var elapsedDate : new Date('1970-01-01 00:00:00')

                function printElapsedTime()
                {
                    elapsedDate = new Date(elapsedDate.getTime() + 500)
                    lifeTimeItemLable.text = "L.T.I. = " + elapsedDate.toLocaleString(Qt.locale("ru_RU"),"hh:mm:ss")
                }
            }
        }
        Label
        {
            id:videoCurrentTimeLabel
            text: "V.C.T. = 00:00"
            color: "white"
            font.pixelSize: 14
            anchors.bottom: videoPlayer.bottom
            anchors.bottomMargin: 3
            anchors.left: videoPlayer.left
            anchors.leftMargin: 3

            Timer
            {
                interval: 500
                running: true
                repeat: true
                onTriggered:
                {
                    videoCurrentTimeLabel.text ="V.C.T. = " + new Date(videoPlayer.position).toLocaleString(Qt.locale("ru_RU"),"mm:ss")
                }
            }

        }
    }
}


