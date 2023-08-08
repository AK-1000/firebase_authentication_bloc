import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_authentication_bloc/Database/firebase_data_source.dart';
import 'package:firebase_authentication_bloc/models/user_model.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseDataSource _db;
  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth, FirebaseDataSource? db})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance, _db = db ?? FirebaseDataSource();
  User currentUser = User.empty;
  String verificationId = '';

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      if (currentUser != User.empty) {
        _addToFirebase(user: user);
      }
      return user;
    });
  }

  Future<void> signUp(
      {required String displayName,
      required String email,
      required String password}) async {
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await authResult.user?.updateDisplayName(displayName);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> logOut() async {
    final googleSignIn = GoogleSignIn();
    Future.wait([_firebaseAuth.signOut(), googleSignIn.signOut()]);
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    //await googleSignIn.disconnect();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      /*if (googleAuth.accessToken != null && googleAuth.idToken != null)*/
      try {
        await _firebaseAuth.signInWithCredential(
          firebase_auth.GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
      } catch (e) {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token! ${e.toString()}');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Error:Signing in process aborted by user!');
    }
  }

  Future<void> _addToFirebase({required User user}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool exists = true;
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(user.id);
      await docRef.get().then((doc) {
        if (!doc.exists) {
          exists = false;
        }
      });
      if (!exists) {
        await docRef.set({
          'UserID': user.id,
          'Display Name': user.name,
          'Email': user.email,
          'Phone': '',
          'City': '',
          'Street': '',
          'Home': '',
        });
      }
      await prefs.setString('userID', user.id);
    } catch (error) {
      print("Error is $error");
    }
  }

  Future<void> verifyPhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted:
          (firebase_auth.PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (firebase_auth.FirebaseAuthException e) {},
      codeSent: (String verificationId, int? forceResendingToken) async {
        await prefs.setString('verificationId', verificationId);
      },
      timeout: const Duration(seconds: 6),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifySMS({
    required String smsCode,
    required String phone,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final verificationId = prefs.getString('verificationId') ?? '';

    firebase_auth.PhoneAuthCredential credential =
        firebase_auth.PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    try {
      _firebaseAuth.currentUser!.updatePhoneNumber(credential);
      await _db.updatePhone(phone: phone);
    } catch (e) {
      print(e.toString());
    }
  }

}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, phone: phoneNumber);
  }
}
