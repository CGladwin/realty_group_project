import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  String? uid;
  String? username;
  String? password;
  String? emailAddress;
  String? phoneNumber;
  DocumentReference? reference;
  String? imageURL;

  UserData({
    required this.uid,
    required this.username,
    required this.password,
    required this.emailAddress,
    required this.phoneNumber,
    required this.reference,
  });

    UserData.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    username = map["username"];
    password = map["password"];
    emailAddress = map["email"].toString();
    phoneNumber = map["phoneNumber"].toString();
    imageURL = map["imageURL"];
  }
  
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "username": username,
      "password": password,
      "email": emailAddress,
      "phoneNumber": phoneNumber,
      "imageURL": imageURL,
    };
  }
}