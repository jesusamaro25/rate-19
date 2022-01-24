
import 'package:flutter/material.dart';
import 'package:rate_19/components/header_logo.dart';
import 'package:rate_19/components/image_header.dart';

import '../constants.dart';
import 'input_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 8, child: ImageHeader(height: 535, imageUrl: 'images/doctor.png', child: HeaderLogo(title: 'COVID-19 SPS')),),
          Expanded(
              flex: 2,
              child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [mBackgroundColor, mSecondBackgroundColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: mButtonColor,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => InputScreen()));
                      },
                      child: Text(
                        'Empezar',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      )
                    ),
                  )
                ]
              ),
            )
          )
        ],
      ),
    );
  }
}
