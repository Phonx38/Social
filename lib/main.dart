import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memester/helper/colors.dart';
// import 'package:flutter/services.dart';
import 'package:memester/providers/auth.dart';
import 'package:memester/providers/camProvider.dart';
import 'package:memester/ui/screens/Homepage.dart';
import 'package:memester/ui/screens/Login.dart';
import 'package:memester/ui/screens/Splash.dart';
import 'package:provider/provider.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AuthProvider.intialize()),
      ChangeNotifierProvider<CamController>.value(
      value: CamController()..init(),)
      
    ],
    child: MyApp(),
    ));
}



class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: secondaryColor
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Flutter Demo',
      theme: ThemeData( 
        fontFamily: 'Montserrat-Medium',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
     
        body: ScreenController()),
    );
  }
}


class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if(auth.status == Status.UnIntialized){
      return Splash();
    }else{
      if(auth.loggedIn){
      return HomeScreen();
    }
    
    else{
       return LoginScreen();
    }
    }
    
  }
}


