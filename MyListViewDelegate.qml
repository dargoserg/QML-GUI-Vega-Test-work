import QtQuick 2.15
import QtMultimedia 5.15
import QtQuick.Controls 2.15

Item
{
    id: listViewDelegate
    height: 290

    anchors.left: parent.left
    anchors.right: parent.right

    property int indexOfThisDelegate: index

    function showCameraFunc()
    {
        showCamera = true
        itemVideo.visible = true
        listViewDelegate.height = 290
        hideShowButtonImage.source = "qrc:/ico/64x64/up_arrow.ico"
        loaderVideo.active = true
    }

    function hideCameraFunc()
    {
        showCamera = false
        itemVideo.visible = false
        listViewDelegate.height = 50
        hideShowButtonImage.source = "qrc:/ico/64x64/down_arrow.ico"
        loaderVideo.active = false
    }

    Connections
    {
        target: starButton
        function onHideSelectedCamera()
        {
            if (selectedCamera)
            {
                hideCameraFunc()
            }

        }
        function onShowSelectedCamera()
        {
            if (selectedCamera)
            {
                showCameraFunc()
            }
        }

    }

    Rectangle
    {
        id: recDelegate
        anchors.fill: listViewDelegate
        color: "transparent"
        border.color: "white"
        border.width: 1
        radius: 3

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                listView.currentIndex = index
            }
        }

        Button
        {
            id: locationButton
            width: 32
            height: 32
            palette
            {
                button: "transparent"
            }

            anchors.left: recDelegate.left
            anchors.top: recDelegate.top
            anchors.topMargin: 5
            anchors.leftMargin: 5

            Image
            {
                anchors.fill: parent
                source: "qrc:/ico/64x64/locate_gps.ico"
            }
        }

        Label
        {
            id: nameLabel
            height: 32
            font.pixelSize: 26
            color: "white"
            text: "Видеокамера (" + name + " - " + idNum + ")"

            anchors.left: locationButton.right
            anchors.top: recDelegate.top
            anchors.topMargin: 5
            anchors.leftMargin: 5
        }

        Button
        {
            id: selectedChangeButton
            width: 32
            height: 32
            palette
            {
                button: "transparent"
            }

            anchors.right: hideShowButton.left
            anchors.top: recDelegate.top
            anchors.topMargin: 5
            anchors.rightMargin: 5


            Image
            {
                id: selectedChangeButtonImage
                anchors.fill: parent
                source: "qrc:/ico/64x64/star.ico"
            }
            onClicked:
            {
                if (selectedCamera)
                {
                    selectedCamera = false
                    selectedChangeButtonImage.source = "qrc:/ico/64x64/star.ico"
                }
                else
                {
                    selectedCamera = true
                    selectedChangeButtonImage.source = "qrc:/ico/64x64/fill_star.ico"
                }
            }
        }

        Button
        {
            id: hideShowButton
            width: 32
            height: 32
            palette
            {
                button: "transparent"
            }

            anchors.right: recDelegate.right
            anchors.top: recDelegate.top
            anchors.topMargin: 5
            anchors.rightMargin: 5

            Image
            {
                id: hideShowButtonImage
                anchors.fill: parent
                source: "qrc:/ico/64x64/down_arrow.ico"
            }
            onClicked:
            {
                if (showCamera)
                {
                    listViewDelegate.hideCameraFunc()
                }
                else
                {
                    listViewDelegate.showCameraFunc()
                }
            }
        }

        Item
        {
            id: itemVideo
            height: 240

            anchors.top: locationButton.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter

            Loader
            {
                id: loaderVideo
                sourceComponent: videoPlayerComponent
                anchors.horizontalCenter: parent.horizontalCenter
            }
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
                            //onTriggered: timerLabel.text = Qt.formatDateTime(new Date(), "hh:mm:ss")
                            onTriggered:
                            {
                                currentTimeLabel.text = new Date().toLocaleString(Qt.locale("ru_RU"),"hh:mm:ss")
                            }
                        }
                    }
                    Label
                    {
                        id: elapsedTime
                        text: "00:00"
                        color: "white"
                        font.pixelSize: 14
                        anchors.top: videoPlayer.top
                        anchors.topMargin: 3
                        anchors.left: videoPlayer.left
                        anchors.leftMargin: 3
                        Timer
                        {
                            interval: 500
                            running: true
                            repeat: true
                            property double startDate : Date.now()
                            function printElapsedTime()
                            {
                                let nowDate = Date.now()
                                let elapsedDate = nowDate - startDate
                                elapsedTime.text = new Date(elapsedDate).toLocaleString(Qt.locale("ru_RU"),"mm:ss")
                            }
                            onTriggered:
                            {
                                printElapsedTime()
                            }
                        }
                    }
                }
            }
        }

        Component.onCompleted:
        {
            if (selectedCamera)
            {
                if (showSelectedCamera)
                {
                    listViewDelegate.showCameraFunc()
                    selectedChangeButtonImage.source = "qrc:/ico/64x64/fill_star.ico"
                }
                else
                {
                    listViewDelegate.hideCameraFunc()
                    selectedChangeButtonImage.source = "qrc:/ico/64x64/fill_star.ico"
                }
            }
            else
            {
                if (showCamera)
                {
                    listViewDelegate.showCameraFunc()
                }
                else
                {
                    listViewDelegate.hideCameraFunc()
                }
            }
        }
    }
}
