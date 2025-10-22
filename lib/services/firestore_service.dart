import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future savePunch(String userId, double lat, double lng, DateTime ts) {
    return _db.collection('punches').add({
      'userId': userId,
      'lat': lat,
      'lng': lng,
      'timestamp': Timestamp.fromDate(ts),
    });
  }

  Stream<QuerySnapshot> punchesFor(String userId) {
    return _db
        .collection('punches')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
