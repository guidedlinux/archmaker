#include "include/fileoperations.h"



extern "C" int cpy_file(const char*, const struct stat, int);
std::string dest_dir = "";
std::string source_dir = "";

static int cpy_file(const char* src_path, const struct stat* sb, int typeflag) {
    std::string src_pth_string = src_path;
    std::string new_path = "";
    if (src_pth_string.length() > source_dir.length()) {
        new_path = dest_dir + src_pth_string.substr(source_dir.length() + 1);

        switch (typeflag) {
            case FTW_D:
                mkdir(new_path.c_str(), sb->st_mode);
                break;
            case FTW_F:
                std::ifstream source(src_path, std::ios::binary);
                std::ofstream dest(new_path, std::ios::binary);
                dest << source.rdbuf();
        }
    }

    return 0;
}

bool FileOperations::copyfolder(const QString& source, const QString& destination) {
    dest_dir = destination.toUtf8().constData();
    mkdir(destination.toUtf8().constData(), S_IRWXU | S_IRWXG | S_IRWXO);
    source_dir = source.toUtf8().constData();
    ftw(source.toUtf8().constData(), cpy_file, 20);

    return true;
}

bool FileOperations::chmodScript(const QString &fileURL) {
    chmod(fileURL.toUtf8().constData(), S_IRWXU|S_IRGRP|S_IXGRP|S_IROTH);

    return true;
}

QString FileOperations::getHomeFolder() {
    struct passwd *pw = getpwuid(getuid());
    std::string homedir = pw->pw_dir;
    return QString::fromStdString(homedir);
}

bool FileOperations::createdir(const QString &foldername) {
    mkdir(foldername.toUtf8().constData(), S_IRWXU | S_IRWXG | S_IRWXO);

    return true;
}
