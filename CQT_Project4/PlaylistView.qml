import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1

Drawer {
    id: drawer
    property alias mediaPlaylist: mediaPlaylist
    property int countMedia: mediaPlaylist.count -1
    property int listCurrentIndex: 0
    interactive: false
    modal: false
    background: Rectangle {
        id: playList_bg
        anchors.fill: parent
        color: "transparent"
    }
    ListView {
        id: mediaPlaylist
        anchors.fill: parent
        model: m_playlistModel
        clip: true
        spacing: 2
        currentIndex: listCurrentIndex
        delegate: MouseArea {
            property variant myData: model
            implicitWidth: playlistItem.width
            implicitHeight: playlistItem.height
            Image {
                id: playlistItem
                width: 400
                height: 120
                source: "qrc:/Image/playlist.png"
                opacity: 0.5
            }
            Text {
                text: title
                anchors.fill: parent
                anchors.leftMargin: 70
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.pixelSize: 20
            }
            onClicked: {
                m_QMediaPlayer.playlist.currentIndex = index
            }

            onPressed: {
                playlistItem.source = "qrc:/Image/hold.png"
            }
            onReleased: {
                playlistItem.source = "qrc:/Image/playlist.png"
            }
            onCanceled:
            {
                playlistItem.source = "qrc:/Image/playlist.png"
            }
        }
        highlight: Image {
            source: "qrc:/Image/playlist_item.png"
            Image {
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/Image/playing.png"
            }
        }
        ScrollBar.vertical: ScrollBar {
            parent: mediaPlaylist.parent
            anchors.top: mediaPlaylist.top
            anchors.left: mediaPlaylist.right
            anchors.bottom: mediaPlaylist.bottom
        }
    }
    Connections{
        target: m_QMediaPlayer.playlist
        onCurrentIndexChanged: {
            if(index<0 ){
                mediaPlaylist.currentIndex = 0
            }else
                mediaPlaylist.currentIndex = index;
        }
    }
}
