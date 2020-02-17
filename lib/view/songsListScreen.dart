import 'package:flutter/material.dart';
import '../model/user.dart';
import '../controller/songsListScreen_controller.dart';
//import '../view/tabNavigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/song.dart';
import '../model/playlist.dart';

class SongsListScreen extends StatefulWidget {
  final User user;
  final List<Song> songlist;
  final List<Playlist> playlist;

  SongsListScreen(this.user, this.songlist, this.playlist);
  @override
  State<StatefulWidget> createState() {
    return SongsListScreenState(user, songlist, playlist);
  }
}

class SongsListScreenState extends State<SongsListScreen> {
  //final navigatorKey = GlobalKey<NavigatorState>();
  SongsListScreenController controller;
  BuildContext context;
  User user;
  List<Song> songlist;
  //List<Song> newSongList;
  List<Playlist> playlist;
  List<int> deleteIndices;

  //ScreenTab currentScreenTab = ScreenTab.home;
  int currentScreenIndex = 0;

  SongsListScreenState(this.user, this.songlist, this.playlist) {
    controller = SongsListScreenController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
          textTheme: Typography(platform: TargetPlatform.iOS).white,
          fontFamily: 'Quantum',
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          //FloatingActionButton(
          //   backgroundColor: Colors.white,
          //   child: Container(
          //     padding: EdgeInsets.only(
          //       left: 8.0,
          //     ),
          //     child: Text(
          //       "Add Song",
          //       style: TextStyle(color: Colors.black),
          //     ),
          //   ),
          // Icon(
          //   Icons.add,
          //   color: Colors.black,
          // ),
          //   onPressed: controller.addSong,
          // ),
          body: ListView.builder(
            itemCount: songlist.length,
            itemBuilder: (BuildContext context, int index) {
              return
                  //songlist[index].genre == playlist[index].genre
                  //? Container()
                  Container(
                padding: EdgeInsets.all(5.0),
                color: deleteIndices != null && deleteIndices.contains(index)
                    ? Colors.cyan[200]
                    : Colors.black,
                child: ListTile(
                    leading: FittedBox(
                      child: Card(
                        elevation: 20,
                        child: CachedNetworkImage(
                          imageUrl: songlist[index].artWork,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline),
                        ),
                      ),
                    ),
                    title: Text(songlist[index].title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            songlist[index].artist,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        songlist[index].featArtist == null ||
                                songlist[index].featArtist.isEmpty
                            ? Container()
                            : Text(
                                'Feat. ' +
                                    songlist[index]
                                        .featArtist
                                        .toString()
                                        .replaceAll("[]", ""),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                        Row(
                          children: <Widget>[
                            Text(
                              songlist[index].pubyear.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 200),
                            ),
                            Container(
                              child: Text(
                                songlist[index].genre,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // need func def no func call
                    // onTap: controller.onTap(index) wrong
                    onTap: () => controller
                        .nowPlaying(index), //=> controller.onTap(index),
                    onLongPress: () {} //=> controller.longPress(index),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
