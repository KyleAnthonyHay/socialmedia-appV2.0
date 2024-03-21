/*
  This database stores post that users have published in an app.
  It's stored in a colelction called post in firebase.

  Each Post contains:
  - a message
  - email or username
  - timestamp

*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firestoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;
  // get collection of post from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');
  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

  // read posts from firebase
  Stream<QuerySnapshot> getPostsStream() {
    final postStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();
    return postStream;
  }
}
