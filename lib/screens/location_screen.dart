import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

import '../Resources/colors.dart';
import '../controllers/location_controller.dart';
import '../controllers/native_ad_controller.dart';
import '../helpers/ad_helper.dart';
import '../main.dart';
import '../widgets/vpn_card.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with SingleTickerProviderStateMixin {
  final _controller = LocationController();

  final _adController = NativeAdController();
  late TabController _tabController;

  final pages = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int ind = 0;
  @override
  Widget build(BuildContext context) {
    if (_controller.vpnList.isEmpty) _controller.getVpnData();

    _adController.ad = AdHelper.loadNativeAd(adController: _adController);

    return Obx(
      () => Scaffold(
          //app bar
          appBar: AppBar(
              elevation: 0,
              backgroundColor: whitecolr,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: blk,
                  size: 18,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.keyboard_control_sharp,
                    color: blk,
                    size: 26,
                  ),
                ),
              ],
              title: Text(
                'Server',
                style: TextStyle(color: blk),
              )),
          // appBar: AppBar(
          //   title: Text('VPN Locations (${_controller.vpnList.length})'),
          // ),

          bottomNavigationBar:
              // Config.hideAds ? null:
              _adController.ad != null && _adController.adLoaded.isTrue
                  ? SafeArea(
                      child: SizedBox(
                          height: 85, child: AdWidget(ad: _adController.ad!)))
                  : null,

          //refresh button
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 10),
            child: FloatingActionButton(
                backgroundColor: bgcolr,
                onPressed: () => _controller.getVpnData(),
                child: Icon(CupertinoIcons.refresh)),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 243, 243, 244),
                      borderRadius: BorderRadius.circular(26)),
                  child: DefaultTabController(
                    length: 2,
                    child: TabBar(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.all(4),
                      automaticIndicatorColorAdjustment: false,
                      indicatorColor: Colors.transparent,
                      labelColor: Color.fromARGB(255, 0, 0, 0),
                      unselectedLabelStyle: TextStyle(color: Colors.grey),
                      controller: _tabController,
                      isScrollable: true,
                      unselectedLabelColor: Colors.black,
                      onTap: (value) {
                        setState(() {
                          ind = value;
                        });
                      },
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                      tabs: [
                        Container(
                          height: 43,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  ind == 0 ? Colors.white : Colors.transparent),
                          child: const Tab(
                            text: 'Free',
                          ),
                        ),
                        Container(
                          height: 43,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  ind == 1 ? Colors.white : Colors.transparent),
                          child: const Tab(
                            text: 'Premium',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.height,
                  child: TabBarView(controller: _tabController, children: [
                    Container(
                      child: _controller.isLoading.value
                          ? _loadingWidget()
                          : _controller.vpnList.isEmpty
                              ? _noVPNFound()
                              : _vpnData(),
                    ),
                    Premium(),
                  ]),
                )
              ],
            ),
          ))),
    );
  }

  _vpnData() => ListView.builder(
        itemCount: _controller.vpnList.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top: mq.height * .015,
            bottom: mq.height * .1,
            left: mq.width * .04,
            right: mq.width * .04),
        itemBuilder: (ctx, i) => VpnCard(vpn: _controller.vpnList[i]),
      );

  _loadingWidget() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //lottie animation
            LottieBuilder.asset('assets/lottie/loading.json',
                width: mq.width * .7),

            //text
            Text(
              'Loading VPNs... 😌',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      );

  _noVPNFound() => Center(
        child: Text(
          'VPNs Not Found! 😔',
          style: TextStyle(
              fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      );
}

class Premium extends StatefulWidget {
  const Premium({
    super.key,
  });

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  final String playStoreLink =
      'https://play.google.com/store/games?pli=1'; // Replace with your app's Play Store link

  void _redirectToPlayStore() async {
    if (await canLaunch(playStoreLink)) {
      await launch(playStoreLink);
    } else {
      // Unable to open the Play Store, display an error message or take alternative actions.
      print('Unable to open the Play Store.');
    }
  }

  final data = [
    {"image": "assets/flags/bh.png", "title": "Bahrain"},
    {"image": "assets/flags/bs.png", "title": "Bahamas"},
    {"image": "assets/flags/cz.png", "title": "Czech Republic"},
    {"image": "assets/flags/do.png", "title": "Dominican Republic"},
    {"image": "assets/flags/gp.png", "title": "France"},
    {"image": "assets/flags/hu.png", "title": "Hungary"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            left: mq.width * .04,
            right: mq.width * .04,
            top: mq.height * .01,
            bottom: mq.height * .1),
        children: [
          SizedBox(
            height: 60,
          ),
          Column(
              children: List.generate(
            data.length,
            (index) => Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: mq.height * .01),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(15),
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      leading: Container(
                        padding: EdgeInsets.all(.5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(data[index]['image']!,
                              height: 40,
                              width: mq.width * .15,
                              fit: BoxFit.cover),
                        ),
                      ),
                      title: Text(
                        data[index]['title']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _redirectToPlayStore();
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 90,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset('assets/images/king.png'),
                                  Text(
                                    'Premium',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            color: whitecolr,
                                            fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(19)),
                            ),
                          )
                        ],
                      )
                      //subtitle
                      ),
                )),
          ))
        ]);
  }
}
