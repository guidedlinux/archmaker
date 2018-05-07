#ifndef ALPMUTILS_H
#define ALPMUTILS_H

#include <QObject>
#include <iostream>
#include <alpm.h>
#include <alpm_list.h>


class alpmUtils : public QObject {
    Q_OBJECT

public slots:
    QString getpkgs() {
        std::string installedpackages = "";
        alpm_handle_t *handle = NULL;
        alpm_db_t *db = NULL;
        alpm_list_t *i;
        alpm_errno_t err;

        handle = alpm_initialize("/", "/var/lib/pacman", &err);
        if (!handle) {
            std::cerr << "Error: Cannot initialize ALPM!" << std::endl;
            return "";
        }

        db = alpm_get_localdb(handle);
        if (db == NULL) {
            std::cerr << "Error: Could not register 'local' database" << std::endl;
            return "";
        }

        alpm_list_t *list = alpm_db_get_pkgcache(db);

        for(i = list; i; i = alpm_list_next(i)) {
            const char *pkgname = alpm_pkg_get_name(static_cast<alpm_pkg_t*>(i->data));
            installedpackages = installedpackages + pkgname + "\n";
        }

        return QString::fromStdString(installedpackages);
    }

public:
    explicit alpmUtils() { }
};

#endif // ALPMUTILS_H
