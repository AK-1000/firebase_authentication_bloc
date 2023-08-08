import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart'
as phone_auth;

class PhoneAuthRepository {
  final phone_auth.FirebaseAuth _phoneAuth;
  String verificationId = '';

  PhoneAuthRepository({phone_auth.FirebaseAuth? phoneAuth})
      : _phoneAuth = phoneAuth ?? phone_auth.FirebaseAuth.instance;

  Future<void> verifyPhone(String phone) async {
    await _phoneAuth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (phone_auth.PhoneAuthCredential credential) async {
        await _phoneAuth.signInWithCredential(credential);
      },
      verificationFailed: (phone_auth.FirebaseAuthException e) {},
      codeSent: (String verificationId, int? forceResendingToken) async {
        verificationId = verificationId;
      },
      timeout: const Duration(seconds: 6),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifySMS({
    required String userID,
    required String smsCode,
    required String phone,
  }) async {
    // phone_auth.PhoneAuthCredential credential =
    // phone_auth.PhoneAuthProvider.credential(
    //   verificationId: verificationId,
    //   smsCode: smsCode,
    // );
    try {
      // phone_auth.UserCredential userCredential =
      // await _phoneAuth.signInWithCredential(credential);
      updatePhone(userID: userID, phone: phone);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updatePhone({
    required String userID,
    required String phone,
  }) async {
    try {
      DocumentReference docRef =
      FirebaseFirestore.instance.collection('users').doc(userID);

      await docRef.update({
        'Phone': phone,
      });
    } catch (error) {
      print("Error is $error");
    }
  }
}
