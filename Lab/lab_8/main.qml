import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Image{
        id: lightTraffic
        width: 300
        height: 300
        anchors.centerIn: parent
        source: "qrc:/Image/8_light_bg.png"
    }
    Row{
        id: ctl
        anchors.top: lightTraffic.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20
        Button{
            id: green
            Text {
                id: xanh
                text: qsTr("Green")
                anchors.centerIn: parent
                color: "green"
                font.pixelSize: 20
            }
            onClicked: {
                //Controler.sendData(0, 60);
            }
        }
        Button{
            id: red
            Text {
                id: maudo
                text: qsTr("Red")
                anchors.centerIn: parent
                color: "Red"
                font.pixelSize: 20
            }
            onClicked: {
                //Controler.sendData(1, 5);
            }
        }
    }
    Item {
        width: root.width
        height: root.height - lightTraffic.height - ctl.height

        Timer {
            interval: 500; running: true; repeat: true
            onTriggered: time.text = Date().toString()
        }

        Text {
            id: time
            anchors.centerIn: parent
            font.pixelSize: 20
        }
    }
//    Connections{
//        target: lightTraffic
//    }



}
