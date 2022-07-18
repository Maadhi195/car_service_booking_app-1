import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../models/service_shop.dart';
import 'user_repo.dart';

class ShopRepo {
  static final ShopRepo instance = ShopRepo();

  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('shops');

  //get shop by id
  Future<ServiceShop> getShopById(String shopId) async {
    final doc = await collection.doc(shopId).get();
    return ServiceShop.fromJson(doc.id, doc.data() as Map<String, dynamic>);
  }

  //increment totalEarning field of shops doc where shopId = shopId
  Future<void> incrementTotalEarning(String shopId, double amount) async {
    await collection.doc(shopId).update({
      'totalEarning': FieldValue.increment(amount),
    });
  }

  //get shopLocation by shopId
  Future<GeoPoint> getShopLocation(String shopId) async {
    final doc = await collection.doc(shopId).get();
    return ((doc.data()! as Map<String, dynamic>)['shopLocation']) as GeoPoint;
  }

  //get userLatLng from users and get shopLocation from shops and find distance
  Future<double> getDistance(String shopId) async {
    final GeoPoint userLatLng = await UserRepo.instance.getUserLatLng();
    final GeoPoint shopLatLng = await getShopLocation(shopId);
    //log userLatLng and shopLatLng
    log('-------- userLatLng: ${userLatLng.latitude}');
    log('-------- shop: ${shopLatLng.latitude}');
    final double userLat = userLatLng.latitude;
    final double userLng = userLatLng.longitude;
    final double shopLat = shopLatLng.latitude;
    final double shopLng = shopLatLng.longitude;
    final double distance = Geolocator.distanceBetween(
      userLat,
      userLng,
      shopLat,
      shopLng,
    );
    return distance / 1000;
  }
}
