import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:app/models/location.dart";

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addLocation({
    required String title,
    required String notes,
    required double lat,
    required double lng,
    required DateTime date,
    required List<String> photoUrls,
    required String placeName,
  }) async {
    String userId = _auth.currentUser!.uid;

    await _db.collection('users').doc(userId).collection('locations').add({
      'title': title,
      'notes': notes,
      'latitude': lat,
      'longitude': lng,
      'date': date.toIso8601String(),
      'photoUrls': photoUrls,
      'placeName': placeName,
    });
  }

  Stream<List<Location>> getLocations() {
    String userId = _auth.currentUser!.uid;

    return _db
        .collection('users')
        .doc(userId)
        .collection('locations')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Location.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();
        });
  }

  Future<void> deleteLocation(String locationId) async {
    String userId = _auth.currentUser!.uid;
    await _db
        .collection('users')
        .doc(userId)
        .collection('locations')
        .doc(locationId)
        .delete();
  }
}
