import QtQuick 2.11
import QtQuick.Window 2.11
import QtQml 2.2
import QtQuick.Layouts 1.3
Window {
    id: root
    width: 640
    height: 520
    visible: true
    title: qsTr("Hello World")
    property bool click: false
    property int cnt: 0
    signal changeImage();
    Item {
        id: name
        anchors.fill: parent
        Image {
            id: img1
            width: 400
            height: 300
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "/Image/icon1.png"
            visible: true
        }
//        Image {
//            id: img2
//            width: 400
//            height: 300
//            anchors.top: parent.top
//            anchors.horizontalCenter: parent.horizontalCenter
//            source: "/Image/icon2.png"
//            visible: false
//        }
//        Image {
//            id: img3
//            width: 400
//            height: 400
//            anchors.top: parent.top
//            anchors.horizontalCenter: parent.horizontalCenter
//            source : "/Image/icon3.png"
//            visible: false
//        }
        Rectangle {
            width: 100
            height: 50
            border.color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            Text {
                id: click
                text: qsTr("Click")
                font.pixelSize: 20
                anchors.centerIn: parent
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    changeImage()
                }
            }
        }
    }
    onChangeImage: {

    }


}
