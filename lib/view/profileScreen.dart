import 'dart:io';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../controller/profileScreen_controller.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  ProfileScreen(this.user);
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState(user);
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenController controller;
  BuildContext context;
  User user = User();
  //ScreenTab currentScreenTab = ScreenTab.profile;
  int currentScreenIndex = 1;
  bool onEdit = false;
  bool resetPass = false;
  File image;
  dynamic uploadedFileURL;
  //String uploadedFileURL1 = uploadedFileURL;
  bool uploaded = false;

  @override
  void initState() {
    super.initState();
    // FirebaseAuth.instance.currentUser().then((user) {
    //   setState(() {
    //     uploadedFileURL = user.photoUrl;

    //   });
    // }).catchError((e) {
    //   print(e);
    // });
    // FirebaseUser user1 = await FirebaseAuth.instance.currentUser();
    // setState(() {
    //   user.imageURL = user1.photoUrl;
    // });
  }

  var formKey1 = GlobalKey<FormState>();
  ProfileScreenState(this.user) {
    controller = ProfileScreenController(this);
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
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: <Widget>[
              onEdit == false
                  ? FlatButton.icon(
                      icon: Icon(Icons.edit, color: Colors.white),
                      label: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: controller.edit,
                    )
                  : FlatButton.icon(
                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: controller.onSave,
                    ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.only(
              left: 50,
              right: 50,
            ),
            child: Form(
              key: formKey1,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 110,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: SizedBox(
                                width: 200.0,
                                height: 220.0,
                                child:
                                    // uploadedFileURL != null
                                    //    ?  Image.network(
                                    //         uploadedFileURL,
                                    //         fit: BoxFit.fill,
                                    //       )
                                    //     : Image.asset(
                                    //         "assets/images/person.png",
                                    //         fit: BoxFit.fill,
                                    //       )

                                    image != null //&& uploadedFileURL == null
                                        ? Image.file(image, fit: BoxFit.fill)
                                        : user.imageURL != null
                                            // : image != null &&
                                            //         uploaded == true &&
                                            //         uploadedFileURL != null
                                            ? Image.network(
                                                user.imageURL, fit: BoxFit.fill,
                                                // placeholder: (context, url) =>
                                                //     CircularProgressIndicator(),
                                                // imageUrl: uploadedFileURL,
                                                // errorWidget: (context, url, error) =>
                                                //     Icon(
                                                //   Icons.error,
                                                // ),
                                              )
                                            : Image.asset(
                                                "assets/images/person.png",
                                                fit: BoxFit.fill,
                                              ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 90,
                          ),
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.camera),
                            onPressed: controller.chooseImage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 170,
                    ),
                    child: RaisedButton(
                      child: Text('Set Profile Image',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                      color: Colors.white,
                      onPressed: controller.uploadImage,
                    ),
                  ),

                  // image != null
                  //     ? Image.asset(
                  //         image.path,
                  //         height:200,
                  //       )
                  //     : Icon(Icons.person, color: Colors.white, size: 100),
                  // Container(
                  //   padding: EdgeInsets.only(right: 66.2, left: 66.2),
                  //   child: image == null
                  //       ? RaisedButton(
                  //           color: Colors.white,
                  //           child: Text('Select Profile Image'),
                  //           //icon: Icon(Icons.person),
                  //           onPressed: controller.chooseImage,
                  //         )
                  //       : Container(),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.only(right: 66.2, left: 66.2),
                  //   child: image != null
                  //       ? RaisedButton(
                  //           child: Text('Set Profile Pic',),
                  //           onPressed: controller.uploadImage,
                  //           color: Colors.white,
                  //         )
                  //       : Container(),
                  // ),
                  Container(
                    child: TextFormField(
                      enabled: false,
                      initialValue: user.email,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        hintText: 'Insert a valid email with @ and .',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.validateEmail,
                      onSaved: controller.saveEmail,
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      enabled: onEdit == true ? true : false,
                      initialValue: user.username,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          hintText:
                              'Anything that is not offensive and obscene is fine',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          )),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      validator: controller.validateUsername,
                      onSaved: controller.saveUsername,
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      enabled: resetPass == true ? true : false,
                      obscureText: true,
                      initialValue: '${user.password}',
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          hintText: 'Enter desired password',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          )),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      validator: controller.validatePassword,
                      onSaved: controller.savePassword,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: ButtonTheme(
                      minWidth: 500,
                      height: 60,
                      buttonColor: Colors.white,
                      child: RaisedButton(
                        child: Text(
                          'Shared Wif Me',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        onPressed: controller.sharedWifMe,
                      ),
                    ),
                  ),
                  resetPass == false
                      ? ButtonTheme(
                          minWidth: 500,
                          height: 60,
                          buttonColor: Colors.white,
                          child: RaisedButton(
                            child: Text(
                              'Reset Password',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            onPressed: controller.resetPassw,
                          ),
                        )
                      : ButtonTheme(
                          minWidth: 500,
                          height: 60,
                          buttonColor: Colors.white,
                          child: RaisedButton(
                            child: Text(
                              'Set Password',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            onPressed: controller.setPassw,
                          ),
                        ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: ButtonTheme(
                      minWidth: 500,
                      height: 60,
                      buttonColor: Colors.white,
                      child: RaisedButton(
                        child: Text(
                          'Sign Out',
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                        onPressed: controller.signOut,
                      ),
                    ),
                  ),
                ],
              ),
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
        ),
      ),
    );
  }
}
