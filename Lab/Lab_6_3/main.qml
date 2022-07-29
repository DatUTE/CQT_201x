import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Layouts 1.3

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    GridView{
        id: mGridViewID
        width: 300
        height: 200
        anchors.fill: parent
        anchors.margins: 30
        model:listModelID
        delegate:
            Image {
                width: 100
                height: 100
                source: mSource
            }
    }
    ListModel{
        id:listModelID

        ListElement{ mSource:"qrc:/Image/anh1.jpg"}
        ListElement{ mSource:"qrc:/Image/anh16.jpg"}
        ListElement{ mSource:"qrc:/Image/anh18.jpg"}
        ListElement{ mSource:"qrc:/Image/anh19.jpg"}
        ListElement{ mSource:"qrc:/Image/anh20.jpg"}
        ListElement{ mSource:"qrc:/Image/anh2.jpg"}
        ListElement{ mSource:"qrc:/Image/anh21.jpg"}
        ListElement{ mSource:"qrc:/Image/anh22.jpg"}
        ListElement{ mSource:"qrc:/Image/anh23.jpg"}
        ListElement{ mSource:"qrc:/Image/anh4.jpg"}
    }

}
