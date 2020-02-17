import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import "../controller/startupScreen_controller.dart";
import '../model/user.dart';

void main() => runApp(StartupScreen());

class StartupScreen extends StatefulWidget {
  @override
  StartupScreenState createState() => StartupScreenState();
}

class StartupScreenState extends State<StartupScreen> {
  VideoPlayerController controller;
  StartupScreenController controller1;
  BuildContext context;
  var user = User();
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/videos/Posty.mp4")
      // _controller = VideoPlayerController.network(
      //     'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        controller.play();
        controller.setLooping(true);
        controller.setVolume(0.0);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
    controller1 = StartupScreenController(this);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(
      theme: ThemeData(
        primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
        textTheme: Typography(platform: TargetPlatform.iOS).white,
        fontFamily: 'Quantum',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.value.size?.width ?? 0,
                  height: controller.value.size?.height ?? 0,
                  child: VideoPlayer(controller),
                ),
              ),
            ),
            //LoginWidget()
            Container(
              padding: EdgeInsets.only(top: 90, left: 50),
              child: Text(
                'LEOZENE',
                style: TextStyle(
                  fontSize: 60,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 335, left: 50, right: 50),
              width: 400,
              height: 570,
              //color: Colors.amber[800].withAlpha(200),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 20,
                      child: TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        validator: controller1.validateEmail,
                        onSaved: controller1.saveEmail,
                      ),
                    ),
                    // TextField(
                    //   decoration: InputDecoration.collapsed(
                    //     hintText: 'Username',
                    //     hintStyle: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 20,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: 20,
                      child: TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        validator: controller1.validatePassword,
                        onSaved: controller1.savePassword,
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 500,
                      height: 60,
                      buttonColor: Colors.black,
                      child: RaisedButton(
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        onPressed: controller1.signIn,
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 500,
                      height: 60,
                      buttonColor: Colors.black,
                      child: RaisedButton(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: controller1.signUp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
