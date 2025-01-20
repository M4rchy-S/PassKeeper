import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    spacing: 10
    Layout.alignment: Qt.AlignHCenter
    height: 75

    // property string label_helper: qsTr("Your password")
    // property string text_field_text: qsTr("text field")

    Text {
        id: help_label
        color: theme.addit_color
        text: label_helper
        font.pixelSize: theme.fontSizeHeader3
        // horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.weight: Font.DemiBold
        font.family: theme.fontFamily

        Layout.preferredWidth: 250
        Layout.preferredHeight: 40
    }

    TextField {
        id: textField
        objectName: "childField"

        color: theme.addit_color
        font.pixelSize: theme.fontSizePara
        // placeholderText: label_helper
        placeholderTextColor: Qt.darker(theme.addit_color)
        font.family: theme.fontFamily
        Layout.preferredWidth: 250
        Layout.preferredHeight: 40

        selectionColor: Qt.lighter(theme.bg_color)


        background: Rectangle {

            implicitHeight: 30
            implicitWidth: 250
            radius: 5
            color: textField.activeFocus ? theme.addit_second_color : theme.bg_color
            // color: theme.bg_color
            border.color: textField.activeFocus ? theme.action_clr : theme.addit_second_color
            border.width: 2
        }
    }
}
