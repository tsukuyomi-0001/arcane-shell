import QtQuick
import Quickshell
import Quickshell.Widgets
import Qt.labs.folderlistmodel

PanelWindow {
    id: root
    implicitHeight: 500
    implicitWidth: 1000
    color: "transparent"

    Rectangle {
        id: shell
        anchors.fill: parent
        color: "#aa020202"
        radius: 50

        FolderListModel {
            id: imageModel

            folder: "file:///home/blankstare/Pictures/Wallpaper"
            nameFilters: ["*.png", "*.jpeg", "*.jpg", "*.webp"]
            showDirs: false
            sortField: FolderListModel.Name
        }

        GridView {
            id: grid
            anchors {
                fill: parent
                topMargin: 30
                bottomMargin: 30
                leftMargin: 25
                rightMargin: 25
            }
            clip: true
            model: imageModel

            flow: GridView.FlowTopToBottom
            flickableDirection: Flickable.HorizontalFlick
            boundsBehavior: Flickable.StopAtBounds
            cellWidth: width / 3 
            cellHeight: height / 2 
            cacheBuffer: cellWidth * 2

            delegate: Item {
                id: cell
                required property url fileUrl
                required property string filePath

                width: grid.cellWidth
                height: grid.cellHeight

                ClippingRectangle {
                    anchors.fill: parent
                    anchors.margins: 10
                    radius: 30
                    color: "transparent"

                    Image {
                        anchors.fill: parent
                        source: cell.fileUrl
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        sourceSize: Qt.size(640, 400)
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(["awww", "img", cell.filePath,
                                "-t", "grow", "--transition-fps", "180", "--transition-duration", "1"])
                            Quickshell.execDetached(["qs", "ipc", "call", "wallpaper", "toggle"])
                        }
                    }
                }
            }
        }
    }
}