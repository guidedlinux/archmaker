import QtQuick 2.4

Page2Form {
    swipeView.onCurrentItemChanged: {
        for (var i = 0; i < 8; i++) {
            swipeView.itemAt(i).visible = false;
        }

        swipeView.currentItem.visible = true;
    }

    editmanuallybtn {
        onClicked: {
            packagesDialog.open();
        }
    }

    usepkgsbtn {
        onClicked: {
            packagesDialog.programstextarea.text = alpmUtils.getpkgs();
        }
    }
}
