import '../model/song.dart';

class Playlist {
  String playlistId; // firestore doc id
  String title;
  String genre;
  String creator;
  //String featArtist;
  //int pubyear;
  String imageUrl;
  //String review;
  String createdBy;
  DateTime lastUpdatedAt; // created or revised
  List<dynamic> sharedWith;
  //List<Song> songs;

  Playlist({
    this.title,
    this.genre,
    this.creator,
    //this.featArtist,
    //this.pubyear,
    this.imageUrl,
    //this.review,
    this.createdBy,
    this.lastUpdatedAt,
    this.sharedWith,
    //this.songs,
  });

  // empty book obj
  Playlist.empty() {
    this.title = '';
    this.genre = '';
    this.creator = '';
    //this.featArtist = '';
    //this.pubyear = 0000;
    this.imageUrl = '';
    //this.review = '';
    this.createdBy = '';
    this.sharedWith = <dynamic>[];
    //this.songs = <Song>[];
  }

  Playlist.clone(Playlist b) {
    this.playlistId = b.playlistId;
    this.title = b.title;
    this.genre = b.genre;
    this.creator = b.creator;
    //this.featArtist = b.featArtist;
    //this.pubyear = b.pubyear;
    //this.review = b.review;
    this.imageUrl = b.imageUrl;
    this.lastUpdatedAt = b.lastUpdatedAt;
    this.createdBy = b.createdBy;
    // is an array or list in Dart
    // so deep copy of contents not just addr ref
    // create empty list 1st, add all contents from b obj,
    // . operator wif dynamic obj cr8ed adding addAll method
    // begin wif blank list, add all the members of this list
    this.sharedWith = <dynamic>[]..addAll(b.sharedWith);
    //this.songs = <dynamic>[]..addAll(b.sharedWith);
  }

  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      TITLE: title,
      GENRE: genre,
      CREATOR: creator,
      //FEATARTIST: featArtist,
      //PUBYEAR: pubyear,
      IMAGEURL: imageUrl,
      //REVIEW: review,
      CREATEDBY: createdBy,
      // timestamp is allowed as well
      LASTUPDATEDAT: lastUpdatedAt,
      // list is array, acceptable by firestore
      SHAREDWITH: sharedWith,
      //SONGS: songs,
    };
  }

  static Playlist deserialize(Map<String, dynamic> data, String playlistsId) {
    var playlist = Playlist(
      title: data[Playlist.TITLE],
      genre: data[Playlist.GENRE],
      creator: data[Playlist.CREATOR],
      //featArtist: data[Playlist.FEATARTIST],
      //pubyear: data[Playlist.PUBYEAR],
      imageUrl: data[Playlist.IMAGEURL],
      //review: data[Playlist.REVIEW],
      createdBy: data[Playlist.CREATEDBY],
      sharedWith: data[Playlist.SHAREDWITH],
      //songs: data[Playlist.SONGS],
    );
    if (data[Playlist.LASTUPDATEDAT] != null) {
      // convert timestamp type to DateTime obj
      playlist.lastUpdatedAt = DateTime.fromMillisecondsSinceEpoch(
          data[Playlist.LASTUPDATEDAT].millisecondsSinceEpoch);
    }
    // passed as param
    playlist.playlistId = playlistsId;
    return playlist;
  }

  static const PLAYLIST_COLLECTION = 'playlists';
  static const TITLE = 'title';
  static const GENRE = 'genre';
  static const CREATOR = 'creator';
  //static const FEATARTIST = 'featArtist';
  //static const PUBYEAR = 'pubyear';
  static const IMAGEURL = 'imageUrl';
  //static const REVIEW = 'review';
  static const CREATEDBY = 'createdBy';
  static const LASTUPDATEDAT = 'lastUpdatedAt';
  static const SHAREDWITH = 'sharedWith';
  //static const SONGS = 'songs';
}
