import '../controller/myfirebase.dart';
import 'package:flutter/material.dart';
import '../view/playlistScreen.dart';
import '../view/mydialog.dart';

class PlaylistScreenController {
  // bookpage state obj as instance member
  PlaylistScreenState state;
  // String _extension;
  // FileType _fileType = FileType.AUDIO;
  // dynamic playlistPath;
  // List<StorageUploadTask> _tasks = <StorageUploadTask>[];
  // constructor receives state obj
  PlaylistScreenController(this.state);

  String validateArtworkUrl(String value) {
    if (value == null || value.length < 5) {
      return 'Enter Image URL beginning with http';
    }
    return null;
  }

  void saveArtworkUrl(String value) {
    state.playlistCopy.imageUrl = value;
  }

  String validateTitle(String value) {
    if (value == null || value.length < 2) {
      return 'Enter playlist title';
    }
    return null;
  }

  void saveTitle(String value) {
    state.playlistCopy.title = value;
  }

  String validateCreator(String value) {
    if (value == null || value.length < 3) {
      return 'Enter playlist artist';
    }
    return null;
  }

  void saveCreator(String value) {
    state.playlistCopy.creator = value;
  }

  String validateGenre(String value) {
    if (value == null || value.length < 3) {
      return 'Enter playlist genre';
    }
    return null;
  }

  void saveGenre(String value) {
    state.playlistCopy.genre = value;
  }

  String validateSharedWith(String value) {
    // empty, or after leading/trailing blanks, still empty
    // its good not sharing
    if (value == null || value.trim().isEmpty) {
      return null; // not sharing
    }
    // comma seperated list comes in, chk if its email
    // use comma as token split long list
    for (var email in value.split(',')) {
      if (!(email.contains('.') && email.contains('@'))) {
        return 'Enter comma(,) seperated email list';
      }
      // if there is multiple @ signs, index from beginning
      // and the last same, those are same, than only 1
      // if diff theres more than 1 @
      if (email.indexOf('@') != email.lastIndexOf('@')) {
        return 'Enter comma(,) seperated email list';
      }
    }
    return null;
  }

  void saveSharedWith(String value) {
    if (value == null || value.trim().isEmpty) {
      return; // dont do anything

    }
    state.playlistCopy.sharedWith = [];
    // value one long list, we split with func call
    // and generate a list of string type email list
    // one long string converted to list, and each element is an email
    List<String> emaillist = value.split(',');
    for (var email in emaillist) {
      // trim the leading/trailing whitespaces in each email seperated by comma
      // add in sharewith list
      state.playlistCopy.sharedWith.add(email.trim());
    }
  }

  void add() async {
    // fails return nothing
    // documentId comes from this call and saved

    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    state.playlistCopy.createdBy = state.user.email;
    state.playlistCopy.lastUpdatedAt = DateTime.now();

    // check firebase addbook successful or not
    try {
      if (state.playlist == null) {
        // addButton to add book if empty
        state.playlistCopy.playlistId =
            await MyFirebase.addPlaylist(state.playlistCopy);
      } else {
        // from homepage to edit a book
        await MyFirebase.updatePlaylist(state.playlistCopy);
      }

      // pass a value back to caller, which is 2nd argument
      // book just stored in firestore
      // using 2nd arg, caller in homepage addbutton could receive return val
      Navigator.pop(state.context, state.playlistCopy);
    } catch (e) {
      // if any error occur in firestore, than give null val
      // b in homepage add is null, it wasnt successfully store
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

    // state.stateChanged(() {
    //   state.audio = null;
    // });
  }
}
