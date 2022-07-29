import QtQuick 2.11
import QtQuick.Window 2.11

Window {
    width: 640
    height: 500
    visible: true
    title: qsTr("Hello World")
    Column{
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        Repeater{
            id: item
            model: listModelID
            delegate:Rectangle{
                id: rectID
                width: 50
                height: 50
                radius: 30
                color: mcolor
                Text {
                    id: textID
                    anchors.centerIn: parent
                    text: name
                    color: "black"
                    font.pixelSize: 13
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log("color: " + rectID.color + "/name: " +textID.text)
                    }
                }

            }
        }
    }
    ListModel{
        id:listModelID
        ListElement{mcolor: "antiquewhite"; name:"Mecury"  }
        ListElement{mcolor: "aliceblue"   ; name:"Venus"   }
        ListElement{mcolor: "aqua"        ; name:"Earth"   }
        ListElement{mcolor: "bisque"      ; name:"Mars"    }
        ListElement{mcolor: "springgreen" ; name:"Jupiter" }
        ListElement{mcolor: "darkorange"  ; name:"Saturn"  }
        ListElement{mcolor: "chocolate"   ; name:"Uranus"  }
        ListElement{mcolor: "orangered"   ; name:"Neptune" }
    }
}
