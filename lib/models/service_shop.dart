import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceShop {
  String id;
  String name;
  String coverImage;
  double rating;
  String address;
  TimeOfDay openingTime;
  TimeOfDay closingTime;
  LatLng shopLocation;
  ServiceShop({
    required this.id,
    required this.name,
    required this.address,
    required this.openingTime,
    required this.closingTime,
    required this.coverImage,
    required this.rating,
    required this.shopLocation,
  });

  factory ServiceShop.fromJson(String uid, Map<String, dynamic> json) {
    return ServiceShop(
      id: uid,
      name: json['name'] as String,
      address: json['address'] as String,
      openingTime: TimeOfDay.now(),
      closingTime: TimeOfDay.now(),
      coverImage: json['coverImage'] ?? '' as String,
      rating: json['rating'] ?? 0 as double,
      shopLocation: LatLng(
        (json['shopLocation'] as GeoPoint).latitude,
        (json['shopLocation'] as GeoPoint).longitude,
      ),
    );
  }
}
