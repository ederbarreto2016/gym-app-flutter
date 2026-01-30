import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/gym.dart';

class GymRepository {
  GymRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  Future<String> createGym({required String name}) async {
    final gymRef = _db.collection('gyms').doc();

    await _db.runTransaction((tx) async {
      tx.set(gymRef, {
        'name': name,
        'ownerUserId': _uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      tx.set(gymRef.collection('members').doc(_uid), {
        'role': 'admin',
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
      });
    });

    return gymRef.id;
  }

  Stream<List<Gym>> watchMyOwnedGyms() {
    return _db
        .collection('gyms')
        .where('ownerUserId', isEqualTo: _uid)
        .snapshots()
        .map(
          (snap) => snap.docs.map((d) => Gym.fromMap(d.id, d.data())).toList(),
        );
  }
}
