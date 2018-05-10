#ifndef TERMINALLAUNCHER_H
#define TERMINALLAUNCHER_H

#include <QObject>
#include <QProcess>
#include <fstream>
#include <iostream>

class TerminalLauncher : public QObject {
    Q_OBJECT

public slots:
    bool launchterminal(const QString& scriptpath, const QString& workingdir) {
        QString launchcmd = "";
        if (std::ifstream("/usr/bin/xterm"))
            launchcmd = "/usr/bin/xterm -e \"cd '" + workingdir + "' && " + scriptpath + " 2>&1 | tee log\"";
        else {
            std::cout << "Cannot execute xterm!" << std::endl;
            return false;
        }
        QProcess proc;
        proc.start(launchcmd);
        proc.waitForStarted();
        proc.waitForFinished(-1);
        return true;
    }

public:
    explicit TerminalLauncher() { }
};

#endif // TERMINALLAUNCHER_H
