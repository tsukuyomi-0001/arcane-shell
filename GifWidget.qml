import Quickshell
import QtQuick
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects

PanelWindow {
    id: root
    

    WlrLayershell.layer: WlrLayershell.Bottom
    
    anchors {
        bottom: true
        left: true
    }
    implicitWidth: 1920
    implicitHeight: 1080

    exclusiveZone: 0
    color: "transparent"

    Rectangle {
        id: gif_player
        implicitHeight: 400
        implicitWidth: 300
        x: 10
        y: 10
        radius: 30

        AnimatedImage {
            id: animated_image
            source: "file:///home/blankstare/Downloads/wallpaper/From Klickpin.com- Explore Aesthetic boho home decor that are trending right now across Pinterest boards for your next Pinterest save-pin-id-61783.gif"
            sourceSize.height: 400
            visible: false
        }

        Rectangle {
            id: roundedMask
            anchors.fill: parent
            visible: false
            radius: 30
        }

        OpacityMask {
            anchors.fill: parent
            source: animated_image
            maskSource: roundedMask
        }

        Behavior on x {
            NumberAnimation {
                duration: 10
                easing.type: Easing.InOutCubic
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: 10
                easing.type: Easing.InOutCubic
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent 

            property point dragOffset: Qt.point(0,0)

            onPressed: (mouse) => {
                dragOffset = Qt.point(mouse.x, mouse.y)
            }

            onPositionChanged: (mouse) => {
                if (pressed) {
                    let pos = mouseArea.mapToItem(
                        root.contentItem,
                        mouse.x,
                        mouse.y
                    )

                    gif_player.x = pos.x - dragOffset.x
                    gif_player.y = pos.y - dragOffset.y
                }
            }
        }
    }
}