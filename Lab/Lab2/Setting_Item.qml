import QtQuick 2.0

Item {
    property string imageResource: " "
    property string title: " "
    imageResource: "image.qrc//Display.png"
    title: "Display"
    Rectangle{
        x:290; y:140
        border{color: "red"; width : 3}
        width: 240
        height: 160
        Image{
            id: display
            source: imageResource
            x:10; y:10
            width: 200
            height: 200
        }
        Text {
            id: textDispaly
            text: title
            x: 40; y: 230
            font.pixelSize: 20
            color: "white"
        }
    }


}
