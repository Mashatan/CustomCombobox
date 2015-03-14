// Date: 2015
// Author: Ali Mashatan
// Email : ali.mashatan@gmail.com

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1

Rectangle {
    id:ethCustomComboBox

    width:200;
    height: 20;

    Component.onCompleted:
    {
        var top = ethdropDown;
        while (top.parent)
            top = top.parent
        var coordinates = ethdropDown.mapToItem(top, 0, 0)
        ethdropDown.parent = top;
        ethdropDown.x = coordinates.x
        ethdropDown.y = coordinates.y
    }

    signal selectItem(real item);
    signal editItem(real item);

    property variant items;
    property alias selectedItem: ethchosenItemText.text;
    property alias selectedIndex: listView.currentRow;
    signal comboClicked;

    property variant colorItem;
    property variant colorSelect;

    smooth:true;
    Rectangle {
        id:ethchosenItem
        width:parent.width;
        height:ethCustomComboBox.height;
        color: ethCustomComboBox.color;
        smooth:true;
        Text {
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.margins: 2;
            color: ethCustomComboBox.colorItem;
            id:ethchosenItemText
            text:ethCustomComboBox.items.get(0).itemName;
            smooth:true
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                ethCustomComboBox.state = ethCustomComboBox.state==="dropDown"?"":"dropDown"
            }
        }
    }

    Rectangle {
        id:ethdropDown
        width:ethCustomComboBox.width;
        height:0;
        clip:true;
        radius:4;
        anchors.top: ethchosenItem.bottom;
        anchors.margins: 2;
        color: ethCustomComboBox.color

        TableView {
            id:listView
            height:500;
            width:ethCustomComboBox.width;
            model: ethCustomComboBox.items
            currentRow: 0
            headerVisible: false;
            backgroundVisible: false
            alternatingRowColors : false;
            frameVisible: false

            TableViewColumn {
                role: ""
                title: ""
                width: ethCustomComboBox.width;
                delegate: mainItemDelegate
                //elideMode: Text.ElideNone
            }

            Component {
                id: mainItemDelegate
                Item{
                    id: itemDelegate
                    width:ethCustomComboBox.width;
                    height: ethCustomComboBox.height;
                    Text {
                        id: textItemid
                        text: styleData.value
                        color: ethCustomComboBox.colorItem;
                        anchors.top: parent.top;
                        anchors.left: parent.left;
                        anchors.margins: 5;

                    }
                    Rectangle
                    {
                        id: spaceItemid
                        anchors.top: textItemid.top;
                        anchors.left: textItemid.right
                        width: parent.width - textItemid.width - imageItemid.width - textItemid.anchors.margins- textItemid.anchors.margins
                    }
                    Image {
                        id: imageItemid
                        height:20
                        width:20;
                        visible: false;
                        fillMode: Image.PreserveAspectFit
                        source: "image/edit.png"
                        anchors.top: spaceItemid.top;
                        anchors.left: spaceItemid.right;
                    }

                    MouseArea {
                        anchors.fill: parent;
                        hoverEnabled : true

                        onEntered: {
                            imageItemid.visible = true;
                            textItemid.color = ethCustomComboBox.colorSelect;
                        }
                        onExited: {
                            imageItemid.visible = false;
                            textItemid.color = ethCustomComboBox.colorItem;
                        }
                        onClicked: {
                            if (mouseX > imageItemid.x && mouseX < imageItemid.x+ imageItemid.width
                                    && mouseY > imageItemid.y && mouseY < imageItemid.y+ imageItemid.height)
                            {
                                ethCustomComboBox.editItem(styleData.row);
                                //console.log("Edit>>>>")
                            } else {
                                //console.log("Select>>>>")
                                ethCustomComboBox.state = ""
                                var prevSelection = ethchosenItemText.text
                                ethchosenItemText.text = modelData
                                if(ethchosenItemText.text != prevSelection){
                                    ethCustomComboBox.comboClicked();
                                }
                                listView.currentRow = styleData.row;
                                ethCustomComboBox.selectItem(styleData.row);
                            }
                        }
                    }
                }//Item
            }//Component
        }
    }
    states: State {
        name: "dropDown";
        PropertyChanges { target: ethdropDown; height:20*ethCustomComboBox.items.count }
    }

    transitions: Transition {
        NumberAnimation { target: ethdropDown; properties: "height"; easing.type: Easing.OutExpo; duration: 1000 }
    }
}
