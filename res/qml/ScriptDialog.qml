import QtQuick 2.4

ScriptDialogForm {
    property var currentsettings: ({});
    property string generatedscript: "";

    function writeFile(fileUrl, content) {
        var savereq = new XMLHttpRequest();
        savereq.open("PUT", fileUrl, false);
        savereq.send(content);
        return savereq.status;
    }

    backbtn {
        onClicked: {
            thisdialog.close();
        }
    }

    function generatescript(settings) {
        currentsettings = settings;
        var resourcerequest = new XMLHttpRequest();
        resourcerequest.open("GET", "/script/scripttemplate.sh", true);
        resourcerequest.onreadystatechange = function() {
            if (resourcerequest.readyState == 4) {
                var scripttext = resourcerequest.responseText;
                scripttext = scripttext.replace(/DISTNAME/g, settings.lsbrelease.name);
                scripttext = scripttext.replace("DISTDESCR", settings.lsbrelease.description);
                if (settings.services.length > 0) {
                    var logintext = "sudo ln -s /usr/lib/systemd/system/" + settings.services[0] + ".service ./workingdir/airootfs/etc/systemd/system/display-manager.service
  sudo sed -i \"s/multi-user.target/graphical.target/g\" ./workingdir/airootfs/root/customize_airootfs.sh";
                    scripttext = scripttext.replace("GUILOGIN", logintext);
                } else {
                    scripttext = scripttext.replace("GUILOGIN", "");
                }

                generatedscript = scripttext;
            }
        };
        resourcerequest.send();
    }

    closebtn {
        onClicked: {
            Qt.quit();
        }
    }

    savebtn {
        onClicked: {
            savefolderdialog.open();
        }
    }

    runbtn {
        onClicked: {
            terminalLauncher.launchterminal("./generateiso.sh " + currentsettings.lsbrelease.version + " " + currentsettings.lsbrelease.codename,
                                            savefolderdialog.folder.toString().replace(/^(file:\/{2})/,""));
        }
    }

    savefolderdialog {
        onAccepted: {
            writeFile(savefolderdialog.folder + "/generateiso.sh", generatedscript);
            writeFile(savefolderdialog.folder + "/packages", currentsettings.pkgs.join("\n"));
            writeFile(savefolderdialog.folder + "/aurpackages", currentsettings.aur.join("\n"));

            if (currentsettings.skelfolder.option == 1) {
                fileOperations.copyfolder(currentsettings.skelfolder.path,
                                          savefolderdialog.folder.toString().replace(/^(file:\/{2})/,"") + "/skeldata/");
            } else if (currentsettings.skelfolder.option == 2) {
                fileOperations.createdir(savefolderdialog.folder.toString().replace(/^(file:\/{2})/,"") + "/skeldata");
                fileOperations.copyfolder(fileOperations.getHomeFolder() + "/.config",
                                          savefolderdialog.folder.toString().replace(/^(file:\/{2})/,"") + "/skeldata/.config/");
            } else {
                fileOperations.createdir(savefolderdialog.folder.toString().replace(/^(file:\/{2})/,"") + "/skeldata");
            }


            if (currentsettings.slideshow.option) {
                fileOperations.copyfolder(currentsettings.slideshow.path,
                                          savefolderdialog.folder.toString().replace(/^(file:\/{2})/,"") + "/calamaresslides/");
            } else {
                fileOperations.copyfolder("/usr/share/archmaker/default-slideshow",
                                          savefolderdialog.folder.toString().replace(/^(file:\/{2})/,"") + "/calamaresslides/");
            }

            fileOperations.chmodScript(savefolderdialog.folder.toString().replace(/^(file:\/{2})/,"") + "/generateiso.sh");

            runbtn.enabled = true;
        }
    }
}
