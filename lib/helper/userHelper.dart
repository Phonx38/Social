import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memester/models/user.dart';

class UserServices {
  String collection = "users";
  Firestore _firestore = Firestore.instance;

  void createUser(Map<String,dynamic> values){
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  void updateUserData(Map<String,dynamic> values){
    _firestore.collection(collection).document(values['id']).updateData(values);
  }

  Future<User> getUserById(String id){
    return _firestore.collection(collection).document(id).get().then((doc){
      if(doc.data == null){
        return null;
      }else{
        return User.fromDocument(doc);
      }
    });
  }
}