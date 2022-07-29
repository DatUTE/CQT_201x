import QtQuick 2.6
import QtQuick.Controls 2.4

ApplicationWindow {
    visible: true
    width: 1360
    height: 768
   // visibility: "FullScreen"
    title: qsTr("Media Player")
    //Backgroud of Application
    Image {
        id: backgroud
        anchors.fill: parent
        source: "qrc:/Image/background.png"
    }
    //Header
    AppHeader{
        id: headerItem
        height: 141
        playlistButtonStatus: playlist.opened ? 1 : 0
        onClickPlaylistButton: {
            if (!playlist.opened) {
                playlist.open()
            } else {
                playlist.close()
            }
        }
    }
    //Playlist
    PlaylistView{
        id: playlist
        y: headerItem.height
        width: 400
        height: parent.height - headerItem.height
        listCurrentIndex: m_QMediaPlayer.playlist.currentIndex < 0 ? 0 : m_QMediaPlayer.playlist.currentIndex
    }

    //Media Info
    MediaInfoControl{
        id: mediaInfoControl
        anchors.top: headerItem.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: playlist.position*playlist.width
        anchors.bottom: parent.bottom
        listCurrentIndex: m_QMediaPlayer.playlist.currentIndex < 0 ? 0 : m_QMediaPlayer.playlist.currentIndex

    }
}
