import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Firebase user one-time fetch
  Future<FirebaseUser> get getUser => _auth.currentUser();
  // Firebase user real time stream
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;
  // Determine if apple sign in is available on device
  Future<bool> get isAppleSignInAvailable => AppleSignIn.isAvailable();

  // Sign in with Apple
  Future<FirebaseUser> appleSignIn() async {
    try {
      final AuthorizationResult appleResult =
          await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      if (appleResult != null) {
        // handle apple sign in error
      }

      final AuthCredential credential =
          OAuthProvider(providerId: 'apple.com').getCredential(
        idToken: String.fromCharCodes(appleResult.credential.identityToken),
        accessToken:
            String.fromCharCodes(appleResult.credential.authorizationCode),
      );

      AuthResult firebaseResult = await _auth.signInWithCredential(credential);

      FirebaseUser user = firebaseResult.user;

      // update user Data
      updateUserData(user);

      return user;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<FirebaseUser> anonLogin() async {
    FirebaseUser user = (await _auth.signInAnonymously()).user;
    updateUserData(user);
    return user;
  }

  // Google Sign-In
  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;

      // update User Data
      updateUserData(user);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference reportRef = _db.collection('reports').document(user.uid);

    return reportRef.setData({'uid': user.uid, 'lastActivity': DateTime.now()},
        merge: true);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
