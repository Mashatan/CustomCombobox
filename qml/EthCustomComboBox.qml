// Date: 2015
// Author: Ali Mashatan
// Email : ali.mashatan@gmail.com

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1

Rectangle {
    id:ethCustomComboBox

    width:400;
    height: 30;



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
    property alias selectedIndex: listView.currentIndex;
    signal comboClicked;
    smooth:true;

    Rectangle {
        id:ethchosenItem
        radius:4;
        width:parent.width;
        height:ethCustomComboBox.height;
        color: "gray"
        smooth:true;
        Text {
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.margins: 8;
            id:ethchosenItemText
            text:ethCustomComboBox.items[0];
            font.pointSize: 14;
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
        color: "gray"

        ListView {
            id:listView
            height:500;
            model: ethCustomComboBox.items
            currentIndex: 0
            highlight: Component{
                Rectangle {
                    width: 180; height: 40
                    color: "lightsteelblue"; radius: 5
                    y: listView.currentItem.y
                    Behavior on y {
                        SpringAnimation {
                            spring: 3
                            damping: 0.2
                        }
                    }
                }

            }

            delegate: Item{
                id:mainItem
                width:ethCustomComboBox.width;
                height: ethCustomComboBox.height;
                Text {
                    id: textItemid
                    text: modelData
                    color: "blue"
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
                    //height:parent.height
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
                    }
                    onExited: {
                        imageItemid.visible = false;
                    }
                    onClicked: {
                        if (mouseX > imageItemid.x && mouseX < imageItemid.x+ imageItemid.width
                                && mouseY > imageItemid.y && mouseY < imageItemid.y+ imageItemid.height)
                        {
                            ethCustomComboBox.editItem(index);
                            //console.log("Edit>>>>")
                        } else {
                            //console.log("Select>>>>")
                            ethCustomComboBox.state = ""
                            var prevSelection = ethchosenItemText.text
                            ethchosenItemText.text = modelData
                            if(ethchosenItemText.text != prevSelection){
                                ethCustomComboBox.comboClicked();
                            }
                            listView.currentIndex = index;
                            ethCustomComboBox.selectItem(index);
                        }

                    }
                }
            }
        }
    }

    states: State {
        name: "dropDown";
        PropertyChanges { target: ethdropDown; height:40*ethCustomComboBox.items.length }
    }

    transitions: Transition {
        NumberAnimation { target: ethdropDown; properties: "height"; easing.type: Easing.OutExpo; duration: 1000 }
    }
}
