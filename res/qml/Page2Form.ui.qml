import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: item1
    property alias swipeView: swipeView
    property alias modelLogin : modelLogin
    property alias modelDesktop : modelDesktop
    property alias modelInternet : modelInternet
    property alias modelMultimedia : modelMultimedia
    property alias modelGraphics : modelGraphics
    property alias modelAccessories : modelAccessories
    property alias modelOffice : modelOffice
    property alias modelOther : modelOther
    property alias editmanuallybtn : editmanuallybtn
    property alias packagesDialog : packagesDialog
    property alias usepkgsbtn : usepkgsbtn

    ListModel {
        id: modelLogin
        ListElement {
            pkgtitle: "LightDM"
            pkgimg: "/icons/login/login.png"
            pkgchecked: false
            pkgrealname: "lightdm\nlightdm-gtk-greeter"
            servicename: "lightdm"
        }
        ListElement {
            pkgtitle: "LXDM"
            pkgimg: "/icons/login/login.png"
            pkgchecked: false
            pkgrealname: "lxdm"
            servicename: "lxdm"
        }
        ListElement {
            pkgtitle: "SDDM"
            pkgimg: "/icons/login/login.png"
            pkgchecked: false
            pkgrealname: "sddm"
            servicename: "sddm"
        }
        ListElement {
            pkgtitle: "GDM"
            pkgimg: "/icons/login/login.png"
            pkgchecked: false
            pkgrealname: "gdm"
            servicename: "gdm"
        }
    }

    ListModel {
        id: modelDesktop
        ListElement {
            pkgtitle: "XFCE"
            pkgimg: "/icons/desktop/xfce.png"
            pkgchecked: false
            pkgrealname: "xfce4\nxfce4-goodies"
        }
        ListElement {
            pkgtitle: "Gnome"
            pkgimg: "/icons/desktop/gnome.png"
            pkgchecked: false
            pkgrealname: "gnome\ngnome-extra"
        }
        ListElement {
            pkgtitle: "KDE"
            pkgimg: "/icons/desktop/kde.png"
            pkgchecked: false
            pkgrealname: "plasma"
        }
        ListElement {
            pkgtitle: "Mate"
            pkgimg: "/icons/desktop/mate.png"
            pkgchecked: false
            pkgrealname: "mate\nmate-extra"
        }
        ListElement {
            pkgtitle: "LXDE"
            pkgimg: "/icons/desktop/lxde.png"
            pkgchecked: false
            pkgrealname: "lxde"
        }
        ListElement {
            pkgtitle: "Openbox"
            pkgimg: "/icons/desktop/openbox.png"
            pkgchecked: false
            pkgrealname: "openbox"
        }
        ListElement {
            pkgtitle: "Budgie"
            pkgimg: "/icons/desktop/budgie.png"
            pkgchecked: false
            pkgrealname: "budgie-desktop"
        }
        ListElement {
            pkgtitle: "Cinnamon"
            pkgimg: "/icons/desktop/cinnamon.png"
            pkgchecked: false
            pkgrealname: "cinnamon"
        }
    }

    ListModel {
        id: modelInternet
        ListElement {
            pkgtitle: "Firefox"
            pkgimg: "/icons/internet/firefox.png"
            pkgchecked: false
            pkgrealname: "firefox"
        }
        ListElement {
            pkgtitle: "Chromium"
            pkgimg: "/icons/internet/chromium.png"
            pkgchecked: false
            pkgrealname: "chromium"
        }
        ListElement {
            pkgtitle: "Opera"
            pkgimg: "/icons/internet/opera.png"
            pkgchecked: false
            pkgrealname: "opera"
        }
        ListElement {
            pkgtitle: "Midori"
            pkgimg: "/icons/internet/midori.png"
            pkgchecked: false
            pkgrealname: "midori"
        }
        ListElement {
            pkgtitle: "Gnome Web"
            pkgimg: "/icons/internet/gnome-web.png"
            pkgchecked: false
            pkgrealname: "epiphany"
        }
        ListElement {
            pkgtitle: "Thunderbird"
            pkgimg: "/icons/internet/thunderbird.png"
            pkgchecked: false
            pkgrealname: "thunderbird"
        }
        ListElement {
            pkgtitle: "Filezilla"
            pkgimg: "/icons/internet/filezilla.png"
            pkgchecked: false
            pkgrealname: "filezilla"
        }
        ListElement {
            pkgtitle: "Transmission"
            pkgimg: "/icons/internet/transmission.png"
            pkgchecked: false
            pkgrealname: "transmission-gtk"
        }
    }

    ListModel {
        id: modelMultimedia
        ListElement {
            pkgtitle: "VLC"
            pkgimg: "/icons/multimedia/vlc.png"
            pkgchecked: false
            pkgrealname: "vlc"
        }
        ListElement {
            pkgtitle: "Rhythmbox"
            pkgimg: "/icons/multimedia/rhythmbox.png"
            pkgchecked: false
            pkgrealname: "rhythmbox"
        }
        ListElement {
            pkgtitle: "Totem"
            pkgimg: "/icons/multimedia/totem.png"
            pkgchecked: false
            pkgrealname: "totem"
        }
        ListElement {
            pkgtitle: "Brasero"
            pkgimg: "/icons/multimedia/brasero.png"
            pkgchecked: false
            pkgrealname: "brasero"
        }
        ListElement {
            pkgtitle: "Clementine"
            pkgimg: "/icons/multimedia/clementine.png"
            pkgchecked: false
            pkgrealname: "clementine"
        }
        ListElement {
            pkgtitle: "Amarok"
            pkgimg: "/icons/multimedia/amarok.png"
            pkgchecked: false
            pkgrealname: "amarok"
        }
        ListElement {
            pkgtitle: "Audacious"
            pkgimg: "/icons/multimedia/audacious.png"
            pkgchecked: false
            pkgrealname: "audacious"
        }
        ListElement {
            pkgtitle: "Audacity"
            pkgimg: "/icons/multimedia/audacity.png"
            pkgchecked: false
            pkgrealname: "audacity"
        }
        ListElement {
            pkgtitle: "Kdenlive"
            pkgimg: "/icons/multimedia/kdenlive.png"
            pkgchecked: false
            pkgrealname: "kdenlive"
        }
    }

    ListModel {
        id: modelGraphics
        ListElement {
            pkgtitle: "Gimp"
            pkgimg: "/icons/graphics/gimp.png"
            pkgchecked: false
            pkgrealname: "gimp"
        }
        ListElement {
            pkgtitle: "Inkscape"
            pkgimg: "/icons/graphics/inkscape.png"
            pkgchecked: false
            pkgrealname: "inkscape"
        }
        ListElement {
            pkgtitle: "Eye of Gnome"
            pkgimg: "/icons/graphics/eog.png"
            pkgchecked: false
            pkgrealname: "eog"
        }
        ListElement {
            pkgtitle: "Darktable"
            pkgimg: "/icons/graphics/darktable.png"
            pkgchecked: false
            pkgrealname: "darktable"
        }
    }

    ListModel {
        id: modelAccessories
        ListElement {
            pkgtitle: "Leafpad"
            pkgimg: "/icons/accessories/leafpad.png"
            pkgchecked: false
            pkgrealname: "leafpad"
        }
        ListElement {
            pkgtitle: "Thunar"
            pkgimg: "/icons/accessories/filemanager.png"
            pkgchecked: false
            pkgrealname: "thunar"
        }
        ListElement {
            pkgtitle: "PCManFM"
            pkgimg: "/icons/accessories/filemanager.png"
            pkgchecked: false
            pkgrealname: "pcmanfm"
        }
        ListElement {
            pkgtitle: "Nautilus"
            pkgimg: "/icons/accessories/filemanager.png"
            pkgchecked: false
            pkgrealname: "nautilus"
        }
        ListElement {
            pkgtitle: "Gedit"
            pkgimg: "/icons/accessories/texteditor.png"
            pkgchecked: false
            pkgrealname: "gedit"
        }
        ListElement {
            pkgtitle: "Xfce4-Terminal"
            pkgimg: "/icons/accessories/xfce4-terminal.png"
            pkgchecked: false
            pkgrealname: "xfce4-terminal"
        }
        ListElement {
            pkgtitle: "Dolphin"
            pkgimg: "/icons/accessories/filemanager.png"
            pkgchecked: false
            pkgrealname: "dolphin"
        }
        ListElement {
            pkgtitle: "KWrite"
            pkgimg: "/icons/accessories/texteditor.png"
            pkgchecked: false
            pkgrealname: "kwrite"
        }
        ListElement {
            pkgtitle: "Ark"
            pkgimg: "/icons/accessories/ark.png"
            pkgchecked: false
            pkgrealname: "ark"
        }
        ListElement {
            pkgtitle: "Galculator"
            pkgimg: "/icons/accessories/galculator.png"
            pkgchecked: false
            pkgrealname: "galculator"
        }
    }

    ListModel {
        id: modelOffice
        ListElement {
            pkgtitle: "LibreOffice"
            pkgimg: "/icons/office/libreoffice.png"
            pkgchecked: false
            pkgrealname: "libreoffice-fresh"
        }
        ListElement {
            pkgtitle: "Calligra Suite"
            pkgimg: "/icons/office/calligra.png"
            pkgchecked: false
            pkgrealname: "calligra"
        }
        ListElement {
            pkgtitle: "Okular"
            pkgimg: "/icons/office/okular.png"
            pkgchecked: false
            pkgrealname: "okular"
        }
        ListElement {
            pkgtitle: "Abiword"
            pkgimg: "/icons/office/abiword.png"
            pkgchecked: false
            pkgrealname: "abiword"
        }
    }

    ListModel {
        id: modelOther
        ListElement {
            pkgtitle: "PAVU-Control"
            pkgimg: "/icons/other/pavucontrol.png"
            pkgchecked: false
            pkgrealname: "pavucontrol"
        }
        ListElement {
            pkgtitle: "Cups"
            pkgimg: "/icons/other/cups.png"
            pkgchecked: false
            pkgrealname: "cups"
        }
        ListElement {
            pkgtitle: "Virtualbox"
            pkgimg: "/icons/other/virtualbox.png"
            pkgchecked: false
            pkgrealname: "virtualbox-host-modules-arch\nvirtualbox"
        }
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

        RowLayout {
            Layout.fillWidth: false
            height: 45
            Layout.alignment: Qt.AlignCenter
            spacing: 10
            Button {
                id: usepkgsbtn
                Layout.fillWidth: true
                Layout.minimumWidth: 60
                Layout.minimumHeight: 45
                Layout.maximumHeight: 45
                text: qsTr("Select currently installed programs")
                font.pointSize: 10
                font.family: "Verdana"
            }
            Button {
                id: editmanuallybtn
                Layout.fillWidth: true
                Layout.minimumWidth: 60
                Layout.minimumHeight: 45
                Layout.maximumHeight: 45
                text: qsTr("Edit manually")
                font.pointSize: 10
                font.family: "Verdana"
            }
        }

        TabBar {
            id: tabBar
            anchors.topMargin: 60
            anchors.fill: parent
            currentIndex: swipeView.currentIndex
            TabButton {
                text: qsTr("Login")
            }
            TabButton {
                text: qsTr("Desktop")
            }
            TabButton {
                text: qsTr("Internet")
            }
            TabButton {
                text: qsTr("Multimedia")
            }
            TabButton {
                text: qsTr("Graphics")
            }
            TabButton {
                text: qsTr("Accessories")
            }
            TabButton {
                text: qsTr("Office")
            }
            TabButton {
                text: qsTr("Other")
            }
        }

        ProgramsGrid { id: programsGrid }

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: tabBar.height + 70
            SwipeView {
                onCurrentItemChanged: swipeView.currentItem.visible = true
                id: swipeView
                anchors.fill: parent
                currentIndex: tabBar.currentIndex

                Page {
                    GridView {
                        id: gridViewLogin
                        anchors.leftMargin: 20
                        anchors.topMargin: 20
                        width: parent.width
                        height: (modelLogin.count / (parent.width / cellWidth)) * cellHeight

                        cellWidth: 150
                        cellHeight: cellWidth

                        model: modelLogin

                        delegate: programsGrid.gridDelegate
                    }
                }

                Page {
                    visible: false
                    GridView {
                        id: gridViewDesktop
                        anchors.leftMargin: 20
                        anchors.topMargin: 20
                        width: parent.width
                        height: (modelDesktop.count / (parent.width / cellWidth)) * cellHeight

                        cellWidth: 150
                        cellHeight: cellWidth

                        model: modelDesktop

                        delegate: programsGrid.gridDelegate
                    }
                }

                Page {
                    visible: false
                    GridView {
                        id: gridViewInternet
                        anchors.leftMargin: 20
                        anchors.topMargin: 20
                        width: parent.width
                        height: (modelInternet.count / (parent.width / cellWidth)) * cellHeight

                        cellWidth: 150
                        cellHeight: cellWidth

                        model: modelInternet

                        delegate: programsGrid.gridDelegate
                    }
                }

                Page {
                    visible: false
                    GridView {
                        id: gridViewMultimedia
                        anchors.leftMargin: 20
                        anchors.topMargin: 20
                        width: parent.width
                        height: (modelMultimedia.count / (parent.width / cellWidth)) * cellHeight

                        cellWidth: 150
                        cellHeight: cellWidth

                        model: modelMultimedia

                        delegate: programsGrid.gridDelegate
                    }
                }

                Page {
                    visible: false
                    GridView {
                        id: gridViewGraphics
                        anchors.leftMargin: 20
                        anchors.topMargin: 20
                        width: parent.width
                        height: (modelGraphics.count / (parent.width / cellWidth)) * cellHeight

                        cellWidth: 150
                        cellHeight: cellWidth

                        model: modelGraphics

                        delegate: programsGrid.gridDelegate
                    }
                }

                Page {
                    visible: false
                    GridView {
                        id: gridViewAccessories
                        anchors.leftMargin: 20
                        anchors.topMargin: 20
                        width: parent.width
                        height: (modelAccessories.count / (parent.width / cellWidth)) * cellHeight

                        cellWidth: 150
                        cellHeight: cellWidth

                        model: modelAccessories

                        delegate: programsGrid.gridDelegate
                    }
                }

                Page {
                    visible: false
                    GridView {
                        id: gridViewOffice
                        anchors.leftMargin: 20
                        anchors.topMargin: 20
                        width: parent.width
                        height: (modelOffice.count / (parent.width / cellWidth)) * cellHeight

                        cellWidth: 150
                        cellHeight: cellWidth

                        model: modelOffice

                        delegate: programsGrid.gridDelegate
                    }
                }

                Page {
                    visible: false
                    GridView {
                        id: gridViewOther
                        anchors.leftMargin: 20
                        anchors.topMargin: 20
                        width: parent.width
                        height: (modelOther.count / (parent.width / cellWidth)) * cellHeight

                        cellWidth: 150
                        cellHeight: cellWidth

                        model: modelOther

                        delegate: programsGrid.gridDelegate
                    }
                }
            }
        }
    }

    PackagesDialog {
        id: packagesDialog
    }
}
