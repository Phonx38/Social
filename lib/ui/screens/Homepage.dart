// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:memester/providers/auth.dart';
// import 'package:provider/provider.dart';
// import 'searchPage.dart';
// import 'addImage.dart';
// import 'profilepage.dart';
// import 'feed.dart';
// import 'notifications.dart';
// import 'package:memester/helper/colors.dart';



// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
  
 
//  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int getPageIndex = 0;
//  PageController _pageController;

//  @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     // TODO: implement dispose
//     super.dispose();

//   }
//   changePage(int pageIndex){
//     _pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
//   }

//   whenPageChanges(int pageIndex){
//     setState(() {
//       this.getPageIndex = pageIndex;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthProvider>(context);
//     return Scaffold(

//       key: _scaffoldKey,
//       body:PageView(
//         children: <Widget>[
//           Feed(),
//           SearchPage(),
//           UploadPage(),
//           Notifications(),
//           Profile()
//         ],
//         controller: _pageController,
//         onPageChanged:  whenPageChanges,
//         physics: NeverScrollableScrollPhysics(),
//       ),


//       bottomNavigationBar: CupertinoTabBar(
//         currentIndex: getPageIndex,
//         onTap: changePage,
//         backgroundColor: secondaryColor,
//         activeColor: Colors.white,
//         inactiveColor: Colors.white70,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Feather.home,size: 25,)
//             ),
//           BottomNavigationBarItem(
//             icon: Icon(Feather.search,size: 25,)
//             ),
//           BottomNavigationBarItem(
//             icon: Icon(Feather.plus_circle,size: 25,)
//             ),

//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications,size: 25,)
//             ),

//           BottomNavigationBarItem(
//             icon: Icon(Feather.user,size: 25,)
//             ),

         
//         ]
//         ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memester/helper/colors.dart';
import 'package:memester/models/user.dart';
import 'package:memester/providers/auth.dart';
import 'package:memester/ui/screens/addImage.dart';
import 'package:memester/ui/screens/notifications.dart';
import 'package:memester/ui/screens/profileSetup.dart';
import 'package:memester/ui/screens/profilepage.dart';
import 'package:memester/ui/screens/searchPage.dart';
import 'package:memester/ui/screens/feed.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


GoogleSignIn gSignIn = GoogleSignIn();
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int getPageIndex=0;

  void initState(){
    super.initState();
    pageController = PageController();
  }
  whenPageChanged(int pageIndex)
   {
     setState(() {
       this.getPageIndex= pageIndex;
     });
   }

  onTapChangePage(int pageIndex)
   {
     pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 400), curve: Curves.decelerate,);

   }



  void dispose(){

    pageController.dispose();

    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
  return Scaffold(
    floatingActionButton: FloatingActionButton(
      elevation: 2,
      child: Container(
        // color: Colors.red,
        child: Icon(Feather.plus,size: 40,)),
      backgroundColor: Colors.black87,
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadPage()));
        // showModalBottomSheet(
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(20),
        //     topRight: Radius.circular(20)
        //   )),
        //   context: context, 
        //   builder: (BuildContext context){
        //     return Padding(
        //       padding: const EdgeInsets.fromLTRB(20,8,20,8),
        //       child: Container(
        //         height: 150,
        //         child: Column(
        //           children: <Widget>[
        //             // Row(
        //             //   mainAxisAlignment: MainAxisAlignment.center,
        //             //   crossAxisAlignment: CrossAxisAlignment.center,
        //             //   children: <Widget>[
        //             //   Expanded(
        //             //     child: Container(
        //             //       color:secondaryColor,
        //             //       height: 1,
        //             //     ),
        //             //   ),
        //             //     Text('Upload',style: TextStyle(
        //             //             fontWeight: FontWeight.w900,
        //             //             fontSize: 15,
        //             //             color: Colors.black38
        //             //           ),),
        //             //     Expanded(
        //             //     child: Container(
        //             //       color: secondaryColor,
        //             //       height: 1,
        //             //     ),
        //             //   ),
        //             //   ],
        //             //   ),
        //               SizedBox(height: 15,),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: <Widget>[
        //                 GestureDetector(
        //                   onTap: (){
                            
        //                   },
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: <Widget>[
        //                       CircleAvatar(
        //                         minRadius: 22,
        //                         child: Icon(Feather.camera,size: 22,color: Colors.white,),
        //                       ),
        //                       SizedBox(height:10),
        //                       Text('Camera',style: TextStyle(
        //                         fontWeight: FontWeight.w900,
        //                         fontSize: 15,
        //                         color: Colors.black87
        //                       ),)
        //                     ],
        //                   ),
        //                 ),
        //                 GestureDetector(
        //                   onTap: (){

        //                   },
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: <Widget>[
        //                       CircleAvatar(
        //                         minRadius: 22,
        //                         child: Icon(FontAwesome.smile_o,size: 22,color: Colors.yellow,),
        //                       ),
        //                       SizedBox(height:10),
        //                       Text('Gallery',style: TextStyle(
        //                         fontWeight: FontWeight.w900,
        //                         fontSize: 15,
        //                         color: Colors.black87
        //                       ),)
        //                     ],
        //                   ),
        //                 ),
        //                 GestureDetector(
        //                   onTap: (){

        //                   },
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: <Widget>[
        //                       CircleAvatar(
        //                         minRadius: 22,
        //                         child: Icon(Feather.video,size: 22,color: Colors.white,),
        //                       ),
        //                       SizedBox(height:10),
        //                       Text('Video',style: TextStyle(
        //                         fontWeight: FontWeight.w900,
        //                         fontSize: 15,
        //                         color: Colors.black87
        //                       ),)
        //                     ],
        //                   ),
        //                 ),
        //                 GestureDetector(
        //                   onTap: (){

        //                   },
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: <Widget>[
        //                       CircleAvatar(
        //                         minRadius: 22,
        //                         child: Icon(Feather.life_buoy,size: 22,color: Colors.white,),
        //                       ),
        //                       SizedBox(height:10),
        //                       Text('Status',style: TextStyle(
        //                         fontWeight: FontWeight.w900,
        //                         fontSize: 15,
        //                         color: Colors.black87
        //                       ),)
        //                     ],
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   }
        //   );
      }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        children: <Widget>[
          Feed(),
        // RaisedButton(child: Text('Logout'),onPressed: (){
        //   auth.gSignOut(context);
        // },),
        SearchPage(),
        // UploadPage(),
        Notifications(),
        Profile(),
        ],controller: pageController,
        onPageChanged: whenPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: getPageIndex,
        onTap: onTapChangePage,
        backgroundColor: secondaryColor,
        activeColor: Colors.white,
        inactiveColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Feather.home,size: 25,)
            ),
          BottomNavigationBarItem(
            icon: Icon(Feather.search,size: 25,)
            ),
          // BottomNavigationBarItem(
          //   icon: Icon(Feather.plus_circle,size: 25,)
          //   ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,size: 25,)
            ),

          BottomNavigationBarItem(
            icon: Icon(Feather.user,size: 25,)
            ),

         
        ]
        ),
    );
  }
}



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool isSignedIn=false;
  

 
 
  
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
   return Scaffold(
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('MEMESTER',style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),),
           
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width *0.8,
                  child: Text("Sign in with", 
                  textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                ),
              ),

           
           FlatButton.icon(
    
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.redAccent,
              onPressed: (){
                auth.signInWithGoogle(context);
              },
              icon: Icon(FontAwesome.google,color: Colors.white,),
              label: Text('Google',style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),)),
          ]
        ),
      )
      );
  }
  }