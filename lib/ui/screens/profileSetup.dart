

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memester/helper/colors.dart';
import 'package:memester/ui/screens/Homepage.dart';


class ProfileSetup extends StatefulWidget {
  @override
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;


  submitUsername(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      SnackBar snackBar = SnackBar(content: Text('Welcome' + username),);
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 2),(){
        
        Navigator.pop(context,username);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Profile Setup',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
            centerTitle: true,
            elevation: 1,
            backgroundColor: secondaryColor,
          ),
          body: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:25.0),
                      child: Center(
                        child: Text(
                          'Set up a Username',style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold
            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Container(
                        child: Form(
                          key: _formKey,
                          autovalidate: true,
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.black87,
                              
                            ),
                            validator:(val){
                                if(val.trim().length <= 5 || val.isEmpty){
                                  return "Username is too short.Username should be in between 8-15 characters.";
                                }
                                else if(val.trim().length > 15 || val.isEmpty){
                                  return "Username is too long . Username should be in between 8-15 characters.";
                                }
                                else{
                                  return null;
                                }
                                
                              },
                              onSaved:(val)=> username = val,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:Colors.grey)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:secondaryColor)
                                ),
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                                labelStyle: TextStyle(fontSize: 16),
                                hintText: 'eg: hey@123_',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: submitUsername,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 55.0,
                      width: 300,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(child: Text('Done',style:TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ))),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}