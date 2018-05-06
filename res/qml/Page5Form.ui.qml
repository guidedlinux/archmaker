import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: item1

    property alias distroname : distroname
    property alias distrodescription : distrodescription
    property alias distroversion : distroversion
    property alias distrocodename : distrocodename

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
            text: "/etc/lsb-release"
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
            text: "The file \"/etc/lsb-release\" contains information about the distribution. The selected name will also be used for dual-boot-entries."
            Layout.fillWidth: true
            font.capitalization: Font.MixedCase
            font.weight: Font.Medium
            font.wordSpacing: 2
            font.pointSize: 11
            font.family: "Verdana"
            wrapMode: Text.WordWrap
        }

        Grid {
            columns: 2
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalItemAlignment: Grid.AlignHCenter
            verticalItemAlignment: Grid.AlignVCenter
            spacing: 15

            Label {
                text: "Name of the distribution:"
                font.capitalization: Font.MixedCase
                font.weight: Font.Medium
                font.pointSize: 11
                font.family: "Verdana"
            }

            TextField {
                id: distroname
                text: "mydistro"
                width: 250
                placeholderText: "mydistro"
            }

            Label {
                text: "Description:"
                font.capitalization: Font.MixedCase
                font.weight: Font.Medium
                font.pointSize: 11
                font.family: "Verdana"
            }

            TextField {
                id: distrodescription
                text: "The best distro ever!"
                width: 250
                placeholderText: "The best distro ever!"
            }

            Label {
                text: "First version:"
                font.capitalization: Font.MixedCase
                font.weight: Font.Medium
                font.pointSize: 11
                font.family: "Verdana"
            }

            TextField {
                id: distroversion
                text: "1.0.0"
                width: 250
                placeholderText: "1.0.0"
            }

            Label {
                text: "First codename:"
                font.capitalization: Font.MixedCase
                font.weight: Font.Medium
                font.pointSize: 11
                font.family: "Verdana"
            }

            TextField {
                id: distrocodename
                text: "TryIt"
                width: 250
                placeholderText: "TryIt"
            }
        }
    }
}
