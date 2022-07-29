import QtQuick 2.0

ListView{
    width: 640
    height: 500
    spacing: 20
    model:myModel
    delegate: Rectangle{
        id: rectID
        width: 640
        height: 130
        border.color:"red"
        Text {
            font.pixelSize: 15
            id: text1ID
            text: "Name: " + modelData.name +"\n" + "Mssv: " + modelData.mssv + "\n" + "DOB " + modelData.dob +"\n"
                + "Email: "+ modelData.email +"\n" + "Phone: " + modelData.phone +"\n"
                + "Add: " + modelData.add +"\n" + "GPA: " + modelData.gpa + "\n"
        }
    }
}
