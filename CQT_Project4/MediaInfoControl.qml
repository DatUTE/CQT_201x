import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.9
Item {
    property var aNumber: 0
    property int listCurrentIndex: 0
    Text {
        id: audioTitle
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: album_art_view.currentItem.myData.title
        color: "white"
        font.pixelSize: 20
        onTextChanged: {
            textChangeAni.targets = [audioTitle,audioSinger]
            textChangeAni.restart()
        }
    }
    Text {
        id: audioSinger
        anchors.top: audioTitle.bottom
        anchors.left: audioTitle.left
        text: album_art_view.currentItem.myData.singer
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
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        text: album_art_view.count
        color: "white"
        font.pixelSize: 20
    }
    Image {
        anchors.top: parent.top
        anchors.topMargin: 23
        anchors.right: audioCount.left
        anchors.rightMargin: 10
        source: "qrc:/Image/music.png"
    }

    Component {
        id: appDelegate
        Item {
            property variant myData: model
            width: 300; height: 300
            scale: PathView.iconScale
            Image {
                id: myIcon
                width: parent.width
                height: parent.height
                y: 20
                anchors.horizontalCenter: parent.horizontalCenter
                source: album_art
            }

            MouseArea {
                anchors.fill: parent
                onClicked:  m_QMediaPlayer.playlist.currentIndex = index
            }
        }
    }

    PathView {
        id: album_art_view
        anchors.left: parent.left
        anchors.leftMargin: (parent.width - 800)/2
        anchors.top: parent.top
        anchors.topMargin: 150
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: m_playlistModel
        delegate: appDelegate
        currentIndex: listCurrentIndex
        pathItemCount: 3
        path: Path {
            startX: 5
            startY: 50
            PathAttribute { name: "iconScale"; value: 0.7 }
            PathLine { x: 360; y: 50 }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathLine { x: 840; y: 50 }
            PathAttribute { name: "iconScale"; value: 0.7 }
        }
        onCurrentIndexChanged: {
            m_QMediaPlayer.playlist.currentIndex = listCurrentIndex
        }
    }
    //Progress
    Text {
        id: currentTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 165
        anchors.right: progressBar.left
        anchors.rightMargin: 20
        text:Player.getTimeInfo(m_QMediaPlayer.position)
        color: "white"
        font.pixelSize: 24
    }
    Slider{
        id: progressBar
        width: 600//1491 - 675*playlist.position
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 160
        anchors.horizontalCenter: parent.horizontalCenter
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
            if (m_QMediaPlayer.seekable){
                m_QMediaPlayer.setPosition(Math.floor(position*m_QMediaPlayer.duration))
            }
        }
    }
    Text {
        id: totalTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 165
        anchors.left: progressBar.right
        anchors.leftMargin: 20
        text: Player.getTimeInfo(m_QMediaPlayer.duration)
        color: "white"
        font.pixelSize: 24
    }
    //Media control
    SwitchButton {
        id: shuffer
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70
        anchors.left: currentTime.left
        icon_off: "qrc:/Image/shuffle.png"
        icon_on: "qrc:/Image/shuffle-1.png"
        status: m_QMediaPlayer.playlist.playbackMode === Playlist.Random ? 1 : 0
        onClicked: {
            status = !status
            Player.setShuffleMode(shuffer.status, repeater.status)
        }
    }
    ButtonControl {
        id: prev
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70
        anchors.right: play.left
        icon_default: "qrc:/Image/prev.png"
        icon_pressed: "qrc:/Image/hold-prev.png"
        icon_released: "qrc:/Image/prev.png"
        onClicked: {
            Player.playPrevious(shuffer.status, repeater.status, album_art_view.currentIndex);
        }
    }
    ButtonControl {
        id: play
        anchors.verticalCenter: prev.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        icon_default: m_QMediaPlayer.state == MediaPlayer.PlayingState ?  "qrc:/Image/pause.png" : "qrc:/Image/play.png"
        icon_pressed: m_QMediaPlayer.state == MediaPlayer.PlayingState ?  "qrc:/Image/hold-pause.png" : "qrc:/Image/hold-play.png"
        icon_released: m_QMediaPlayer.state== MediaPlayer.PlayingState ?  "qrc:/Image/pause.png" : "qrc:/Image/play.png"
        onClicked: {
            if (m_QMediaPlayer.state != MediaPlayer.PlayingState){
                m_QMediaPlayer.play()
            } else {
                m_QMediaPlayer.pause()
            }
        }
        Connections {
            target: m_QMediaPlayer
            onStateChanged:{
                play.source = m_QMediaPlayer.state == MediaPlayer.PlayingState ?  "qrc:/Image/pause.png" : "qrc:/Image/play.png"
            }
        }
    }
    ButtonControl {
        id: next
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70
        anchors.left: play.right
        icon_default: "qrc:/Image/next.png"
        icon_pressed: "qrc:/Image/hold-next.png"
        icon_released: "qrc:/Image/next.png"
        onClicked: {
            Player.playNext(shuffer.status, repeater.status, album_art_view.currentIndex);
        }
    }
    SwitchButton {
        id: repeater
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70
        anchors.right: totalTime.right
        icon_on: "qrc:/Image/repeat1_hold.png"
        icon_off: "qrc:/Image/repeat.png"
        status: m_QMediaPlayer.playlist.playbackMode === Playlist.Loop ? 1 : 0
        onClicked: {
            repeater.status = !repeater.status
            Player.setRepeatMode(shuffer.status, repeater.status)
        }
    }
    Connections{
        target: m_QMediaPlayer.playlist
        onCurrentIndexChanged: {
            console.log("index: "+index)
            if(index < 0 ){
                album_art_view.currentIndex =  0;
            }
            else
            {
                album_art_view.currentIndex = index;
            }
            if(m_QMediaPlayer.state != MediaPlayer.PlayingState)
            {
                m_QMediaPlayer.play()
            }
        }
    }
}
