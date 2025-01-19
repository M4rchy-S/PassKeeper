import QtQuick
import QtQuick.Controls

Button {
    // property string text_btn: qsTr("Enter")
    width: 250
    height: 40


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
        color: custom_btn.down ? "#60B57C" : theme.addit_second_color
        // color: custom_btn.down ? Qt.lighter(
        //                              theme.addit_second_color) : theme.addit_second_color
        radius: 5

    }
}
