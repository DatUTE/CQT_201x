#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include "playlistmodel.h"
#include "player.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Player myPlayer;
    engine.rootContext()->setContextProperty("Player", &myPlayer);
    engine.rootContext()->setContextProperty("m_QMediaPlayer", myPlayer.m_player);
    engine.rootContext()->setContextProperty("m_QMediaPlaylist", myPlayer.m_playlist);
    engine.rootContext()->setContextProperty("m_playlistModel", myPlayer.m_playlistModel);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
