// import 'package:flutter/material.dart';
// import '../model/song.dart';
// import '../model/playlist.dart';
// import '../view/homeScreen.dart';
// import '../view/songScreen.dart';
// import '../view/playlistScreen.dart';

// class FancyFab extends StatefulWidget {
//   final Function() onPressed;
//   final String tooltip;
//   final IconData icon;

//   FancyFab({this.onPressed, this.tooltip, this.icon});

//   @override
//   _FancyFabState createState() => _FancyFabState();
// }

// class _FancyFabState extends State<FancyFab>
//     with SingleTickerProviderStateMixin {
//   bool isOpened = false;
//   AnimationController _animationController;
//   Animation<Color> _buttonColor;
//   Animation<double> _animateIcon;
//   Animation<double> _translateButton;
//   Curve _curve = Curves.easeOut;
//   double _fabHeight = 56.0;
//   HomeScreenState state;
//   //BuildContext context;

//   @override
//   initState() {
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500))
//           ..addListener(() {
//             setState(() {});
//           });
//     _animateIcon =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
//     _buttonColor = ColorTween(
//       begin: Colors.white,
//       end: Colors.white,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Interval(
//         0.00,
//         1.00,
//         curve: Curves.linear,
//       ),
//     ));
//     _translateButton = Tween<double>(
//       begin: _fabHeight,
//       end: -14.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Interval(
//         0.0,
//         0.75,
//         curve: _curve,
//       ),
//     ));
//     super.initState();
//   }

//   @override
//   dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   animate() {
//     if (!isOpened) {
//       _animationController.forward();
//     } else {
//       _animationController.reverse();
//     }
//     isOpened = !isOpened;
//   }

//   Future addSongs() async {
//     Song s = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SongScreen(state.user, null),
//         ));
//     if (s != null) {
//       // new book stored in Firebase
//       // then add to our list here
//       state.songlist.add(s);
//     } else {
//       // error occurred in storing in Firebase
//     }
//   }

//   Future addPlaylists() async {
//     Playlist p = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PlaylistScreen(state.user, null),
//         ));
//     if (p != null) {
//       // new book stored in Firebase
//       // then add to our list here
//       state.playlist.add(p);
//     } else {
//       // error occurred in storing in Firebase
//     }
//   }

//   Widget addSong() {
//     return Container(
//       child: FloatingActionButton(
//         backgroundColor: _buttonColor.value,
//         onPressed: () => addSongs,
//         tooltip: 'Add Song',
//         child: Container(
//           padding: EdgeInsets.only(left: 11.0),
//           child: Text(
//             "Add Song",
//             style: TextStyle(color: Colors.black, fontSize: 12),
//           ),
//         ),
//         heroTag: null,
//       ),
//     );
//   }

//   Widget addPlaylist() {
//     return Container(
//       child: FloatingActionButton(
//         backgroundColor: _buttonColor.value,
//         onPressed: () => addPlaylists(context),
//         tooltip: 'Add Playlist',
//         child: Container(
//           padding: EdgeInsets.only(left: 3.5),
//           child: Text(
//             "Add Playlist",
//             style: TextStyle(color: Colors.black, fontSize: 10),
//           ),
//         ),
//         heroTag: null,
//       ),
//     );
//   }

//   // Widget image() {
//   //   return Container(
//   //     child: FloatingActionButton(
//   //       onPressed: null,
//   //       tooltip: 'Image',
//   //       child: Icon(Icons.image),
//   //     ),
//   //   );
//   // }

//   // Widget inbox() {
//   //   return Container(
//   //     child: FloatingActionButton(
//   //       onPressed: null,
//   //       tooltip: 'Inbox',
//   //       child: Icon(Icons.inbox),
//   //     ),
//   //   );
//   // }

//   Widget toggle() {
//     return FloatingActionButton(
//       backgroundColor: _buttonColor.value,
//       onPressed: animate,
//       tooltip: 'Toggle',
//       child: AnimatedIcon(
//         icon: AnimatedIcons.menu_close,
//         color: Colors.black,
//         progress: _animateIcon,
//       ),
//       heroTag: null,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: <Widget>[
//         Transform(
//           transform: Matrix4.translationValues(
//             0.0,
//             _translateButton.value * 2.0,
//             0.0,
//           ),
//           child: addSong(),
//         ),
//         Transform(
//           transform: Matrix4.translationValues(
//             0.0,
//             _translateButton.value,
//             0.0,
//           ),
//           child: addPlaylist(),
//         ),
//         //  Transform(
//         //   transform: Matrix4.translationValues(
//         //     0.0,
//         //     _translateButton.value * 2.0,
//         //     0.0,
//         //   ),
//         //   child: image(),
//         // ),
//         // Transform(
//         //   transform: Matrix4.translationValues(
//         //     0.0,
//         //     _translateButton.value,
//         //     0.0,
//         //   ),
//         //   child: inbox(),
//         // ),
//         toggle(),
//       ],
//     );
//   }
// }
