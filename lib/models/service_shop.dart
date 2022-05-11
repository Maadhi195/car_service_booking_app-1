import 'package:flutter/material.dart';

class ServiceShop {
  String id;
  String name;
  String address;
  TimeOfDay openingTime;
  TimeOfDay closingTime;
  ServiceShop({
    required this.id,
    required this.name,
    required this.address,
    required this.openingTime,
    required this.closingTime,
  });
}
