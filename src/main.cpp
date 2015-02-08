// Date: 2015
// Author: Ali Mashatan
// Email : ali.mashatan@gmail.com

#include <QApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QtQml>

#include <iostream>

int main(int argc, char ** argv)
{
    QApplication app(argc, argv);
    QQuickView view;

    view.setSource(QUrl("qrc:///qml/main.qml"));
    view.show();

    return app.exec();
}
