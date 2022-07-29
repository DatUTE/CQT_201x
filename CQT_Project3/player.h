#ifndef PLAYER_H
#define PLAYER_H

#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <tag.h>
#include <fileref.h>
#include <id3v2tag.h>
#include <mpegfile.h>
#include <id3v2frame.h>
#include <id3v2header.h>
#include <attachedpictureframe.h>

QT_BEGIN_NAMESPACE
class QAbstractItemView;
class QMediaPlayer;
QT_END_NAMESPACE

class PlaylistModel;

using namespace TagLib;

class Player : public QObject
{
    Q_OBJECT //quan ly signal va slot
public:
    explicit Player(QObject *parent = nullptr);
    void addToPlaylist(const QList<QUrl> &urls);

public slots:
    void open();
    QString getTimeInfo(qint64 currentInfo);

public:
    //Q_INVOKABLE
    QString getAlbumArt(TagLib::MPEG::File* mpegFile);
    QMediaPlayer *m_player = nullptr;
    QMediaPlaylist *m_playlist = nullptr;
    PlaylistModel *m_playlistModel = nullptr;

};

#endif // PLAYER_H
