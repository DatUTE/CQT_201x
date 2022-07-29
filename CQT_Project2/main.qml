import QtQuick 2.6
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.8

ApplicationWindow {
    id: root
    visible: true
    width: 1360
    height: 768
    title: qsTr("Media Player")
    property int temp: 0
    //contain currentIndex, use to next and prev
    property var list: []
    //Progress
    function str_pad_left(string,pad,length) {
        return (new Array(length+1).join(pad)+string).slice(-length);
    }

    function getTime(time){
        time = time/1000
        var minutes = Math.floor(time / 60);
        var seconds = Math.floor(time - minutes * 60);

        return str_pad_left(minutes,'0',2)+':'+str_pad_left(seconds,'0',2);
    }
    // get random a number from min to max -1 ( 0, 1, 2)
    function getRandom(min, max){
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }
    //AppModel
    ListModel {
        id: appModel
        ListElement { title: "Phố Không Mùa"; singer: "Bùi Anh Tuấn" ; icon: "qrc:/Image/Bui-Anh-Tuan.png"; source: "qrc:/Music/Pho-Khong-Mua-Duong-Truong-Giang-ft-Bui-Anh-Tuan.mp3" }
        ListElement { title: "Chuyện Của Mùa Đông"; singer: "Hà Anh Tuấn" ; icon: "qrc:/Image/Ha-Anh-Tuan.png"; source: "qrc:/Music/Chuyen-Cua-Mua-Dong-Ha-Anh-Tuan.mp3"}
        ListElement { title: "Hongkong1"; singer: "Nguyễn Trọng Tài" ; icon: "qrc:/Image/Hongkong1.png"; source: "qrc:/Music/Hongkong1-Official-Version-Nguyen-Trong-Tai-San-Ji-Double-X.mp3" }
    }

    //MediaPlayer
    MediaPlayer{
        id: player
        property bool shuffer: false
        property bool repeat: false
        onPlaybackStateChanged: {
            if (playbackState == MediaPlayer.StoppedState && position == duration){
                if(player.repeat){
                    player.source = mediaPlaylist.currentItem.myData.source
                    player.play()
                }
                else{
                        if (player.shuffer) {
                            var newIndex = getRandom(0, appModel.count -1) //create a var get random number from 0 to 2
                            while (newIndex === mediaPlaylist.currentIndex) {
                                newIndex = getRandom(0, appModel.count -1)
                            }
                            mediaPlaylist.currentIndex = newIndex
                        } else if(mediaPlaylist.currentIndex < mediaPlaylist.count - 1) {
                            mediaPlaylist.currentIndex = mediaPlaylist.currentIndex + 1;
                        }
                    }
                }
            }
        autoPlay: true
    }
    //Backgroud of Application
    Image {
        id: backgroud
        anchors.fill: parent
        source: "qrc:/Image/background.png"
    }
    //Header
    Image{
        id:imageHeader
        width: 1360
        height: 90
        source: "Image/title.png"
        Text {
            id: header
            text: qsTr("Media Player")
            font.pixelSize: 40
            font.family: "Times New Roman"
            x:550; y:20
            color: "#ffffff"
        }
    }
    //Playlist
    Image{
        id:playList_bg
        width: 430
        height: 678
        source: "Image/playlist.png"
        anchors.top: imageHeader.bottom
    }
    ListView {
        id: mediaPlaylist
        anchors.fill: playList_bg
        model: appModel
        clip: true
        spacing: 2
        currentIndex: 0
        delegate: MouseArea {
            property variant myData: model
            implicitWidth: playlistItem.width
            height: 150
            Image {
                id: playlistItem
                width: 675
                height: 150
                source: "qrc:/Image/playlist_item.png"
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
               mediaPlaylist.currentIndex = index
                console.log("name: "+index)
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
            album_art_view.currentIndex = currentIndex
            player.source = mediaPlaylist.currentItem.myData.source;
            player.play();
        }
    }
    //Media Info
    Text {
        id: audioTitle
        anchors.top: imageHeader.bottom
        anchors.topMargin: 20
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 20
        text: mediaPlaylist.currentItem.myData.title
        color: "white"
        font.pixelSize: 25
        onTextChanged: {
            textChangeAni.targets = [audioTitle,audioSinger]
            textChangeAni.restart()
        }
    }
    Text {
        id: audioSinger
        anchors.top: audioTitle.bottom
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 20
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
    // count song in listmodel
    Text {
        id: audioCount
        anchors.top: imageHeader.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        text: appModel.count
        color: "white"
        font.pixelSize: 25
    }
    Image {
        anchors.top: imageHeader.bottom
        anchors.topMargin: 23
        anchors.right: audioCount.left
        anchors.rightMargin: 10
        source: "qrc:/Image/music.png"
    }

    Component {
        id: appDelegate
        Item {
            width: 250; height: 250
            scale: PathView.iconScale
            Image {
                id: myIcon
                width: parent.width
                height: parent.height
                y: 20; anchors.horizontalCenter: parent.horizontalCenter
                source: icon
            }

            MouseArea {
                anchors.fill: parent
                onClicked: album_art_view.currentIndex = index
            }
        }
    }

    PathView {
        id: album_art_view
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 80
        anchors.top: imageHeader.bottom
        anchors.topMargin: 150
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: appModel
        delegate: appDelegate
        path: Path {
            startX: 10
            startY: 50
            PathAttribute { name: "iconScale"; value: 0.5 }
            PathLine { x: 350; y: 50 }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathLine { x: 700; y: 50 }
            PathAttribute { name: "iconScale"; value: 0.5 }
        }
        onCurrentIndexChanged: {
            mediaPlaylist.currentIndex = currentIndex
            player.source = mediaPlaylist.currentItem.myData.source
            player.play()
        }
    }
    Text {
        id: currentTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 210
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 50
        text: getTime(player.position)
        color: "white"
        font.pixelSize: 20
    }
    Slider{
        id: progressBar
        width: 600
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 200
        anchors.left: currentTime.right
        anchors.leftMargin: 20
        from: 0
        to: player.duration
        value: player.position
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
            if (player.seekable){
                player.seek(progressBar.value)
            }
        }
    }
    Text {
        id: totalTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 210
        anchors.left: progressBar.right
        anchors.leftMargin: 20
        text: getTime(player.duration)
        color: "white"
        font.pixelSize: 20
    }
    //Media control
    SwitchButton {
        id: shufferID
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 70
        icon_off: "qrc:/Image/shuffle.png"
        icon_on: "qrc:/Image/shuffle-1.png"
        status: player.shuffer
        onClicked: {
            player.shuffer = !player.shuffer
        }
    }
    ButtonControl {
        id: prev
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.left: shufferID.right
        anchors.leftMargin: 120
        icon_default: "qrc:/Image/prev.png"
        icon_pressed: "qrc:/Image/hold-prev.png"
        icon_released: "qrc:/Image/prev.png"
        onClicked: {
            if(list.length !=0 && list.length>1 ){
                list.pop()
                mediaPlaylist.currentIndex=list[list.length-1]
            }else{
                if(mediaPlaylist.currentIndex==0){
                    mediaPlaylist.currentIndex=mediaPlaylist.count - 1
                }else{
                    mediaPlaylist.currentIndex=mediaPlaylist.currentIndex-1
                }
            }

            player.source = mediaPlaylist.currentItem.myData.source;
            player.play();
        }

    }
    ButtonControl {
        id: play
        anchors.verticalCenter: prev.verticalCenter
        anchors.left: prev.right
        icon_default: player.playbackState == MediaPlayer.PlayingState ?  "qrc:/Image/pause.png" : "qrc:/Image/play.png"
        icon_pressed: player.playbackState == MediaPlayer.PlayingState ?  "qrc:/Image/hold-pause.png" : "qrc:/Image/hold-play.png"
        icon_released: player.playbackState== MediaPlayer.PlayingState ?  "qrc:/Image/play.png" : "qrc:/Image/pause.png"
        onClicked: {
            player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
        }
        Connections {
            target: player
            onPlaybackStateChanged:{
                if(player.playbackState == MediaPlayer.PlayingState){
                    play.source = "qrc:/Image/pause.png"
                }
            }
        }
    }
    ButtonControl {
        id: next
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.left: play.right
        icon_default: "qrc:/Image/next.png"
        icon_pressed: "qrc:/Image/hold-next.png"
        icon_released: "qrc:/Image/next.png"
        onClicked: {
            if (player.shuffer) {
                do{
                    temp = getRandom(0, appModel.count-1)
                }while(mediaPlaylist.currentIndex == temp)
                mediaPlaylist.currentIndex = temp
            }
            else  {
                if(mediaPlaylist.currentIndex < mediaPlaylist.count - 1 ){
                    mediaPlaylist.currentIndex +=1
                }
                else{
                    mediaPlaylist.currentIndex = 0
                }
            }
            list.push(mediaPlaylist.currentIndex) // push currentIndex on the list
            player.source = mediaPlaylist.currentItem.myData.source
            player.play()
        }
    }
    SwitchButton {
        id: repeater
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.left: next.right
        anchors.leftMargin: 100
        icon_on: "qrc:/Image/repeat1_hold.png"
        icon_off: "qrc:/Image/repeat.png"
        status: player.repeat
        onClicked:
        {
            player.repeat = !player.repeat
        }
    }
}

