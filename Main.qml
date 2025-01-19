import QtQuick
// import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Controls.Basic

Window {
    width: 480
    height: 800
    visible: true

    title: qsTr("Pass Keeper")

    Rectangle {
        id: main
        width: 480
        height: 800

        anchors.fill: parent

        Item {
            id: theme

            property color bg_color: "#373F47"
            property color bg_accent: "#7E99A3"
            property color action_clr: "#A5BFCC"
            property color addit_color: "#DBDBDB"
            property color addit_second_color: "#76979C"
            property color bg_color_sec: "#2A323A"

            property int fontSizePara: 16
            property int fontSizeHeader: 24
            property int fontSizeHeader3: 20

            property string fontFamily: "Roboto"
        }

        color: theme.bg_color

        ColumnLayout {
            id: enter_center_widget

            anchors.horizontalCenter: parent.horizontalCenter

            width: 270
            visible: true

            anchors.top: parent.top
            anchors.topMargin: 220

            spacing: 40

            Text {

                id: app_title_enter
                color: theme.addit_color
                text: qsTr("PassKeeper")
                font.pixelSize: 42
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.DemiBold
                font.family: theme.fontFamily
                Layout.alignment: Qt.AlignHCenter
            }

            InputElement {
                property string label_helper: qsTr("Your password")
                id: inputElementStart
            }

            Default_Button {
                // id: enter_button
                Layout.preferredWidth: 250
                Layout.preferredHeight: 45
                Layout.alignment: Qt.AlignHCenter

                property string text_btn: qsTr("Enter")

                Connections {
                    target: enter_button
                    onClicked: main.state = "CardsPage"
                }
            }
        }

        ColumnLayout {
            id: top_bar

            width: parent.width
            height: 70

            visible: false

            anchors.topMargin: 200

            Text {
                id: _text1
                Layout.alignment: Qt.AlignHCenter

                color: theme.addit_color
                text: qsTr("Main")
                font.pixelSize: theme.fontSizeHeader

                font.weight: Font.DemiBold
                font.family: theme.fontFamily
            }
        }

        ScrollView {
            id: settingsscrollView
            x: 0
            y: 85

            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height - 155
            width: 400
            visible: false

            ColumnLayout {
                id: settingsColumn
                width: parent.width
                height: parent.height
                visible: false
                spacing: 30

                Rectangle {
                    id: theme_change_btn
                    width: parent.width
                    height: 75
                    color: theme.bg_color

                    RowLayout {
                        height: parent.height
                        spacing: 25
                        Item {}

                        Text {
                            Layout.alignment: Qt.AlignVCenter
                            color: theme.addit_color
                            text: qsTr("P")
                            font.pixelSize: theme.fontSizeHeader

                            font.weight: Font.DemiBold
                            font.family: theme.fontFamily
                        }

                        ColumnLayout {

                            Text {
                                id: theme_text
                                Layout.alignment: Qt.AlignVCenter
                                color: theme.addit_color
                                text: qsTr("Change theme")
                                font.pixelSize: theme.fontSizeHeader

                                font.weight: Font.DemiBold
                                font.family: theme.fontFamily
                            }
                            Text {
                                Layout.alignment: Qt.AlignVCenter
                                color: theme.bg_accent
                                text: qsTr("Dark")
                                font.pixelSize: theme.fontSizePara

                                font.weight: Font.DemiBold
                                font.family: theme.fontFamily
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = Qt.darker(theme.bg_color)
                        onExited: parent.color = theme.bg_color
                        onPressed: parent.color = Qt.darker(theme.bg_color)
                        onClicked: theme_popup.open()
                    }
                    Menu {
                        id: theme_popup
                        width: main.width -  100
                        // height: main.height - 400
                        anchors.centerIn: parent


                        title: qsTr("Themes")

                        modal: true
                        focus: true
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                        MenuItem{
                            height: 75

                            Text{
                                // Layout.alignment: Qt.AlignHCenter
                                anchors.centerIn: parent
                                color: theme.bg_color
                                text: qsTr("Dark")
                                font.pixelSize: theme.fontSizePara

                                font.weight: Font.DemiBold
                                font.family: theme.fontFamily
                            }

                        }
                        MenuItem{
                            height: 75
                            Text{
                                // Layout.alignment: Qt.AlignHCenter
                                anchors.centerIn: parent
                                color: theme.bg_color
                                text: qsTr("Light")
                                font.pixelSize: theme.fontSizePara

                                font.weight: Font.DemiBold
                                font.family: theme.fontFamily
                            }
                        }
                    }
                }
                Rectangle {
                    id: change_language_btn
                    width: parent.width
                    height: 75
                    color: theme.bg_color

                    RowLayout {
                        height: parent.height
                        spacing: 25
                        Item {}

                        Text {
                            Layout.alignment: Qt.AlignVCenter
                            color: theme.addit_color
                            text: qsTr("P")
                            font.pixelSize: theme.fontSizeHeader

                            font.weight: Font.DemiBold
                            font.family: theme.fontFamily
                        }

                        ColumnLayout {

                            Text {
                                id: language_text
                                Layout.alignment: Qt.AlignVCenter
                                color: theme.addit_color
                                text: qsTr("Change language")
                                font.pixelSize: theme.fontSizeHeader

                                font.weight: Font.DemiBold
                                font.family: theme.fontFamily
                            }
                            Text {
                                Layout.alignment: Qt.AlignVCenter
                                color: theme.bg_accent
                                text: qsTr("English")
                                font.pixelSize: theme.fontSizePara

                                font.weight: Font.DemiBold
                                font.family: theme.fontFamily
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = Qt.darker(theme.bg_color)
                        onExited: parent.color = theme.bg_color
                        onPressed: parent.color = Qt.darker(theme.bg_color)
                        onClicked: language_popup.open()
                    }
                    Menu {
                        id: language_popup
                        width: main.width -  100
                        // height: main.height - 400
                        anchors.centerIn: parent


                        title: qsTr("Languages")

                        modal: true
                        focus: true
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                        MenuItem{
                            height: 75

                            Text{
                                // Layout.alignment: Qt.AlignHCenter
                                anchors.centerIn: parent
                                color: theme.bg_color
                                text: qsTr("English")
                                font.pixelSize: theme.fontSizePara

                                font.weight: Font.DemiBold
                                font.family: theme.fontFamily
                            }

                        }
                        MenuItem{
                            height: 75
                            Text{
                                // Layout.alignment: Qt.AlignHCenter
                                anchors.centerIn: parent
                                color: theme.bg_color
                                text: qsTr("Russian")
                                font.pixelSize: theme.fontSizePara

                                font.weight: Font.DemiBold
                                font.family: theme.fontFamily
                            }
                        }
                    }
                }
            }
        }

        ScrollView {
            id: cardscrollview
            x: 0
            y: 85

            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height - 155
            width: 400
            visible: false

            ListView {
                id: listView
                visible: false

                model: 4

                spacing: 15

                delegate: Rectangle {

                    height: 75
                    width: 350
                    color: theme.bg_color
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius: 5



                    RowLayout {
                        anchors.left: parent
                        anchors.verticalCenter: parent.verticalCenter

                        // anchors.leftMargin: 150
                        spacing: 20

                        Item {}

                        Text {

                            color: theme.addit_color
                            text: qsTr("P")
                            font.pixelSize: 35
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.weight: Font.DemiBold
                            font.family: theme.fontFamily
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {

                            color: theme.addit_color
                            text: qsTr("PassKeeper")
                            font.pixelSize: theme.fontSizeHeader3
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.weight: Font.DemiBold
                            font.family: theme.fontFamily
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = Qt.darker(theme.bg_color)
                        onExited: parent.color = theme.bg_color
                        onPressed: parent.color = Qt.darker(theme.bg_color)
                        onClicked: main.state = "EditCard"
                    }
                }
            }
        }

        ScrollView {
            id: create_card_form

            // visible: false
            // anchors.centerIn: main
            // height: parent.height - 200
            // width: 400

            x: 0
            y: 85

            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height - 155
            width: 400
            visible: false


            ColumnLayout {
                // id: create_card_form

                // visible: false

                anchors.topMargin: 200

                // anchors.fill: parent

                // anchors.horizontalCenter: parent.horizontalCenter

                // width: 400
                // height: parent.height + 150

                    height: parent.height - 200
                    width: 400

                spacing: 25
                // Text {
                //     id: _text
                //     color: theme.addit_color
                //     text: qsTr("Create Card")
                //     font.pixelSize: theme.fontSizeHeader
                //     horizontalAlignment: Text.AlignHCenter
                //     verticalAlignment: Text.AlignVCenter
                //     font.weight: Font.DemiBold
                //     font.family: theme.fontFamily
                //     Layout.alignment: Qt.AlignHCenter
                // }
                InputElement {
                    property string label_helper: qsTr("Title")
                }
                InputElement {
                    property string label_helper: qsTr("Password")
                }
                InputElement {
                    property string label_helper: qsTr("Email or Username")
                }
                DescElement {
                    property string label_helper: qsTr("Description")
                }
                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    // width: parent.width
                    spacing: 40
                    Default_Button {
                        id: cancel_btn
                        Layout.preferredWidth: 135
                        Layout.preferredHeight: 45
                        Layout.alignment: Qt.AlignHCenter
                        property string text_btn: qsTr("Cancel")
                        // Text {

                        //     color: theme.addit_color
                        //     text: "Cancel"
                        //     font.pixelSize: theme.fontSizeHeader3
                        //     font.family: theme.fontFamily
                        //     anchors.centerIn: parent
                        //     font.weight: font.DemiBold
                        // }
                        Connections {
                            target: cancel_btn
                            onClicked: main.state = "CardsPage"
                        }
                    }
                    Default_Button {
                        id: create_btn
                        Layout.preferredWidth: 135
                        Layout.preferredHeight: 45
                        Layout.alignment: Qt.AlignHCenter
                        property string text_btn: qsTr("Create")

                        // Text {

                        //     color: theme.addit_color
                        //     text: "Create"
                        //     font.pixelSize: theme.fontSizeHeader3
                        //     font.family: theme.fontFamily
                        //     anchors.centerIn: parent
                        //     font.weight: font.DemiBold
                        // }
                        Connections {
                            target: create_btn
                            onClicked: main.state = "CardsPage"
                        }
                    }
                }
            }
        }

        Default_Button {
            id: remove_card
            x: 50
            y: main.height - 125

            width: 50
            height: 50

            visible: false
            property string text_btn: qsTr("R")
        }

        Default_Button {
            id: add_new_card_btn
            x: main.width - 100
            y: main.height - 150

            width: 50
            height: 50

            visible: false
            property string text_btn: qsTr("+")

            Connections {
                target: add_new_card_btn
                onClicked: main.state = "CreateCard"
            }
        }

        Rectangle {
            id: nav_bar
            color: theme.addit_second_color

            x: 0
            y: parent.height - 70

            height: 70
            width: parent.width

            visible: false
            RowLayout {
                id: nav_bar_layout

                anchors.centerIn: parent

                spacing: 100

                Rectangle {
                    id: home_btn
                    width: 50
                    height: 50
                    color: "black"

                    Text {

                        color: theme.addit_color
                        text: qsTr("Main")
                        font.pixelSize: theme.fontSizeHeader

                        font.weight: Font.DemiBold
                        font.family: theme.fontFamily
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: home_btn.color = "red"
                        onExited: home_btn.color = "black"
                        onClicked: main.state = "CardsPage"
                    }
                }
                Rectangle {

                    id: settings_btn
                    width: 50
                    height: 50
                    color: "black"

                    Text {

                        color: theme.addit_color
                        text: qsTr("Settings")
                        font.pixelSize: theme.fontSizeHeader

                        font.weight: Font.DemiBold
                        font.family: theme.fontFamily
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: settings_btn.color = "red"
                        onExited: settings_btn.color = "black"
                        onClicked: main.state = "Settings"
                    }
                }
            }
        }

        states: [
            State {
                name: "CardsPage"

                PropertyChanges {
                    target: enter_center_widget
                    visible: false
                }

                PropertyChanges {
                    target: top_bar
                    visible: true
                    z: 5
                }

                PropertyChanges {
                    target: nav_bar
                    visible: true
                    z: 5
                }
                PropertyChanges {
                    target: cardscrollview
                    visible: true
                }
                PropertyChanges {
                    target: add_new_card_btn
                    visible: true
                    wheelEnabled: false
                    spacing: 8
                    hoverEnabled: true
                    checkable: false
                    flat: false
                }

                PropertyChanges {
                    target: listView
                    visible: true
                    snapMode: ListView.SnapToItem
                    z: 0
                }
            },
            State {
                name: "CreateCard"

                PropertyChanges {
                    target: cardscrollview
                    visible: false
                }

                PropertyChanges {
                    target: enter_center_widget
                    visible: false
                }
                PropertyChanges {
                    target: create_card_form
                    visible: true
                }
                PropertyChanges {
                    target: _text1
                    text: qsTr("Create card")
                }
                PropertyChanges {
                    target: top_bar
                    visible: true
                }

            },
            State {
                name: "EditCard"

                PropertyChanges {
                    target: enter_center_widget
                    visible: false
                }

                PropertyChanges {
                    target: create_card_form
                    visible: true
                }
                PropertyChanges {
                    target: create_card_form
                    visible: true
                }

                PropertyChanges {
                    target: _text
                    text: qsTr("Edit card")
                }

                PropertyChanges {
                    target: remove_card
                    visible: true
                }

                PropertyChanges {
                    target: create_btn
                    text: "Edit"
                }

                PropertyChanges {
                    target: _text1
                    text: qsTr("Edit Card")
                }
                PropertyChanges {
                    target: top_bar
                    visible: true
                }
            },
            State {
                name: "Settings"

                PropertyChanges {
                    target: nav_bar
                    visible: true
                }

                PropertyChanges {
                    target: top_bar
                    visible: true
                }

                PropertyChanges {
                    target: _text1
                    text: qsTr("Settings")
                }

                PropertyChanges {
                    target: settingsscrollView
                    visible: true
                }
                PropertyChanges {
                    target: settingsColumn
                    visible: true
                }
                PropertyChanges {
                    target: enter_center_widget
                    visible: false
                }
            }
        ]
    }

}
