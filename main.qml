import QtQuick
import QtQuick.Window
import QtQuick.Controls
import AdMob 1.0

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("TestAdmob")

    readonly property bool isIos: Qt.platform.os === "ios"
    readonly property string bannerAdUnitId: isIos ? "ca-app-pub-3940256099942544/2934735716" : "ca-app-pub-3940256099942544/6300978111"
    readonly property string interstitialAdUnitId: isIos ? "ca-app-pub-3940256099942544/4411468910" : "ca-app-pub-3940256099942544/1033173712"
    readonly property string rewardedAdUnitId: isIos ? "ca-app-pub-3940256099942544/1712485313" : "ca-app-pub-3940256099942544/5224354917"

    function adErrorText(errorCode) {
        switch (errorCode) {
        case 0:
            return "invalid request"
        case 1:
            return "no fill"
        case 2:
            return "network error"
        case 3:
            return "server error"
        case 4:
            return "OS version too low"
        case 5:
            return "timeout"
        case 7:
            return "mediation data error"
        case 8:
            return "mediation adapter error"
        case 10:
            return "mediation invalid ad size"
        case 11:
            return "internal error"
        case 12:
            return "invalid argument"
        case 19:
            return "ad already used"
        case 20:
            return "app id missing"
        case 21:
            return "invalid ad string"
        default:
            return "unknown"
        }
    }

    Item {
        id: safe_area_probe
        anchors.fill: parent
    }

    Item {
        id: content_area
        x: safe_area_probe.SafeArea.margins.left
        y: safe_area_probe.SafeArea.margins.top
        width: window.width - safe_area_probe.SafeArea.margins.left - safe_area_probe.SafeArea.margins.right
        height: window.height - safe_area_probe.SafeArea.margins.top - safe_area_probe.SafeArea.margins.bottom
    }

    Text {
        id: hello_text
        text: qsTr("Hello World")
        anchors.centerIn: content_area
    }

    QmlBanner {
        id: banner_ad
        unitId: window.bannerAdUnitId
        bannerSize: QmlBanner.BANNER
        x: content_area.x + (content_area.width - width) / 2
        y: content_area.y + content_area.height - height
        visible: true
        testDeviceId: "41E647017EBEBB0650DAE627391B7A43"

        onBannerClosed: {}
        onBannerFailedToLoad: function(errorCode) {
            console.log("banner ad failed to load error code = " + errorCode + " (" + window.adErrorText(errorCode) + ")")
        }
        onBannerLeftApplication: {}
        onBannerLoaded: {}
        onBannerOpened: {}
    }

    QmlInterstitialAd {
        id: interstitial_ad
        unitId: window.interstitialAdUnitId
        testDeviceId: "41E647017EBEBB0650DAE627391B7A43"

        onInterstitialAdClosed: {
            interstitial_ad_status.text = "interstitial ad closed"
        }
        onInterstitialAdFailedToLoad: function(errorCode) {
            interstitial_ad_status.text = "interstitial ad failed to load error code = " + errorCode + " (" + window.adErrorText(errorCode) + ")"
            console.log("interstitial ad failed to load error code = " + errorCode + " (" + window.adErrorText(errorCode) + ")")
        }
        onInterstitialAdLeftApplication: {}
        onInterstitialAdLoaded: {
            interstitial_ad_status.text = "interstitial ad loaded"
            interstitial_ad_button.enabled = true
            console.log("interstitial ad loaded")
        }
        onInterstitialAdOpened: {}
    }

    Button {
        id: interstitial_ad_button
        width: content_area.width / 3
        anchors.left: content_area.left
        anchors.top: content_area.top
        enabled: false
        text: qsTr("show interstitial ad")
        onClicked: {
            enabled = false
            interstitial_ad.showInterstitialAd()
        }
    }

    Text {
        id: interstitial_ad_status
        width: content_area.width / 3
        anchors.top: interstitial_ad_button.bottom
        anchors.left: content_area.left
    }

    QmlRewardedVideoAd {
        id: video_ad
        unitId: window.rewardedAdUnitId
        testDeviceId: "41E647017EBEBB0650DAE627391B7A43"

        onRewarded: {}
        onRewardedVideoAdClosed: {
            video_ad_status.text = "video ad closed"
        }
        onRewardedVideoAdFailedToLoad: function(errorCode) {
            video_ad_status.text = "video ad failed to load error code = " + errorCode + " (" + window.adErrorText(errorCode) + ")"
            console.log("video ad failed to load error code = " + errorCode + " (" + window.adErrorText(errorCode) + ")")
        }
        onRewardedVideoAdLeftApplication: {}
        onRewardedVideoAdLoaded: {
            video_ad_status.text = "video ad loaded"
            video_ad_button.enabled = true
            console.log("video ad loaded")
        }
        onRewardedVideoAdOpened: {}
        onRewardedVideoCompleted: {}
        onRewardedVideoStarted: {}
    }

    Button {
        id: video_ad_button
        width: content_area.width / 3
        anchors.right: content_area.right
        anchors.top: content_area.top
        enabled: false
        text: qsTr("show video ad")
        onClicked: {
            enabled = false
            video_ad.show()
        }
    }

    Text {
        id: video_ad_status
        width: content_area.width / 3
        anchors.top: video_ad_button.bottom
        anchors.right: content_area.right
    }

    Component.onCompleted: {
        banner_ad.loadBanner()
        interstitial_ad.loadInterstitialAd()
        video_ad.loadRewardedVideoAd()
    }
}
