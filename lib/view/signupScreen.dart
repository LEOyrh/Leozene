import 'package:flutter/material.dart';
import '../controller/signupScreen_controller.dart';
import '../model/user.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  SignupScreenController controller;
  BuildContext context;
  var formKey = GlobalKey<FormState>();
  User user = User();

  SignupScreenState() {
    controller = SignupScreenController(this);
  }
  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
        textTheme: Typography(platform: TargetPlatform.iOS).white,
        fontFamily: 'Quantum',
      ),
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: 170,
            left: 50,
            right: 50,
          ),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  child: TextFormField(
                    initialValue: user.username,
                    autocorrect: false,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Username',
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    validator: controller.validateUsername,
                    onSaved: controller.saveUsername,
                  ),
                ),
                Container(
                  child: TextFormField(
                    initialValue: user.email,
                    autocorrect: false,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Email',
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    validator: controller.validateEmail,
                    onSaved: controller.saveEmail,
                  ),
                ),
                Container(
                  child: TextFormField(
                    initialValue: user.password,
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Password',
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    validator: controller.validatePassword,
                    onSaved: controller.savePassword,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ButtonTheme(
                    height: 60,
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: controller.signup,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
