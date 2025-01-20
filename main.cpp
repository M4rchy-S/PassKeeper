#include <QGuiApplication>
#include <QQmlApplicationEngine>


#include "PassSafer.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<PassSafer>("com.ics.keeper", 1, 0, "PassSafer");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("PassKeeper", "Main");

    return app.exec();
}
