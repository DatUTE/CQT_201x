import QtQuick 2.0

Item {
    property string imageResource: "image - Resource/Display.png"
    property string title: "Display"
    Rectangle{
        x:290; y:140
        border{color: "red"; width : 3}
        width: 220
        height: 250
        color: "#00000000"
        Image{
            id:display
            x:10;y:10
            width: 200
            height: 200
            source: imageResource
        }

        Text {
            id: textDispaly
            text: title
            x: 70; y: 220
            font.pixelSize: 20
            color: "white"
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
