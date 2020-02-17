class Song {
  String songId; // firestore doc id
  String title;
  String artist;
  String genre;
  List<dynamic> featArtist;
  int pubyear;
  String artWork;
  dynamic songURL;
  String review;
  String createdBy;
  DateTime lastUpdatedAt; // created or revised
  List<dynamic> sharedWith;

  Song({
    this.title,
    this.artist,
    this.genre,
    this.featArtist,
    this.pubyear,
    this.artWork,
    this.songURL,
    this.review,
    this.createdBy,
    this.lastUpdatedAt,
    this.sharedWith,
  });

  // empty book obj
  Song.empty() {
    this.title = '';
    this.artist = '';
    this.genre = '';
    this.featArtist = <dynamic>[];
    this.pubyear = 0000;
    this.artWork = '';
    this.songURL = '';
    this.review = '';
    this.createdBy = '';
    this.sharedWith = <dynamic>[];
  }

  Song.clone(Song b) {
    this.songId = b.songId;
    this.title = b.title;
    this.artist = b.artist;
    this.genre = b.genre;
    this.featArtist = <dynamic>[]..addAll(b.featArtist);
    this.pubyear = b.pubyear;
    this.review = b.review;
    this.artWork = b.artWork;
    this.songURL = b.songURL;
    this.lastUpdatedAt = b.lastUpdatedAt;
    this.createdBy = b.createdBy;
    // is an array or list in Dart
    // so deep copy of contents not just addr ref
    // create empty list 1st, add all contents from b obj,
    // . operator wif dynamic obj cr8ed adding addAll method
    // begin wif blank list, add all the members of this list
    this.sharedWith = <dynamic>[]..addAll(b.sharedWith);
  }

  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      TITLE: title,
      ARTIST: artist,
      GENRE: genre,
      FEATARTIST: featArtist,
      PUBYEAR: pubyear,
      ARTWORK: artWork,
      SONGURL: songURL,
      REVIEW: review,
      CREATEDBY: createdBy,
      // timestamp is allowed as well
      LASTUPDATEDAT: lastUpdatedAt,
      // list is array, acceptable by firestore
      SHAREDWITH: sharedWith,
    };
  }

  static Song deserialize(Map<String, dynamic> data, String songsId) {
    var song = Song(
      title: data[Song.TITLE],
      artist: data[Song.ARTIST],
      genre: data[Song.GENRE],
      featArtist: data[Song.FEATARTIST],
      pubyear: data[Song.PUBYEAR],
      artWork: data[Song.ARTWORK],
      songURL: data[Song.SONGURL],
      review: data[Song.REVIEW],
      createdBy: data[Song.CREATEDBY],
      sharedWith: data[Song.SHAREDWITH],
    );
    if (data[Song.LASTUPDATEDAT] != null) {
      // convert timestamp type to DateTime obj
      song.lastUpdatedAt = DateTime.fromMillisecondsSinceEpoch(
          data[Song.LASTUPDATEDAT].millisecondsSinceEpoch);
    }
    // passed as param
    song.songId = songsId;
    return song;
  }

  static const SONG_COLLECTION = 'songs';
  static const TITLE = 'title';
  static const ARTIST = 'author';
  static const GENRE = 'genre';
  static const FEATARTIST = 'featArtist';
  static const PUBYEAR = 'pubyear';
  static const ARTWORK = 'artWork';
  static const SONGURL = 'songURL';
  static const REVIEW = 'review';
  static const CREATEDBY = 'createdBy';
  static const LASTUPDATEDAT = 'lastUpdatedAt';
  static const SHAREDWITH = 'sharedWith';
}
