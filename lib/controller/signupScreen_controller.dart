import 'package:flutter/material.dart';
import '../controller/myfirebase.dart';
import '../view/mydialog.dart';

import '../view/signupScreen.dart';
//import '../controller/myfirebase.dart';
//import '../view/mydialog.dart';

class SignupScreenController {
  SignupScreenState state;
  SignupScreenController(this.state);

  List<String> badwords = [
    'fuck',
    'Fuck',
    'Asshole',
    'asshole',
    'shit',
    'Shit',
    'bitch',
    'Bitch',
    'dick',
    'Dick',
  ];

  String validateUsername(String value) {
    if (value == null || value.length < 3) {
      return 'Enter at least 3 chars';
    }
    for (String word in badwords) {
      if (value == word) {
        return 'Display name cannot be a offensive or obscene word';
      }
    }
    return null;
  }

  void saveUsername(String value) {
    state.user.username = value;
  }

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter a valid Email address';
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validatePassword(String value) {
    if (value == null || value.length < 6) {
      return 'Enter a password with at least 6 characters';
    }
    return null;
  }

  void savePassword(String value) {
    state.user.password = value;
  }

  void signup() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    // using email/password: sign up an account at Firebase

    MyDialog.showProgressBar(state.context);
    try {
      // create acc timeconsuming, need await
      state.user.uid = await MyFirebase.createAccount(
        email: state.user.email,
        password: state.user.password,
      );
    } catch (e) {
      // unsuccessful
      MyDialog.popProgressBar(state.context);
      MyDialog.info(
        context: state.context,
        title: 'Account creation failed!',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );

      return; // do not proceed if gets here
    }
    // create user profile in firestore db
    try {
      MyFirebase.createProfile(state.user);
    } catch (e) {
      state.user.username = null;
    }

    MyDialog.popProgressBar(state.context);

    // successful
    MyDialog.info(
        context: state.context,
        title: 'Leozene Account Created Successfully!',
        message:
            'Your Leozene account was created with ${state.user.email}, now go sign in!',
        action: () {
          Navigator.pop(state.context);
          Navigator.pop(state.context);
        });
  }
}
