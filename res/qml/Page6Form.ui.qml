import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {
    property alias slideshowopendialog : slideshowopendialog
    property alias selectslideshowbtn : selectslideshowbtn
    property alias slideshowselection : slideshowselection
    property alias radiodefault : radiodefault
    property alias radiocustom : radiocustom

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
            text: "Slideshow"
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
            text: "The slideshow will be shown during the installation of the distro. The folder should contain the images as PNG-files with a recommended size of 800x400px."
            Layout.fillWidth: true
            font.capitalization: Font.MixedCase
            font.weight: Font.Medium
            font.wordSpacing: 2
            font.pointSize: 11
            font.family: "Verdana"
            wrapMode: Text.WordWrap
        }

        Grid {
            ButtonGroup { id: slideshowgroup }

            columns: 2
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30

            RadioButton {
                id: radiodefault
                text: "Use the default-slideshow."
                Layout.fillWidth: true
                font.capitalization: Font.MixedCase
                font.weight: Font.Medium
                font.pointSize: 11
                font.family: "Verdana"
                checked: true
                ButtonGroup.group: slideshowgroup
            }

            Label {
                text: " "
            }

            RadioButton {
                id: radiocustom
                text: "Use a custom slideshow."
                Layout.fillWidth: true
                font.capitalization: Font.MixedCase
                font.weight: Font.Medium
                font.pointSize: 11
                font.family: "Verdana"
                ButtonGroup.group: slideshowgroup
            }

            ColumnLayout {
                Layout.fillWidth: true

                Label {
                    id: slideshowselection
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
                    id: selectslideshowbtn
                    text: "Pick a folder."
                    Layout.fillWidth: true
                    Layout.minimumWidth: 250
                    Layout.minimumHeight: 45
                    Layout.maximumHeight: 45
                    font.pointSize: 10
                    font.family: "Verdana"
                }
            }
        }
    }

    FileDialog {
        selectFolder: true
        id: slideshowopendialog
        title: "Please select a slideshow-folder"
        folder: shortcuts.home
    }
}
