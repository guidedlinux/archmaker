import QtQuick 2.4

Page7Form {

    function displaysummary(settings) {
        summarytext.text = "Packages that need to be installed: selected packages
Packages from the AUR: \n" + settings.aur.join("\n") + "
/etc/skel-folder: " + settings.skelfolder.summary + "
Name of the distribution: " + settings.lsbrelease.name + "
Description of the Distribution: " + settings.lsbrelease.description + "
First version of the Distribution: " + settings.lsbrelease.version + "
First codename of the Distribution: " + settings.lsbrelease.codename + "
Slideshow-folder: " + settings.slideshow.summary;
        scriptdialog.generatescript(settings);
    }

    generatebtn {
        onClicked: {
            scriptdialog.open();
        }
    }
}
