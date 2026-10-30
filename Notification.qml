// import QtQuick
// import QtQuick.Layouts
// import Quickshell
// import Quickshell.Wayland
// import Quickshell.Services.Notifications

// ShellRoot {
//     NotificationServer {
//         id: server

//         // Capabilities are mostly off by default; enable what you render
//         actionsSupported: true
//         bodyMarkupSupported: true
//         imageSupported: true
//         keepOnReload: true

//         // Without this, the notification is discarded and never shown
//         onNotification: notification => {
//             notification.tracked = true
//         }
//     }

//     PanelWindow {
//         id: popup
//         // Only show the window when there is something to show
//         visible: server.trackedNotifications.values.length > 0

//         anchors { top: true; right: true }
//         margins { top: 10; right: 10 }
//         implicitWidth: 360
//         implicitHeight: column.implicitHeight
//         color: "transparent"

//         // Don't reserve screen space
//         exclusionMode: ExclusionMode.Ignore
//         WlrLayershell.layer: WlrLayer.Overlay

//         ColumnLayout {
//             id: column
//             width: parent.width
//             spacing: 8

//             Repeater {
//                 model: server.trackedNotifications

//                 delegate: Rectangle {
//                     id: card
//                     required property Notification modelData

//                     Layout.fillWidth: true
//                     implicitHeight: content.implicitHeight + 24
//                     radius: 10
//                     color: "#1e1e2e"
//                     border.color: modelData.urgency === NotificationUrgency.Critical
//                         ? "#f38ba8" : "#45475a"

//                     // Auto-dismiss (expireTimeout is in seconds; 0 = never, -1 = unspecified)
//                     Timer {
//                         interval: card.modelData.expireTimeout > 0
//                             ? card.modelData.expireTimeout * 1000 : 5000
//                         running: card.modelData.urgency !== NotificationUrgency.Critical
//                         onTriggered: card.modelData.expire()
//                     }

//                     ColumnLayout {
//                         id: content
//                         anchors { fill: parent; margins: 12 }
//                         spacing: 4

//                         Text {
//                             text: card.modelData.appName
//                             color: "#a6adc8"
//                             font.pixelSize: 11
//                         }
//                         Text {
//                             text: card.modelData.summary
//                             color: "white"
//                             font.bold: true
//                             wrapMode: Text.Wrap
//                             Layout.fillWidth: true
//                         }
//                         Text {
//                             text: card.modelData.body
//                             color: "#cdd6f4"
//                             wrapMode: Text.Wrap
//                             textFormat: Text.StyledText
//                             visible: text !== ""
//                             Layout.fillWidth: true
//                         }

//                         // Action buttons
//                         RowLayout {
//                             visible: card.modelData.actions.length > 0
//                             Repeater {
//                                 model: card.modelData.actions
//                                 delegate: Rectangle {
//                                     required property var modelData
//                                     implicitWidth: label.implicitWidth + 16
//                                     implicitHeight: 24
//                                     radius: 6
//                                     color: "#313244"
//                                     Text {
//                                         id: label
//                                         anchors.centerIn: parent
//                                         text: parent.modelData.text
//                                         color: "white"
//                                     }
//                                     MouseArea {
//                                         anchors.fill: parent
//                                         onClicked: parent.modelData.invoke()
//                                     }
//                                 }
//                             }
//                         }
//                     }

//                     // Click the card to dismiss
//                     MouseArea {
//                         anchors.fill: parent
//                         z: -1
//                         onClicked: card.modelData.dismiss()
//                     }
//                 }
//             }
//         }
//     }
// }
// 

import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Services.Notifications

ShellRoot {
    NotificationServer {
        id: notification_server

        onNotification: notification => {
            notification.trackeked = true
        }
    }

    PanelWindow {
        id: popup
        visible: notification_server.trackedNotification.values.length > 0

        anchors { top: true; right: true}
        margins { top: 10; right: 10}
        implicitWidth: 360
        implicitHeight: column.implicitHeight
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay

        ColumnLayout {
            id: column
            width: parent.width
            spacing: 8
            Repeat {
                model: notification_server.trackedNotifications

                delegate: Rectangle {
                    id: card
                }
            }
        }
    }
}