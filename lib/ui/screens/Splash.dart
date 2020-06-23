import 'package:flutter/material.dart';
import 'package:memester/helper/colors.dart';



class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text('MEMESTER',style: TextStyle(
                   fontSize: 40,
                   fontWeight: FontWeight.bold,
                   color: Colors.black
                 ),),
          ),

          SizedBox(height: 50,),
          Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(secondaryColor),
            ),
          )
        ],
      ),
    );
  }
}