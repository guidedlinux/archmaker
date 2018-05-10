#include <QGuiApplication>
#include <QTranslator>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "include/fileoperations.h"
#include "include/terminallauncher.h"
#include "include/alpmutils.h"

int main(int argc, char *argv[]) {
    FileOperations fileOperations;
    TerminalLauncher terminalLauncher;
    alpmUtils _alpmUtils;

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QTranslator qtTranslator;
    qtTranslator.load("ArchMaker_" + QLocale::system().name(), ":/translations/");
    app.installTranslator(&qtTranslator);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));

    engine.rootContext()->setContextProperty("fileOperations", &fileOperations);
    engine.rootContext()->setContextProperty("terminalLauncher", &terminalLauncher);
    engine.rootContext()->setContextProperty("alpmUtils", &_alpmUtils);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
