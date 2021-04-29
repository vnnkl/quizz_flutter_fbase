import 'package:flutter/material.dart';
import 'package:quizz_flutter_fbase/shared/bottom_nav.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topics'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Different topics listed here'),
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
