import 'package:flutter/material.dart';
import 'package:quizz_flutter_fbase/shared/bottom_nav.dart';
import 'package:quizz_flutter_fbase/services/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key key}) : super(key: key);

  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    
    var user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName ?? 'Guest'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(user.photoUrl != null)
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user.photoUrl),
                ),
              ),
            ),
            Text(user.email ?? '', style: Theme.of(context).textTheme.headline5),
            Spacer(),
            CupertinoButton(
              child: Text('Logout'),
              color: Colors.red,
              onPressed: () async {
                await auth.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
