import Quickshell
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

PanelWindow {
    id: root
    implicitHeight: 400
    implicitWidth: 1200
    color: "transparent"

    Rectangle {
        id: shell
        anchors.fill: parent
        color: "#990e0e0e"
        radius: 50

        RowLayout {
            id: layout
            
            anchors.centerIn: parent
            height: root.height * 0.85
            width: root.width * 0.95
            
            spacing: 25
            
            property real border_width: 2
            property var border_color: "#B7DAF0"
            property var color: "#77020202"
            property real card_radius: 30

            property int hoveredIndex: -1
            property real hoverWeight: 1.25

            readonly property int cardCount: 5
            readonly property real totalWeight: hoveredIndex >= 0 ? (cardCount - 1) + hoverWeight : cardCount
            readonly property real usableWidth: width - spacing * (cardCount - 1)
            
            Repeater {
                model: [
                    { icon: "./res/power.png", action: "power" },
                    { icon: "./res/restart.png", action: "restart" },
                    { icon: "./res/sleep.png", action: "sleep" },
                    { icon: "./res/hibernate.png", action: "hibernate" },
                    { icon: "./res/logout.png", action: "logout" }
                ]

                delegate: Rectangle {
                    id: card
                    required property var modelData
                    required property int index
                    readonly property real weight: layout.hoveredIndex === index ? layout.hoverWeight : 1
                    
                    // Layout.fillWidth: true
                    Layout.preferredWidth: layout.usableWidth * weight / layout.totalWeight
                    Layout.fillHeight: true

                    Behavior on Layout.preferredWidth {
                        NumberAnimation { duration: 180; easing.type: Easing.InOutCubic }
                    }

                    radius: layout.card_radius
                    color: layout.color

                    border.width: layout.border_width
                    border.color: layout.border_color

                    Image {
                        anchors.centerIn: parent
                        source: modelData.icon
                        sourceSize.height: parent.height * 0.3
                    }

                    MouseArea {
                        id: mouse_area
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onContainsMouseChanged: {
                            if (mouse_area.containsMouse) {
                                layout.hoveredIndex = card.index
                            }
                            else if (layout.hoveredIndex === card.index)
                                layout.hoveredIndex = -1
                        }
                    }
                }
            }
        }
    }
}