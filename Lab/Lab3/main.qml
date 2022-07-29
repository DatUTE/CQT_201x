import QtQuick 2.11
import QtQuick.Window 2.11
import "Define.js" as Define1
Window {
    width: 1000
    height: 600
    visible: true
    title: qsTr("Hello World")
    Column{
        width: implicitWidth.parent
        height: implicitHeight.parent
        Text {
            id: text1
            text: qsTr("this line has a font size of " + Define1.sizeText(18) )
            font.pixelSize: Define1.sizeText(18)
        }
        Text {
            id: text2
            text: qsTr("this line has a font size of " + Define1.sizeText(24) )
            font.pixelSize: Define1.sizeText(24)
        }
        Text {
            id: text3
            text: qsTr("this line has a font size of " + Define1.sizeText(36) )
            font.pixelSize: Define1.sizeText(36)
        }
        Text {
            id: text4
            text: qsTr("this line has a font size of " + Define1.sizeText(48) )
            font.pixelSize: Define1.sizeText(48)
        }
        Text {
            id: text5
            text: qsTr("this line has a font size of " + Define1.sizeText(72) )
            font.pixelSize: Define1.sizeText(72)
        }
    }
}
