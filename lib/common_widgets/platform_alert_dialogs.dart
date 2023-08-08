import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showExitDialog(BuildContext context) async {
  if (Platform.isAndroid) {
// Show the Android dialog and wait for its result
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

// Return the result of the dialog
    return result ?? false; // default to false if result is null
  } else if (Platform.isIOS) {
// Show the iOS dialog and wait for its result
    final result = await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: [
          CupertinoDialogAction(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
          CupertinoDialogAction(
            child: Text('Yes'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

// Return the result of the dialog
    return result ?? false; // default to false if result is null
  } else {
// Return true as a default value for other platforms (e.g. web)
    return true;
  }
}

Future<bool> firebaseAuthExceptionDialog(
    BuildContext context, FirebaseAuthException e) async {
  String title = '';
  String message = '';
  String positiveButtonLabel = 'OK';

  switch (e.code) {
    case 'invalid-email':
      title = 'Invalid Email';
      message = 'Please enter a valid email address.';
      break;
    case 'wrong-password':
      title = 'Incorrect Password';
      message = 'The password you entered is incorrect. Please try again.';
      break;
    case 'user-not-found':
      title = 'User Not Found';
      message =
          'No user found with that email address. Please check your email and try again.';
      break;
    case 'user-disabled':
      title = 'User Disabled';
      message =
          'Your account has been disabled. Please contact support for assistance.';
      break;
    case 'too-many-requests':
      title = 'Too Many Requests';
      message = 'Too many unsuccessful attempts. Please try again later.';
      break;
    case 'operation-not-allowed':
      title = 'Operation Not Allowed';
      message =
          'This operation is not allowed at the moment. Please try again later.';
      break;
    case 'email-already-in-use':
      title = 'Email Already in Use';
      message =
          'An account with this email address already exists. Please try signing in instead or use a different email address.';
      break;
    case 'weak-password':
      title = 'Weak Password';
      message = 'Please choose a stronger password.';
      break;
    case 'invalid-phone-number':
      title = 'Invalid Phone Number';
      message = 'The provided phone number is not valid.';
      break;
    case 'phone-number-already-exists':
      title = 'Phone number already registered to another user';
      message = 'The provided phone number is not valid.';
      break;
    default:
      title = 'Authentication Error';
      message = 'An unknown error occurred. Please check email and password.';
      break;
  }
  bool result = false;
  if (Platform.isAndroid) {
    result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text(positiveButtonLabel),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  } else if (Platform.isIOS) {
    result = await showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(positiveButtonLabel),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }
  return result;
}

Future<void> showSmsCodeDialog(
    {required BuildContext context,
    required void Function(String)? onChanged,
    required void Function()? onPressed}) async {
  if (Platform.isIOS) {
    // show iOS-style dialog
    await showDialog(
      context: context,
      builder: (_) => Container(
        color: Colors.grey[300],
        child: CupertinoAlertDialog(
          title: Text(
            'Enter 6-PIN Number (OTP Code)',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.ten * 1.8),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CupertinoTextField(
              onChanged: onChanged,
              keyboardType: TextInputType.number,
              maxLength: 6,
              placeholder: 'SMS code',
            ),
          ),
          actions: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.black,
                  child: CupertinoDialogAction(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: CupertinoDialogAction(
                    child: Text('Submit'),
                    onPressed: onPressed,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  } else {
    // show Android-style dialog
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(
          Dimensions.ten * 3,
          Dimensions.thirty,
          Dimensions.ten * 3,
          0,
        ),
        backgroundColor: Colors.grey[300],
        title: Text(
          'Enter 6-PIN Number (OTP Code)',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.ten * 1.8),
        ),
        content: TextField(
          style: TextStyle(
              letterSpacing: Dimensions.five,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.ten * 1.8,
              color: Colors.black),
          textAlign: TextAlign.center,
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.ten),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.ten),
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "SMS CODE",
              hintStyle: TextStyle(
                  color: Colors.grey[500],
              letterSpacing: Dimensions.one *2)
          ),
        ),
        actions: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text('Submit'),
                onPressed: onPressed,
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<void> getSMSDialog()async {
  if (Platform.isIOS) {
    // show iOS-style dialog
    await Get.dialog(
      Container(
        color: Colors.grey[300],
        child: CupertinoAlertDialog(
          title: Text(
            'Enter 6-PIN Number (OTP Code)',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.ten * 1.8),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CupertinoTextField(
              onChanged: (value)=>(){},
              keyboardType: TextInputType.number,
              maxLength: 6,
              placeholder: 'SMS code',
            ),
          ),
          actions: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.black,
                  child: CupertinoDialogAction(
                    child: Text('Cancel'),
                    onPressed: () => Get.back(),
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: CupertinoDialogAction(
                    child: Text('Submit'),
                    onPressed: (){},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  } else {
    // show Android-style dialog
    await Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(
          Dimensions.ten * 3,
          Dimensions.thirty,
          Dimensions.ten * 3,
          0,
        ),
        backgroundColor: Colors.grey[300],
        title: Text(
          'Enter 6-PIN Number (OTP Code)',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.ten * 1.8),
        ),
        content: TextField(
          style: TextStyle(
              letterSpacing: Dimensions.five,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.ten * 1.8,
              color: Colors.black),
          textAlign: TextAlign.center,
          onChanged: (value) => (){},
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.ten),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.ten),
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "SMS CODE",
              hintStyle: TextStyle(
                  color: Colors.grey[500],
                  letterSpacing: Dimensions.one * 2)
          ),
        ),
        actions: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text('Cancel'),
                onPressed: () => Get.back(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text('Submit'),
                onPressed: (){},
              ),
            ],
          )
        ],
      ),
    );
  }

}
