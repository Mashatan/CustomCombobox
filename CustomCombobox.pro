## Date: 2015
## Author: Ali Mashatan
## Email : ali.mashatan@gmail.com

TEMPLATE = app
TARGET = CustomCombobox
QMAKE_PROJECT_NAME = CustomCombobox
DESTDIR = bin


QT += widgets
QT += qml
QT += quick
QT += quick-private
QT += webkit
QT += webkit-private
QT += webkitwidgets

CONFIG += qml_debug
CONFIG += qt
CONFIG += warn_on
CONFIG += console
CONFIG += thread 

CONFIG(debug, debug|release) {
    win32: TARGET = $$join(TARGET,,,_d)
}

QMAKE_LIBDIR += 
LIBS += 

Release:OBJECTS_DIR = build/release/.obj
Release:MOC_DIR     = build/release/.moc
Release:RCC_DIR     = build/release/.rcc
Release:UI_DIR      = build/release/.ui
Release:INCLUDEPATH += build/release/.ui

Debug:OBJECTS_DIR = build/debug/.obj
Debug:MOC_DIR     = build/debug/.moc
Debug:RCC_DIR     = build/debug/.rcc
Debug:UI_DIR      = build/debug/.ui
Debug:INCLUDEPATH += build/debug/.ui

INCLUDEPATH += .
INCLUDEPATH += inc/


SOURCES += src/main.cpp

HEADERS +=

RESOURCES += Resource.qrc
