import 'service_shop.dart';

class BookingHistory {
  String id;
  DateTime dateTime;
  ServiceShop serviceShop;
  double price;
  BookingHistory({
    required this.id,
    required this.dateTime,
    required this.serviceShop,
    required this.price,
  });
}
