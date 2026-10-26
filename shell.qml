import Quickshell
import QtQuick
import QtQuick.Shapes
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts
import Quickshell.Networking
import Quickshell.Bluetooth
import Qt5Compat.GraphicalEffects
import Quickshell.Widgets
// import qs.Wallpaper

ShellRoot {
    LazyLoader {
        id: wallpaper
        // active: false
        activeAsync: false
        source: "Wallpaper.qml"
    }

    LazyLoader {
        id: power_menu
        activeAsync: false
        source: "PowerMenu.qml"
    }

    LazyLoader {
        id: sound_show
        activeAsync: false
        source: "Sound.qml"
    }

    Timer {
        id: sound_show_timer
        interval: 5000
        running: !sound_show.activeAsync ? false : true
        onTriggered: {
            sound_show.activeAsync = !sound_show.activeAsync
        }
    }

    IpcHandler {
        target: "sound_show"
        function keep_active(): void {
            sound_show.activeAsync = true
            sound_show_timer.restart()
        }
    }
    
    IpcHandler {
        target: "wallpaper"
        function toggle(): void {
            wallpaper.activeAsync = !wallpaper.activeAsync
        }
    }

    IpcHandler {
        target: "power"
        function toggle(): void {
            power_menu.activeAsync = !power_menu.activeAsync
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
                    id: shaped_island
                    strokeWidth: 0
                    fillColor: mouse_area.containsMouse ? "#aa020202" : "#ee020202" 
                    startX: 0
                    startY: 0

                    Behavior on fillColor {
                        ColorAnimation { duration: 180; easing.type: Easing.InOutCubic }
                    }
    
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

                RowLayout {
                    visible: mouse_area.containsMouse && (island.width === 750) ? true : false
                    anchors.centerIn: parent
                    height: parent.height * 0.85
                    width: parent.width * 0.87
                    spacing: 20

                    Rectangle {
                        radius: 15
                        color: "#55020202"
                        Layout.fillHeight: true
                        implicitWidth: parent.width * 0.40

                        Rectangle {
                            anchors.centerIn: parent
                            implicitHeight: parent.height * 0.75
                            implicitWidth: parent.height * 0.75
                            radius: parent.height * 0.1
                            color: "#000000"

                            Image {
                                id: profile_image
                                visible: false
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectCrop
                                asynchronous: true
                                cache: true
                                source: "./res/pfp.png"
                                sourceSize.height: parent.implicitHeight * 2
                            }
    
    
                            Rectangle {
                                id: masked_rect
                                visible: false
                                anchors.fill: parent
                                radius: parent.radius
                            }
                            
                            OpacityMask {
                                anchors.fill: parent
                                source: profile_image
                                maskSource: masked_rect
                            }
                        }
                    }

                    Rectangle {
                        radius: 15
                        color: "#55020202"
                        Layout.fillHeight: true
                        implicitWidth: parent.width * 0.58

                        ClippingRectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: parent.implicitWidth * 0.4
                            height: parent.implicitWidth * 0.4
                            radius: parent.implicitWidth
                            color: "black"
                            border.color: "white"
                            border.width: 3

                            Image {
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectCrop
                                source: "./res/no_app_icon.png"

                                transformOrigin: Item.Center

                                NumberAnimation on rotation {
                                    from: 0
                                    to: 360
                                    duration: 13000
                                    loops: Animation.Infinite
                                    running: true
                                    easing.type: Easing.Linear
                                }
                            }

                        }
                        Rectangle {
                            id: controls
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: parent.height * 0.3
                            color: "transparent"

                            ColumnLayout {
                                anchors.centerIn: parent
                                spacing: 15
                                width: parent.width

                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    implicitWidth: controls.width * 0.8
                                    implicitHeight: 25
                                    color: "transparent"

                                    RowLayout {
                                        height: parent.height
                                        width: parent.width
                                        Rectangle {
                                            color: "white"
                                            implicitWidth: parent.width * 0.75
                                            implicitHeight: 5
                                        }

                                        Rectangle {
                                            color: "white"
                                            implicitWidth: parent.width * 0.005
                                            rotation: 30
                                            implicitHeight: 25
                                        }

                                        Rectangle {
                                            color: "white"
                                            implicitWidth: parent.width * 0.2
                                            implicitHeight: 2
                                        }
                                    }
                                }
                                RowLayout {
                                    Layout.alignment: Qt.AlignHCenter
                                    spacing: 30
                                    Image {
                                        source: "./res/back.svg"
                                        sourceSize.height: controls.height * 0.3
                                    }
                                    Image {
                                        source: "./res/start.svg"
                                        sourceSize.height: controls.height * 0.3
                                    }
                                    Image {
                                        source: "./res/next.svg"
                                        sourceSize.height: controls.height * 0.3
                                    }
                                }
                            }

                        }
                    }
                }
            }
        }
        Rectangle {
            id: right_anchor
            property bool wifi_enabled: Networking.wifiHardwareEnabled
            property bool bluetooth_enabled: Bluetooth.defaultAdapter?.enabled ?? false
            
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.rightMargin: 10
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
                implicitHeight: 70

                color: "transparent"

                Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "#aa020202"

                    RowLayout {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 20
                        anchors.topMargin: 20
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
                        anchors.topMargin: 25
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
                implicitHeight: 70

                color: "transparent"

                Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "#aa020202"

                    RowLayout {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 20
                        anchors.topMargin: 20 
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
                        anchors.topMargin: 25
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

                Rectangle {
                    id: wifi

                    TapHandler {
                        onTapped: wifi_popup.visible = !wifi_popup.visible 
                    }
                    
                    implicitHeight: 25
                    implicitWidth: 25
                    color: "transparent"
                    Image {
                        anchors.centerIn: parent
                        source: right_anchor.wifi_enabled ? "./res/wifi.png" : "./res/no-wifi.png"
                        sourceSize.height: 25
                        height: 25
                        width: 25
                    }
                }

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
                        source: right_anchor.bluetooth_enabled ? "./res/bluetooth.png" : "./res/no-bluetooth.png" 
                        sourceSize.height: 22
                        height: 22
                        width: 22
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
