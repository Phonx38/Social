// import 'dart:async';
// import 'dart:ffi';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:memester/helper/userHelper.dart';
// import 'package:memester/models/user.dart';
// import 'package:memester/ui/screens/Homepage.dart';
// import 'package:memester/ui/screens/Login.dart';
// import 'package:memester/ui/screens/profileSetup.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// enum Status{UnIntialized, Authenticated, Authenticating, UnAutheticated}

// class AuthProvider with ChangeNotifier{
//   static const LOGGED_IN = "loggedIn";
//   static const GLOGGED_IN = "gLoggedIn";
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   GoogleSignIn googleSignIn = GoogleSignIn();
//   FirebaseUser _user;
//   Status _status = Status.UnIntialized;
//   UserServices _userServices = UserServices();
//   User _userModel;
//   TextEditingController _phoneController;
//   String smsOtp;
//   String verificationId;
//   String errorMessage = '';
//   bool loggedIn;
//   bool gLoggedIn;
//   bool loading = false;

//   User get userModel => _userModel;
//   Status get status => _status;
//   FirebaseUser get user => _user;


//   AuthProvider.intialize(){
//     readPrefs();
//   }


  

//   Future signOut(BuildContext context)async{
    
//     await _auth.signOut();
   
//       SharedPreferences prefs =  await SharedPreferences.getInstance();
//       prefs.clear();
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
//   }




//   Future<String> signInWithGoogle(BuildContext context)async{
//     final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

//     try{
//       final AuthCredential authCredential = GoogleAuthProvider.getCredential(
//       idToken: googleSignInAuthentication.idToken, 
//       accessToken: googleSignInAuthentication.accessToken

//       );

//       final AuthResult authResult = await _auth.signInWithCredential(authCredential);
//       final FirebaseUser user = authResult.user;
//       assert(!user.isAnonymous);
//       assert(await user.getIdToken() != null);
//       final FirebaseUser currentUser = await _auth.currentUser();
//       assert(user.uid == currentUser.uid);
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool(GLOGGED_IN, true);
//       gLoggedIn = true;
//       prefs.setBool(LOGGED_IN, true);
//       loggedIn = true;
//       if(user != null){
//          _userModel =  await _userServices.getUserById(user.uid);
//          if(_userModel == null){
//            print('bowwchika bow bow');
//            return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileSetup()));
//          }
//          loading = false;
//          Navigator.pop(context);
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
//        }
//     }catch(e){
//       print(e.toString());
//     }
    
//   }








//   Future<Void> readPrefs() async {
//     await Future.delayed(Duration(seconds: 5)).then((v) async{
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       loggedIn  = prefs.getBool(LOGGED_IN) ?? false;
//       gLoggedIn = prefs.getBool(GLOGGED_IN) ?? false;
//       if(loggedIn){
//         _user = await _auth.currentUser();
//         _userModel = await _userServices.getUserById(_user.uid);
//         _status = Status.Authenticated;
//         notifyListeners();
//         return;
//       }
//       _status = Status.UnAutheticated;
//       notifyListeners();
//     });

    

  
// }




//   Future<void> verifyPhone(BuildContext context,String number) async {
//       final PhoneCodeSent smsOtpSent = (String verId,[int forceCodeResend]){
//         this.verificationId = verId;
//         smsOTPDialog(context).then((value){
//           print('sign in');
//         });
        
//       };
//       try{
//         await _auth.verifyPhoneNumber(
//           phoneNumber: number.trim(),
//           timeout: const Duration(seconds: 30),
//           verificationCompleted: (AuthCredential phoneAuthCredential){
//             print(phoneAuthCredential.toString());
//           },
//           verificationFailed: (AuthException exception){
//             print(exception.message + " A Problem Occured");
//           }, 
//           codeSent: smsOtpSent, 
//           codeAutoRetrievalTimeout: (String verId){
//             this.verificationId =verId;
//           });
//       }catch(e){
//         Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
//         handleErrors(e, context);
//         errorMessage = e.toString();
//         notifyListeners();
//       }
//     }






