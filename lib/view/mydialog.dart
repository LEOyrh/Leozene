import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyDialog {
  static void info(
      {@required BuildContext context,
      @required String title,
      @required String message,
      @required Function action}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ButtonTheme(
              buttonColor: Colors.black,
              child: RaisedButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: action,
              ),
            ),
          ],
        );
      },
    );
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: SpinKitWave(color: Colors.white,),
        // child: CircularProgressIndicator(
        //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        // ),
      ),
    );
  }

  static void popProgressBar(BuildContext context) {
    Navigator.pop(context);
  }
}
