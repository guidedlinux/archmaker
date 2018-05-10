import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
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
            text: qsTr("Welcome to ArchMaker!")
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
            text: qsTr("This assistant will guide you step-by-step through the creation of your custom, arch-based GNU/Linux-distribution.

You just have to complete the following 7 steps:
1. Programs that need to be installed (normal repositories)
2. Programs that need to be installed (AUR)
3. Standard-folder-content for new users (/etc/skel)
4. lsb-release information
5. Slideshow for calamares (the installer)
6. Summary
7. Saving the final script")
            Layout.fillWidth: true
            font.capitalization: Font.MixedCase
            font.weight: Font.Medium
            font.wordSpacing: 2
            font.pointSize: 11
            font.family: "Verdana"
            wrapMode: Text.WordWrap
        }
    }
}
