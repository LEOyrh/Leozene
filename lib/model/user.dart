//List<String> index = ["home", "search", "profile"];

class User {
  String email;
  String password;
  String username;
  String uid;
  dynamic imageURL;

  User({
    this.email,
    this.password,
    this.username,
    this.uid,
    this.imageURL,
  });

  // serialize to key value pair
  // for firebase storage
  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      EMAIL: email,
      USERNAME: username,
      UID: uid,
      IMAGEURL: imageURL,
    };
  }

// deserialize for dart use
  static User deserialize(Map<String, dynamic> document) {
    return User(
      email: document[EMAIL],
      username: document[USERNAME],
      uid: document[UID],
      imageURL: document[IMAGEURL],
    );
  }

  static const PROFILE_COLLECTION = 'userprofile';
  static const EMAIL = 'email';
  static const USERNAME = 'username';
  static const ZIP = 'zip';
  static const UID = 'uid';
  static const IMAGEURL = 'imageURL';
}
