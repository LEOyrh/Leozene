import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/song.dart';
import '../controller/searchScreen_controller.dart';

class SearchScreen extends StatefulWidget {
  final User user;
  final List<Song> songlist;
  SearchScreen(this.user, this.songlist);
  @override
  State<StatefulWidget> createState() {
    return SearchScreenState(user, songlist);
  }
}

class SearchScreenState extends State<SearchScreen> {
  SearchScreenController controller;
  BuildContext context;
  User user;
  final List<Song> songlist;
  //ScreenTab currentScreenTab = ScreenTab.search;
  int currentScreenIndex = 2;
  SearchScreenState(this.user, this.songlist) {
    controller = SearchScreenController(this);
  }
  void stateChanged(Function fn) {
    setState(fn);
  }

  // Map<ScreenTab, GlobalKey<NavigatorState>> _navigatorKeys = {
  //   ScreenTab.home: GlobalKey<NavigatorState>(),
  //   ScreenTab.search: GlobalKey<NavigatorState>(),
  //   ScreenTab.profile: GlobalKey<NavigatorState>(),
  // };
  // void selectTab(ScreenTab screenTab) {
  //   if (screenTab == currentScreenTab) {
  //     _navigatorKeys[screenTab].currentState.popUntil((route) => route.isFirst);
  //   } else {
  //     setState(() {
  //       currentScreenTab = screenTab;
  //     });
  //   }
  // }

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
          body: Center(
            child: Text(
              'search',
            ),
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
          // bottomNavigationBar: BottomNavigation(
          //   currentTab: currentScreenTab,
          //   selectedTab: selectTab,
          // ),
        ),
      ),
    );
  }
}
