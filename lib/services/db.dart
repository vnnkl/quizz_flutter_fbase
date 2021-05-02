import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import './globals.dart';

class Document<T> {
  final Firestore _db = Firestore.instance;
  final String path;

  DocumentReference ref;

  Document({this.path}) {
    ref = _db.document(path);
  }

  Future<T> getData() {
    return ref.get().then((snapshot) => Global.models[T](snapshot.data) as T);
  }

  Stream<T> streamData() {
    return ref
        .snapshots()
        .map((snapshot) => Global.models[T](snapshot.data) as T);
  }
}

class Collection<T> {
  final Firestore _db = Firestore.instance;
  final String path;

  CollectionReference ref;

  Collection({this.path}) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    var snapshots = await ref.getDocuments();

    return snapshots.documents
        .map((doc) => Global.models[T](doc.data) as T)
        .toList();
  }

  Stream<List<T>> streamData() {
    return ref.snapshots().map((list) =>
        list.documents.map((doc) => Global.models[T](doc.data) as T).toList());
  }
}

class UserData<T> {
  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collection;

  UserData({this.collection});

  Stream<T> documentStream() {

    return _auth.onAuthStateChanged.switchMap((user) {
        if (user != null){

          Document doc = Document<T>(path:'$collection/${user.uid}');
          return doc.streamData();
        } else {
          return Stream<T>.value(null);
        }



    });
  }

  Future<T> getDocument() async {
    FirebaseUser user = await _auth.currentUser();

    if (user != null){
      Document doc = Document<T>(path:'$collection/${user.uid}');
      return doc.getData();
    } else {
      return null;
    }

  }
 

}
