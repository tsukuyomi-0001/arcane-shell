import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Services.Pipewire

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayershell.Overlay

    property PwNode activeSink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: root.activeSink ? [root.activeSink] : []
    }

    readonly property bool hasAudio: root.activeSink !== null && activeSink.audio !== null
    readonly property real volume_level: hasAudio ? Math.floor(activeSink.audio.volume * 100) : 0
    
    anchors.right: true
    exclusiveZone: 0

    implicitWidth:  90
    implicitHeight: 1080 * 0.3
    color: "transparent"

    Rectangle {
        anchors.rightMargin: 10
        anchors.right: parent.right
        height: parent.height
        width: parent.width * 0.9
        radius: 30
        color: "#aa020202"
        
        ClippingRectangle {
            id: block
            property double percent: 0.5
            anchors.centerIn: parent
            height: parent.height * 0.90
            width: parent.width * 0.65
            radius: 20
            color: "#11ffffff"

            Rectangle {
                anchors.bottom: parent.bottom
                height: { console.log(root.volume_level); parent.height * root.volume_level / 100 } //parent.height * block.percent
                width: parent.width
                color: "#eeecf6f8"

                Behavior on height {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.Linear
                    }
                }
            }
            Text {
                anchors.centerIn: parent
                text: root.volume_level
                color: "gray"
                font {
                    pixelSize: 25
                    family: "Jetbrains Mono Nerd Font"
                }
            }
        }
    }

}