import 'package:flutter/material.dart';
import '../controller/myfirebase.dart';
import '../view/nowPlayingScreen.dart';
import '../view/songsListScreen.dart';
import '../model/song.dart';
import '../model/playlist.dart';

class SongsListScreenController {
  SongsListScreenState state;
  //NowPlayingScreenState state1;
  //SearchScreenState state1;
  //ProfileScreenState state2;
  SongsListScreenController(this.state);
  int selectedIndex = 0;
  List<Song> songlist;
  List<Playlist> playlist;

  void nowPlaying(int index) async {
    try {
      songlist = await MyFirebase.getSong(state.user.email);
    } catch (e) {
      songlist = <Song>[];
    }
    Navigator.push(
      state.context,
      MaterialPageRoute(
        builder: (context) =>
            NowPlayingScreen(state.user, state.songlist[index]),
      ),
    );
  }
}
