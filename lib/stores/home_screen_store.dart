import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
//Models
import '../../models/service_shop.dart';
import '../../models/booking_history.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStore with _$HomeScreenStore;

abstract class _HomeScreenStore with Store {
  @observable
  int bookings = 2;
  @observable
  int messages = 15;
  @observable
  int totalUserVehicles = 1;

  @observable
  ObservableList<ServiceShop> serviceShopList = ObservableList<ServiceShop>.of([
    ServiceShop(
        id: '1',
        name: 'Faiq Car Service',
        address: 'Mujahid Colony, Burewala',
        openingTime: TimeOfDay.now(),
        closingTime: TimeOfDay.now()),
    ServiceShop(
        id: '2',
        name: 'Bilal Car Service',
        address: 'Satellite Town, Burewala',
        openingTime: TimeOfDay.now(),
        closingTime: TimeOfDay.now()),
  ]);

  @observable
  ObservableList<BookingHistory> _bookingHistoryList =
      ObservableList<BookingHistory>.of([]);

  ObservableList<BookingHistory> get bookingHistoryList {
    // return ObservableList<BookingHistory>.of([]);
    return ObservableList<BookingHistory>.of([
      BookingHistory(
        id: '1',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        serviceShop: serviceShopList[0],
        price: 1240,
      ),
      BookingHistory(
        id: '2',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        serviceShop: serviceShopList[1],
        price: 1200,
      ),
      BookingHistory(
        id: '3',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        serviceShop: serviceShopList[0],
        price: 800,
      ),
      BookingHistory(
        id: '4',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        serviceShop: serviceShopList[0],
        price: 5340,
      ),
      BookingHistory(
        id: '5',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        serviceShop: serviceShopList[0],
        price: 5340,
      ),
      BookingHistory(
        id: '6',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        serviceShop: serviceShopList[0],
        price: 5340,
      ),
    ]);
  }
}
