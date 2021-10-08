import QtQuick 2.15
import QtMultimedia 5.15
import QtQuick.Controls 2.15

Item
{
    id: listViewDelegate
    //height: 640
    width: 480

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
        target: selectButton
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
                sourceComponent: MCCameraView{}
                anchors.horizontalCenter: parent.horizontalCenter
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
}
