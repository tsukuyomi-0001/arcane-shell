import Quickshell
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

PanelWindow {
    id: root
    implicitHeight: 500
    implicitWidth: 1000
    color: "transparent"

    Rectangle {
        id: shell
        anchors.fill: parent
        color: "#ee0e0e0e"
        radius: 50

        FolderListModel {
            id: imageModel

            folder: "file:///home/blankstare/Pictures/Wallpaper"
            nameFilters: ["*.png", "*.jpeg", "*.jpg", "*.webp"]
            showDirs: false
            sortField: FolderListModel.Name
        }

        Flickable {
            anchors.fill: parent
            clip: true

            anchors.topMargin: 30
            anchors.leftMargin: 30
            
            contentWidth: grid.width
            contentHeight: grid.height
            
            flickableDirection: Flickable.HorizontalFlick
            
            GridLayout {
                id: grid
                anchors.centerIn: parent
                columns: imageModel.count / 2 
                columnSpacing: 20
                rowSpacing: 20
    
                Repeater {
                    model: imageModel.count
                    delegate: Item {
                        required property int index
    
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.minimumHeight: (shell.height / 2) - (10 * 4)
                        Layout.minimumWidth: (shell.width / 3) - (10 * 3)
                        clip: true
    
                        Rectangle {
                            id: roundedMask
                            anchors.fill: parent
                            radius: 30
                            visible: false
                            color: "#121212"   
                        }
                        
                        Image {
                            id: sourceImage
                            anchors.fill: parent
                            source: imageModel.get(index, "fileUrl")
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                            cache: true
                            sourceSize.height: parent.height
                            sourceSize.width: parent.width
                            visible: false
                        }
    
                        OpacityMask {
                            anchors.fill: parent
                            source: sourceImage
                            maskSource: roundedMask
                        }
    
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
    
                            onClicked: {
                                const imagePath = imageModel.get(index, "filePath")
                                console.log("awww img " + imagePath)
                                Quickshell.execDetached(["awww", "img", imagePath, "-t", "grow"])
                                Quickshell.execDetached(["qs", "ipc", "call", "wallpaper", "toggle"])
                            }
                        }
                    }
                }
            }
        }
    }
}