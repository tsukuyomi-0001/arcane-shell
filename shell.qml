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

    Loader {
        id: power_menu
        active: false
        source: "PowerMenu.qml"
    }

    IpcHandler {
        target: "wallpaper"
        function toggle(): void {
            wallpaper.active = !wallpaper.active
        }
    }

    IpcHandler {
        target: "power"
        function toggle(): void {
            power_menu.active = !power_menu.active
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
            Region {
                item: island
            }
            Region {
                item: right_anchor
            }
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
            width: mouse_area.containsMouse ? 750 : 200
            height: mouse_area.containsMouse ? 300 : 50
            color: "transparent"

            Behavior on width {
                NumberAnimation { duration: 180; easing.type: Easing.InOutCubic }
            }

            Behavior on height {
                NumberAnimation { duration: 180; easing.type: Easing.InOutCubic }
            }
            
            MouseArea {
                id: mouse_area
                anchors.fill: parent
                hoverEnabled: true
            }
            
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
                    visible: mouse_area.containsMouse ? false : true
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
            id: right_anchor
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.rightMargin: 10
            // anchors.
            height: 50
            width: 50 * 3
            radius: 15
            color: "#ee020202"

            PopupWindow {
                id: wifi_popup
                anchor.window: root
                anchor.rect.x: root.width
                anchor.rect.y: 60
                // visible: true
                implicitWidth: 300
                implicitHeight: 50

                color: "transparent"

                Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "#aa020202"

                    RowLayout {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 20
                        anchors.topMargin: 10
                        implicitHeight: 25
                        implicitWidth: 25
                        spacing: 15

                        Image {
                            source: "./res/wifi.png"
                            sourceSize.height: 25
                        }
                        
                        Text {
                            text: "Wi-Fi"
                            color: "white"
                            font {
                                pixelSize: 20
                                family: "Gothic"
                            }
                        }
                    }

                    Rectangle {
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.rightMargin: 15
                        anchors.topMargin: 13
                        width: 50
                        height: 25
                        radius: 30
                        color: "#D6DDEF"

                        Rectangle {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: 3
                            height: 20
                            width: 20
                            radius: 30
                            color: "#171719"
                        }
                    }
                }
            }

            PopupWindow {
                id: bluetooth_popup
                anchor.window: root
                anchor.rect.x: root.width
                anchor.rect.y: 60
                visible: false
                implicitWidth: 300
                implicitHeight: 50

                color: "transparent"

                Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "#aa020202"

                    RowLayout {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 20
                        anchors.topMargin: 10
                        implicitHeight: 25
                        implicitWidth: 25
                        spacing: 15

                        Image {
                            source: "./res/bluetooth.png"
                            sourceSize.height: 25
                        }
                        
                        Text {
                            text: "Bluetooth"
                            color: "white"
                            font {
                                pixelSize: 20
                                family: "Gothic"
                            }
                        }
                    }

                    Rectangle {
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.rightMargin: 15
                        anchors.topMargin: 13
                        width: 50
                        height: 25
                        radius: 30
                        color: "#D6DDEF"

                        Rectangle {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: 3
                            height: 20
                            width: 20
                            radius: 30
                            color: "#171719"
                        }
                    }
                }
            }

            RowLayout {
                anchors.centerIn: parent
                spacing: 15

                ColumnLayout {
                    spacing: 10

                    Rectangle {
                        id: bluetooth
                        implicitHeight: 22
                        implicitWidth: 22
                        color: "transparent"

                        TapHandler {
                            onTapped: bluetooth_popup.visible = !bluetooth_popup.visible
                        }

                        Image {
                            anchors.centerIn: parent
                            source: "./res/bluetooth.png"
                            sourceSize.height: 20
                            height: 20
                            width: 20
                        }
                    }

                    Rectangle {
                        id: wifi
                        implicitHeight: 22
                        implicitWidth: 22
                        color: "transparent"

                        TapHandler {
                            onTapped: wifi_popup.visible = !wifi_popup.visible
                        }

                        Image {
                            anchors.centerIn: parent
                            source: "./res/wifi.png"
                            sourceSize.height: 20
                            height: 20
                            width: 20
                        }
                    }
                }

                Rectangle {
                    implicitHeight: 22
                    implicitWidth: 22
                    color: "transparent"
                    Image {
                        anchors.centerIn: parent
                        source: "./res/power.png"
                        sourceSize.height: 20
                        height: 20
                        width: 20
                    }

                    TapHandler {
                        onTapped: {
                            Quickshell.execDetached(["qs", "ipc", "call", "power", "toggle"])
                        }
                    }
                }
            }
        }
    }
}
