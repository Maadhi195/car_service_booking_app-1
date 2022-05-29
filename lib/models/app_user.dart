import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppUser {
  String id;
  String name;
  String email;
  String password;
  String userImage;
  String address;
  String userBio;
  LatLng userLatLng;
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.userImage,
    required this.address,
    required this.userBio,
    required this.userLatLng,
  });
}
