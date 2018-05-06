import QtQuick 2.4

Page6Form {
    selectslideshowbtn {
        onClicked: {
            slideshowopendialog.open();
        }
    }

    slideshowopendialog {
        onAccepted: {
            var oldpath = slideshowopendialog.folder.toString();
            var path = oldpath.replace(/^(file:\/{2})/,"");
            slideshowselection.text = path;
        }
    }
}
