import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';
import '../model/song.dart';
import '../model/playlist.dart';

class MyFirebase {
// static to call func w/o cr8ing obj
  // need future as system await to return uid
  static Future<String> createAccount({String email, String password}) async {
    // returns uid
    AuthResult auth =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return auth.user.uid;
  }

  static Future<String> signin({String email, String password}) async {
    AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user.uid;
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }

  static void createProfile(User user) async {
    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .setData(user.serialize());

    // await Firestore.instance
    //     .collection(Song.SONG_COLLECTION)
    //     .document(user.uid)
    //     .setData(user.serialize());

    // await Firestore.instance
    //     .collection(Playlist.PLAYLIST_COLLECTION)
    //     .document(user.uid)
    //     .setData(user.serialize());
  }

  static Future<User> readProfile(String uid) async {
    DocumentSnapshot doc = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(uid)
        .get();
    return User.deserialize(doc.data);
  }

  static Future<String> addSong(Song song) async {
    // save it from firstore instance
    // collection name is Song.SONG_COLLECTION
    // add function after serialized data
    // returns document reference type
    DocumentReference ref = await Firestore.instance
        .collection(Song.SONG_COLLECTION)
        .add(song.serialize());
    return ref.documentID;
  }

  static Future<String> addPlaylist(Playlist playlist) async {
    // save it from firstore instance
    // collection name is Playlist.PLAYLIST_COLLECTION
    // add function after serialized data
    // returns document reference type
    DocumentReference ref = await Firestore.instance
        .collection(Playlist.PLAYLIST_COLLECTION)
        .add(playlist.serialize());
    return ref.documentID;
  }

  static Future<void> updateSong(Song song) async {
    await Firestore.instance
        .collection(Song.SONG_COLLECTION)
        .document(song.songId)
        .setData(song
            .serialize()); // serialized for keymap val, if book exist, corresponding book updated
  }

  static Future<void> updatePlaylist(Playlist playlist) async {
    await Firestore.instance
        .collection(Playlist.PLAYLIST_COLLECTION)
        .document(playlist.playlistId)
        .setData(playlist
            .serialize()); // serialized for keymap val, if book exist, corresponding book updated
  }

