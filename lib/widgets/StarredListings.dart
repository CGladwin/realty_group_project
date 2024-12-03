import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/Listing.dart';

class StarredListings extends ChangeNotifier {
  final List<Listing> _starredListings = [];

  List<Listing> get starredListings => _starredListings;

  void toggleStar(Listing listing) async {
    if (_starredListings.contains(listing)) {
      _starredListings.remove(listing);

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        try {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'favouriteListings': FieldValue.arrayRemove([listing.id])
          });
          print('Listing removed from favourites.');
        } catch (e) {
          print('Error removing from favourites: $e');
        }
      }

    } else {
      _starredListings.add(listing);

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        try {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'favouriteListings': FieldValue.arrayUnion([listing.id])
          });
          print('Listing added to favourites.');
        } catch (e) {
          print('Error adding to favourites: $e');
        }
      }
    }
  }

  Future<List<Listing>> getListings() async {
    print("code ran");
    List<Listing> userStarredListings = [];
    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      print('User ID: ${user.uid}');
      FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((doc) async{
        if(doc.exists && doc.data() != null){
          List<dynamic>favouriteListings = doc.data()!['favouriteListings'];
          print('Favourite Listings: $favouriteListings');
          for(String listingId in favouriteListings){
            DocumentSnapshot listingDoc = await FirebaseFirestore.instance.collection('houses').doc(listingId).get();
            if(listingDoc.exists){
              Listing listing = Listing.fromMap(listingDoc.data() as Map<String, dynamic>, reference: listingDoc.reference);
              print(listing.address);
              print("Blah");
              userStarredListings.add(listing);
            }
          }
        }
      });
    }
    return userStarredListings;
  }
}