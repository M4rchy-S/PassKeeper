import QtQuick
import QtQuick.Controls

Button {

    // Layout.preferredWidth: 250
    // Layout.preferredHeight: 40
    // Layout.alignment: Qt.AlignHCenter

    // property string text_btn: qsTr("Enter")
    width: 250
    height: 40

    // color: theme.addit_color
    // text: text_btn
    // font.pixelSize: theme.fontSizeHeader3
    // font.family: theme.fontFamily
    // font.weight: font.DemiBold
    id: custom_btn



    contentItem: Text {
        text: text_btn
        font.pixelSize: theme.fontSizeHeader3
        font.family: theme.fontFamily
        font.weight: font.DemiBold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color:theme.addit_color
    }

    background: Rectangle {
        implicitWidth: custom_btn.width
        implicitHeight: custom_btn.height
        // color: custom_btn.down ? "#60B57C" : theme.addit_second_color
        color: custom_btn.down ? Qt.lighter(
                                     theme.addit_second_color) : theme.addit_second_color
        radius: 5

    }
}
