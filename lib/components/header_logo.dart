import 'package:flutter/material.dart';

import '../constants.dart';


class HeaderLogo extends StatelessWidget {


  final String title;

  HeaderLogo({required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.only(top: 55.0),
         child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Image.asset(
             'images/logo.png',
             width: 36,
             height:36,
           ),
           SizedBox(width: 12),
           Text(
              title,
             style: TextStyle(
               fontSize: 38,
               color: mTitleTextColor,
               fontWeight: FontWeight.bold,
             ),
           ),
         ],
       ),
    );
  }
}