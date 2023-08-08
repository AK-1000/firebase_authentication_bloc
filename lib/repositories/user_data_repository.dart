import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication_bloc/Database/firebase_data_source.dart';
import 'package:firebase_authentication_bloc/models/user_model.dart';

class UserDataRepository {
  final FirebaseDataSource _db = FirebaseDataSource();

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  User currentUser = User.empty;

  Stream<User> getMyUsers() {
    return _db.getUserDetails();
  }

  Future<void> updateDetails({required User user}) async {
    return _db.updateDetails(user: user);
  }
}
