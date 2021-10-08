import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15
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
    property bool showSelectesCamerаs: false

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
                    srcCamera: "qrc:/video/Hubsan H122D X4 Storm.mp4",
                    showCamera: false,
                    selectedCamera: false,
                    showSelectedCamera: false
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
            id: selectButton
            width: 42
            height: 32
            palette
            {
                button: "transparent"
            }
            Image
            {
                id: selectButtonImage
                anchors.fill: parent
                source: "qrc:/ico/64x85/star_down.ico"
            }

            signal hideSelectedCamera()
            signal showSelectedCamera()

            onClicked:
            {
                if (showSelectesCamerаs)
                {
                    showSelectesCamerаs = false
                    selectButtonImage.source = "qrc:/ico/64x85/star_down.ico"
                    hideSelectedCamera()
                    for (let i=0; i <listModel.count; i++)
                    {
                        listModel.get(i).showSelectedCamera = false
                    }
                }
                else
                {
                    showSelectesCamerаs = true
                    selectButtonImage.source = "qrc:/ico/64x85/star_up.ico"
                    showSelectedCamera()
                    for (let j=0; j <listModel.count; j++)
                    {
                        listModel.get(j).showSelectedCamera = true
                    }
                }
            }
        }
    }

    Rectangle
    {
        id: borderRectangle

        anchors.top: topButtonRow.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.bottomMargin: 10

        color: "transparent"
        border.color: "white"
        border.width: 3
        radius: 5

        ListModel
        {
            id: listModel
        }

        ListView
        {
            id: listView
            model: listModel
            spacing: 5

            anchors.fill: parent
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            clip: true

            highlightFollowsCurrentItem: true
            highlightMoveDuration: -1
            highlightMoveVelocity: 1000
            highlight:
            Rectangle
            {
                color: "#0D577E"
                radius: 3
            }

            delegate: MCListViewDelegate {}
        }
    }
}

