import QtQuick 2.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2

Dialog {
    property alias programstextarea : programstextarea
    property alias okbtn : okbtn
    property alias thisdialog : thisdialog

    id: thisdialog

    implicitWidth: parent.width
    implicitHeight: parent.height

    title: "Customize selected packages"

    contentItem: ColumnLayout {
        spacing: 2
        ScrollView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            TextArea {
                id: programstextarea
            }
        }
        Button {
            id: okbtn
            text: "OK"
            font.pointSize: 11
            Layout.minimumWidth: 80
            Layout.maximumWidth: 80
            Layout.minimumHeight: 50
            Layout.maximumHeight: 50
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
