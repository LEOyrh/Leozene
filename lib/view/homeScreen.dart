import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';

import '../model/user.dart';
import '../controller/homeScreen_controller.dart';
//import '../view/tabNavigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/song.dart';
import '../model/playlist.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  final List<Song> songlist;
  final List<Playlist> playlist;

  HomeScreen(this.user, this.playlist, this.songlist);
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState(user, playlist, songlist);
  }
}

class HomeScreenState extends State<HomeScreen> {
  //final navigatorKey = GlobalKey<NavigatorState>();
  HomeScreenController controller;
  BuildContext context;
  User user;
  List<Song> songlist;
  List<Playlist> playlist;
  List<int> deleteIndices;

  //ScreenTab currentScreenTab = ScreenTab.home;
  int currentScreenIndex = 0;

  HomeScreenState(this.user, this.playlist, this.songlist) {
    controller = HomeScreenController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    var childButtons = List<UnicornButton>();

    childButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Add Playlist",
        labelFontSize: 10,
        currentButton: FloatingActionButton(
          heroTag: "Add Playlist",
          backgroundColor: Colors.white,
          mini: true,
          child: Icon(
            Icons.library_music,
            color: Colors.black,
          ),
          // Text(
          //   "Add Playlist",
          //   style: TextStyle(color: Colors.black),
          // ),
          onPressed: controller.addPlaylists,
        ),
      ),
    );

    childButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Add Song",
        labelFontSize: 10,
        currentButton: FloatingActionButton(
          heroTag: "Add Song",
          backgroundColor: Colors.white,
          mini: true,
          child: Icon(
            Icons.music_note,
            color: Colors.black,
          ),
          // Text(
          //   "Add Song",
          //   style: TextStyle(color: Colors.black),
          // ),
          onPressed: controller.addSongs,
        ),
      ),
    );

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
          floatingActionButton: UnicornDialer(
            backgroundColor: Colors.transparent,
            parentButtonBackground: Colors.blueGrey[300],
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(
              Icons.menu,
            ),
            childButtons: childButtons,
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
            itemCount: playlist.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(5.0),
                color: deleteIndices != null && deleteIndices.contains(index)
                    ? Colors.cyan[200]
                    : Colors.black,
                child: ListTile(
                    leading: FittedBox(
                      child: Card(
                        elevation: 20,
                        child: CachedNetworkImage(
                          imageUrl: playlist[index].imageUrl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline),
                        ),
                      ),
                    ),
                    title: Text(playlist[index].title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            playlist[index].creator,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            playlist[index].genre,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // need func def no func call
                    // onTap: controller.onTap(index) wrong
                    onTap: () => controller
                        .songsList(index), //=> controller.onTap(index),
                    onLongPress: () {} //=> controller.longPress(index),
                    ),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: currentScreenIndex,
            onTap: (index) => {
              controller.navigate(index),
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                title: Text('Search',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// List<UnicornButton> _getProfileMenu() {
//   List<UnicornButton> children = [];

//   // Add Children here
//   children.add(_profileOption(
//     iconData: Icons,),
//     onPressed: () {},
//   ));
//   children.add(_profileOption(
//     iconData: Icons.settings,
//     onPressed: () {},
//   ));

//   return children;
// }

// Widget _profileOption({IconData iconData, Function onPressed}) {
//   return UnicornButton(
//       currentButton: FloatingActionButton(
//     backgroundColor: Colors.white,
//     mini: true,
//     heroTag: null,
//     child: Icon(
//       iconData,
//       color: Colors.black,
//     ),
//     onPressed: onPressed,
//   ));
// }

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
//   HomeScreenController controller;
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

//   Widget addSong() {
//     return Container(
//       child: FloatingActionButton(
//         backgroundColor: _buttonColor.value,
//         onPressed: () => controller.addSongs,
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

//    Widget addPlaylist() async {
//     return Container(
//       child: FloatingActionButton(
//         backgroundColor: _buttonColor.value,
//         onPressed: () {
//           Playlist p = await Navigator.push(
//               state.context,
//               MaterialPageRoute(
//                 builder: (context) => PlaylistScreen(state.user, null),
//               ));
//           if (p != null) {
//             // new book stored in Firebase
//             // then add to our list here
//             state.playlist.add(p);
//           } else {
//             // error occurred in storing in Firebase
//           }
//         },
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
