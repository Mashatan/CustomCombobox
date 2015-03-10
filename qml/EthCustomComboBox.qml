// Date: 2015
// Author: Ali Mashatan
// Email : ali.mashatan@gmail.com

import QtQuick 2.0

Rectangle {
    width:400;
    height: 50;

    Rectangle {
            id:ethCustomComboBox
            property variant items: ["Item 1", "Item 2", "Item 3"]
            property alias selectedItem: ethchosenItemText.text;
            property alias selectedIndex: listView.currentIndex;
            signal comboClicked;
            width: 100;
            height: 30;
            z: 100;
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
                    delegate: Item{
                        width:ethCustomComboBox.width;
                        height: ethCustomComboBox.height;

                        Text {
                            text: modelData
                            anchors.top: parent.top;
                            anchors.left: parent.left;
                            anchors.margins: 5;

                        }
                        MouseArea {
                            anchors.fill: parent;
                            onClicked: {
                                ethCustomComboBox.state = ""
                                var prevSelection = ethchosenItemText.text
                                ethchosenItemText.text = modelData
                                if(ethchosenItemText.text != prevSelection){
                                    ethCustomComboBox.comboClicked();
                                }
                                listView.currentIndex = index;
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
    }
