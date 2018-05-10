import QtQuick 2.4

Page7Form {

    function displaysummary(settings) {
        summarytext.text = qsTr("Packages that need to be installed: selected packages
Packages from the AUR: \n") + settings.aur.join("\n") + qsTr("
/etc/skel-folder: ") + settings.skelfolder.summary + qsTr("
Name of the distribution: ") + settings.lsbrelease.name + qsTr("
Description of the Distribution: ") + settings.lsbrelease.description + qsTr("
First version of the Distribution: ") + settings.lsbrelease.version + qsTr("
First codename of the Distribution: ") + settings.lsbrelease.codename + qsTr("
Slideshow-folder: ") + settings.slideshow.summary;
        scriptdialog.generatescript(settings);
    }

    generatebtn {
        onClicked: {
            scriptdialog.open();
        }
    }
}
