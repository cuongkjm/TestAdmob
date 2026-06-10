#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "QmlBanner.h"
#include "QmlInterstitialAd.h"
#include "QmlRewardedVideoAd.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<QmlBanner>("AdMob", 1, 0, "QmlBanner");
    qmlRegisterType<QmlInterstitialAd>("AdMob", 1, 0, "QmlInterstitialAd");
    qmlRegisterType<QmlRewardedVideoAd>("AdMob", 1, 0, "QmlRewardedVideoAd");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
