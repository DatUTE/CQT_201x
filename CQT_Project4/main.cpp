#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "player.h"
#include <QQmlContext>
#include "playlistmodel.h"
#include "translation.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qRegisterMetaType<QMediaPlaylist*>("QMediaPlaylist*");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Translation translator(&app);
    translator.setCurrentLanguage("us");
    Player myPlayer;

    engine.rootContext()->setContextProperty("Player", &myPlayer);
    engine.rootContext()->setContextProperty("m_QMediaPlayer", myPlayer.m_player);
    engine.rootContext()->setContextProperty("m_playlistModel", myPlayer.m_playlistModel);
    engine.rootContext()->setContextProperty("m_QMediaPlaylist", myPlayer.m_playlist);
    engine.rootContext()->setContextProperty("translator",&translator);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
