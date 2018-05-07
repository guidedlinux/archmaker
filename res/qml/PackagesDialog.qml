import QtQuick 2.4

PackagesDialogForm {
    Component.onCompleted: {
        var programsrequest = new XMLHttpRequest();
        programsrequest.open("GET", "/script/standardprograms", false);
        programsrequest.send();
        programstextarea.text = programsrequest.responseText;
    }

    okbtn {
        onClicked: {
            thisdialog.close();
        }
    }
}
