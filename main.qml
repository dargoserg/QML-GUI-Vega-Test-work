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
                delegate: MyListViewDelegate {}
            }
        }
    }
}

