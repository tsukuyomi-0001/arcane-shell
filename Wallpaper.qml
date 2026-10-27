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
            nameFilters: ["*.png", "*.jpeg", "*.jpg", "*.webp", "*.gif"]
            showDirs: false
            sortField: FolderListModel.Name

            onCountChanged: grid.model = shell.identity_list(imageModel)
        }

        function identity_list(files) : var {
            const items = [];
            
            for (let i = 0; i < files.count; i++) {
                // Fetch using standardized modern casing conventions
                let name = files.get(i, "fileName");
                let url = files.get(i, "fileUrl"); // Use "fileUrl" instead of "fileURL"
                let path = files.get(i, "filePath");
                            
                let suffix = "." + name.split('.').pop().toLowerCase();
                
                if (suffix === '.gif') { 
                    items.push({ 'fileUrl': url, 'filePath': path, 'type': 'gif' });
                } else { 
                    items.push({ 'fileUrl': url, 'filePath': path, 'type': 'static' });
                }
            }
            return items;
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
            model: [] //imageModel

            flickDeceleration: 800
            maximumFlickVelocity: 2000
            
            // boundsBehavior: Flickable.StopAtBounds
            pixelAligned: false
            
            flow: GridView.FlowTopToBottom
            flickableDirection: Flickable.HorizontalFlick
            boundsBehavior: Flickable.StopAtBounds
            cellWidth: width / 3 
            cellHeight: height / 2 
            cacheBuffer: cellWidth * 3

            reuseItems: true

            delegate: Item {
                id: cell
                required property url fileUrl
                required property string filePath
                required property string type

                width: grid.cellWidth
                height: grid.cellHeight

                ClippingRectangle {
                    anchors.fill: parent
                    anchors.margins: 10
                    radius: 30
                    color: "transparent"

                    Loader {
                        anchors.fill: parent

                        sourceComponent: cell.type === 'gif' ? animatedComponent : staticComponent
                        Binding {
                            target: loaderItem.item
                            property: "source"
                            value: cell.fileUrl
                        }
                        id: loaderItem
                    }

                    Component {
                        id: staticComponent
                        Image {
                            anchors.fill: parent
                            source: cell.fileUrl
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                            sourceSize: Qt.size(384, 216)
                            mipmap: true
                            cache: true
                        }
                    }

                    Component {
                        id: animatedComponent
                        AnimatedImage {
                            source: cell.fileUrl
                            fillMode: Image.PreserveAspectCrop
                            cache: true
                        }
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