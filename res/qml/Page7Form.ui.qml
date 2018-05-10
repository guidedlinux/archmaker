import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: item1

    property alias scriptdialog : scriptdialog
    property alias generatebtn : generatebtn
    property alias summarytext : summarytext

    ColumnLayout {
        id: columnLayout
        anchors.horizontalCenterOffset: -2
        anchors.top: parent.top
        anchors.topMargin: 17
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 50
        Label {
            id: headinglabel
            Layout.alignment: Qt.AlignCenter
            text: qsTr("Summary")
            font.capitalization: Font.MixedCase
            font.weight: Font.Medium
            font.wordSpacing: 4
            font.pointSize: 22
            font.family: "Verdana"
            horizontalAlignment: Text.AlignHCenter
        }

        TextEdit {
            id: summarytext
            text: ""
            font.family: "Courier"
            readOnly: true
            wrapMode: Text.WordWrap
            selectByMouse: true
            font.pointSize: 11
            Layout.fillWidth: true
            font.capitalization: Font.MixedCase
            font.weight: Font.Medium
            color: "#fafafa"
            horizontalAlignment: TextEdit.AlignHCenter
        }

        Button {
            id: generatebtn
            text: qsTr("Generate")
            font.pointSize: 14
            Layout.minimumWidth: 140
            Layout.maximumWidth: 140
            Layout.minimumHeight: 60
            Layout.maximumHeight: 60
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    ScriptDialog {
        id: scriptdialog
    }
}