  static Future<List<Song>> getSong(String email) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(Song.SONG_COLLECTION)
        .where(Song.CREATEDBY, isEqualTo: email)
        .getDocuments();
    var songlist = <Song>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return songlist;
    }

    for (DocumentSnapshot doc in querySnapshot.documents) {
      songlist.add(Song.deserialize(doc.data, doc.documentID));
    }
    return songlist;
  }

  static Future<List<Playlist>> getPlaylist(String email) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(Playlist.PLAYLIST_COLLECTION)
        .where(Playlist.CREATEDBY, isEqualTo: email)
        .getDocuments();
    var playlist = <Playlist>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return playlist;
    }

    for (DocumentSnapshot doc in querySnapshot.documents) {
      playlist.add(Playlist.deserialize(doc.data, doc.documentID));
    }
    return playlist;
  }

  static Future<List<Song>> getSongsSharedWithMe(String email) async {
    try {
      // get song
      // 1st where the array contains, then order by the below
      // each uses a key and firebase will throw a precondition indexing issue
      // have to build index for each query in FireStore
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection(Song.SONG_COLLECTION)
          .where(Song.SHAREDWITH, arrayContains: email) // access request
          .orderBy(Song.CREATEDBY)
          .orderBy(Song.LASTUPDATEDAT)
          .getDocuments();
      var songs = <Song>[];
      if (querySnapshot == null || querySnapshot.documents.length == 0) {
        return songs;
      }
      for (DocumentSnapshot doc in querySnapshot.documents) {
        songs.add(Song.deserialize(doc.data, doc.documentID));
      }
      return songs;
    } catch (e) {
      throw e;
    }
  }

  static Future<void> updateProfile(User user) async {
    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .setData(user
            .serialize()); // serialized for keymap val, if user exist, corresponding user updated
  }

  static Future<void> updateProfilePic(dynamic picURL, User user) async {
    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        //.setData(user.serialize()
        .updateData({'imageURL': picURL}).then((val) {
      print('Updated');
    }).catchError((e) {
      print(e);
    }); // serialized for keymap val, if user exist, corresponding user updated
  }

  static Future<void> updateSongURL(dynamic songURL, Song song) async {
    await Firestore.instance
        .collection(Song.SONG_COLLECTION)
        .document(song.songId)
        //.setData(user.serialize()
        .updateData({'songURL': songURL}).then((val) {
      print('Updated');
    }).catchError((e) {
      print(e);
    }); // serialized for keymap val, if user exist, corresponding user updated
  }
  //   var userInfo = new UserUpdateInfo();
  //   userInfo.photoUrl = picURL;

  // await FirebaseAuth.instance.updateProfile(userInfo).then((val){
  //   FirebaseAuth.instance.currentUser().then((user) {
  //       Firestore.instance
  //   });
  // });
  // await Firestore.instance
  //     .collection(User.PROFILE_COLLECTION)
  //     .document(user.uid)
  //     .setData(user
  //         .serialize()); // serialized for keymap val, if user exist, corresponding user updated

  static Future<void> updateEmail(User user) async {
    //FirebaseUser user1 = await FirebaseAuth.instance.currentUser();
    // user.updateEmail(user.email).then((_) {}).catchError((error) {
    //   print("Email can't be changed" + error.toString());
    // });
    // AuthCredential credential = EmailAuthProvider.getCredential(
    //     email: user.email, password: user.password);
    //  FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential).then((_) {
    //   print('User successfully reauthenticated');
    //   // User successfully reauthenticated. New ID tokens should be valid.
    // }).catchError((error) {
    //   // An error occurred.
    //   print('User reauthentication failed');
    // });
    FirebaseUser user1 = await FirebaseAuth.instance.currentUser();
    if (user.email != user1.email) {
      user1.updateEmail(user.email).then((_) {}).catchError((error) {
        print(
            "Please sign out and sign in to reauthenticate after updating email or password" +
                error.toString());
      });
    } else {}
    // AuthCredential credential = EmailAuthProvider
    //             .getCredential(email: user.email, password: user.password );
    // FirebaseUser user1 = await FirebaseAuth.instance.currentUser();
    //     // Get auth credentials from the user for re-authentication
    //      // Current Login Credentials \\
    //     // Prompt the user to re-provide their sign-in credentials
    //     user1.reauthenticateWithCredential(credential)
    //             .addOnCompleteListener(new OnCompleteListener<Void>() {
    //                 @Override
    //                 public void onComplete(@NonNull Task<Void> task) {
    //                     Log.d(TAG, "User re-authenticated.");
    //                     //Now change your email address \\
    //                     //----------------Code for Changing Email Address----------\\
    //                     FirebaseUser user = FirebaseAuth.getInstance().getCurrentUser();
    //                     user.updateEmail("user@example.com")
    //                             .addOnCompleteListener(new OnCompleteListener<Void>() {
    //                                 @Override
    //                                 public void onComplete(@NonNull Task<Void> task) {
    //                                     if (task.isSuccessful()) {
    //                                         Log.d(TAG, "User email address updated.");
    //                                     }
    //                                 }
    //                             });
    //                     //----------------------------------------------------------\\
    //                 }
    //             });
  }

  static Future<void> updatePassword(User user) async {
    FirebaseUser user1 = await FirebaseAuth.instance.currentUser();
    user1.updatePassword(user.password).then((_) {}).catchError((error) {
      print(
          "Please sign out and sign in to reauthenticate after updating email or password" +
              error.toString());
    });
  }
  // MyFirebase.initializeApp(
  //     {credential: MyFirebase.credential.applicationDefault(),
  //     databaseURL:
  //         'https://console.firebase.google.com/u/0/project/leozene-4e46e/database/firestore/data~2F'});
}
