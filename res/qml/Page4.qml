import QtQuick 2.4

Page4Form {
    selectfolderbtn {
        onClicked: {
            skelopendialog.open();
        }
    }

    skelopendialog {
        onAccepted: {
            var oldpath = skelopendialog.folder.toString();
            var path = oldpath.replace(/^(file:\/{2})/,"");
            skelfolderselection.text = path;
        }
    }
}
