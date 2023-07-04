import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;
  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  // @override
  // void initState() {
  //   super.initState();
  //   FacebookAudienceNetwork.init(
  //     testingId: "a77955ee-3304-4635-be65-81029b0f5201",
  //     iOSAdvertiserTrackingEnabled: true,
  //   );
  //
  //   _loadInterstitialAd();
  //   _loadRewardedVideoAd();
  // }

  void loadInterstitialAddd() {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED) {
          setState(() {
            _isInterstitialAdLoaded = true;
            print("=====[TRUE]=====");
          });
        }
        // if(result==InterstitialAdResult.LOGGING_IMPRESSION)
        //   {
        //     showDialog(context: context, builder: (context) {
        //       return Center(child: CircularProgressIndicator(),);
        //     },);
        //   }
        // if(result==InterstitialAdResult.LOADED)
        // {
        //   Navigator.pop(context);
        // }
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {

          _isInterstitialAdLoaded = false;
          loadInterstitialAddd();
        }
        if (result == InterstitialAdResult.DISMISSED && value["invalidated"] == true) {

         showDialog(context: context, builder: (context) {
           return AlertDialog(title: Text("Close button event handled"),actions: [TextButton(onPressed: () {
             Navigator.pop(context);
           }, child: Text("OK"))],);
         },);
        }
      },
    );
  }

  void _loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) _isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          _isRewardedAdLoaded = false;
          _loadRewardedVideoAd();
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("=====[1]=====");
    loadInterstitialAddd();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:
          AppBar(title: Text("FaceBook Ads"), centerTitle: true, elevation: 20),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                //
                loadInterstitialAddd();
              },
              child: Text("Tap to Load Interstitial Ad"),
            ),
            ElevatedButton(
              onPressed: () {
                //
                _showInterstitialAd();
              },
              child: Text("Tap to Show Interstitial Ad"),
            ),
            ElevatedButton(
              onPressed: () {
                //
                _showRewardedAd();
              },
              child: Text("Tap to Show Rewarded Ad"),
            ),
            ElevatedButton(
              onPressed: () {
                //
                _showNativeAd();
              },
              child: Text("Tap to Show Native Ad"),
            ),
            ElevatedButton(
              onPressed: () {
                //
                _showNativeBannerAd();
              },
              child: Text("Tap to Show Native Banner Ad"),
            ),
            ElevatedButton(
              onPressed: () {
                //
                _showBannerAd();
              },
              child: Text("Tap to Show Banner Ad"),
            ),
            _currentAd
          ],
        ),
      ),
    );
  }

  _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();

    else
      print("Interstial Ad not yet loaded!");
  }

  _showRewardedAd() {
    if (_isRewardedAdLoaded == true)
      FacebookRewardedVideoAd.showRewardedVideoAd();
    else
      print("Rewarded Ad not yet loaded!");
  }

  _showBannerAd() {
    setState(() {
      _currentAd = FacebookBannerAd(
        // placementId: "YOUR_PLACEMENT_ID",
        placementId:
            "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
  }

  _showNativeBannerAd() {
    setState(() {
      _currentAd = _nativeBannerAd();
    });
  }

  Widget _nativeBannerAd() {
    return FacebookNativeAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      width: double.infinity,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    );
  }

  _showNativeAd() {
    setState(() {
      _currentAd = _nativeAd();
    });
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }
}
