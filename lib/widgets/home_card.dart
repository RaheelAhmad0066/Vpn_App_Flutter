import 'package:flutter/material.dart';

import '../main.dart';

//card to represent status in home screen
class HomeCard extends StatelessWidget {
  final String title, subtitle;
  final Widget icon;

  const HomeCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: mq.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon

            Center(child: icon),
            SizedBox(
              width: 10,
            ),
            //for adding some space
            const SizedBox(height: 6),

            //title
            Text(
              title,
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.w500),
              overflow: TextOverflow.clip,
            ),

            //for adding some space
            const SizedBox(height: 6),

            //subtitle
            Text(
              subtitle,
              style: TextStyle(
                  color: Theme.of(context).lightText,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ],
        ));
  }
}
