import QtQuick 2.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2

Dialog {
    property alias searchresults : searchresults
    property alias searchpkg : searchpkg
    property alias searchinput : searchinput
    property alias selectpkg : selectpkg
    property alias thisdialog : thisdialog
    property alias searchresultslist : searchresultslist

    id: thisdialog

    ListModel {
        id: searchresults
        ListElement {
            name: "No search results."
            pkgid: -1
            url: "none"
            description: ""
        }
    }
    implicitWidth: parent.width
    implicitHeight: parent.height

    title: "Select an AUR package"

    contentItem: Rectangle {
        color: "#2d2d2d"
        ColumnLayout {
            spacing: 0
            anchors.fill: parent
            ListView {
                id: searchresultslist
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 70
                Layout.fillWidth: true
                Layout.fillHeight: true
                height: 200
                model: searchresults
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
                            text: description;
                            color: "#fafafa"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: searchresultslist.currentIndex = index
                        }
                    }
                }
                highlight: Item {
                    Rectangle {
                        color: "#3a3a3a"
                        radius: 1
                        height: 35
                        width: parent.width
                    }
                    height: 45
                    width: parent.width
                }
                focus: true
            }

            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: 0
                Layout.preferredHeight: 50
                Layout.fillWidth: true
                color: "#3a3a3a"
                RowLayout {
                    spacing: 20
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    Button {
                        id: selectpkg
                        Layout.minimumHeight: 45
                        Layout.maximumHeight: 45
                        text: "Add"
                        font.pointSize: 10
                        font.family: "Verdana"
                    }

                    TextField {
                        id: searchinput
                        placeholderText: "Search"
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    Button {
                        id: searchpkg
                        Layout.minimumHeight: 45
                        Layout.maximumHeight: 45
                        text: "Search"
                        font.pointSize: 10
                        font.family: "Verdana"
                    }
                }
            }
        }
    }
}
