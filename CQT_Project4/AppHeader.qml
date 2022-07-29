import QtQuick 2.0

Item {
    property alias playlistButtonStatus:playlist_button.status
    signal clickPlaylistButton
    Image {
        id: headerItem
        source: "qrc:/Image/title.png"
        width: 1360
        SwitchButton {
            id: playlist_button
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            icon_off: "qrc:/Image/drawer.png"
            icon_on: "qrc:/Image/back.png"
            onClicked: {
                clickPlaylistButton()
            }
        }
        Text {
            anchors.left: playlist_button.right
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Playlist")+ translator.emptyString
            color: "white"
            font.pixelSize: 32
        }
        Text {
            id: headerTitleText
            text: qsTr("Media Player")+ translator.emptyString
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 46
        }
        Image {
            id: vn_flag
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            height: 50
            source: "qrc:/Image/vn.png"
            Rectangle{
                width: 50
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                border.color: "gray"
                border.width: 3
                color: "transparent"
                visible: translator.currentLanguage === "vn"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("!us_flag.visible: "+translator.currentLanguage)
                    console.log("us: "+ translator.emptyString)
                    translator.selectLanguage("vn")
                }
            }
        }
        Image {
            id: us_flag
            anchors.right: vn_flag.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            height: 50
            source: "qrc:/Image/us.png"
            Rectangle{
                width: 50
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                border.color: "gray"
                border.width: 3
                color: "transparent"
                visible: translator.currentLanguage === "us"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("us: "+ translator.currentLanguage)
                    translator.selectLanguage("us")
                }
            }
        }
//        Text {
//            id: langua
//            text: qsTr("VietNam") + translator.emptyString
//            color: "white"
//            font.pixelSize: 20
//            anchors.top: us_flag.bottom
//            anchors.topMargin: 10
//        }

    }
}
