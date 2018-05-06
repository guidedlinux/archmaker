import QtQuick 2.4

AURDialogForm {
    function searchPkgs() {
        searchresults.clear();
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var myArr = JSON.parse(xmlhttp.responseText);
                if (myArr["type"] === "search") {
                    myArr["results"].forEach(function(element) {
                        searchresults.append({
                                                 name: element["Name"],
                                                 pkgid: element["ID"],
                                                 url: "https://aur.archlinux.org" + element["URLPath"],
                                                 description: element["Description"]
                                             });
                    });
                }
            }
        };
        xmlhttp.open("GET", "https://aur.archlinux.org/rpc/?v=5&type=search&arg=" + searchinput.text, true);
        xmlhttp.send();
        searchinput.clear();
    }

    searchpkg {
        onClicked: searchPkgs()
    }

    searchinput {
        onAccepted: searchPkgs()
    }

    selectpkg {
        onClicked: {
            if (searchresultslist.currentItem != null) {
                thisdialog.done(searchresults.get(searchresultslist.currentIndex).pkgid);
            } else {
                thisdialog.done(-1);
            }
        }
    }
}
