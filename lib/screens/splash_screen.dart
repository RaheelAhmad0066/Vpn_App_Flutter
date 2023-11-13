import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../Resources/colors.dart';
import '../main.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration(minutes: 30), () {
  //     //exit full-screen
  //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  //     AdHelper.precacheInterstitialAd();
  //     AdHelper.precacheNativeAd();

  //     //navigate to home
  //     Get.off(() => HomeScreen());
  //     // Navigator.pushReplacement(
  //     //     context, MaterialPageRoute(builder: (_) => HomeScreen()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              //app logo
              SizedBox(
                height: mq.height * .1,
              ),
              Center(
                child: Image.asset(
                  'assets/images/vp.png',
                  width: mq.width * .7,
                ),
              ),
              SizedBox(
                height: mq.height * .050,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Color.fromARGB(255, 227, 229, 230),
                    child: Image.asset('assets/images/vp.png'),
                  ),
                  SizedBox(
                    width: mq.width * .03,
                  ),
                  Text(
                    'Brando ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    ' konnect',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Color.fromARGB(255, 43, 160, 255)),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .050,
              ),
              Text(
                'The Best Vpn Network',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: mq.height * .020,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Provides Various kind Of VPN Servers For You,Form Free To Premium',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                ),
              ),
              SizedBox(
                height: mq.height * .099,
              ),
              SizedBox(
                height: mq.height * .039,
              ),
              InkWell(
                onTap: () {
                  Get.off(() => HomeScreen());
                },
                child: Container(
                  height: mq.height * .069,
                  width: mq.width * .80,
                  child: Center(
                    child: Text('Explore Now',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            )),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 16, 183, 213),
                        Color.fromARGB(207, 165, 48, 232),
                        Color.fromARGB(219, 53, 52, 52)
                      ]),
                      color: bgcolr,
                      borderRadius: BorderRadius.circular(26)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
