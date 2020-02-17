import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leozene/view/sharedSongsScreen.dart';
import 'package:path/path.dart' as Path;
import '../controller/myfirebase.dart';
import '../view/homeScreen.dart';
import '../view/searchScreen.dart';
import '../view/profileScreen.dart';
import '../view/mydialog.dart';
import '../model/song.dart';
import '../model/playlist.dart';

class ProfileScreenController {
  ProfileScreenState state;
  //HomeScreenState state;
  //SearchScreenState state2;
  ProfileScreenController(this.state);
  int selectedIndex = 0;
  List<Song> songlist;
  List<Playlist> playlist;

  void signOut() {
    MyFirebase.signOut();
    state.formKey1.currentState.reset();
    Navigator.popUntil(
      state.context,
      ModalRoute.withName(Navigator.defaultRouteName),
    ); // to close the drawer at homepage
    // state.stateChanged(() {
    //   state.formKey.currentState.reset();
    // });
    //Navigator.pop(state.context); // to return to the front page
  }

  void navigate(int index) async {
    if (index == 0) {
      try {
        playlist = await MyFirebase.getPlaylist(state.user.email);
        songlist = await MyFirebase.getSong(state.user.email);
      } catch (e) {
        playlist = <Playlist>[];
        songlist = <Song>[];
      }
      Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(state.user, playlist, songlist),
        ),
      );
    }
    if (index == 1) {
      try {
        playlist = await MyFirebase.getPlaylist(state.user.email);
        songlist = await MyFirebase.getSong(state.user.email);
      } catch (e) {
        playlist = <Playlist>[];
        songlist = <Song>[];
      }
      Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => SearchScreen(state.user, songlist),
        ),
      );
    }
    if (index == 2) {
      Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(state.user),
        ),
      );
    }
  }

  Future chooseImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery); /*.then((image)*/
    state.stateChanged(() {
      state.image = image;
    });
    //});
  }

  Future uploadImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Profiles/${Path.basename(state.image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(state.image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    state.stateChanged(() {
      print("Image uploaded!");
      MyDialog.info(
        context: state.context,
        title: 'Profile Image Upload Success',
        message: 'Press <Ok> to Navigate to ProfileScreen',
        action: () {
          Navigator.pop(state.context); // dispose this dialog
        },
      );
      // Scaffold.of(state.context)
      //     .showSnackBar(SnackBar(content: Text('Profile Image Uploaded')));
    });
    storageReference.getDownloadURL().then((fileURL) async {
      state.stateChanged(() {
        print("File URL is " + fileURL);
        state.uploadedFileURL = fileURL;
        print("uploadedFileURL is " + state.uploadedFileURL);
        state.uploaded = true;
        state.user.imageURL = fileURL;
        state.formKey1.currentState.save();

        var userInfo = new UserUpdateInfo();
        userInfo.photoUrl = fileURL;
        print("UserInfo.photoUrl is " + userInfo.photoUrl);

        //print(userInfo);
      });
      await MyFirebase.updateProfilePic(fileURL, state.user);
    });
  }

  void resetPassw() {
    state.stateChanged(() {
      state.resetPass = true;
    });
  }

  void setPassw() async {
    if (!state.formKey1.currentState.validate()) {
      return;
    }

    state.stateChanged(() {
      state.resetPass = false;
    });
    state.formKey1.currentState.save();

    try {
      await MyFirebase.updatePassword(state.user).then((val) {
        MyFirebase.signOut();
        MyDialog.info(
            context: state.context,
            title: 'Password Change Success',
            message: 'Press <Ok> to resign-in',
            action: () {
              Navigator.popUntil(
                  state.context,
                  ModalRoute.withName(
                      Navigator.defaultRouteName)); // dispose this dialog
            });
      });

      //await MyFirebase.updateEmail(state.user);
      //await MyFirebase.updateProfile(state.user);

    } catch (e) {
      MyDialog.info(
        context: state.context,
        title: 'Firestore Save Error',
        message: 'Firestore is unavailable now. Try again later',
        action: () {
          Navigator.pop(state.context);
          // b null, storing failed
          Navigator.pop(state.context, null);
        },
      );
    }
  }

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
  String validateEmail(String value) {
    if (value == null || !value.contains('@') || !value.contains('.')) {
      return "Please don't leave empty & insert a vald email with @ and .";
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validateUsername(String value) {
    if (value == null || value.length <= 1) {
      return 'Please insert something, and it should be at least more than 1 letter';
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

  String validatePassword(String value) {
    if (value == null) {
      return 'Enter a password';
    }
    return null;
  }

  void savePassword(String value) {
    state.user.password = value;
  }

  void edit() {
    state.stateChanged(() {
      state.onEdit = true;
    });
  }

  void onSave() async {
    if (!state.formKey1.currentState.validate()) {
      return;
    }
    state.stateChanged(() {
      state.onEdit = false;
    });
    state.formKey1.currentState.save();

    try {
      //await MyFirebase.updatePassword(state.user);
      //await MyFirebase.updateEmail(state.user);
      await MyFirebase.updateProfile(state.user);

      MyDialog.info(
          context: state.context,
          title: 'Edit Success',
          message: 'Press <Ok> to go back to Profile',
          action: () {
            Navigator.pop(state.context); // dispose this dialog
          });
    } catch (e) {
      MyDialog.info(
        context: state.context,
        title: 'Firestore Save Error',
        message: 'Firestore is unavailable now. Try again later',
        action: () {
          Navigator.pop(state.context);
          // b null, storing failed
          Navigator.pop(state.context, null);
        },
      );
    }
  }

  Future sharedWifMe() async {
    // param = specify who i am
    List<Song> songs = await MyFirebase.getSongsSharedWithMe(state.user.email);
    print('# of songs: ' + songs.length.toString());
    for (var song in songs) {
      print(song.title);
    }
    // navigate to a new page for SharedBooks
    await Navigator.push(
      state.context,
      MaterialPageRoute(
        builder: (context) => SharedSongsScreen(state.user, songs),
      ),
    );
  }
}
