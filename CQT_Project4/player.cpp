
#include "player.h"

#include "playlistmodel.h"

#include <QMediaService>
#include <QMediaPlaylist>
#include <QMediaMetaData>
#include <QObject>
#include <QFileInfo>
#include <QTime>
#include <QDir>
#include <QStandardPaths>

Player::Player(QObject *parent)
    : QObject(parent)
{
    m_player = new QMediaPlayer(this);
    m_playlist = new QMediaPlaylist(this);
    m_player->setPlaylist(m_playlist);
    m_playlistModel = new PlaylistModel(this);
    open();
    //m_player->play();
    if (!m_playlist->isEmpty()) {
        m_playlist->setCurrentIndex(0);
    }
}

void Player::open()
{
    QDir directory(QStandardPaths::standardLocations(QStandardPaths::MusicLocation)[0]);
    QFileInfoList musics = directory.entryInfoList(QStringList() << "*.mp3",QDir::Files);
    QList<QUrl> urls;
    for (int i = 0; i < musics.length(); i++){
        urls.append(QUrl::fromLocalFile(musics[i].absoluteFilePath()));
    }
    addToPlaylist(urls);
}

void Player::addToPlaylist(const QList<QUrl> &urls)
{
    for (auto &url: urls) {
        m_playlist->addMedia(url);
        FileRef f(url.path().toStdString().erase(0,1).c_str());
        Tag *tag = f.tag();
        Song song(QString::fromWCharArray(tag->title().toCWString()),
                  QString::fromWCharArray(tag->artist().toCWString()),url.toDisplayString(),
                  getAlbumArt(dynamic_cast<MPEG::File*>(f.file())));
        m_playlistModel->addSong(song);
    }
}

void Player::setShuffleMode(bool shuffer,bool repeat)
{
    qDebug() << "status shuffer: " << shuffer << "status repeat: " << repeat ;
    if(repeat)
    {
        m_playlist->setPlaybackMode(QMediaPlaylist::PlaybackMode::CurrentItemInLoop);
    }
    else{
        if(shuffer)
        {
            m_playlist->setPlaybackMode(QMediaPlaylist::PlaybackMode::Random);
        }
        else{
            m_playlist->setPlaybackMode(QMediaPlaylist::PlaybackMode::Sequential);
        }
    }
}

void Player::setRepeatMode(bool shuffer,bool repeat)
{
    qDebug() << "status shuffer: " << shuffer << "status repeat: " << repeat ;
    if(repeat)
    {
        m_playlist->setPlaybackMode(QMediaPlaylist::PlaybackMode::CurrentItemInLoop);
    }
    else{
        if(shuffer)
        {
            m_playlist->setPlaybackMode(QMediaPlaylist::PlaybackMode::Random);
        }
        else{
            m_playlist->setPlaybackMode(QMediaPlaylist::PlaybackMode::Sequential);
        }
    }
}

void Player::playNext(bool shuffer,bool repeat, int index)
{
    qDebug() << "status shuffer: " << shuffer << "status repeat: " << repeat ;
    if(shuffer)
    {
        m_playlist->setPlaybackMode(QMediaPlaylist::PlaybackMode::Random);
        if(m_playlist->currentIndex() == index)
        {
            m_playlist->next();
        }
    }
    else{
        m_playlist->setPlaybackMode(QMediaPlaylist::PlaybackMode::Sequential);
    }
    m_playlist->next();
}

void Player::playPrevious(bool shuffer,bool repeat, int index)
{
    qDebug() << "status shuffer: " << shuffer << "status repeat: " << repeat ;
    if(m_playlist->currentIndex() < 0)
    {
        m_playlist->setCurrentIndex(m_playlistModel->rowCount());
    }
    if(shuffer)
    {
        m_playlist->setPlaybackMode(QMediaPlaylist::PlaybackMode::Random);
        if(m_playlist->currentIndex() == index)
        {
            m_playlist->previousIndex();
        }
    }
    else{
        m_playlist->setPlaybackMode(QMediaPlaylist::PlaybackMode::Sequential);
    }
    m_playlist->previous();
}

QString Player::getTimeInfo(qint64 currentInfo)
{
    QString tStr = "00:00";
    currentInfo = currentInfo/1000;
    qint64 durarion = m_player->duration()/1000;
    if (currentInfo || durarion) {
        QTime currentTime((currentInfo / 3600) % 60, (currentInfo / 60) % 60,
                          currentInfo % 60, (currentInfo * 1000) % 1000);
        QTime totalTime((durarion / 3600) % 60, (m_player->duration() / 60) % 60,
                        durarion % 60, (m_player->duration() * 1000) % 1000);
        QString format = "mm:ss";
        if (durarion > 3600)
            format = "hh::mm:ss";
        tStr = currentTime.toString(format);
    }
    return tStr;
}

QString Player::getAlbumArt(MPEG::File* mpegFile)
{
    static const char *IdPicture = "APIC" ;
    TagLib::ID3v2::Tag *id3v2tag = mpegFile->ID3v2Tag();
    TagLib::ID3v2::FrameList Frame ;
    TagLib::ID3v2::AttachedPictureFrame *PicFrame ;
    void *SrcImage ;
    unsigned long Size ;

    auto name=mpegFile->name().toString()+ ".jpg";
    FILE *jpegFile;
    jpegFile = fopen(name.toCString(),"wb");

    if ( id3v2tag )
    {
        // picture frame
        Frame = id3v2tag->frameListMap()[IdPicture] ;
        if (!Frame.isEmpty() )
        {
            for(TagLib::ID3v2::FrameList::ConstIterator it = Frame.begin(); it != Frame.end(); ++it)
            {
                PicFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame*>(*it) ;
                //  if ( PicFrame->type() ==
                //TagLib::ID3v2::AttachedPictureFrame::FrontCover)
                {
                    // extract image (in it’s compressed form)
                    Size = PicFrame->picture().size() ;
                    SrcImage = malloc ( Size ) ;
                    if ( SrcImage )
                    {
                        memcpy ( SrcImage, PicFrame->picture().data(), Size ) ;
                        fwrite(SrcImage,Size,1, jpegFile);
                        fclose(jpegFile);
                        free( SrcImage ) ;
                        return QUrl::fromLocalFile(name.toCString()).toDisplayString();
                    }

                }
            }
        }
    }
    else
    {
        qDebug() <<"id3v2 not present";
        return "qrc:/Image/album_art.png";
    }
    return "qrc:/Image/album_art.png";
}
