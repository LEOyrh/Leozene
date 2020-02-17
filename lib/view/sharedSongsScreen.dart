import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leozene/view/nowPlayingScreen.dart';
import '../model/song.dart';
import '../model/user.dart';

class SharedSongsScreen extends StatelessWidget {
  final User user;
  final List<Song> songs;

  SharedSongsScreen(this.user, this.songs);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
          textTheme: Typography(platform: TargetPlatform.iOS).white,
          fontFamily: 'Quantum',
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Shared Wif Me',
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(5.0),
              //color: Colors.lime,
              // child: ListTile(
              //   leading: FittedBox(
              child: Card(
                color: Colors.black,
                elevation: 10.0,
                child: Column(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: songs[index].artWork,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline),
                    ),
                    Text(
                      '${songs[index].title}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text('Author: ${songs[index].artist}'),
                    Text('Publication Year: ${songs[index].pubyear}'),
                    Text(
                      'Review: ${songs[index].review}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.orange[100],
                      ),
                    ),
                    Text('Created By: ${songs[index].createdBy}'),
                    Text('Last Updated At: ${songs[index].lastUpdatedAt}'),
                    Text(
                      'Shared With: ' +
                          songs[index]
                              .sharedWith
                              .toString()
                              .replaceAll("[]", ""),
                    ),
                    Container(
                        child: FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Play",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlayingScreen(
                            user,
                            songs[index],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            // onTap: () => Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => NowPlayingScreen(
            //       user,
            //       songs[index],
            //     ),
            //   ),
            // ),
          ),
        ),
      ),
      //     ),
      // ),
    );
  }
}
