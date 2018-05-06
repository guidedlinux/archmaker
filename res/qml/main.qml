import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

ApplicationWindow {
    function appendpackages(model, pkglist) {
        var returnlist = pkglist;
        for (var i = 0; i < model.count; i++) {
            if (model.get(i).pkgchecked) {
                returnlist.push(model.get(i).pkgrealname);
            }
        }
        return returnlist;
    }

    Material.theme: Material.Dark
    Material.accent: Material.Teal

    visible: true
    width: 800
    height: 480
    title: qsTr("ArchMaker")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1 {
        }

        Page2 {
            id: pg2
        }

        Page3 {
            id: pg3
        }

        Page4 {
            id: pg4
        }

        Page5 {
            id: pg5
        }

        Page6 {
            id: pg6
        }

        Page7 {
            id: pg7
        }

        onCurrentIndexChanged: {
            if (swipeView.currentIndex == 6) {
                var packagestoinstall = [];

                var programsrequest = new XMLHttpRequest();
                programsrequest.open("GET", "/script/standardprograms", false);
                programsrequest.send();
                packagestoinstall.push(programsrequest.responseText);

                packagestoinstall = appendpackages(pg2.modelLogin, packagestoinstall);
                packagestoinstall = appendpackages(pg2.modelDesktop, packagestoinstall);
                packagestoinstall = appendpackages(pg2.modelInternet, packagestoinstall);
                packagestoinstall = appendpackages(pg2.modelMultimedia, packagestoinstall);
                packagestoinstall = appendpackages(pg2.modelGraphics, packagestoinstall);
                packagestoinstall = appendpackages(pg2.modelAccessories, packagestoinstall);
                packagestoinstall = appendpackages(pg2.modelOffice, packagestoinstall);
                packagestoinstall = appendpackages(pg2.modelOther, packagestoinstall);

                var servicestoenable = [];

                for (var i = 0; i < pg2.modelLogin.count; i++) {
                    if (pg2.modelLogin.get(i).pkgchecked) {
                        servicestoenable.push(pg2.modelLogin.get(i).servicename);
                    }
                }

                var aurpackagelinks = [];

                for (i = 0; i < pg3.aurpkgs.count; i++) {
                    aurpackagelinks.push(pg3.aurpkgs.get(i).url);
                    packagestoinstall.push(pg3.aurpkgs.get(i).name);
                }


                var skelfolderoption = 0;
                var skelfoldertext = "";
                var skelfolderpath = "none";

                if (pg4.radioempty.checked) skelfolderoption = 0; skelfoldertext = "Empty /etc/skel-folder";
                if (pg4.radiohome.checked) skelfolderoption = 2; skelfoldertext = "Config from ~ as /etc/skel";
                if (pg4.radiocustom.checked) {
                    if (pg4.skelfolderselection.text !== "No folder selected.") {
                        skelfolderpath = pg4.skelfolderselection.text;
                        skelfolderoption = 1; skelfoldertext = "Custom /etc/skel-folder: " + skelfolderpath;
                    } else {
                        skelfolderoption = 0; skelfoldertext = "Empty /etc/skel-folder";
                    }
                }

                var distroname = pg5.distroname.text;
                var distrodescription = pg5.distrodescription.text;
                var distroversion = pg5.distroversion.text;
                var distrocodename = pg5.distrocodename.text;

                var customslideshow = false;
                var customslideshowtext = "";
                var slideshowpath = "none";

                if (pg6.radiodefault.checked) customslideshow = false; customslideshowtext = "Use default slideshow.";
                if (pg6.radiocustom.checked) {
                    if (pg6.slideshowselection.text !== "No folder selected.") {
                        slideshowpath = pg6.slideshowselection.text;
                        customslideshow = true; customslideshowtext = "Use custom slideshow: " + slideshowpath;
                    } else {
                        customslideshow = false; customslideshowtext = "Use default slideshow.";
                    }
                }


                var settings = {
                    pkgs: packagestoinstall,
                    services: servicestoenable,
                    aur: aurpackagelinks,
                    skelfolder: {
                        summary: skelfoldertext,
                        option: skelfolderoption,
                        path: skelfolderpath
                    },
                    lsbrelease: {
                        name: distroname,
                        description: distrodescription,
                        version: distroversion,
                        codename: distrocodename
                    },
                    slideshow: {
                        summary: customslideshowtext,
                        option: customslideshow,
                        path: slideshowpath
                    }
                };

                pg7.displaysummary(settings);
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Welcome")
        }
        TabButton {
            text: qsTr("Programs (repos)")
        }
        TabButton {
            text: qsTr("Programs (AUR)")
        }
        TabButton {
            text: qsTr("/etc/skel-folder")
        }
        TabButton {
            text: qsTr("lsb-release")
        }
        TabButton {
            text: qsTr("Slideshow")
        }
        TabButton {
            text: qsTr("Summary")
        }
    }
}
