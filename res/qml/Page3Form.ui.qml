import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3


Item {
    id: item1
    property alias aurpkgslist : aurpkgslist
    property alias aurpkgs : aurpkgs

    property alias addpkgbtn : addpkgbtn
    property alias removepkgbtn : removepkgbtn
    property alias aurdialog : aurdialog

    ListModel {
        id: aurpkgs;
    }

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
            width: 357
            Layout.alignment: Qt.AlignCenter
            text: "Which programs would you like to install?"
            font.capitalization: Font.MixedCase
            Layout.fillWidth: true
            font.weight: Font.Medium
            font.wordSpacing: 4
            font.pointSize: 22
            font.family: "Verdana"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        RowLayout {
            Layout.fillWidth: false
            width: 130
            height: 45
            Layout.alignment: Qt.AlignCenter
            spacing: 10
            Button {
                id: addpkgbtn
                Layout.fillWidth: true
                Layout.minimumWidth: 60
                Layout.maximumWidth: 60
                Layout.minimumHeight: 45
                Layout.maximumHeight: 45
                text: "+"
                font.pointSize: 14
                font.family: "Verdana"
            }
            Button {
                id: removepkgbtn
                Layout.fillWidth: true
                Layout.minimumWidth: 60
                Layout.maximumWidth: 60
                Layout.minimumHeight: 45
                Layout.maximumHeight: 45
                text: "-"
                font.pointSize: 18
                font.family: "Verdana"
            }
        }

        Flickable {
            width: 357
            height: 200
            Layout.fillWidth: true
            Layout.fillHeight: true
            ListView {
                width: parent.width
                height: 200
                id: aurpkgslist
                model: aurpkgs
                delegate: Item  {
                    width: parent.width
                    height: 40

                    Item {
                        width: parent.width
                        height: 35

                        Text {
                            id: nameItem
                            anchors.left: parent.left
                            anchors.leftMargin: 20;
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 17
                            text: name
                            color: "#fafafa"
                        }


                        Text {
                            anchors.left: nameItem.right
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 10
                            text: url;
                            color: "#fafafa"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: aurpkgslist.currentIndex = index
                        }
                    }
                }
                highlight: Item {
                    Rectangle {
                        color: "#444"
                        radius: 2
                        height: 35
                        width: parent.width
                    }
                    height: 45
                    width: parent.width
                }
                focus: true
            }
        }
    }

    AURDialog {
        id: aurdialog
    }
}
