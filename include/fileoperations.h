#ifndef FILEOPERATIONS_H
#define FILEOPERATIONS_H

#include <QObject>
#include <iostream>
#include <ftw.h>
#include <fstream>
#include <sys/stat.h>
#include <pwd.h>
#include <unistd.h>

class FileOperations : public QObject {
    Q_OBJECT

public slots:
    bool copyfolder(const QString& source, const QString& destination);

    bool chmodScript(const QString& fileURL);

    QString getHomeFolder();

    bool createdir(const QString &foldername);

public:
    explicit FileOperations() { }
};

#endif // FILEOPERATIONS_H
