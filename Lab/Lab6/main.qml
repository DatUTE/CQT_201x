import QtQuick 2.11
import QtQuick.Window 2.11

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Lab 6")

    Rectangle{
        id: rectID
        width: parent.width
        height: 50
        color: "beige"
        Text{
            id: textID
            anchors.centerIn: parent
            text:"Danh Sach Sinh Vien"
            font.pixelSize: 30
        }
    }

    Rectangle{
        width: width.parent
        y: rectID.height
        height: parent.height - rectID.height
        ListView{
            id: mListViewID
            anchors.fill: parent
            model: listModelID
            delegate:
                Text {
                    font.pixelSize: 15
                    id: text1ID
                    text: "Name: " + name +"\n" + "Mssv: " + mssv + "\n" + "DOB " + DOB +"\n"
                        + "Email: "+ email +"\n" + "Phone: " + phone +"\n"
                        + "Add: " + addr +"\n" + "GPA: " + gpa + "\n"
                }
        }
    }

    ListModel{
        id: listModelID
        ListElement{
            name: "Nguyen Van An"; mssv: "FUNIX_0123"; DOB: "1/3/2000";
            email: "AnNV_FUNIX_0123@funix.edu.vn"; phone: 123456789 ; addr:"Ha Noi"; gpa: 7.1
        }
        ListElement{
            name: "Hoang Tan Minh"; mssv: "FUNIX_0214"; DOB: "15/6/2000";
            email: "MinhHT_FUNIX_0214@funix.edu.vn"; phone: 123456666 ; addr:"Ho Chi Minh"; gpa: 8.4
        }
        ListElement{
            name: "Tran Minh Ha"; mssv: "FUNIX_0412"; DOB: "14/2/2000";
            email: "HaTH_FUNIX_0412@funix.edu.vn"; phone: 111112222 ; addr:"Can Tho"; gpa: 6.5
        }
    }
}
