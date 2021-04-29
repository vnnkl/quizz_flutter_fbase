import 'package:flutter/material.dart';
import 'package:quizz_flutter_fbase/shared/bottom_nav.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('About this app'),
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
