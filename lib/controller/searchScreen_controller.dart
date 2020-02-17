import 'package:flutter/material.dart';
import '../view/searchScreen.dart';
import '../view/homeScreen.dart';
import '../view/profileScreen.dart';
import '../model/song.dart';
import '../model/playlist.dart';
import '../controller/myfirebase.dart';

class SearchScreenController {
  SearchScreenState state;
  //HomeScreenState state;
  //ProfileScreenState state2;
  SearchScreenController(this.state);
  int selectedIndex = 0;
  List<Song> songlist;
  List<Playlist> playlist;

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
}
