import Quickshell
import QtQuick
import QtQuick.Shapes
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts

// import qs.Wallpaper

ShellRoot {
    Loader {
        id: wallpaper
        active: false
        source: "Wallpaper.qml"
    }

    IpcHandler {
        target: "wallpaper"
        function toggle(): void {
            wallpaper.active = !wallpaper.active
        }
    }
    
    PanelWindow {
        id: root
        anchors {
            top: true 
            left: true
            right: true
        }
        
        implicitHeight: 300
        implicitWidth: 200
        color: "transparent"
        exclusiveZone: 50
    
        mask: Region {
            item: island
        }
    
        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.leftMargin: 10
            height: 50
            width: 90
            radius: 15
            color: "#ee020202"
    
            
            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
                source: "res/workspace.svg"
                sourceSize.width: 25
                height: 25
                width: 25
            }
            Text {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 20
                text: Hyprland.focusedWorkspace?.id ?? 1
                color: "white"
                font {
                    pixelSize: 20
                    family: "Cantarell"
                }
            }
        }
    
        Rectangle {
            id: island
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200
            height: 50
            color: "transparent"
    
            Shape {
                width: parent.width
                height: parent.height
    
                ShapePath {
                    strokeWidth: 0
                    fillColor: "#ee020202"
                    startX: 0
                    startY: 0
    
                    PathLine { x: 0; y: 0 }
                    PathArc {
                        relativeX: 20; y: 20
                        radiusX: 20; radiusY: 20
                    }
                    PathLine { x: 20; y: island.height - 20 }
                    PathArc {
                        relativeX: 20; y: island.height
                        radiusX: 20; radiusY: 20
                        direction: PathArc.Counterclockwise
                    }
                    PathLine { x: island.width - 40; y: island.height }
                    PathArc {
                        relativeX: 20; y: island.height - 20
                        radiusX: 20; radiusY: 20
                        direction: PathArc.Counterclockwise
                    }
                    PathLine { x: island.width - 20; y: 20 }
                    PathArc {
                        relativeX: 20; y: 0
                        radiusX: 20; radiusY: 20
                    }
                    PathLine { x: 0; y: 0 }
                }
    
                SystemClock {
                    id: clock
                    precision: SystemClock.Seconds
                }
    
                Text {
                    anchors.centerIn: parent
                    text: Qt.formatDateTime(clock.date, "hh:mm AP")
                    color: "white"
                    font {
                        pixelSize: 18
                        // C059 for classic roman 
                        // Cantarell for simple
                        // Noto Color Emoji is bit strange.
                        // Red Hat Display like ubuntu
                        // URW Gothic also clean look
                        family: "Cantarell"
                        // family: "Red Hat Display"
                        // family: "Canterell"
                    }
                }
            }
        }
    
        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.rightMargin: 10
            height: 50
            width: 50 * 3
            radius: 15
            color: "#ee020202"

            RowLayout {
                anchors.centerIn: parent
                spacing: 15

                Rectangle {
                    implicitHeight: 25
                    implicitWidth: 25
                    color: "transparent"
                    Image {
                        anchors.centerIn: parent
                        source: "./res/wifi.png"
                        sourceSize.height: 25
                        height: 25
                        width: 25
                    }
                }

                Rectangle {
                    implicitHeight: 25
                    implicitWidth: 25
                    color: "transparent"
                    Image {
                        anchors.centerIn: parent
                        source: "./res/bluetooth.png"
                        sourceSize.height: 22
                        height: 22
                        width: 22
                    }
                }

                Rectangle {
                    implicitHeight: 25
                    implicitWidth: 25
                    color: "transparent"
                    Image {
                        anchors.centerIn: parent
                        source: "./res/power.png"
                        sourceSize.height: 22
                        height: 22
                        width: 22
                    }
                }
            }
        }
    }
}