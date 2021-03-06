/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

Control {
    id: ethComboBox

    /*! \qmlproperty model ComboBox::model
        The model to populate the ComboBox from.

        Changing the model after initialization will reset \l currentIndex to \c 0.
    */
    property alias model: popupItems.model

    /*! The model role used for populating the ComboBox. */
    property string textRole: ""

    /*! \qmlproperty int ComboBox::currentIndex
        The index of the currently selected item in the ComboBox.

        Setting currentIndex to \c -1 will reset the selection and clear the text
        label. If \l editable is \c true, you may also need to manually clear \l editText.

        \sa model
    */
    property alias currentIndex: popup.__selectedIndex

    /*! \qmlproperty string ComboBox::currentText
        The text of the currently selected item in the ComboBox.

        \note Since \c currentText depends on \c currentIndex, there's no way to ensure \c currentText
        will be up to date whenever a \c onCurrentIndexChanged handler is called.
    */
    readonly property alias currentText: popup.currentText

    /*! This property holds whether the combo box can be edited by the user.
     The default value is \c false.
     \since QtQuick.Controls 1.1
    */
    property bool editable: false

    /*! \qmlproperty string ComboBox::editText
        \since QtQuick.Controls 1.1
        This property specifies text being manipulated by the user for an editable combo box.
    */
    property alias editText: input.text

    /*! This property specifies whether the combobox should gain active focus when pressed.
        The default value is \c false. */
    property bool activeFocusOnPress: false

    /*! \qmlproperty bool ComboBox::pressed

        This property holds whether the button is being pressed. */
    readonly property bool pressed: mouseArea.effectivePressed || popup.__popupVisible

    /*! \qmlproperty bool ComboBox::hovered

        This property indicates whether the control is being hovered.
    */
    readonly property bool hovered: mouseArea.containsMouse || cursorArea.containsMouse

    /*! \qmlproperty int ComboBox::count
        \since QtQuick.Controls 1.1
        This property holds the number of items in the combo box.
    */
    readonly property alias count: popupItems.count

    /*! Returns the text for a given \a index.
        If an invalid index is provided, \c null is returned
        \since QtQuick.Controls 1.1
    */
    function textAt (index) {
        if (index >= count || index < 0)
            return null;
        return popupItems.objectAt(index).text;
    }

    /*! Finds and returns the index of a given \a text
        If no match is found, \c -1 is returned. The search is case sensitive.
        \since QtQuick.Controls 1.1
    */
    function find (text) {
        return input.find(text, Qt.MatchExactly)
    }

    /*!
        \qmlproperty Validator ComboBox::validator
        \since QtQuick.Controls 1.1

        Allows you to set a text validator for an editable ComboBox.
        When a validator is set,
        the text field will only accept input which leaves the text property in
        an intermediate state. The accepted signal will only be sent
        if the text is in an acceptable state when enter is pressed.

        Currently supported validators are \l{QtQuick::}{IntValidator},
        \l{QtQuick::}{DoubleValidator}, and \l{QtQuick::}{RegExpValidator}. An
        example of using validators is shown below, which allows input of
        integers between 11 and 31 into the text field:

        \note This property is only applied when \l editable is \c true

        \qml
        import QtQuick 2.2
        import QtQuick.Controls 1.2

        ComboBox {
            editable: true
            model: 10
            validator: IntValidator {bottom: 0; top: 10;}
            focus: true
        }
        \endqml

        \sa acceptableInput, accepted, editable
    */
    property alias validator: input.validator

    /*!
        \qmlproperty bool ComboBox::acceptableInput
        \since QtQuick.Controls 1.1

        Returns \c true if the combo box contains acceptable
        text in the editable text field.

        If a validator was set, this property will return \c
        true if the current text satisfies the validator or mask as
        a final string (not as an intermediate string).

        \sa validator, accepted

    */
    readonly property alias acceptableInput: input.acceptableInput

    /*!
        \qmlsignal ComboBox::accepted()
        \since QtQuick.Controls 1.1

        This signal is emitted when the Return or Enter key is pressed on an
        \l editable combo box. If the confirmed string is not currently in the model,
        the currentIndex will be set to -1 and the \l currentText will be updated
        accordingly.

        \note If there is a \l validator set on the combobox,
        the signal will only be emitted if the input is in an acceptable state.

        The corresponding handler is \c onAccepted.
    */
    signal accepted

    /*!
        \qmlsignal ComboBox::activated(int index)
        \since QtQuick.Controls 1.1

        \a index is the triggered model index or -1 if a new string is accepted

        This signal is similar to currentIndex changed, but will only
        be emitted if the combo box index was changed by the user and not
        when set programatically.

        The corresponding handler is \c onActivated.
    */
    signal activated(int index)

    /*!
        \qmlmethod ComboBox::selectAll()
        \since QtQuick.Controls 1.1

        Causes all \l editText to be selected.
    */
    function selectAll() {
        input.selectAll()
    }

    /*! \internal */
    function __selectPrevItem() {
        input.blockUpdate = true
        if (currentIndex > 0) {
            currentIndex--;
            input.text = popup.currentText;
            activated(currentIndex);
        }
        input.blockUpdate = false;
    }

    /*! \internal */
    function __selectNextItem() {
        input.blockUpdate = true;
        if (currentIndex < popupItems.count - 1) {
            currentIndex++;
            input.text = popup.currentText;
            activated(currentIndex);
        }
        input.blockUpdate = false;
    }

    /*! \internal */
    property var __popup: popup

    style: Qt.createComponent("EthComboBoxStyle.qml", ethComboBox)

    activeFocusOnTab: true

    Accessible.name: editable ? editText : currentText
    Accessible.role: Accessible.ComboBox
    Accessible.editable: editable

    MouseArea {
        id: mouseArea
        property bool overridePressed: false
        readonly property bool effectivePressed: (pressed || overridePressed) && containsMouse
        anchors.fill: parent
        hoverEnabled: true
        onPressed: {
            if (ethComboBox.activeFocusOnPress)
                forceActiveFocus()
            if (!Settings.hasTouchScreen)
                popup.show()
            else
                overridePressed = true
        }
        onCanceled: overridePressed = false
        onClicked: {
            if (Settings.hasTouchScreen)
                popup.show()
            overridePressed = false
        }
        onWheel: {
            if (wheel.angleDelta.y > 0) {
                __selectPrevItem();
            } else if (wheel.angleDelta.y < 0){
                __selectNextItem();
            }
        }
    }

    Component.onCompleted: {
        if (currentIndex === -1)
            currentIndex = 0

        popup.ready = true
        popup.resolveTextValue(textRole)
    }

    Keys.onPressed: {
        // Perform one-character based lookup for non-editable combo box
        if (!editable && event.text.length > 0) {
            var index = input.find(event.text, Qt.MatchStartsWith);
            if (index >= 0 && index !== currentIndex) {
                currentIndex = index;
                activated(currentIndex);
            }
        }
    }

    TextInput {
        id: input

        visible: editable
        enabled: editable
        focus: true
        clip: contentWidth > width

        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: __style.dropDownButtonWidth + __style.padding.right

        verticalAlignment: Text.AlignVCenter

        renderType: __style ? __style.renderType : Text.NativeRendering
        selectByMouse: true
        color: SystemPaletteSingleton.text(enabled)
        selectionColor: SystemPaletteSingleton.highlight(enabled)
        selectedTextColor: SystemPaletteSingleton.highlightedText(enabled)
        onAccepted: {
            var idx = input.find(editText, Qt.MatchFixedString)
            if (idx > -1) {
                editTextMatches = true;
                currentIndex = idx;
                editText = textAt(idx);
            } else {
                editTextMatches = false;
                currentIndex = -1;
                popup.currentText = editText;
            }
            comboBox.accepted();
        }

        property bool blockUpdate: false
        property string prevText
        property bool editTextMatches: true

        function find (text, searchType) {
            for (var i = 0 ; i < popupItems.count ; ++i) {
                var currentString = popupItems.objectAt(i).text
                if (searchType === Qt.MatchExactly) {
                    if (text === currentString)
                        return i;
                } else if (searchType === Qt.CaseSensitive) {
                    if (currentString.indexOf(text) === 0)
                        return i;
                } else if (searchType === Qt.MatchFixedString) {
                    if (currentString.toLowerCase().indexOf(text.toLowerCase()) === 0
                            && currentString.length === text.length)
                        return i;
                } else if (currentString.toLowerCase().indexOf(text.toLowerCase()) === 0) {
                    return i
                }
            }
            return -1;
        }

        // Finds first entry and shortest entry. Used by editable combo
        function tryComplete (inputText) {
            var candidate = "";
            var shortestString = "";
            for (var i = 0 ; i < popupItems.count ; ++i) {
                var currentString = popupItems.objectAt(i).text;

                if (currentString.toLowerCase().indexOf(inputText.toLowerCase()) === 0) {
                    if (candidate.length) { // Find smallest possible match
                        var cmp = 0;

                        // We try to complete the shortest string that matches our search
                        if (currentString.length < candidate.length)
                            candidate = currentString

                        while (cmp < Math.min(currentString.length, shortestString.length)
                               && shortestString[cmp].toLowerCase() === currentString[cmp].toLowerCase())
                            cmp++;
                        shortestString = shortestString.substring(0, cmp);
                    } else { // First match, select as current index and find other matches
                        candidate = currentString;
                        shortestString = currentString;
                    }
                }
            }

            if (candidate.length)
                return inputText + candidate.substring(inputText.length, candidate.length);
            return inputText;
        }

        property bool allowComplete: false
        Keys.forwardTo: ethComboBox
        Keys.onPressed: allowComplete = (event.key !== Qt.Key_Backspace && event.key !== Qt.Key_Delete);

        onTextChanged: {
            if (editable && !blockUpdate && allowComplete && text.length > 0) {
                var completed = input.tryComplete(text)
                if (completed.length > text.length) {
                    var oldtext = input.text;
                    input.text = completed;
                    input.select(text.length, oldtext.length);
                }
            }
            prevText = text
        }

        MouseArea {
            id: cursorArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.IBeamCursor
            acceptedButtons: Qt.NoButton
        }
    }

    Binding {
        target: input
        property: "text"
        value: popup.currentText
        when: input.editTextMatches
    }

    onTextRoleChanged: popup.resolveTextValue(textRole)

    Menu {
        id: popup
        objectName: "popup"

        style: isPopup ? __style.__popupStyle : __style.__dropDownStyle

        property string currentText: selectedText
        onSelectedTextChanged: if (selectedText) popup.currentText = selectedText

        property string selectedText
        on__SelectedIndexChanged: {
            if (__selectedIndex === -1)
                popup.currentText = ""
            else
                updateSelectedText()
        }
        property string textRole: ""

        property bool ready: false
        property bool isPopup: !editable && !!__panel && __panel.popup

        property int y: isPopup ? (ethComboBox.__panel.height - ethComboBox.__panel.implicitHeight) / 2.0 : ethComboBox.__panel.height
        __minimumWidth: ethComboBox.width
        __visualItem: ethComboBox

        property ExclusiveGroup eg: ExclusiveGroup { id: eg }

        property bool modelIsArray: false

        Instantiator {
            id: popupItems
            active: false

            property bool updatingModel: false
            onModelChanged: {
                popup.modelIsArray = !!model ? model.constructor === Array : false
                if (active) {
                    if (updatingModel && popup.__selectedIndex === 0) {
                        // We still want to update the currentText
                        popup.updateSelectedText()
                    } else {
                        updatingModel = true
                        popup.__selectedIndex = 0
                    }
                }
                popup.resolveTextValue(ethComboBox.textRole)
            }

            MenuItem {
                text: popup.textRole === '' ?
                        modelData :
                          ((popup.modelIsArray ? modelData[popup.textRole] : model[popup.textRole]) || '')
                iconSource: "qml/image/edit.ico"
                onTriggered: {
                    if (index !== currentIndex)
                        activated(index)
                    ethComboBox.editText = text
                }
                checkable: true
                exclusiveGroup: eg
            }

            onObjectAdded: {
                popup.insertItem(index, object)
                if (!updatingModel && index === popup.__selectedIndex)
                    popup.selectedText = object["text"]
            }
            onObjectRemoved: popup.removeItem(object)

        }

        function resolveTextValue(initialTextRole) {
            if (!ready || !model) {
                popupItems.active = false
                return;
            }

            var get = model['get'];
            if (!get && popup.modelIsArray && !!model[0]) {
                if (model[0].constructor !== String && model[0].constructor !== Number)
                    get = function(i) { return model[i]; }
            }

            var modelMayHaveRoles = get !== undefined
            textRole = initialTextRole
            if (textRole === "" && modelMayHaveRoles && get(0)) {
                // No text role set, check whether model has a suitable role
                // If 'text' is found, or there's only one role, pick that.
                var listElement = get(0)
                var roleName = ""
                var roleCount = 0
                for (var role in listElement) {
                    if (listElement[role].constructor === Function)
                        continue;
                    if (role === "text") {
                        roleName = role
                        break
                    } else if (!roleName) {
                        roleName = role
                    }
                    ++roleCount
                }
                if (roleCount > 1 && roleName !== "text") {
                    console.warn("No suitable 'textRole' found for ComboBox.")
                } else {
                    textRole = roleName
                }
            }

            if (!popupItems.active)
                popupItems.active = true
            else
                updateSelectedText()
        }

        function show() {
            if (items[__selectedIndex])
                items[__selectedIndex].checked = true
            __currentIndex = ethComboBox.currentIndex
            if (Qt.application.layoutDirection === Qt.RightToLeft)
                __popup(ethComboBox.width, y, isPopup ? __selectedIndex : 0)
            else
                __popup(0, y, isPopup ? __selectedIndex : 0)
        }

        function updateSelectedText() {
            var selectedItem;
            if (__selectedIndex !== -1 && (selectedItem = items[__selectedIndex])) {
                input.editTextMatches = true
                selectedText = selectedItem.text
                if (currentText !== selectedText) // __selectedIndex went form -1 to 0
                    selectedTextChanged()
            }
        }
    }

    // The key bindings below will only be in use when popup is
    // not visible. Otherwise, native popup key handling will take place:
    Keys.onSpacePressed: {
        if (!popup.popupVisible)
            popup.show()
    }

    Keys.onUpPressed: __selectPrevItem()
    Keys.onDownPressed: __selectNextItem()
}
