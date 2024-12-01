import 'package:flutter/material.dart';
import 'Listing.dart';

class StarredListings extends ChangeNotifier {
  final List<Listing> _starredListings = [];

  List<Listing> get starredListings => _starredListings;

  void toggleStar(Listing listing) {
    if (_starredListings.contains(listing)) {
      _starredListings.remove(listing);
    } else {
      _starredListings.add(listing);
    }
  }
}