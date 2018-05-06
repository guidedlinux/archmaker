import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {
    property alias skelopendialog : skelopendialog
    property alias selectfolderbtn : selectfolderbtn
    property alias skelfolderselection : skelfolderselection
    property alias radioempty : radioempty
    property alias radiocustom : radiocustom
    property alias radiohome: radiohome

    id: item1

    ColumnLayout {
        id: columnLayout
        anchors.horizontalCenterOffset: -2
        anchors.top: parent.top
        anchors.topMargin: 17
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 20
        Label {
            Layout.alignment: Qt.AlignCenter
            text: "/etc/skel-folder"
            font.capitalization: Font.MixedCase
            font.weight: Font.Medium
            font.wordSpacing: 4
            font.pointSize: 22
            font.family: "Verdana"
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            width: 357
            Layout.alignment: Qt.AlignCenter
            text: "The /etc/skel-folder contains files/folders, which will be copied to every new user's home-folder when creating the account. It can be used to store standard configuration-files."
            Layout.fillWidth: true
            font.capitalization: Font.MixedCase
            font.weight: Font.Medium
            font.wordSpacing: 2
            font.pointSize: 11
            font.family: "Verdana"
            wrapMode: Text.WordWrap
        }

        Grid {
            ButtonGroup { id: etcskelgroup }

            columns: 2
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30

            RadioButton {
                id: radioempty
                text: "Keep /etc/skel empty
            (no personal settings)."
                Layout.fillWidth: true
                font.capitalization: Font.MixedCase
                font.weight: Font.Medium
                font.pointSize: 11
                font.family: "Verdana"
                checked: true
                ButtonGroup.group: etcskelgroup
            }

            Label {
                text: " "
            }

            RadioButton {
                id: radiocustom
                text: "Use a custom /etc/skel-folder
            (with personal settings)."
                Layout.fillWidth: true
                font.capitalization: Font.MixedCase
                font.weight: Font.Medium
                font.pointSize: 11
                font.family: "Verdana"
                ButtonGroup.group: etcskelgroup
            }

            ColumnLayout {
                Layout.fillWidth: true

                Label {
                    id: skelfolderselection
                    text: "No folder selected."
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillWidth: true
                    width: parent.width
                    font.capitalization: Font.MixedCase
                    font.weight: Font.Medium
                    font.pointSize: 11
                    font.family: "Verdana"
                }
                Button {
                    id: selectfolderbtn
                    text: "Pick a folder."
                    Layout.fillWidth: true
                    Layout.minimumWidth: 250
                    Layout.minimumHeight: 45
                    Layout.maximumHeight: 45
                    font.pointSize: 10
                    font.family: "Verdana"
                }
            }

            RadioButton {
                id: radiohome
                text: "Use my home-folder
            (only the configuration files will
                be copied)."
                Layout.fillWidth: true
                font.capitalization: Font.MixedCase
                font.weight: Font.Medium
                font.pointSize: 11
                font.family: "Verdana"
                ButtonGroup.group: etcskelgroup
            }

        }
    }

    FileDialog {
        selectFolder: true
        id: skelopendialog
        title: "Please select an /etc/skel-folder"
        folder: shortcuts.home
    }
}
