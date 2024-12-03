import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realty_group_project/models/Listing.dart';
import 'package:realty_group_project/models/ListingsModel.dart';


// Mock Classes
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference<T> extends Mock implements CollectionReference<T> {}

void main() {
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
   
    mockFirestore = MockFirebaseFirestore();
  });

  test('addListing should call Firestore add with correct data', () async {
    
    final mockCollection = MockCollectionReference<Map<String, dynamic>>();
    when(mockFirestore.collection('houses')).thenReturn(mockCollection);

    // Creating instance of ListingsModel
    final listingsModel = ListingsModel();

    
    final listingData = Listing(
      address: '123 Main St',
      numBeds: '3',
      numBaths: '2',
      squareFeet: '1500',
      price: 350000.0,
      highestBid: 350000.0, // Add the highestBid parameter
    );

    // Call the method
    await listingsModel.addListing(listingData);

    // Verify that the add method was called with the expected data
    verify(mockFirestore.collection('houses')).called(1);
    verify(mockCollection.add({
      'address': '123 Main St',
      'numBeds': '3',
      'numBaths': '2',
      'squareFeet': '1500',
      'price': 350000.0,
      'highestBid': 350000.0,
    })).called(1);
  });
}
