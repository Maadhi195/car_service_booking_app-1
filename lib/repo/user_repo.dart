import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  static final UserRepo instance = UserRepo();
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  //get userLatLng from users where userId is currentUser.userId
  Future<GeoPoint> getUserLatLng() async {
    final doc =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return ((doc.data()! as Map<String, dynamic>)['userLatLng']) as GeoPoint;
  }
}
