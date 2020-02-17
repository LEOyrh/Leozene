import 'package:flutter/material.dart';
import '../controller/myfirebase.dart';
import '../view/homeScreen.dart';
import '../view/searchScreen.dart';
import '../view/nowPlayingScreen.dart';
import '../view/profileScreen.dart';
import '../view/songsListScreen.dart';
import '../view/songScreen.dart';
import '../view/playlistScreen.dart';
import '../model/song.dart';
import '../model/playlist.dart';

class HomeScreenController {
  HomeScreenState state;
  NowPlayingScreenState state1;
  //SearchScreenState state1;
  //ProfileScreenState state2;
  HomeScreenController(this.state);
  int selectedIndex = 0;
  List<Song> songlist = new List<Song>();
  List<Song> newSongList;
  List<Playlist> playlist;

  // void addSong() async {
  //   Song s = await Navigator.push(
  //       state.context,
  //       MaterialPageRoute(
  //         builder: (context) => SongScreen(state.user, null),
  //       ));
  //   if (s != null) {
  //     // new book stored in Firebase
  //     // then add to our list here
  //     state.songlist.add(s);
  //   } else {
  //     // error occurred in storing in Firebase
  //   }
  // }

  void navigate(int index) async {
    if (index == 0) {
      try {
        state.playlist = await MyFirebase.getPlaylist(state.user.email);
        state.songlist = await MyFirebase.getSong(state.user.email);
      } catch (e) {
        state.playlist = <Playlist>[];
        state.songlist = <Song>[];
      }

      Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(state.user, state.playlist, state.songlist),
        ),
      );
    }
    if (index == 1) {
      try {
        state.playlist = await MyFirebase.getPlaylist(state.user.email);
        state.songlist = await MyFirebase.getSong(state.user.email);
      } catch (e) {
        state.playlist = <Playlist>[];
        state.songlist = <Song>[];
      }
      Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => SearchScreen(state.user, state.songlist),
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

  Future songsList(int index) async {
    bool matchCases = false;
    // try {
    //   playlist = await MyFirebase.getPlaylist(state.user.email);
    // } catch (e) {
    //   playlist = <Playlist>[];
    // }

    //print(state.songlist[0]);
    state.stateChanged(() {
      newSongList = new List<Song>();
    });

    for (Song song in state.songlist) {
      //print(song);
      if (song.genre.toString() == state.playlist[index].genre.toString() &&
          song.genre.length == state.playlist[index].genre.length) {
        // List<Song> tempSongList;
        print("GENRE: " + song.genre);
        newSongList.add(song);
        matchCases = true;
        //state.songlist = newSongList;
        // for (dynamic matchSong in tempSongList) {
        //   newSongList.add(matchSong);
        // }

      } else {
        matchCases = false;
        //newSongList = null;
        //break;
        //return;
      }
    }
    //(matchCases) ? songlist = newSongList : songlist = state.songlist;

    if (matchCases = true && newSongList.length != 0) {
      print("NEWSONGLIST LENGTH: " + newSongList.length.toString());
      Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => SongsListScreen(
            state.user,
            newSongList,
            state.playlist,
          ),
        ),
      );
    } else if (matchCases == false && newSongList.length == 0) {
      print("NEWSONGLIST LENGTH: " + newSongList.length.toString());
      Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => SongsListScreen(
            state.user,
            state.songlist,
            state.playlist,
          ),
        ),
      );
    }
  }

  Future addSongs() async {
    Song s = await Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => SongScreen(state.user, null),
        ));
    if (s != null) {
      // new book stored in Firebase
      // then add to our list here
      state.songlist.add(s);
    } else {
      // error occurred in storing in Firebase
    }
  }

  void addPlaylists() async {
    Playlist p = await Navigator.push(
      state.context,
      MaterialPageRoute(
        builder: (context) => PlaylistScreen(state.user, null),
      ),
    );
    if (p != null) {
      // new book stored in Firebase
      // then add to our list here
      state.playlist.add(p);
    } else {
      // error occurred in storing in Firebase
    }
  }
}
