import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/user.dart';
import '../model/playlist.dart';
import '../controller/playlistScreen_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlaylistScreen extends StatefulWidget {
  // changes should be done within state object, these should be unchangeable
  final User user;
  final Playlist playlist;

  // bookpage constructor to store user and book info pass
  PlaylistScreen(this.user, this.playlist);

  @override
  State<StatefulWidget> createState() {
    // state we need to pass these info as well
    return PlaylistScreenState(user, playlist);
  }
}

class PlaylistScreenState extends State<PlaylistScreen> {
  // book and user info received
  User user;
  Playlist playlist;
  Playlist playlistCopy;
  PlaylistScreenController controller;
  var formKey = GlobalKey<FormState>();
  String audio;
  dynamic uploadedFileURL;
  bool playlistLoaded = false;
  bool sharing = false;
  bool imageGOT = false;
  bool clicked = false;
  String tempURL = "";
  var textColor = Colors.black;

  // controller cr8ed inside constructor
  PlaylistScreenState(this.user, this.playlist) {
    // we pass the current state obj
    controller = PlaylistScreenController(this);
    if (playlist == null) {
      // addButton
      playlistCopy = Playlist.empty();
    } else {
      // this is only copying addr
      // but cuz of sharedby we need actual copy
      playlistCopy = Playlist.clone(playlist); //clone
    }
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  // void onClick() {
  //   stateChanged(() {
  //     clicked = true;
  //     controller.choosePlaylist();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
          textTheme: Typography(platform: TargetPlatform.iOS).white,
          fontFamily: 'Quantum',
        ),
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.black,
            title: Text(
              'Add Playlist',
            ),
          ),
          body: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                ),
                playlistCopy.imageUrl == null ||
                        playlistCopy.imageUrl.isEmpty ||
                        imageGOT == false
                    ? Image.asset(
                        "assets/images/PlaylistNezuko_anime_design.png",
                        width: 300,
                        height: 300,
                      )
                    : CachedNetworkImage(
                        imageUrl: playlistCopy.imageUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error_outline, size: 250),
                        height: 250,
                        width: 250,
                      ),
                // playlistLoaded == false
                //     ? ButtonTheme(
                //         minWidth: 500,
                //         height: 60,
                //         buttonColor: Colors.black,
                //         child: RaisedButton(
                //           child: Text(
                //             'Choose Playlist',
                //             style: TextStyle(
                //               fontSize: 40,
                //               color: Colors.white,
                //             ),
                //           ),
                //           onPressed: controller.choosePlaylist,
                //         ),
                //       )
                //     : ButtonTheme(
                //         minWidth: 500,
                //         height: 60,
                //         buttonColor: Colors.black,
                //         child: RaisedButton(
                //           child: Text(
                //             'Playlist loaded',
                //             style: TextStyle(
                //               fontSize: 40,
                //               color: Colors.greenAccent[200],
                //             ),
                //           ),
                //           onPressed: null,
                //         ),
                //       ),
                TextFormField(
                  onChanged: (text) {
                    stateChanged(() {
                      if (text == null || text.trim().isEmpty) {
                        imageGOT = false;
                        playlistCopy.imageUrl = null;
                      } else {
                        imageGOT = true;
                        playlistCopy.imageUrl = text;
                      }
                    });
                  },
                  initialValue: playlistCopy.imageUrl,
                  decoration: InputDecoration(
                    labelText: 'Artwork',
                  ),
                  style: TextStyle(
                    color: textColor,
                  ),
                  autocorrect: false,
                  validator: controller.validateArtworkUrl,
                  onSaved: controller.saveArtworkUrl,
                ),
                TextFormField(
                  initialValue: playlistCopy.title,
                  decoration: InputDecoration(
                    labelText: 'Playlist Title',
                  ),
                  style: TextStyle(
                    color: textColor,
                  ),
                  autocorrect: false,
                  validator: controller.validateTitle,
                  onSaved: controller.saveTitle,
                ),
                TextFormField(
                  initialValue: playlistCopy.creator,
                  decoration: InputDecoration(
                    labelText: 'Playlist Creator',
                  ),
                  style: TextStyle(
                    color: textColor,
                  ),
                  autocorrect: false,
                  validator: controller.validateCreator,
                  onSaved: controller.saveCreator,
                ),
                // TextFormField(
                //   initialValue: playlistCopy.featArtist.join(',').toString(),
                //   decoration: InputDecoration(
                //     labelText: 'Playlist featuring Artist (seperate with comma)',
                //   ),
                //   style: TextStyle(
                //     color: textColor,
                //   ),
                //   autocorrect: false,
                //   validator: controller.validateFeatArtist,
                //   onSaved: controller.saveFeatArtist,
                // ),
                TextFormField(
                  initialValue: playlistCopy.genre,
                  decoration: InputDecoration(
                    labelText: 'Playlist Genre',
                  ),
                  style: TextStyle(
                    color: textColor,
                  ),
                  autocorrect: false,
                  validator: controller.validateGenre,
                  onSaved: controller.saveGenre,
                ),
                // TextFormField(
                //   initialValue: '${playlistCopy.pubyear}',
                //   decoration: InputDecoration(
                //     labelText: 'Publication Year',
                //   ),
                //   style: TextStyle(
                //     color: textColor,
                //   ),
                //   autocorrect: false,
                //   validator: controller.validatePubyear,
                //   onSaved: controller.savePubyear,
                // ),
                TextFormField(
                  // conversion, array join with comma
                  // each element in list join wif comma and convert to string data
                  onChanged: (text) {
                    stateChanged(() {
                      if (text == null || text.trim().isEmpty) {
                        sharing = false;
                      } else {
                        sharing = true;
                      }
                    });
                  },
                  initialValue: playlistCopy.sharedWith.join(',').toString(),
                  decoration: InputDecoration(
                    labelText: 'Shared with (comma seperated email list)',
                  ),
                  style: TextStyle(
                    color: textColor,
                  ),
                  autocorrect: false,
                  validator: controller.validateSharedWith,
                  onSaved: controller.saveSharedWith,
                  keyboardType: TextInputType.emailAddress,
                ),
                // sharing == true
                //     ? TextFormField(
                //         maxLines: 5,
                //         decoration: InputDecoration(
                //             labelText: 'Review',
                //             hintText:
                //                 'Let ur friend knw they should listen to this now!'),
                //         autocorrect: false,
                //         style: TextStyle(
                //           color: textColor,
                //         ),
                //         initialValue: playlistCopy.review,
                //         validator: controller.validateReview,
                //         onSaved: controller.saveReview,
                //       )
                //     : Container(),
                Text(
                  'CreatedBy: ' + playlistCopy.createdBy,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Last Updated At: ' + playlistCopy.lastUpdatedAt.toString(),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  'DocumentID: ' + playlistCopy.playlistId.toString(),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                RaisedButton(
                  child: Text('Add'),
                  onPressed: controller.add,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
