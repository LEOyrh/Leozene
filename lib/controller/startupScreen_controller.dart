import 'package:flutter/material.dart';
import "../view/startupScreen.dart";
import '../view/signupScreen.dart';
import '../model/user.dart';
import '../model/song.dart';
import '../model/playlist.dart';
import '../view/mydialog.dart';
import '../controller/myfirebase.dart';
import '../view/homeScreen.dart';

class StartupScreenController {
  StartupScreenState state;

  StartupScreenController(this.state);

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter a valid Email';
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validatePassword(String value) {
    if (value == null || value.length < 6) {
      return 'Enter a valid Password';
    }
    return null;
  }

  void savePassword(String value) {
    state.user.password = value;
  }

  void signIn() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }
    state.formKey.currentState.save();

    MyDialog.showProgressBar(state.context);
    try {
      state.user.uid = await MyFirebase.signin(
        email: state.user.email,
        password: state.user.password,
      );
    } catch (e) {
      MyDialog.popProgressBar(state.context);
      MyDialog.info(
        context: state.context,
        title: 'Login Error',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );
      return; // do not proceed pass this pt if abv cannot pass
    }

    // login success -> read user profile
    try {
      User user = await MyFirebase.readProfile(state.user.uid);

      state.user.username = user.username;
      state.user.imageURL = user.imageURL;
      state.user.email = user.email;
      state.user.password = user.password;
    } catch (e) {
      // no displayName and zip can be updated
      print('*********READPROFILE' + e.toString());
    }

    List<Song> songlist;
    List<Playlist> playlist;

    try {
      playlist = await MyFirebase.getPlaylist(state.user.email);
      songlist = await MyFirebase.getSong(state.user.email);
    } catch (e) {
      playlist = <Playlist>[];
      print("PLAYLiST LENGTH: " + playlist.length.toString());
      songlist = <Song>[];
      print("SONGLiST LENGTH: " + songlist.length.toString());
    }

    // read book reviews this user has created
    MyDialog.popProgressBar(state.context);

    MyDialog.info(
      context: state.context,
      title: 'Sign In Success',
      message: 'Press <Ok> to go to HomeScreen',
      action: () {
        Navigator.pop(state.context); // dispose this dialog
        Navigator.push(
          state.context,
          MaterialPageRoute(
            // 2nd param, pass list of books to homepage too
            builder: (context) => HomeScreen(state.user, playlist, songlist),
          ),
        ).then((val) => state.formKey.currentState.reset());
      },
    );
  }

  void signUp() {
    Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => SignupScreen(),
        ));
  }
}
