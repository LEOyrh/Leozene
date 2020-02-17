// import 'package:flutter/material.dart';
// import 'package:leozene/controller/homeScreen_controller.dart';
// import '../controller/bottomNavigation_controller.dart';
// import '../model/user.dart';

// enum ScreenTab { home, search, profile }
// //final User user;

// // Map<TabItem, String> tabName = {
// //   TabItem.home: 'Home',
// //   TabItem.search: 'Search',
// //   TabItem.profile: 'Profile',
// // };

// // Map<TabItem, MaterialColor> activeTabColor = {
// //   TabItem.home: Colors.white,
// //   TabItem.search: Colors.white,
// //   TabItem.profile: Colors.white,
// // };

// // class BottomNavigation extends StatefulWidget {
// //   final int currentTab = 0;
// //   @override
// //   State<StatefulWidget> createState() {
// //     return BottomNavigationState(this.currentTab);
// //   }
// //   // @override
// //   // HomeScreenState createState() => HomeScreenState();
// // }

// BottomNavigationController controller;

// class BottomNavigation extends StatelessWidget {
//   BottomNavigation({this.currentTab, this.selectedTab});
//   final ScreenTab currentTab;
//   final ValueChanged<ScreenTab> selectedTab;

//   // void tabChange(int index) {
//   //   screenTab.values[index];
//   //   controller.navigate(index);
//   // }
//   // final ValueChanged<TabItem> onSelectTab;

//   // void stateChanged(Function fn) {
//   //   setState(fn);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Colors.black,
//       //currentIndex: currentTab,
//       onTap: (index) => {
//         selectedTab(
//           ScreenTab.values[index],
//         ),
//         controller.navigate(index),
//       },
//       items: <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(
//             Icons.home,
//             color: Colors.white,
//           ),
//           title: Text(
//             'Home',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             Icons.search,
//             color: Colors.white,
//           ),
//           title: Text('Search',
//               style: TextStyle(
//                 color: Colors.white,
//               )),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             Icons.person,
//             color: Colors.white,
//           ),
//           title: Text(
//             'Profile',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // BottomNavigationBarItem _buildItem({TabItem tabItem}) {
//   //   String text = tabName[tabItem];
//   //   IconData icon = Icons.layers;
//   //   return BottomNavigationBarItem(
//   //     icon: Icon(
//   //       icon,
//   //       color: _colorTabMatching(item: tabItem),
//   //     ),
//   //     title: Text(
//   //       text,
//   //       style: TextStyle(
//   //         color: _colorTabMatching(item: tabItem),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Color _colorTabMatching({TabItem item}) {
//   //   return currentTab == item ? activeTabColor[item] : Colors.grey[100];
//   // }
// }
