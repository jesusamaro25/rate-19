import 'package:flutter/material.dart';
import 'package:rate_19/screens/welcome_screen.dart';
import 'constants.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor,
      ),
      home: WelcomeScreen(),
    );
  }
}

// initialRoute: '/',
// routes: {
// '/': (context) => WelcomeScreen(),
// '/input': (context) => InputScreen(),
// '/result': (context) => ResultScreen(puntaje: '',
// resultadoTexto: '',
// indicaciones: ''),
// },

