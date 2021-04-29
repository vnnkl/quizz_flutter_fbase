import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.graduationCap, size: 20),
          label: 'Topics',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.bolt, size: 20),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.userCircle, size: 20),
          label: 'Profile',
        ),
      ].toList(),
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // nothing as we are on the right screen
            Navigator.pushNamed(context, '/topics');
            break;
          case 1:
            Navigator.pushNamed(context, '/about');
            break;
          case 2:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
