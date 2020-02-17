// import 'package:flutter/material.dart';
// import 'package:leozene/controller/homeScreen_controller.dart';
// import '../controller/myfirebase.dart';
// import '../view/homeScreen.dart';
// import '../view/searchScreen.dart';
// import '../view/profileScreen.dart';
// import '../view/bottomNavigation.dart';


// class BottomNavigationController {
//   BottomNavigation state;
//   HomeScreenState state1;
//   SearchScreenState state2;
//   ProfileScreenState state3;
//   BottomNavigationController(this.state);
//   int selectedIndex = 0;
//   //ScreenTab screenTab;

//   // static const TextStyle optionStyle = TextStyle(
//   //   fontSize: 30,
//   //   fontWeight: FontWeight.bold,
//   // );

//   // static const List<Widget> bottomBarOps = <Widget>[
//   //   Text(
//   //     'Index 0: Home',
//   //     style: optionStyle,
//   //   ),
//   //   Text(
//   //     'Index 1: Business',
//   //     style: optionStyle,
//   //   ),
//   //   Text(
//   //     'Index 2: School',
//   //     style: optionStyle,
//   //   ),
//   // ];

//   void navigate(int index) {
//     if (index == 0) {
//       Navigator.push(
//           state1.context,
//           MaterialPageRoute(
//             builder: (context) => HomeScreen(state1.user),
//           ));
//     }
//     if (index == 1) {
//       Navigator.push(
//           state2.context,
//           MaterialPageRoute(
//             builder: (context) => SearchScreen(state2.user),
//           ));
//     }
//     if (index == 2) {
//       Navigator.push(
//           state3.context,
//           MaterialPageRoute(
//             builder: (context) => ProfileScreen(state3.user),
//           ));
//     }
//   }
// }
