#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "include/fileoperations.h"
#include "include/terminallauncher.h"

int main(int argc, char *argv[]) {
    FileOperations fileOperations;
    TerminalLauncher terminalLauncher;

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));

    engine.rootContext()->setContextProperty("fileOperations", &fileOperations);
    engine.rootContext()->setContextProperty("terminalLauncher", &terminalLauncher);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
