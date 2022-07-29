
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
    Q_OBJECT
public:
    explicit Player(QObject *parent = nullptr);

    void addToPlaylist(const QList<QUrl> &urls);


public slots:
    void open();
    QString getTimeInfo(qint64 currentInfo);
    void setShuffleMode(bool shuffer,bool repeat);
    void setRepeatMode(bool shuffer,bool repeat);
    void playNext(bool shuffer,bool repeat,int index);
    void playPrevious(bool shuffer,bool repeat, int index);

public:
    QString getAlbumArt(MPEG::File*);

    QMediaPlayer *m_player = nullptr;
    QMediaPlaylist *m_playlist = nullptr;
    PlaylistModel *m_playlistModel = nullptr;
};

#endif // PLAYER_H
