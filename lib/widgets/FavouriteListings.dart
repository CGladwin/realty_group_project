import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:realty_group_project/models/Listing.dart';
import 'StarredListings.dart';


class FavouriteListings extends StatelessWidget {
  const FavouriteListings({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Listings'),
      ),
      body: user != null 
          ? FutureBuilder<List<Listing>>(
              future: StarredListings().getListings(), // Call the getListings method
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No favourite listings found.'));
                } else {
                  List<Listing> listings = snapshot.data!;
                  return ListView.builder(
                    itemCount: listings.length,
                    itemBuilder: (context, index) {
                      return ListingWidget(listing: listings[index]);
                    },
                  );
                }
              },
            )
          : const Center(child: Text('Please log in to see your favourite listings.')),
    );
  }
}
