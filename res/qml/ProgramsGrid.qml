import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property Component gridDelegate: gridDelegateComp

    Component {
        id: gridDelegateComp
        RowLayout {
            width: 150 * 0.9
            height: 150 * 0.9
            spacing: 2
            CheckBox {
                id: pkgcheckbox
                width: 15
                height: parent.height
                checked: pkgchecked
                onCheckedChanged: {
                    pkgchecked = pkgcheckbox.checked;
                }
            }
            MouseArea {
                width: 80
                height: parent.height
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10
                    Image {
                        width: 120
                        height: 120
                        fillMode: Image.Stretch
                        source: pkgimg
                    }
                    Text {
                        text: pkgtitle
                        Layout.fillWidth: true
                        font.capitalization: Font.MixedCase
                        font.weight: Font.Medium
                        font.wordSpacing: 2
                        font.pointSize: 11
                        font.family: "Verdana"
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        width: 90
                        anchors.rightMargin: 30
                    }
                }
            }
        }
    }
}
