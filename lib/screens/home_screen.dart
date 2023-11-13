import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Resources/colors.dart';
import '../controllers/home_controller.dart';
import '../helpers/ad_helper.dart';
import '../helpers/config.dart';
import '../helpers/pref.dart';
import '../main.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';
import '../widgets/count_down_timer.dart';
import '../widgets/home_card.dart';
import '../widgets/watch_ad_dialog.dart';
import 'location_screen.dart';
import 'network_test_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      //app bar
      backgroundColor: whitecolr,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whitecolr,
        leading: Icon(
          Icons.menu_rounded,
          color: Colors.black,
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Color.fromARGB(255, 227, 229, 230),
              child: Image.asset('assets/images/vp.png'),
            ),
            SizedBox(
              width: mq.width * .02,
            ),
            Text(
              'Brando ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black),
            ),
            Text(
              'konnect',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Color.fromARGB(255, 43, 160, 255)),
            ),
          ],
        ),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       //ad dialog

          //       if (Config.hideAds) {
          //         Get.changeThemeMode(
          //             Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
          //         Pref.isDarkMode = !Pref.isDarkMode;
          //         return;
          //       }

          //       Get.dialog(WatchAdDialog(onComplete: () {
          //         //watch ad to gain reward
          //         AdHelper.showRewardedAd(onComplete: () {
          //           Get.changeThemeMode(
          //               Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
          //           Pref.isDarkMode = !Pref.isDarkMode;
          //         });
          //       }));
          //     },
          //     icon: Icon(
          //       Icons.brightness_medium,
          //       size: 26,
          //     )),
          IconButton(
              padding: EdgeInsets.only(right: 8),
              onPressed: () => Get.to(() => NetworkTestScreen()),
              icon: Icon(
                CupertinoIcons.settings,
                color: Colors.black,
              )),
        ],
      ),

      bottomNavigationBar: _changeLocation(context),

      //body
      body: SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //vpn button
          SizedBox(
            height: mq.height * .060,
          ),
          Obx(
            () => HomeCard(
                title: _controller.vpn.value.countryLong.isEmpty
                    ? ' Country'
                    : _controller.vpn.value.countryLong,
                subtitle: '',
                icon: CircleAvatar(
                  radius: 27,
                  backgroundColor: bgcolr,
                  child: _controller.vpn.value.countryLong.isEmpty
                      ? Icon(Icons.vpn_lock_rounded,
                          size: 30, color: Colors.white)
                      : null,
                  backgroundImage: _controller.vpn.value.countryLong.isEmpty
                      ? null
                      : AssetImage(
                          'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
                )),
          ),
          // Obx(
          //   () => Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       //country flag

          //       //ping time
          //       // HomeCard(
          //       //     title: _controller.vpn.value.countryLong.isEmpty
          //       //         ? '100 ms'
          //       //         : '${_controller.vpn.value.ping} ms',
          //       //     subtitle: 'PING',
          //       //     icon: CircleAvatar(
          //       //       radius: 30,
          //       //       backgroundColor: Colors.orange,
          //       //       child: Icon(Icons.equalizer_rounded,
          //       //           size: 30, color: Colors.white),
          //       //     )),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<VpnStatus?>(
              initialData: VpnStatus(),
              stream: VpnEngine.vpnStatusSnapshot(),
              builder: (context, snapshot) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //download
                      Container(
                        height: mq.height * .087,
                        width: mq.width * .40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Color.fromARGB(255, 237, 237, 237)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.red,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Upload'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${snapshot.data?.byteIn ?? 'kbps'}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: mq.width * .049,
                      ),
                      Container(
                        height: mq.height * .087,
                        width: mq.width * .40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Color.fromARGB(255, 237, 237, 237)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.arrow_downward_rounded,
                              color: Colors.green,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Download'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${snapshot.data?.byteOut ?? 'kbps'}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),

          Obx(() => _vpnButton()),
        ]),
      ),
    );
  }

  //vpn button
  Widget _vpnButton() => Column(
        children: [
          //vpn button
          SizedBox(
            height: mq.height * .080,
          ),
          Text(
            _controller.vpnState.value == VpnEngine.vpnDisconnected
                ? 'Not Connected'
                : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
            style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: _controller.vpnState.value == VpnEngine.vpnDisconnected
                    ? Colors.red
                    : Colors.green),
          ),
          //button
          SizedBox(
            height: mq.height * .030,
          ),
          Obx(() => CountDownTimer(
              startTimer:
                  _controller.vpnState.value == VpnEngine.vpnConnected)),
          SizedBox(
            height: mq.height * .1,
          ),
          Container(
            child: Stack(
              children: [
                LottieBuilder.asset(
                  'assets/lottie/animation_lkxo3nrt.json',
                ),
                Positioned(
                  left: 100,
                  child: Semantics(
                    button: true,
                    child: InkWell(
                      onTap: () {
                        _controller.connectToVpn();
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _controller.getButtonColor.withOpacity(.1)),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  _controller.getButtonColor.withOpacity(.3)),
                          child: Container(
                            width: mq.height * .14,
                            height: mq.height * .14,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _controller.getButtonColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //icon
                                Icon(
                                  Icons.power_settings_new,
                                  size: 28,
                                  color: Colors.white,
                                ),

                                SizedBox(height: 4),

                                //text
                                Text(
                                  _controller.getButtonText,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //connection status label

          //count down timer
        ],
      );

  //bottom nav to change location
  Widget _changeLocation(BuildContext context) => SafeArea(
          child: Semantics(
        button: true,
        child: InkWell(
          onTap: () => Get.to(() => LocationScreen()),
          child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 244),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
              height: 60,
              child: Row(
                children: [
                  //icon
                  Icon(CupertinoIcons.globe, color: bgcolr, size: 28),

                  //for adding some space
                  SizedBox(width: 10),

                  //text
                  Text(
                    'Change Location',
                    style: TextStyle(
                        color: blk, fontSize: 18, fontWeight: FontWeight.w500),
                  ),

                  //for covering available spacing
                  Spacer(),

                  //icon
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.keyboard_arrow_right_rounded,
                        color: blk, size: 26),
                  )
                ],
              )),
        ),
      ));
}
