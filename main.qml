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

    Text {
        id: hello_text
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }

    QmlBanner {
        id: banner_ad
        unitId: "ca-app-pub-3940256099942544/6300978111"
        bannerSize: QmlBanner.LARGE_BANNER
        x: (window.width - width) / 2
        y: window.height - height
        visible: true
        testDeviceId: "41E647017EBEBB0650DAE627391B7A43"

        onBannerClosed: {}
        onBannerFailedToLoad: {}
        onBannerLeftApplication: {}
        onBannerLoaded: {}
        onBannerOpened: {}
    }

    QmlInterstitialAd {
        id: interstitial_ad
        unitId: "ca-app-pub-3940256099942544/1033173712"
        testDeviceId: "41E647017EBEBB0650DAE627391B7A43"

        onInterstitialAdClosed: {
            interstitial_ad_status.text = "interstitial ad closed"
        }
        onInterstitialAdFailedToLoad: {
            interstitial_ad_status.text = "interstitial ad failed to load error code = " + errorCode
            console.log("interstitial ad failed to load error code = " + errorCode)
        }
        onInterstitialAdLeftApplication: {}
        onInterstitialAdLoaded: {
            interstitial_ad_status.text = "interstitial ad loaded"
        }
        onInterstitialAdOpened: {}
    }

    Button {
        id: interstitial_ad_button
        width: parent.width / 3
        anchors.left: parent.left
        text: qsTr("show interstitial ad")
        onClicked: interstitial_ad.showInterstitialAd()
    }

    Text {
        id: interstitial_ad_status
        width: parent.width / 3
        anchors.top: interstitial_ad_button.bottom
        anchors.left: parent.left
    }

    QmlRewardedVideoAd {
        id: video_ad
        unitId: "ca-app-pub-3940256099942544/5224354917"
        testDeviceId: "41E647017EBEBB0650DAE627391B7A43"

        onRewarded: {}
        onRewardedVideoAdClosed: {
            video_ad_status.text = "video ad closed"
        }
        onRewardedVideoAdFailedToLoad: {
            video_ad_status.text = "video ad failed to load error code = " + errorCode
            console.log("video ad failed to load error code = " + errorCode)
        }
        onRewardedVideoAdLeftApplication: {}
        onRewardedVideoAdLoaded: {
            video_ad_status.text = "video ad loaded"
        }
        onRewardedVideoAdOpened: {}
        onRewardedVideoCompleted: {}
        onRewardedVideoStarted: {}
    }

    Button {
        id: video_ad_button
        width: parent.width / 3
        anchors.right: parent.right
        text: qsTr("show video ad")
        onClicked: video_ad.show()
    }

    Text {
        id: video_ad_status
        width: parent.width / 3
        anchors.top: video_ad_button.bottom
        anchors.right: parent.right
    }

    Component.onCompleted: {
        banner_ad.loadBanner()
        interstitial_ad.loadInterstitialAd()
        video_ad.loadRewardedVideoAd()
    }
}
