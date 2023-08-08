import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_authentication_bloc/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseDataSource {
  final _firebaseFirestore = FirebaseFirestore.instance;


  auth.User get currentUser {
    final user = auth.FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  Stream<User> getUserDetails() {
    return _firebaseFirestore
        .collection('users')
        .doc(currentUser.uid)
        .snapshots()
        .map((user) => !user.exists ? User.empty : User.fromMap(user.data()!));
  }

  Future<void> updateDetails({required User user}) async {
    try {
      DocumentReference docRef =
          _firebaseFirestore.collection('users').doc(currentUser.uid);
      await docRef.update(user.toFirebaseMap());
    } catch (error) {
      print("Error is $error");
    }
  }

  Future<void> updatePhone({required String phone}) async {
    try {
      DocumentReference docRef =
          _firebaseFirestore.collection('users').doc(currentUser.uid);
      await docRef.update({'Phone': phone});
    } catch (error) {
      print("Error is $error");
    }
  }
}
