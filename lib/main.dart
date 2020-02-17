import "package:flutter/material.dart";
import './view/startupScreen.dart';

void main() => runApp(BookReviewApp());

class BookReviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Quantum',
      ),
      
      home: StartupScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(BackgroundVideo());

// class BackgroundVideo extends StatefulWidget {
//   @override
//   _BackgroundVideoState createState() => _BackgroundVideoState();
// }

// class _BackgroundVideoState extends State<BackgroundVideo> {
//   VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset("assets/videos/Posty.mp4")
//       // _controller = VideoPlayerController.network(
//       //     'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
//       ..initialize().then((_) {
//         _controller.play();
//         _controller.setLooping(true);
//         _controller.setVolume(0.0);
//         // Ensure the first frame is shown after the video is initialized
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
//         textTheme: Typography(platform: TargetPlatform.iOS).white,
//       ),
//       home: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             SizedBox.expand(
//               child: FittedBox(
//                 fit: BoxFit.cover,
//                 child: SizedBox(
//                   width: _controller.value.size?.width ?? 0,
//                   height: _controller.value.size?.height ?? 0,
//                   child: VideoPlayer(_controller),
//                 ),
//               ),
//             ),
//             LoginWidget()
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }

// class LoginWidget extends StatelessWidget {
//   const LoginWidget({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.only(top: 20),
//           child: Text(
//             'LEOZENE',
//             style: TextStyle(
//               fontSize: 60,
//             ),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.all(40),
//           width: 450,
//           height: 280,
//           //color: Colors.amber[800].withAlpha(200),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               TextField(
//                 decoration: InputDecoration.collapsed(
//                   hintText: 'Username',
//                   hintStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               TextField(
//                 decoration: InputDecoration.collapsed(
//                   hintText: 'Password',
//                   hintStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               ButtonTheme(
//                 minWidth: 3000,
//                 height: 60,
//                 buttonColor: Colors.black,
//                 child: RaisedButton(
//                   child: Text(
//                     'Sign In',
//                     style: TextStyle(fontSize: 40, color: Colors.white),
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//               ButtonTheme(
//                 minWidth: 3000,
//                 height: 60,
//                 buttonColor: Colors.black,
//                 child: RaisedButton(
//                   child: Text(
//                     'Sign Up',
//                     style: TextStyle(
//                       fontSize: 40,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
