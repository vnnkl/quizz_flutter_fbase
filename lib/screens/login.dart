import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizz_flutter_fbase/shared/shared.dart';
import 'package:quizz_flutter_fbase/services/services.dart';
import 'package:apple_sign_in/apple_sign_in.dart' as Apple;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/topics');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlutterLogo(
            size: 150,
          ),
          Text(
            'Login to Start',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          Text('Your Tagline'),
          LoginButton(
            text: 'Login with Google',
            icon: FontAwesomeIcons.google,
            color: Colors.black45,
            loginMethod: auth.googleSignIn,
          ),
          FutureBuilder<Object>(
              future: auth.isAppleSignInAvailable,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return Apple.AppleSignInButton(
                    style: Apple.ButtonStyle.black,
                    onPressed: () async {
                      FirebaseUser user = await auth.appleSignIn();

                      if (user != null) {
                        Navigator.pushReplacementNamed(context, '/topics');
                      }
                    },
                  );
                } else {
                  return Container();
                }
              }),
          LoginButton(text: 'Continue as Guest', loginMethod: auth.anonLogin),
        ],
      ),
    ));
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.color, this.icon, this.text, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center),
        ),
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/topics');
          }
        },
      ),
    );
  }
}
