// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:memester/providers/auth.dart';
// import 'package:memester/ui/screens/Splash.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';



// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _autovalidate = false;
  
//   TextEditingController number = TextEditingController();
//   @override
// void dispose() {
//   super.dispose(); // always call super for dispose/initState
//   // AuthProvider().dispose(this);
// }


//   final _formKey = GlobalKey<FormState>();
  
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthProvider>(context);
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body:  SingleChildScrollView(
//           child: auth.loading ? Splash()
//           : Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center, 
//               children: [
//               SizedBox(
//                 height: 100,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                  Text('MEMESTER',style: TextStyle(
//                    fontSize: 40,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.black
//                  ),)
//                 ],
//               ),
//               SizedBox(height: 50),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width *0.7,
//                   child: Text("Lets get you registered here. Mind entering your Mobile Number", 
//                   textAlign: TextAlign.center, style: TextStyle(color: Colors.grey,fontSize: 13),),
//                 ),
//               ),
             
             
//               SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.only(left:12, right: 12, bottom: 12),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.black, width: 0.2),
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             offset: Offset(2, 1),
//                             blurRadius: 2
//                         )
//                       ]
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left:8.0),
//                     child: TextFormField(
//                       autovalidate: _autovalidate,
//                       validator:  (value) {
//                         if (value.isEmpty) {
//                           return 'Please enter valid Mobile No';
//                         }
//                         return null;
//                       },
//                       keyboardType: TextInputType.phone,
//                       controller: number,
                      
//                       decoration: InputDecoration(
//                           icon: Icon(Icons.phone_android, color: Colors.grey),
//                           border: InputBorder.none,
//                           hintText: "45678786",
//                           hintStyle: TextStyle(
//                               color: Colors.grey,
//                               fontFamily: "Sen",
//                               fontSize: 18
//                           )
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width *0.8,
//                   child: Text("By continuing, I agree to the Terms & Conditions", 
//                   textAlign: TextAlign.center, style: TextStyle(color: Colors.grey,fontSize: 13),),
//                 ),
//               ),
              
//               SizedBox(height: 10),
//               FlatButton.icon(
                
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                 color: Colors.redAccent,
//                 onPressed: (){
//                   if(_formKey.currentState.validate()){
//                     auth.verifyPhone(context,"+91"+ number.text);
//                   }else{
//                     setState(() => _autovalidate = true);
//                   }
                  
//                 },
//                 icon: Icon(Icons.navigate_next,color: Colors.white,),
//                label: Text('Verify',style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  color: Colors.white
//                ),)),

//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width *0.8,
//                   child: Text("Or", 
//                   textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
//                 ),
//               ),
              
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width *0.8,
//                   child: Text("Sign in with", 
//                   textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
//                 ),
//               ),

            
//               FlatButton.icon(
                
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                 color: Colors.redAccent,
//                 onPressed: (){
//                   auth.signInWithGoogle(context);
                  
//                 },
//                 icon: Icon(FontAwesome.google,color: Colors.white,),
//                label: Text('Google',style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  color: Colors.white
//                ),)),

                
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

