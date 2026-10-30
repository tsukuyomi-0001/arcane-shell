import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Wayland
import QtQuick.Shapes

PanelWindow {
    id: root
    anchors {
        right: true
        top: true
        bottom: true
    }

    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    
    focusable: true
    implicitWidth: 500
    exclusiveZone: 0

    color: "transparent"

    mask: Region {
        item: window
    }

    Rectangle {
        id: window
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: 50
        width: 50
        topLeftRadius: 15
        bottomLeftRadius: 15
        color: "#990e0e0e"

        Behavior on height {
            NumberAnimation {
                duration: 600
                easing.type: Easing.Type.InCurve
            }
        }

        Behavior on width {
            NumberAnimation {
                duration: 600
                easing.type: Easing.Type.InCurve
            }
        }

        Rectangle {
            id: resize_box
            anchors.top: parent.top
            anchors.right: parent.right
            width: 20
            height: 20
            color: "transparent"
            Image {
                id: resize
                anchors.fill: parent
                source: "./res/resize.svg"
                sourceSize.height: 20
    
            }
            MouseArea {
                enabled: window.width === (root.width * 0.95) ? true : false
                anchors.fill: parent
                onPressed: {   
                    window.height = 50
                    window.width = 50
                    parent.visible = false
                    icon.visible = true
                    mouse_control.enabled = true
                }
            }
        }

        Image {
            id: icon
            anchors.centerIn: parent
            source: "./res/nevara-icon.png"
            sourceSize.height: 50
        }

        MouseArea {
            id: mouse_control
            anchors.fill: parent
            onPressed: {
                window.height = root.height * 0.75
                window.width = root.width * 0.95
                icon.visible = false
                mouse_control.enabled = false
                resize_box.visible = true
            }
        }
    }

    // Rectangle {
    //     id: window
    //     anchors.left: parent.left
    //     anchors.verticalCenter: parent.verticalCenter
    //     height: parent.height * 0.75
    //     width: parent.width * 0.95
    //     radius: 30
    //     color: "#990e0e0e"

    //     Rectangle {
    //         id: chatArea
            
    //         anchors.top: parent.top
    //         width: parent.width
    //         height: parent.height * 0.87
    //         topLeftRadius: 30
    //         topRightRadius: 30
    //         color: "transparent"
    //         clip: true

    //         Flickable {
    //             id: chatScroll
    //             anchors.fill: parent
    //             anchors.margins: 10

    //             contentWidth: width
    //             contentHeight: messagesColumn.implicitHeight

    //             clip: true
    //             flickableDirection: Flickable.VerticalFlick
    //             boundsBehavior: Flickable.StopAtBounds

    //             Column {
    //                 id: messagesColumn

    //                 width: parent.width
    //                 height: 70

    //                 Rectangle {
    //                     anchors.right: parent.right
    //                     width: Math.min(humanText.implicitWidth + 30,
    //                                     parent.width * 0.8)
    //                     height: 60
    //                     radius: 20
    //                     color: "black"
    
    //                     Text {
    //                         id: humanText
    //                         anchors.centerIn: parent
    //                         text: "Hello!"
    //                         color: "white"
    //                     }
    //                 }
    //                 Rectangle {
    //                     width: parent.width
    //                     height: 70
    //                     color: "transparent"
        
    //                     Rectangle {
    //                         anchors.left: parent.left
    //                         width: Math.min(aiText.implicitWidth + 30,
    //                                         parent.width * 0.8)
    //                         height: 60
    //                         radius: 20
    //                         color: "#303030"
        
    //                         Text {
    //                             id: aiText
    //                             anchors.centerIn: parent
    //                             text: "Hello, good sir!"
    //                             color: "white"
    //                         }
    //                     }
    //                 }
    //                 Rectangle {
    //                     anchors.right: parent.right
    //                     width: Math.min(humanText.implicitWidth + 30,
    //                                     parent.width * 0.8)
    //                     height: 60
    //                     radius: 20
    //                     color: "black"
    
    //                     Text {
    //                         id: humanText2
    //                         anchors.centerIn: parent
    //                         text: "Hello!"
    //                         color: "white"
    //                     }
    //                 }
    //                 Rectangle {
    //                     width: parent.width
    //                     height: 70
    //                     color: "transparent"
        
    //                     Rectangle {
    //                         anchors.left: parent.left
    //                         width: Math.min(aiText.implicitWidth + 30,
    //                                         parent.width * 0.8)
    //                         height: 60
    //                         radius: 20
    //                         color: "#303030"
        
    //                         Text {
    //                             id: aiText2
    //                             anchors.centerIn: parent
    //                             text: "Hello, good sir!"
    //                             color: "white"
    //                         }
    //                     }
    //                 }
    //                 Rectangle {
    //                     anchors.right: parent.right
    //                     width: Math.min(humanText.implicitWidth + 30,
    //                                     parent.width * 0.8)
    //                     height: 60
    //                     radius: 20
    //                     color: "black"
    
    //                     Text {
    //                         id: humanText3
    //                         anchors.centerIn: parent
    //                         text: "Hello!"
    //                         color: "white"
    //                     }
    //                 }
    //                 Rectangle {
    //                     width: parent.width
    //                     height: 70
    //                     color: "transparent"
        
    //                     Rectangle {
    //                         anchors.left: parent.left
    //                         width: Math.min(aiText.implicitWidth + 30,
    //                                         parent.width * 0.8)
    //                         height: 60
    //                         radius: 20
    //                         color: "#303030"
        
    //                         Text {
    //                             id: aiText3
    //                             anchors.centerIn: parent
    //                             text: "Hello, good sir!"
    //                             color: "white"
    //                         }
    //                     }
    //                 }
    //                 Rectangle {
    //                     anchors.right: parent.right
    //                     width: Math.min(humanText.implicitWidth + 30,
    //                                     parent.width * 0.8)
    //                     height: 60
    //                     radius: 20
    //                     color: "black"
    
    //                     Text {
    //                         id: humanText4
    //                         anchors.centerIn: parent
    //                         text: "Hello!"
    //                         color: "white"
    //                     }
    //                 }
    //                 Rectangle {
    //                     width: parent.width
    //                     height: 70
    //                     color: "transparent"
        
    //                     Rectangle {
    //                         anchors.left: parent.left
    //                         width: Math.min(aiText.implicitWidth + 30,
    //                                         parent.width * 0.8)
    //                         height: 60
    //                         radius: 20
    //                         color: "#303030"
        
    //                         Text {
    //                             id: aiText4
    //                             anchors.centerIn: parent
    //                             text: "Hello, good sir!"
    //                             color: "white"
    //                         }
    //                     }
    //                 }
    //                 Rectangle {
    //                     anchors.right: parent.right
    //                     width: Math.min(humanText.implicitWidth + 30,
    //                                     parent.width * 0.8)
    //                     height: 60
    //                     radius: 20
    //                     color: "black"
    
    //                     Text {
    //                         id: humanText5
    //                         anchors.centerIn: parent
    //                         text: "Hello!"
    //                         color: "white"
    //                     }
    //                 }
    //                 Rectangle {
    //                     width: parent.width
    //                     height: 70
    //                     color: "transparent"
        
    //                     Rectangle {
    //                         anchors.left: parent.left
    //                         width: Math.min(aiText.implicitWidth + 30,
    //                                         parent.width * 0.8)
    //                         height: 60
    //                         radius: 20
    //                         color: "#303030"
        
    //                         Text {
    //                             id: aiText5
    //                             anchors.centerIn: parent
    //                             text: "Hello, good sir!"
    //                             color: "white"
    //                         }
    //                     }
    //                 }
    //                 Rectangle {
    //                     anchors.right: parent.right
    //                     width: Math.min(humanText.implicitWidth + 30,
    //                                     parent.width * 0.8)
    //                     height: 60
    //                     radius: 20
    //                     color: "black"
    
    //                     Text {
    //                         id: humanText6
    //                         anchors.centerIn: parent
    //                         text: "Hello!"
    //                         color: "white"
    //                     }
    //                 }
    //                 Rectangle {
    //                     width: parent.width
    //                     height: 70
    //                     color: "transparent"
        
    //                     Rectangle {
    //                         anchors.left: parent.left
    //                         width: Math.min(aiText.implicitWidth + 30,
    //                                         parent.width * 0.8)
    //                         height: 60
    //                         radius: 20
    //                         color: "#303030"
        
    //                         Text {
    //                             id: aiText6
    //                             anchors.centerIn: parent
    //                             text: "Hello, good sir!"
    //                             color: "white"
    //                         }
    //                     }
    //                 }
    //             }
    //         }

    //         function scrollToBottom() {
    //             contentY = Math.max(0, contentHeight - height)
    //         }
    //         Component.onCompleted: scrollToBottom()
    //     }

    //     Rectangle {
    //         id: inter_control
    //         anchors.bottom: parent.bottom
    //         width: parent.width
    //         height: parent.height * 0.13
    //         bottomLeftRadius: 30
    //         bottomRightRadius: 30
    //         color: "#990e0e0e"

    //         // color: "transparent"

    //         RowLayout {
    //             anchors.centerIn: parent
    //             spacing: 15
    //             TextArea {
    //                 implicitHeight: inter_control.height * 0.5
    //                 implicitWidth: inter_control.width * 0.7

    //                 verticalAlignment: TextInput.AlignVCenter
    //                 horizontalAlignment: TextInput.AlignLeft

    //                 leftPadding: 15
    //                 rightPadding: 15
                    
    //                 placeholderText: "Type Here..."
    //                 placeholderTextColor: "white"

    //                 color: "white"
    //                 focus: true

    //                 font.family: "JetBrains Mono Nerd Font"
    //                 font.pixelSize: 14

    //                 background: Rectangle {
    //                     color: "#161B22"
    //                     radius: 15
    //                     border.width: 2
    //                     border.color: "gray" // cool-purple: #5050F4; cool-blue: #1F51FF; cool-light-blue: #0096ff
    //                 }

    //                 Component.onCompleted: {
    //                     forceActiveFocus()
    //                 }
    //             }
    //             Button {
    //                 id: send_button
    //                 implicitHeight: inter_control.height * 0.5
    //                 implicitWidth: inter_control.width * 0.1

    //                 hoverEnabled: true
                    
    //                 leftPadding: 15
    //                 rightPadding: 15
    //                 topPadding: 8
    //                 bottomPadding: 8

    //                 background: Rectangle {
    //                     id: button_background
    //                     color: "#161B22"
    //                     radius: 15
    //                     border.width: 2 
    //                     border.color: send_button.hovered ? "lightgray" : "gray"
    //                 }
    //                 Image {
    //                     anchors.centerIn: parent
    //                     source: "./res/send.svg"
    //                     sourceSize.height: 25
    //                 }
    //             }
    //         }
    //     }
    // }
}
