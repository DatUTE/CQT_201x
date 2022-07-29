import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.2

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Text{
        id: textID
        anchors {
                    top: parent.top
                    topMargin: 100
                    horizontalCenter: parent.horizontalCenter
                }
        //wrapMode: textID.Wrap
        text:"This is text use to test font and color"

    }
    Row{
        spacing: 20
        anchors {
                    bottom:  parent.bottom
                    bottomMargin: 50
                    horizontalCenter: parent.horizontalCenter
                }
        Button{
            text:"Open Font Dialog"
            onClicked: {
                fontID.open()
            }
        }
        Button{
            text:"Open Color Dialog"
            onClicked: {
                colorID.open()
            }
        }
    }
    FontDialog{
        id: fontID
        title: "choose a font"
        font: Qt.font({family: "Arial", pixelSize: 24,wieght: Font.Nomarl })
        onAccepted: {
            console.log("font is: " +font)
            textID.font = font
        }
    }
    ColorDialog{
        id: colorID
        title: "please choose a color"
        onAccepted: {
            console.log("user choose color is: " +color)
            textID.color = color
        }
    }

}