//     handleErrors(error,BuildContext context){
//       print(error);
//       errorMessage = error.toString();
//       notifyListeners();
//       switch (error.code) {
//         case 'ERROR_INVALID_VERIFICTION_CODE':
//           print("The verifiction code is invalid");
//           break;
//         default:
//           errorMessage = error.message;
//           break;
//       }
//       notifyListeners();
//     }





//   void createUser({String id,String number,String email,String username,String photoUrl,String profileName,String bio}){
//     _userServices.createUser({
//       "id":id,
//       "number":number,
//       "email":email,
//       "username" : username,
//       "profileName":profileName,
//       "photoUrl": photoUrl,
//       "bio": bio
//     });
//   }




//   signIn(BuildContext context) async {
//     try{
//       final AuthCredential credential = PhoneAuthProvider.getCredential(
//         verificationId: verificationId, 
//         smsCode: smsOtp
//         );
//        final AuthResult user = await _auth.signInWithCredential(credential);
//        final FirebaseUser currentUser = await _auth.currentUser();
//        assert(user.user.uid == currentUser.uid);
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//        prefs.setBool(LOGGED_IN, true);
//        loggedIn = true;
//        if(user != null){
//          _userModel =  await _userServices.getUserById(user.user.uid);
//          if(_userModel == null){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileSetup()));
//            createUser(id : user.user.uid,number:user.user.phoneNumber,email: user.user.email,username: "",profileName: "",photoUrl: "",bio: "");
//          }
//          loading =false;
//          Navigator.pop(context);
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
//        }
//     }catch(e){
//       Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }



//   Future<bool> smsOTPDialog(BuildContext context){
//     return showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//         barrierColor: Colors.black.withOpacity(0.5),
//       shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15),
//       ),
//      builder: (BuildContext c){
//        return Padding(
//          padding: const EdgeInsets.all(15.0),
//          child: Container(
//            height: MediaQuery.of(context).size.height * 0.4,
//            child: Material(
//              borderRadius: BorderRadius.circular(10),
//              child: Container(
//                decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
               
//                   width: MediaQuery.of(context).size.width * 0.92,
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Column(
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text('Our secret agent has sent you a secret OTP on 7889839939',
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                          color: Colors.grey,
//                        ),),
//                      ),
//                      Padding(
//                     padding: const EdgeInsets.only(left:12, right: 12, bottom: 12),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.black, width: 0.2),
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.grey.withOpacity(0.3),
//                                 offset: Offset(2, 1),
//                                 blurRadius: 2
//                             )
//                           ]
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left:8.0),
//                         child: TextField(
//                           keyboardType: TextInputType.phone,
//                           onChanged: (value){
//                             this.smsOtp = value;
//                           },
//                           decoration: InputDecoration(
//                               icon: Icon(Icons.phone_android, color: Colors.grey),
//                               border: InputBorder.none,
//                               hintText: "Enter OTP here",
//                               hintStyle: TextStyle(
//                                   color: Colors.grey,
//                                   fontFamily: "Sen",
//                                   fontSize: 18
//                               )
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height:20),
//                    Center(
//                      child: FlatButton(
//                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                         color: Colors.redAccent,
//                       onPressed: ()async{
//                         loading = true;
//                         notifyListeners();
//                         _auth.currentUser().then((user)async{
//                           if(user != null){
//                             _userModel = await _userServices.getUserById(user.uid);
//                             if(_userModel == null){
//                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileSetup()));
//                               createUser(id: user.uid,number: user.phoneNumber,email: user.email);
//                             }
//                             Navigator.pop(c);
//                             loading = false;
//                             notifyListeners();
//                             Navigator.of(c).push(MaterialPageRoute(builder: (c)=>HomePage()));
                          

