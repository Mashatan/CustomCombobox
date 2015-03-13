// Date: 2015
// Author: Ali Mashatan
// Email : ali.mashatan@gmail.com

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2


Rectangle {
    width: 600;
    height: 400;

    ColumnLayout
    {

        EthCustomComboBox
        {
            items: ["No Transaction", "Sining up first tim", "Widthdraw from account", "Edit State..."]
            onSelectItem: console.log("Combobox Select Item: " + item )
            onEditItem: console.log("Combobox Edit Item: " + item )

        }
        Rectangle {
            width: 1000;
            height: 20;
            color: "red"
        }
        Text {
            text:"This is a Example Text"
        }
    }
    /*
            RowLayout{
                Text {
                    text:"Current State: "
                }

                ComboBox {
                    id: box
                    currentIndex: 2
                    activeFocusOnPress: true
                    style: ComboBoxStyle {
                        id: comboBox
                        background: Rectangle {
                            id: rectCategory
                            //radius: 5
                            border.width: 1
                            color: "#fff"
                        }
                        label: Text {
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 12
                            font.family: "tahoma"
                            font.capitalization: Font.SmallCaps
                            color: "black"
                            text: control.currentText
                        }

                        // drop-down customization here
                        property Component __dropDownStyle: MenuStyle {
                            __maxPopupHeight: 600
                            __menuItemType: "comboboxitem"

                            frame: Rectangle {              // background
                                color: "#fff"
                                border.width: 1
                                //radius: 2
                            }

                            itemDelegate.label:             // an item text
                                Item {
                                    height: 50
                                    id:itemEdit
                                    anchors.margins: 4
                                  RowLayout {
                                      Text {
                                           verticalAlignment: Text.AlignVCenter
                                           horizontalAlignment: Text.AlignHCenter
                                           font.pointSize: 10
                                           font.family: "tahoma"
                                           font.capitalization: Font.SmallCaps
                                           color: styleData.selected ? "white" : "black"
                                           text: styleData.text
                                      }
                                      Image {
                                          id: imgEdit
                                          fillMode: Image.PreserveAspectCrop
                                          source: "image/edit.png"
                                          visible: styleData.selected
                                          MouseArea {
                                              anchors.fill: parent
                                              anchors.margins: -10
                                              hoverEnabled: true
                                              onClicked: {
                                                  console.log("test click");
                                              }
                                          }
                                      }
                                  }
                               }

                            itemDelegate.background: Rectangle {  // selection of an item
                                radius: 2
                                color: styleData.selected ? "darkGray" : "transparent"
                            }

                            __scrollerStyle: ScrollViewStyle { }
                        }

                        property Component __popupStyle: Style {
                            property int __maxPopupHeight: 400
                            property int submenuOverlap: 0

                            property Component frame: Rectangle {
                                width: (parent ? parent.contentWidth : 0)
                                height: (parent ? parent.contentHeight : 0) + 2
                                border.color: "black"
                                property real maxHeight: 500
                                property int margin: 1
                            }

                            property Component menuItemPanel: Text {
                                text: "NOT IMPLEMENTED"
                                color: "red"
                                font {
                                    pixelSize: 14
                                    bold: true
                                }
                            }

                            property Component __scrollerStyle: null
                        }
                    }

                    model: ListModel {
                        id: cbItems
                        ListElement { text: "No Transaction"; idt:false }
                        ListElement { text: "Sining up first time"; idt:true }
                        ListElement { text: "Widthdraw from account"; idt:true }
                        ListElement { text: "Edit State..."; idt:false }
                    }
                    width: 200
                }

                EthComboBox
                {
                    id: functionComboBox
                    currentIndex: 0
                    textRole: "text"
                    editable: false
                    model: ListModel {
                        id: unitsModel
                        ListElement { text: "No Transaction"; image:"image/edit.png" }
                        ListElement { text: "Sining up first time"; image:"image/edit.png" }
                        ListElement { text: "Widthdraw from account"; image:"image/edit.png" }
                        ListElement { text: "Edit State..."; image:"image/edit.png" }
                    }
                }

            }*/
}
