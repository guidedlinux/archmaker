import QtQuick 2.4

Page3Form {
    aurpkgslist {
    }
    addpkgbtn {
        onClicked: {
            aurdialog.open();
        }
    }
    removepkgbtn {
        onClicked: {
            aurpkgs.remove(aurpkgslist.currentIndex);
        }
    }

    aurdialog {
        onClosed: {
            if (aurdialog.result !== -1) {
                var dlgresult = aurdialog.searchresults.get(aurdialog.searchresultslist.currentIndex);
                aurpkgs.append({
                                   name: dlgresult.name,
                                   url: dlgresult.url
                               });
                aurdialog.searchresults.clear();
                aurdialog.searchresults.append({
                                                    name: "No search results.",
                                                    pkgid: -1,
                                                    url: "none",
                                                    description: ""
                                                });
            }
        }
    }
}
