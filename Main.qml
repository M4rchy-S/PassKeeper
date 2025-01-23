import QtQuick
import QtQuick.Layouts
import QtQuick.VectorImage

import QtQuick.Controls.Basic

import QtQml
// import QtQuick.Controls 2.15
// import QtQuick.Controls.Material 2.12

import com.ics.keeper 1.0

Window {



    width: Qt.platform.os === "android" ? 480 : 1280
    height: Qt.platform.os === "android" ? 800 : 920
    visible: true

    title: qsTr("Pass Keeper")

    PassSafer{
        id: safer
    }

    function updateDataCards()
    {
        cards_list_model.clear();
        for(var i = 0; i < safer.getCardCount(); i++)
        {
            var card = safer.GetCardInfo(i);
            var title_str = card[1]

            if(title_str.length > 15)
                title_str = card[1].substr(0, 15) + "..."

            cards_list_model.append({title: title_str, index: card[0]})
        }
    }

    function cleanInputs()
    {
        title_input.children[1].text = "" ;
        password_input.children[1].text = "" ;
        email_input.children[1].text = "" ;
        desc_input.children[1].text = "" ;

        console.log("inputs cleared");
    }

    function fillInputs(index)
    {
        var card = safer.GetCardInfo(index);

        title_input.children[1].text = card[1] ;
        password_input.children[1].text = card[2] ;
        email_input.children[1].text = card[3] ;
        desc_input.children[1].text = card[4] ;

        console.log("inputs filled");
    }


    Rectangle {
        id: main
        width: 480
        height: 800

        anchors.fill: parent

        Item {
            id: theme

            property int index: 0
            property bool editMode: false

            property color bg_color: "#2B2D42"
            property color bg_accent: "#7692FF"
            property color action_clr: "#A5BFCC"
            property color addit_color: "#DBDBDB"
            property color addit_second_color: "#7692FF"
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
            anchors.topMargin: 100

            spacing: 20

            AnimatedImage{
                id: enter_key_animation
                source: "qrc:/anims/images/key-turning.gif"

                Layout.alignment: Qt.AlignHCenter
                sourceSize.width: 100
                sourceSize.height: 100

            }

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

                property string label_helper: safer.isFileGood() ? qsTr("Your password") : qsTr("Create your password")

                id: inputElementStart
            }

            Text {

                id: error_input
                color: "#B56060"
                text: safer.isFileGood() ? qsTr( "Wrong password" ) : qsTr("Your password should be stronger") ;
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.DemiBold
                font.family: theme.fontFamily
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 250
                Layout.preferredHeight: 40

                visible: false
            }


            Default_Button {
                // id: enter_button
                Layout.preferredWidth: 250
                Layout.preferredHeight: 45
                Layout.alignment: Qt.AlignHCenter

                property string text_btn: qsTr("Enter")

                Connections {
                    target: enter_button
                    onClicked: {
                        load_indicator.visible = true

                        let childTextField = inputElementStart.children[1];
                        if(safer.isFileGood())
                        {
                            if( safer.EnterMasterPassword(childTextField.text) == true )
                            {
                                console.log("Entered master password");
                                updateDataCards();
                                main.state = "CardsPage"
                            }
                            else
                            {
                                console.log("Error input visible set")
                                error_input.visible = true
                            }
                        }
                        else{
                            if(safer.IsPasswordStrong(childTextField.text) == true)
                            {
                                if( safer.CreateMasterPassword(childTextField.text) == true)
                                {
                                    console.log("Created master password");
                                    updateDataCards();
                                    main.state = "CardsPage"
                                } 
                            }
                            else
                            {
                                console.log("Error input visible set")
                                error_input.visible = true
                            }

                        }

                        load_indicator.visible = false

                        //main.state = "CardsPage"
                    }

                }
            }

            BusyIndicator{
                id: load_indicator

                Layout.alignment: Qt.AlignHCenter
                palette.dark: theme.addit_second_color
                visible: false
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



                        VectorImage{
                            source: "qrc:/icons/images/palette_vec.svg"
                            // sourceSize.width: 40
                            // sourceSize.height: 40
                            fillMode: VectorImage.Stretch
                        }

                        // Text {
                        //     Layout.alignment: Qt.AlignVCenter
                        //     color: theme.addit_color
                        //     text: qsTr("P")
                        //     font.pixelSize: theme.fontSizeHeader

                        //     font.weight: Font.DemiBold
                        //     font.family: theme.fontFamily
                        // }

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
                        // MenuItem{
                        //     height: 75
                        //     Text{
                        //         // Layout.alignment: Qt.AlignHCenter
                        //         anchors.centerIn: parent
                        //         color: theme.bg_color
                        //         text: qsTr("Light")
                        //         font.pixelSize: theme.fontSizePara

                        //         font.weight: Font.DemiBold
                        //         font.family: theme.fontFamily
                        //     }
                        // }
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

                        VectorImage{
                            source: "qrc:/icons/images/globe.svg"
                            // sourceSize.width: 40
                            // sourceSize.height: 40
                            fillMode: VectorImage.Stretch
                        }
                        // Text {
                        //     Layout.alignment: Qt.AlignVCenter
                        //     color: theme.addit_color
                        //     text: qsTr("P")
                        //     font.pixelSize: theme.fontSizeHeader

                        //     font.weight: Font.DemiBold
                        //     font.family: theme.fontFamily
                        // }

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
                        // MenuItem{
                        //     height: 75
                        //     Text{
                        //         // Layout.alignment: Qt.AlignHCenter
                        //         anchors.centerIn: parent
                        //         color: theme.bg_color
                        //         text: qsTr("Russian")
                        //         font.pixelSize: theme.fontSizePara

                        //         font.weight: Font.DemiBold
                        //         font.family: theme.fontFamily
                        //     }
                        // }
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

                model: ListModel{
                    id: cards_list_model
                    ListElement { title: "test1"; index: "1" }
                    ListElement { title: "test2"; index: "2" }
                }

                spacing: 15

                snapMode: PathView.SnapToItem
                //boundsBehavior: Flickable.OvershootBounds

                delegate: Rectangle {

                    height: 75
                    width: 350
                    color: theme.bg_color
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius: 5


                    RowLayout {
                        anchors.left: parent
                        anchors.verticalCenter: parent.verticalCenter

                        spacing: 20

                        Item {}

                        VectorImage{
                            source: "qrc:/icons/images/key.svg"
                            // sourceSize.width: 40
                            // sourceSize.height: 40
                            fillMode: VectorImage.Stretch
                        }

                        Text {

                            color: theme.addit_color
                            text: model.title
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
                        onClicked: {
                            theme.editMode = true
                            theme.index = index
                            console.log("Switched theme index to " + theme.index)
                            fillInputs(index);
                            main.state = "EditCard";
                        }
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
                    id: title_input
                }
                InputElement {
                    property string label_helper: qsTr("Password")
                    id: password_input
                }
                InputElement {
                    property string label_helper: qsTr("Email or Username")
                    id: email_input
                }
                DescElement {
                    property string label_helper: qsTr("Description")
                    id: desc_input
                }
                Text {

                    id: error_input_form
                    color: "#B56060"
                    text: "Title and Password are mandatory fields" ;
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.DemiBold
                    font.family: theme.fontFamily
                    Layout.alignment: Qt.AlignHCenter

                    visible: false
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
                        property string text_btn:  qsTr("Cancel")

                        Connections {
                            target: cancel_btn
                            onClicked: {
                                updateDataCards();

                                main.state = "CardsPage"
                                error_input_form.visible = false
                            }

                        }
                    }
                    Default_Button {
                        id: create_btn
                        Layout.preferredWidth: 135
                        Layout.preferredHeight: 45
                        Layout.alignment: Qt.AlignHCenter
                        property string text_btn: theme.editMode ? qsTr("Apply") : qsTr("Create");

                        Connections {
                            target: create_btn
                            onClicked:{
                                if(theme.editMode)
                                {
                                    console.log("Edit mode apply");
                                    if ( safer.EditCard(theme.index, title_input.children[1].text, password_input.children[1].text, email_input.children[1].text, desc_input.children[1].text ) == 1 )
                                    {
                                        updateDataCards();
                                        main.state = "CardsPage"
                                        error_input_form.visible = false
                                    }
                                    else
                                    {
                                        error_input_form.visible = true
                                    }
                                }
                                else
                                {
                                    console.log("Create card");
                                    if( safer.CreateCard(title_input.children[1].text, password_input.children[1].text, email_input.children[1].text, desc_input.children[1].text ) == 1 )
                                    {
                                        updateDataCards();
                                        main.state = "CardsPage"
                                        error_input_form.visible = false
                                    }
                                    else
                                    {
                                        error_input_form.visible = true
                                    }
                                }


                            }
                        }
                    }
                }
            }
        }

        // Default_Button {
        //     id: remove_card
        //     x: 50
        //     y: main.height - 125

        //     width: 50
        //     height: 50

        //     visible: false
        //     property string text_btn: qsTr("R")
        // }

        Button {
            id: remove_card

            width: 50
            height: 50

            x: 50
            y: main.height - 125

            visible: false

            contentItem: VectorImage{
                // height: 50
                // width: 50
                fillMode: VectorImage.Stretch
                source : "qrc:/icons/images/bin.svg"
            }

            background: Rectangle {
                id: background_btn_bin
                implicitWidth: custom_btn.width
                implicitHeight: custom_btn.height
                color: remove_card.down ? "#B56060" : theme.addit_second_color
                radius: 5
            }

            MouseArea{
                anchors.fill : parent
                hoverEnabled: true
                onEntered: background_btn_bin.color =  "#B56060";
                onExited: background_btn_bin.color = theme.addit_second_color;
                onClicked: {
                    //console.log("Bin pressed with ID " + theme.index);
                    if( safer.DeleteCard(theme.index) == 1 )
                    {
                        updateDataCards();
                        main.state = "CardsPage"
                    }
                }
            }
        }


        Button {
            id: add_card_btn_plus

            width: 50
            height: 50

            x: main.width - 100
            y: main.height - 150

            visible: false

            contentItem: VectorImage{
                // height: 50
                // width: 50
                fillMode: VectorImage.Stretch
                source : "qrc:/icons/images/plus.svg"
            }

            background: Rectangle {
                id: background_btn_plus
                implicitWidth: custom_btn.width
                implicitHeight: custom_btn.height
                color: add_card_btn_plus.down ? "#60B57C" : theme.addit_second_color
                radius: 5
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: background_btn_plus.color =  "#60B57C";
                onExited: background_btn_plus.color = theme.addit_second_color;
                onClicked: {
                    theme.editMode = false;
                    cleanInputs() ;
                    main.state = "CreateCard";
                }
            }
        }

        Button {
            id: save_file_btn

            width: 50
            height: 50

            x: main.width - 175
            y: main.height - 150

            visible: false

            contentItem: VectorImage{
                // height: 50
                // width: 50
                fillMode: VectorImage.Stretch
                source : "qrc:/icons/images/save.svg"
            }

            background: Rectangle {
                id: save_file_btn_background
                implicitWidth: custom_btn.width
                implicitHeight: custom_btn.height
                color: save_file_btn.down ? "#60B57C" : theme.addit_second_color
                radius: 5
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: save_file_btn_background.color =  "#60B57C";
                onExited: save_file_btn_background.color = theme.addit_second_color;
                onClicked: {
                    console.log("File btn clicked");
                    safer.SaveToFile();
                }
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
                    width: 60
                    height: 60
                    color: theme.addit_second_color

                    ColumnLayout{
                        anchors.fill : parent

                        spacing: 0

                        VectorImage{
                            id: home_btn_image
                            Layout.alignment: Qt.AlignHCenter
                            source: "qrc:/icons/images/home.svg"
                            // sourceSize.height: 35
                            // sourceSize.width: 35
                            fillMode: VectorImage.Stretch
                        }

                        Text {
                            id: home_btn_text
                            color: theme.addit_color
                            text: qsTr("Home")
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.weight: Font.Medium
                            font.family: theme.fontFamily
                            Layout.alignment: Qt.AlignHCenter
                        }

                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {home_btn_image.opacity = 0.5 ; home_btn_text.opacity = 0.5}
                        onExited: {home_btn_image.opacity = 1 ; home_btn_text.opacity = 1}
                        onClicked: main.state = "CardsPage"
                    }
                }
                // Rectangle {

                //     id: settings_btn
                //     width: 50
                //     height: 50
                //     color: "black"

                //     Text {

                //         color: theme.addit_color
                //         text: qsTr("Settings")
                //         font.pixelSize: theme.fontSizeHeader

                //         font.weight: Font.DemiBold
                //         font.family: theme.fontFamily
                //         anchors.centerIn: parent
                //     }
                //     MouseArea {
                //         anchors.fill: parent
                //         hoverEnabled: true
                //         onEntered: settings_btn.color = "red"
                //         onExited: settings_btn.color = "black"
                //         onClicked: main.state = "Settings"
                //     }
                // }
                Rectangle {
                    id: settings_btn
                    width: 60
                    height: 60

                    color: theme.addit_second_color

                    ColumnLayout{
                        anchors.fill : parent

                        spacing: 0



                        VectorImage{
                            id: settings_btn_image
                            Layout.alignment: Qt.AlignHCenter
                            source: "qrc:/icons/images/gear.svg"
                            // sourceSize.height: 35
                            // sourceSize.width: 35

                            fillMode: VectorImage.Stretch
                        }

                        Text {
                            id: settings_btn_text
                            color: theme.addit_color
                            text: qsTr("Settings")
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.weight: Font.Medium
                            font.family: theme.fontFamily
                            Layout.alignment: Qt.AlignHCenter
                        }

                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {settings_btn_image.opacity = 0.5 ; settings_btn_text.opacity = 0.5}
                        onExited: {settings_btn_image.opacity = 1 ; settings_btn_text.opacity = 1}
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

                PropertyChanges {
                    target: add_card_btn_plus
                    visible: true
                }

                PropertyChanges {
                    target: save_file_btn
                    visible: true
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
