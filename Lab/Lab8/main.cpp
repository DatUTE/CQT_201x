#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "lightcontroler.h"
#include "lightdisplay.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    LightControler obj1;
    LightDisplay obj2;

    QObject::connect(&obj1, SIGNAL(signalSendData(int, int)), &obj2, SLOT(slotReceivedData(int, int)));
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("Controler", &obj1);
    engine.rootContext()->setContextProperty("Display", &obj2);

    engine.load(url);

    return app.exec();
}
