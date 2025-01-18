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
        Layout.preferredHeight: 28
    }

    TextField {
        id: textField

        color: theme.addit_color
        font.pixelSize: theme.fontSizePara
        placeholderText: label_helper
        placeholderTextColor: Qt.darker(theme.addit_color)
        font.family: theme.fontFamily
        Layout.preferredWidth: 250
        Layout.preferredHeight: 40

        selectionColor: Qt.lighter(theme.bg_color)

        /*
        contentItem: Text {
            text: text_btn
            font.pixelSize: theme.fontSizePara
            font.family: theme.fontFamily
            font.weight: font.DemiBold
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        */

        background: Rectangle {

            implicitHeight: 40
            implicitWidth: 250
            radius: 5
            color: textField.activeFocus ? theme.addit_second_color : theme.bg_color
            // color: theme.bg_color
            border.color: textField.activeFocus ? theme.action_clr : theme.addit_second_color
            border.width: 2
        }
    }
}
