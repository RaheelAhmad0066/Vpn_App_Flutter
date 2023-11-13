import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Resources/colors.dart';
import '../apis/apis.dart';
import '../main.dart';
import '../models/ip_details.dart';
import '../models/network_data.dart';
import '../widgets/network_card.dart';

class NetworkTestScreen extends StatefulWidget {
  NetworkTestScreen({super.key});

  @override
  State<NetworkTestScreen> createState() => _NetworkTestScreenState();
}

class _NetworkTestScreenState extends State<NetworkTestScreen>
    with SingleTickerProviderStateMixin {
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
    final ipData = IPDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: ipData);

    return Scaffold(
        backgroundColor: whitecolr,
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
                size: 20,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.keyboard_control_sharp,
                  color: blk,
                  size: 20,
                ),
              ),
            ],
            title: Text(
              'Settings',
              style: TextStyle(color: blk),
            )),

        //refresh button

        body: Column(
          children: [
            SizedBox(
              height: mq.height * .02,
            ),
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
                          color: ind == 0 ? Colors.white : Colors.transparent),
                      child: const Tab(
                        text: 'Settings',
                      ),
                    ),
                    Container(
                      height: 43,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ind == 1 ? Colors.white : Colors.transparent),
                      child: const Tab(
                        text: 'Locations',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Settings(),
                  Locations(ipData: ipData),
                ],
              ),
            ),
          ],
        ));
  }
}

class Settings extends StatefulWidget {
  Settings({
    super.key,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = false;
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;

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
          height: mq.height * .053,
        ),
        Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: mq.height * .01),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),

                title: Text('Anti-Malware Protectation'),
                trailing: Transform.scale(
                  scale: 1.3,
                  child: Switch(
                      inactiveTrackColor:
                          const Color.fromARGB(255, 243, 243, 244),
                      thumbColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          // Use different colors for the thumb based on the state of the switch
                          if (states.contains(MaterialState.selected)) {
                            return Colors
                                .white; // Color when the switch is "on"
                          }
                          return Colors.white; // Color when the switch is "off"
                        },
                      ),
                      activeTrackColor: Colors.green,
                      value: value,
                      onChanged: (v) {
                        setState(() {
                          value = v;
                        });
                      }),
                ),
                //subtitle
              ),
            )),
        Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: mq.height * .01),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),

                title: Text('Privacy Protection'),
                trailing: Transform.scale(
                  scale: 1.3,
                  child: Switch(
                      inactiveTrackColor:
                          const Color.fromARGB(255, 243, 243, 244),
                      thumbColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          // Use different colors for the thumb based on the state of the switch
                          if (states.contains(MaterialState.selected)) {
                            return Colors
                                .white; // Color when the switch is "on"
                          }
                          return Colors.white; // Color when the switch is "off"
                        },
                      ),
                      activeTrackColor: Colors.green,
                      value: value1,
                      onChanged: (v) {
                        setState(() {
                          value1 = v;
                        });
                      }),
                ),
                //subtitle
              ),
            )),
        Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: mq.height * .01),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),

                title: Text('Ultra Data Saving Mode'),
                trailing: Transform.scale(
                  scale: 1.3,
                  child: Switch(
                      inactiveTrackColor:
                          const Color.fromARGB(255, 243, 243, 244),
                      thumbColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          // Use different colors for the thumb based on the state of the switch
                          if (states.contains(MaterialState.selected)) {
                            return Colors
                                .white; // Color when the switch is "on"
                          }
                          return Colors.white; // Color when the switch is "off"
                        },
                      ),
                      activeTrackColor: Colors.green,
                      value: value2,
                      onChanged: (v) {
                        setState(() {
                          value2 = v;
                        });
                      }),
                ),
                //subtitle
              ),
            )),
        Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: mq.height * .01),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),

                title: Text('Auto Reconnect'),
                trailing: Transform.scale(
                  scale: 1.3,
                  child: Switch(
                      inactiveTrackColor:
                          const Color.fromARGB(255, 243, 243, 244),
                      thumbColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          // Use different colors for the thumb based on the state of the switch
                          if (states.contains(MaterialState.selected)) {
                            return Colors
                                .white; // Color when the switch is "on"
                          }
                          return Colors.white; // Color when the switch is "off"
                        },
                      ),
                      activeTrackColor: Colors.green,
                      value: value3,
                      onChanged: (v) {
                        setState(() {
                          value3 = v;
                        });
                      }),
                ),
                //subtitle
              ),
            )),
        Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: mq.height * .01),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),

                title: Text('Auto Connect'),
                trailing: Transform.scale(
                  scale: 1.3,
                  child: Switch(
                      inactiveTrackColor:
                          const Color.fromARGB(255, 243, 243, 244),
                      thumbColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          // Use different colors for the thumb based on the state of the switch
                          if (states.contains(MaterialState.selected)) {
                            return Colors
                                .white; // Color when the switch is "on"
                          }
                          return Colors.white; // Color when the switch is "off"
                        },
                      ),
                      activeTrackColor: Colors.green,
                      value: value3,
                      onChanged: (v) {
                        setState(() {
                          value3 = v;
                        });
                      }),
                ),
                //subtitle
              ),
            )),
        SizedBox(
          height: mq.height * .02,
        ),
        Container(
          height: mq.height * .07,
          width: mq.width * .2,
          child: Center(
            child: Text('Save Settings',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
          ),
          decoration: BoxDecoration(
              color: bgcolr, borderRadius: BorderRadius.circular(26)),
        ),
        SizedBox(
          height: mq.height * .05,
        ),
        Container(
          height: mq.height * .11,
          width: mq.width * .2,
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: bgcolr,
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/king.png')),
              ),
              SizedBox(
                width: mq.width * .05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  Text(
                    'Upgrade to Premium',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Get A Server With Fast And Stable Network Quality',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 243, 244),
              borderRadius: BorderRadius.circular(12)),
        )
      ],
    );
  }
}

