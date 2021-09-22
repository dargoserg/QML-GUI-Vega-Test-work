import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15
import QtMultimedia 5.15


//import "my"
//import "ico"

import QtMultimedia 5.12

Window
{
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    color: "#31363A"

    property int numberItem: 0
    property bool priority: false

    Row
    {
        id: topButtonRow
        height: 40
        spacing: 10

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 5
        anchors.leftMargin: 10
        anchors.topMargin: 5

        Button
        {
            id: addButton
            width: 32
            height: 32
            palette
            {
                button: "transparent"
            }

            Image
            {
                anchors.fill: parent
                source: "qrc:/ico/64x64/plus.ico"
            }
            onClicked:
            {
                var value =
                {
                    name: "ББП",
                    idNum: numberItem++,
                    srcCamera: "src",
                    showCamera: false,
                    priorityCamera: false,
                    priorityShow: true
                }
                listModel.append(value)
            }
        }

        Button
        {
            id: deleteButton
            width: 32
            height: 32
            palette
            {
                button: "transparent"
            }

            Image
            {
                anchors.fill: parent
                source: "qrc:/ico/64x64/trash.ico"
            }
            onClicked:
            {
                listModel.remove(listView.currentIndex)
            }
        }

        Button
        {
            id: starButton
            width: 42
            height: 32
            palette
            {
                button: "transparent"
            }
            Image
            {
                id: starButtonImage
                anchors.fill: parent
                source: "qrc:/ico/64x85/star_down.ico"
            }

            onClicked:
            {
                if (priority)
                {
                    priority = false
                    starButtonImage.source = "qrc:/ico/64x85/star_down.ico"
                    for (let i=0; i <listModel.count; i++)
                    {
                        listModel.get(i).priorityShow = false
                    }
                }
                else
                {
                    priority = true
                    starButtonImage.source = "qrc:/ico/64x85/star_up.ico"
                    for (let j=0; j <listModel.count; j++)
                    {
                        listModel.get(j).priorityShow = true
                    }
                }
                listView.model = tempModel
                listView.model = listModel
            }
        }
    }

    Rectangle
    {
        id: recFlic

        anchors.top: topButtonRow.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.bottomMargin: 5

        color: "transparent"
        border.color: "white"
        border.width: 3
        radius: 5

        Flickable{
            anchors.fill: parent
            anchors.topMargin: 3
            anchors.bottomMargin: 3

            clip: true

            ListModel
            {
                id: listModel
            }

            ListModel
            {
                id: tempModel
            }

            ListView
            {
                id: listView
                model: listModel
                spacing: 5

                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                topMargin: 5
                bottomMargin: 5

                highlightFollowsCurrentItem: true
                highlightMoveDuration: 100
                highlight:
                Rectangle
                {
                    color: "#0D577E"
                    radius: 3
                }
                delegate:
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
                            id: priorityChangeButton
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
                                id: priorityChangeButtonImage
                                anchors.fill: parent
                                source: "qrc:/ico/64x64/star.ico"
                            }
                            onClicked:
                            {
                                if (priorityCamera)
                                {
                                    priorityCamera = false
                                    priorityChangeButtonImage.source = "qrc:/ico/64x64/star.ico"
                                }
                                else
                                {
                                    priorityCamera = true
                                    priorityChangeButtonImage.source = "qrc:/ico/64x64/fill_star.ico"
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
                                    source: "qrc:/video/Hubsan H122D X4 Storm.mp4"
                                    autoPlay: true
                                    loops: MediaPlayer.Infinite
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    MouseArea
                                    {
                                            anchors.fill: parent
                                            onClicked:
                                            {
                                                if (videoPlayer.playbackState == MediaPlayer.PausedState)
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
                            if (priorityCamera)
                            {
                                if (priorityShow)
                                {
                                    listViewDelegate.showCameraFunc()
                                    priorityChangeButtonImage.source = "qrc:/ico/64x64/fill_star.ico"
                                }
                                else
                                {
                                    listViewDelegate.hideCameraFunc()
                                    priorityChangeButtonImage.source = "qrc:/ico/64x64/fill_star.ico"
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
            }
        }
    }
}

