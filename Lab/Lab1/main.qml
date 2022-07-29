import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    width: 1360
    height: 736
    visible: true
    title: qsTr("Lab 1 ")
    Image{
        id: background
        width: 1360
        height: 736
        source: "image - Resource/bg_full.png"
        anchors.centerIn: parent
        Rectangle{
            id: header
            width: 1360
            height: 100
            color: "#43415c"
            Text {
                anchors.centerIn: parent
                text: qsTr("Setting")
                color: "white"
                font.pixelSize: 40
                font.family: "Verdana"
            }
        }
        // connection item
        Image{
            id:connection
            width: 200
            height: 200
            source: "image - Resource/Connections.png"
            //x: 50; y:150
            anchors.top: header.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 50
        }
        Text {
            id: textConnection
            text: qsTr("Connection")
            x:90; y:360
            font.pixelSize: 20
            color: "white"
        }
        // display Item {
        Image{
            id: display
            width: 200
            height: 200
            source: "image - Resource/Display.png"
            x:300; y:150
        }
        Text{
            id:textDisplay
            text: qsTr("Display")
            x:360; y:360
            font.pixelSize: 20
            color: "white"
        }
        //General item
        Image{
            id: general
            width: 200
            height: 200
            source: "image - Resource/General.png"
            x:550; y:150
        }
        Text{
            id:textGeneral
            text: qsTr("General")
            x:610; y:360
            font.pixelSize: 20
            color: "white"
        }
        //Navigation item
        Image{
            id: navigation
            width: 200
            height: 200
            source: "image - Resource/Navigation.png"
            x:800; y:150
        }
        Text{
            id:textNavigation
            text: qsTr("Navigation")
            x:850; y:360
            font.pixelSize: 20
            color: "white"
        }
        //Sound item
        Image{
            id: sound
            width: 200
            height: 200
            source: "image - Resource/Sound.png"
            x:1050; y:150
        }
        Text{
            id:textSound
            text: qsTr("Navigation")
            x:1100; y:360
            font.pixelSize: 20
            color: "white"
        }
        // User prolife item
        Image{
            id:userProlife
            width: 200
            height: 200
            source: "image - Resource/User Profile.png"
            x: 50; y:400

        }
        Text {
            id: textUserProlife
            text: qsTr("User Prolife")
            x:90; y:615
            font.pixelSize: 20
            color: "white"
        }
        // Vehicle item
        Image{
            id:vehicle
            width: 200
            height: 200
            source: "image - Resource/Vehicle.png"
            x: 300; y:400

        }
        Text {
            id: textVehicle
            text: qsTr("Vehicle")
            x:370; y:615
            font.pixelSize: 20
            color: "white"
        }
        // Voice item
        Image{
            id: voice
            width: 200
            height: 200
            source: "image - Resource/Voice.png"
            x: 550; y:400

        }
        Text {
            id: textVoice
            text: qsTr("Voice")
            x:625; y:615
            font.pixelSize: 20
            color: "white"
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
