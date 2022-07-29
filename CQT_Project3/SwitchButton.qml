import QtQuick 2.0

MouseArea {
    id: root
    property string icon_on: ""
    property string icon_off: ""
    property bool status: false //false-Off true-On
    implicitWidth: img.width
    implicitHeight: img.height
    Image {
        id: img
        source: root.status === false ? icon_off : icon_on
    }
}
