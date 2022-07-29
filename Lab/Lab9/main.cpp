#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QStringList>
#include <qqmlcontext.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>
#include "infor.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QList<QObject*> listObject;
    listObject.append(new Infor("Nguyen Van An", "FX_0123", "1/3/2000", "AnNV_FUNIX_0123@funix.edu.vn", 123456789, "Ha Noi", 7.1));
    listObject.append(new Infor("Hoang Tan Minh", "FX_0214", "15/6/2000", "MinhHT_FUNIX_0214@funix.edu.vn", 1234566666, "Ho Chi Minh", 8.4));
    listObject.append(new Infor("Tran Minh Ha", "FX_0412", "14/2/2000", "HaTM_FUNIX_0412@funix.edu.vn", 11112222, "Can Tho", 6.5));

    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    QQmlContext *ctxt = view.rootContext();
    ctxt->setContextProperty("myModel", QVariant::fromValue(listObject));

//    const QUrl url(QStringLiteral("qrc:/main.qml"));
//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    engine.load(url);

    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return app.exec();
}
