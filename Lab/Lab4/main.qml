import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Window {
    id:root
    width: 640
    height: 480
    visible: true
    title: qsTr("Setting")

    ColumnLayout{
        spacing: 30
        width: parent.width
        Label {
            id: wifi
            text: "Wi-Fi Setting"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
        ColumnLayout{
            RadioButton {
                checked: false
                text: qsTr("2.4 GHz")
                onPressed: {
                    console.log("you select 2.4 GHz")
                }
            }
            RadioButton {
                text: qsTr("5 GHz")
                onPressed: {
                    console.log("you select 5 GHz")
                }
            }
        }
        Label{
            text: "Language Settings"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
        ComboBox{
            id:nonEditable
            model: ["English","Vietnamese", "Chinese", "Japanese", "Korean" ]
            onActivated: {
                console.log("language is "+ currentText)
            }
        }
        Label{
            text: "Display Settings"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Row{
            spacing: 15
            anchors.horizontalCenter:  parent.horizontalCenter

            Text {
                id: start
                text: qsTr("0")
                font.pixelSize: 20
            }
            Slider{
                from: 0
                to:100
                value: 20
                stepSize: 1
                width: root.width-150
                onValueChanged: {
                    console.log("value is: " +value)
                }
            }
            Text {
                id: end
                text: qsTr("100")
                font.pixelSize: 20
            }
        }

    }
}