//                           }
//                           else{
//                             loading = true;
//                             notifyListeners();
//                             Navigator.pop(c);
//                             loading = false;
//                             signIn(context);
//                           }
//                         });
//                       }, 
//                       child: Text('Verify',style: TextStyle(
//                         color: Colors.white
//                       ),)
//                       ),
                    
//                    ),
                
//                    Center(
//                      child: Container(
//                        width: MediaQuery.of(context).size.width *0.60,
//                        child: Column(
//                          children: <Widget>[
//                            Text('Didn’t recieve the OTP ? '),
//                            GestureDetector(
//                              child: Text('Resend OTP',style: TextStyle(
//                                color: Colors.redAccent,

//                              ),),
//                            )
//                          ],
//                        )
//                          ),
//                        )
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
//        );
//      }
//      );

//   }

// }






import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memester/models/user.dart';
import 'package:memester/ui/screens/Homepage.dart';
import 'package:memester/ui/screens/profileSetup.dart';
import 'package:shared_preferences/shared_preferences.dart';
 final userReference = Firestore.instance.collection("users");
final DateTime timestamp = DateTime.now();
User currentUser;
enum Status{UnIntialized, Authenticated, Authenticating, UnAutheticated}
class AuthProvider with ChangeNotifier{
  bool loggedIn;
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn gSignIn = GoogleSignIn();
  FirebaseUser _user;
  static const LOGGED_IN = "loggedIn";
  Status _status = Status.UnIntialized;
  bool loading = false;
 

 Status get status => _status;
  FirebaseUser get user => _user;


    AuthProvider.intialize(){
    readPrefs();
  }



  Future gSignOut(BuildContext context)async{
    await gSignIn.signOut();
      SharedPreferences prefs =  await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
    Future<void> readPrefs() async {
    await Future.delayed(Duration(seconds: 5)).then((v) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      loggedIn  = prefs.getBool(LOGGED_IN) ?? false;
      
      if(loggedIn){
        _user = await _auth.currentUser();
       
        _status = Status.Authenticated;
        notifyListeners();
        return;
      }
      _status = Status.UnAutheticated;
      notifyListeners();
    });
    }


    controlSignIn(GoogleSignInAccount signInAccount) async
  {
    if(signInAccount != null)
    {
      
      SharedPreferences prefs =  await SharedPreferences.getInstance();
      prefs.setBool(LOGGED_IN, true);
       loggedIn = true;
      notifyListeners();

      
    }
    else{
      SharedPreferences prefs =  await SharedPreferences.getInstance();
      prefs.setBool(LOGGED_IN, false);
       loggedIn = false;
      notifyListeners();
    }
  }

  saveUserInfoToFireStore(context) async {
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot = await userReference.document(gCurrentUser.id).get();
    if(!documentSnapshot.exists)
    {
      final username = await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProfileSetup()));
  
    
        userReference.document(gCurrentUser.id).setData({
          "id" : gCurrentUser.id,
          "profileName": gCurrentUser.displayName,
          "username": username ,
          "url": gCurrentUser.photoUrl,
          "email":gCurrentUser.email,
          "bio": "",
          "timestamp": timestamp ,

    });
    documentSnapshot = await userReference.document(gCurrentUser.id).get();
    }
    currentUser = User.fromDocument(documentSnapshot);
    //  Navigator.pop(context,);
  }

  Future<String> signInWithGoogle(BuildContext context)async{
    
    final GoogleSignInAccount googleSignInAccount = await gSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    try{
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken, 
      accessToken: googleSignInAuthentication.accessToken

      );

      final AuthResult authResult = await _auth.signInWithCredential(authCredential);
      final FirebaseUser user = authResult.user;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      
      loading = true;
      if(user != null){
        await saveUserInfoToFireStore(context);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(LOGGED_IN, true);
        loggedIn = true;
       }
       else{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(LOGGED_IN, false);
          loggedIn = false;
       }

    }catch(e){
      print(e.toString());
    }
    
  }




    loginUser(){
    gSignIn.signIn();
  }

}