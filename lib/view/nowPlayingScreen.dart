import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../model/user.dart';
import '../controller/nowPlayingScreen_controller.dart';
//import '../view/tabNavigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/song.dart';
import 'package:audioplayers/audioplayers.dart';

class NowPlayingScreen extends StatefulWidget {
  final User user;
  final Song song;

  NowPlayingScreen(this.user, this.song);
  @override
  State<StatefulWidget> createState() {
    return NowPlayingScreenState(user, song);
  }
}

class NowPlayingScreenState extends State<NowPlayingScreen> {
  //final navigatorKey = GlobalKey<NavigatorState>();
  NowPlayingScreenController controller;
  BuildContext context;
  User user;
  Song song;
  Song songCopy;
  AudioPlayer audioPlayer;
  bool play = true;
  bool pause = false;
  bool onComplete = false;
  int result;
  bool exitNBack;
  Duration duration, position;
  double value = 0.0;
  Duration remainDur;
  //String featArtist = songCopy.featArtist.toString();

  //ScreenTab currentScreenTab = ScreenTab.home;
  //int currentScreenIndex = 0;

  NowPlayingScreenState(this.user, this.song) {
    controller = NowPlayingScreenController(this);
    songCopy = Song.clone(song);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  initState() {
    super.initState();
    //audioPlayer.stop();
    audioPlayer = new AudioPlayer();
    // audioPlayer.onAudioPositionChanged.listen((Duration p) {
    //   //print('Current position: $p');
    //   setState(() {
    //     position = p;
    //     if (duration != null) {
    //       value = position.inSeconds / duration.inSeconds;
    //     }
    //   });
    // });
    // audioPlayer.onDurationChanged.listen((Duration d) {
    //   //print('Current position: $p');
    //   setState(() {
    //     duration = d;
    //     if (position != null) {
    //       value = position.inSeconds / duration.inSeconds;
    //     }
    //   });
    // });
    controller.play();
    controller.getDuration();
    controller.getPosition();
    controller.getCompleted();
    //controller.getRemainDur();
    //controller.getDurToString(Duration d);
    // controller.setDuration(duration);
    // controller.setPosition(position);
  }

  @override
  void dispose() {
    audioPlayer = null;
    super.dispose();
  }

  @override
  void deactivate() {
    audioPlayer.stop();
    super.deactivate();
  }

  // Future play() async {
  //   int result = await audioPlayer.play(songCopy.songURL);
  //   if (result == 1) {
  //     // success
  //   }
  // }

  String getDurToString(Duration d) {
    var parts = <int>[];

    // Add seconds
    if (d != null) {
      parts.add(d.inSeconds % 60);

      // Add minutes
      if (d.inMinutes >= 1)
        parts.add(d.inMinutes % 60);
      else
        parts.add(0);

      // Hours?
      if (d.inHours >= 1) parts.add(d.inHours);

      return parts.reversed
          .map((p) {
            if (p < 10) return '0$p';
            return p.toString();
          })
          .join(':')
          .toString();
    } else
      return null;
  }

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
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                exitNBack = true;
                Navigator.of(context).pop();
              },
            ),
          ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
          body: Column(
            // children: <Widget>[
            children: <Widget>[
              //Stack(
              //children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 13),
                    child: Container(
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(1.0) ,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 6.0,
                            //spreadRadius: 0.0,
                            //offset: Offset(.1, 3),
                          )
                        ],
                      ),
                      child: Card(
                        child: CachedNetworkImage(
                          imageUrl: songCopy.artWork,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline, size: 250),
                          height: 300,
                          width: 300,
                        ),
                        elevation: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${songCopy.title}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40),
                child: Row(
                  children: <Widget>[
                    // Container(
                    //   padding: EdgeInsets.only(left: 55, top: 398),
                    //     child: Wrap(
                    //       children: <Widget>[
                    Expanded(
                      child: Text(
                        '${songCopy.artist}',
                        style: TextStyle(
                          color: Colors.grey[350],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  //  ),
                  //   color: Colors.transparent,
                  //   ),
                  //  ],
                ),
              ),
              songCopy.featArtist == null || songCopy.featArtist.isEmpty
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(left: 40),
                      child: Row(
                        children: <Widget>[
                          // padding: EdgeInsets.only(left: 55, top: 411),
                          Expanded(
                            child: Text(
                              ('Feat. ${songCopy.featArtist}'
                                  .toString()
                                  .replaceAll("[]", "")),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[350],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              Container(
                  width: 380,
                  //  padding: EdgeInsets.only(top: 300, left: 30),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 4.0),
                    ),
                    child: Slider(
                      onChanged: (value) {
                        if (duration != null) {
                          var seconds = duration.inSeconds * value;
                          audioPlayer
                              .seek(new Duration(seconds: seconds.toInt()));
                        }
                      },
                      value: value ?? 0.0,
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey[400],
                    ),
                  )),
              Container(
                //   padding: EdgeInsets.only(top: 458, left: 55),
                width: 335,
                child: SizedBox(
                  width: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        //padding: EdgeInsets.only(),
                        child: new Text(
                          getDurToString(position) ?? "",
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        child: new Text(
                          getDurToString(duration) ?? "",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              play == true && onComplete == false
                  ? Container(
                      //   padding: EdgeInsets.only(top: 475),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 75,
                            width: 75,
                            child: FittedBox(
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: Icon(
                                  Icons.pause,
                                ),
                                onPressed: controller.pauseSong,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      //    padding: EdgeInsets.only(top: 475),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 75,
                            width: 75,
                            child: FittedBox(
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: Icon(
                                  Icons.play_arrow,
                                ),
                                onPressed: controller.play,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
          //   ],
          //      ),
        ),
      ),
    );
  }
}
