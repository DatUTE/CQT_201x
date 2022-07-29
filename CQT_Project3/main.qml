import QtQuick 2.6
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.8

ApplicationWindow {
    visible: true
    width: 1360
    height: 768
    //visibility: "FullScreen"
    title: qsTr("Media Player")
    property int checkNext: 0
    //Backgroud of Application
    Image {
        id: backgroud
        anchors.fill: parent
        source: "qrc:/Image/background.png"
    }
    //Header
    Image {
        id: headerItem
        width: 1360
        height: 90
        source: "qrc:/Image/title.png"
        Text {
            id: headerTitleText
            text: qsTr("Media Player")
            anchors.centerIn: headerItem
            color: "white"
            font.pixelSize: 46
        }
    }
    //Playlist
    Image {
        id: playList_bg
        width: 420
        anchors.top: headerItem.bottom
        anchors.bottom: parent.bottom
        source: "qrc:/Image/playlist.png"
        opacity: 0.2
    }
    ListView {
        id: mediaPlaylist
        anchors.fill: playList_bg
        model: m_playlistModel
        clip: true
        spacing: 2
        currentIndex: 0
        delegate: MouseArea {
            property variant myData: model
            implicitWidth: playlistItem.width
            implicitHeight: playlistItem.height
            Image {
                id: playlistItem
                width: 675
                height: 193
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
                m_QMediaPlaylist.currentIndex = mediaPlaylist.currentIndex = index
            }

            onPressed: {
                playlistItem.source = "qrc:/Image/hold.png"
            }
            onReleased: {
                playlistItem.source = "qrc:/Image/playlist.png"
            }
            onCanceled: {
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
        onCurrentItemChanged: {
            album_art_view.currentIndex= currentIndex
            positionViewAtIndex(currentIndex, ListView.Contain)
        }

    }
    //Media Info
    Text {
        id: audioTitle
        anchors{
            top: headerItem.bottom
            topMargin: 20
            left: mediaPlaylist.right
            leftMargin: 20
        }
        text: mediaPlaylist.currentItem.myData.title
        color: "white"
        font.pixelSize: 20
        onTextChanged: {
            textChangeAni.targets = [audioTitle,audioSinger]
            textChangeAni.restart()
        }
    }
    Text {
        id: audioSinger
        anchors{
            top: audioTitle.bottom
            left: mediaPlaylist.right
            leftMargin: 20
        }
        text: mediaPlaylist.currentItem.myData.singer
        color: "white"
        font.pixelSize: 20
    }

    NumberAnimation {
        id: textChangeAni
        property: "opacity"
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }
    Text {
        id: audioCount
        anchors{
            top: headerItem.bottom
            topMargin: 20
            right: parent.right
            rightMargin: 20
        }
        text: mediaPlaylist.count
        color: "white"
        font.pixelSize: 36
    }
    Image {
        anchors{
            top: headerItem.bottom
            topMargin: 23
            right: audioCount.left
            rightMargin: 10
        }
        source: "qrc:/Image/music.png"
    }

    Component {
        id: appDelegate
        Item {
            width: 300; height: 300
            scale: PathView.iconScale
            Image {
                id: myIcon
                width: parent.width
                height: parent.height
                y: 20
                anchors.horizontalCenter: parent.horizontalCenter
                source: albumArt
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    album_art_view.currentIndex = index
                    m_QMediaPlaylist.currentIndex = index
                }
            }
        }
    }

    PathView {
        id: album_art_view
        anchors{
            left: mediaPlaylist.right
            leftMargin: 50
            top: headerItem.bottom
            topMargin: 150
        }
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: m_playlistModel
        delegate: appDelegate
        pathItemCount: 3
        path: Path {
            startX: 10
            startY: 50
            PathAttribute { name: "iconScale"; value: 0.5 }
            PathLine { x: 350; y: 50 }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathLine { x: 800; y: 50 }
            PathAttribute { name: "iconScale"; value: 0.5 }
        }
        onCurrentIndexChanged: {
            mediaPlaylist.currentIndex= currentIndex
        }
    }
    //Progress
    Text {
        id: currentTime
        anchors{
            bottom: parent.bottom
            bottomMargin: 205
            left: mediaPlaylist.right
            leftMargin: 50
        }
        text: Player.getTimeInfo(m_QMediaPlayer.position)
        color: "white"
        font.pixelSize: 24
    }
    Slider{
        id: progressBar
        width: 600
        anchors{
            bottom: parent.bottom
            bottomMargin: 200
            left: currentTime.right
            leftMargin: 20
        }
        from: 0
        to: m_QMediaPlayer.duration
        value: m_QMediaPlayer.position
        background: Rectangle {
            x: progressBar.leftPadding
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: progressBar.availableWidth
            height: implicitHeight
            radius: 2
            color: "gray"

            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: parent.height
                color: "white"
                radius: 2
            }
        }
        handle: Image {
            anchors.verticalCenter: parent.verticalCenter
            x: progressBar.leftPadding + progressBar.visualPosition * (progressBar.availableWidth - width)
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            source: "qrc:/Image/point.png"
            Image {
                anchors.centerIn: parent
                source: "qrc:/Image/center_point.png"
            }
        }
        onMoved: {
            m_QMediaPlayer.setPosition(progressBar.value)
        }
    }
    Text {
        id: totalTime
        anchors{
            bottom: parent.bottom
            bottomMargin: 205
            left: progressBar.right
            leftMargin: 20
        }
        text: Player.getTimeInfo(m_QMediaPlayer.duration)
        color: "white"
        font.pixelSize: 24
    }
    //Media control
    SwitchButton {
        id: shuffer
        anchors{
            bottom: parent.bottom
            bottomMargin: 100
            left: mediaPlaylist.right
            leftMargin: 80
        }
        icon_off: "qrc:/Image/shuffle.png"
        icon_on: "qrc:/Image/shuffle-1.png"
        status: m_QMediaPlaylist.playbackMode === Playlist.Random ? 1 : 0
        onClicked: {
            m_QMediaPlaylist.playbackMode = m_QMediaPlaylist.playbackMode === Playlist.Random ? Playlist.Sequential : Playlist.Random

        }
    }
    ButtonControl {
        id: prev
        anchors{
            bottom: parent.bottom
            bottomMargin: 100
            left: shuffer.right
            leftMargin: 120
        }
        icon_default: "qrc:/Image/prev.png"
        icon_pressed: "qrc:/Image/hold-prev.png"
        icon_released: "qrc:/Image/prev.png"       
        onClicked: {
            m_QMediaPlaylist.previous();
        }
    }
    ButtonControl {
        id: play
        anchors.verticalCenter: prev.verticalCenter
        anchors.left: prev.right
        icon_default: m_QMediaPlayer.state === MediaPlayer.PlayingState ?  "qrc:/Image/pause.png" : "qrc:/Image/play.png"
        icon_pressed: m_QMediaPlayer.state === MediaPlayer.PlayingState ?  "qrc:/Image/hold-pause.png" : "qrc:/Image/hold-play.png"
        icon_released: m_QMediaPlayer.state === MediaPlayer.PlayingState ?  "qrc:/Image/play.png" : "qrc:/Image/pause.png"
        onClicked: {
            m_QMediaPlayer.state === MediaPlayer.PlayingState ?  m_QMediaPlayer.pause() : m_QMediaPlayer.play()
        }
        Connections {
            target: m_QMediaPlayer
            onStateChanged:{
                play.source = m_QMediaPlayer.state === MediaPlayer.PlayingState ? "qrc:/Image/pause.png" : "qrc:/Image/play.png"
            }
        }
    }
    ButtonControl {
        id: next
        anchors{
            bottom: parent.bottom
            bottomMargin: 100
            left: play.right
        }
        icon_default: "qrc:/Image/next.png"
        icon_pressed: "qrc:/Image/hold-next.png"
        icon_released: "qrc:/Image/next.png"
        onClicked: {
            m_QMediaPlaylist.next();
            if (m_QMediaPlaylist.currentIndex == mediaPlaylist.count -1 )
            {
                checkNext = 1;
            }
            else{
                checkNext = 0;
            }
            console.log("check:" + checkNext )
        }
    }
    SwitchButton {
        id: repeater
        anchors{
            bottom: parent.bottom
            bottomMargin: 100
            left: next.right
            leftMargin: 100
        }
        icon_on: "qrc:/Image/repeat1_hold.png"
        icon_off: "qrc:/Image/repeat.png"
        status: m_QMediaPlaylist.playbackMode === Playlist.CurrentItemInLoop ? 1 : 0
        onClicked: {
            repeater.status = !repeater.status
        }
    }
    Connections{
        target: m_QMediaPlaylist
        onCurrentIndexChanged: {
            console.log("QMediaPlaylist.currentIndex: " + m_QMediaPlaylist.currentIndex)
            console.log("repeat status " + repeater.status)
            if(repeater.status == 1){
                if(m_QMediaPlaylist.currentIndex<0 && checkNext == 1)
                {
                     mediaPlaylist.currentIndex=m_QMediaPlaylist.currentIndex= 0;
                }
                else if(m_QMediaPlaylist.currentIndex<0)
                {
                    mediaPlaylist.currentIndex=m_QMediaPlaylist.currentIndex= mediaPlaylist.count -1;
                }

                else{
                    mediaPlaylist.currentIndex = m_QMediaPlaylist.currentIndex;
                }
            }else{
                if(m_QMediaPlaylist.currentIndex<0)
                {
                    mediaPlaylist.currentIndex=m_QMediaPlaylist.currentIndex= 0;
                }
                else{
                    mediaPlaylist.currentIndex = m_QMediaPlaylist.currentIndex;
                }
                if(m_QMediaPlayer.state != MediaPlayer.PlayingState){
                    m_QMediaPlayer.play()
                }
            }
        }
    }
    Connections{
        target: m_QMediaPlayer
        onCurrentIndexChanged:
        {
            console.log("m_player.onPositionChange: " +m_QMediaPlayer.position)
            if(repeater.status === 1 && m_QMediaPlayer.position >= m_QMediaPlayer.duration )
            {
                m_QMediaPlayer.setPosition(0);
                m_QMediaPlayer.play();
            }
        }
    }
}
