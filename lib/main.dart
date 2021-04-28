import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Firebase Analytics
      navigatorObserver: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],

      routes: {
        '/': (context) => LoginScreen(),
        '/topics': (context) => TopicsScreen(),
        '/profile': (context) => ProfileScreen(),
        '/about': (context) => AboutScreen(),
      },

      // Theme
      theme: ThemeData (
        fontFamily: 'Nunito',
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.black87,
        ),
        brightness: Brightness.dark,
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 18),
          body2: TextStyle(fontSize: 16),
          button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
          headline: TextStyle(fontWeight: FontWeight.bold),
          subhead: TextStyle(color: Colors.grey),
        )
      ),
    );
  }
}