class Locations extends StatelessWidget {
  const Locations({
    super.key,
    required this.ipData,
  });

  final Rx<IPDetails> ipData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolr,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
            backgroundColor: bgcolr,
            onPressed: () {
              ipData.value = IPDetails.fromJson({});
              APIs.getIPDetails(ipData: ipData);
            },
            child: Icon(CupertinoIcons.refresh)),
      ),
      body: Obx(
        () => ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
                left: mq.width * .04,
                right: mq.width * .04,
                top: mq.height * .01,
                bottom: mq.height * .1),
            children: [
              //isizedp
              SizedBox(
                height: mq.height * .10,
              ),
              NetworkCard(
                  data: NetworkData(
                      title: 'IP Address',
                      subtitle: ipData.value.query,
                      icon: Icon(CupertinoIcons.location_solid,
                          color: Colors.blue))),

              //isp
              NetworkCard(
                  data: NetworkData(
                      title: 'Internet Provider',
                      subtitle: ipData.value.isp,
                      icon: Icon(Icons.business, color: Colors.orange))),

              //location
              NetworkCard(
                  data: NetworkData(
                      title: 'Location',
                      subtitle: ipData.value.country.isEmpty
                          ? 'Fetching ...'
                          : '${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}',
                      icon: Icon(CupertinoIcons.location, color: Colors.pink))),

              //pin code
              NetworkCard(
                  data: NetworkData(
                      title: 'Pin-code',
                      subtitle: ipData.value.zip,
                      icon: Icon(CupertinoIcons.location_solid,
                          color: Colors.cyan))),

              //timezone
              NetworkCard(
                  data: NetworkData(
                      title: 'Timezone',
                      subtitle: ipData.value.timezone,
                      icon: Icon(CupertinoIcons.time, color: Colors.green))),
            ]),
      ),
    );
  }
}
