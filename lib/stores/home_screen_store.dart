import 'package:app_30_car_service_app/custom_utils/google_maps_helper.dart';
import 'package:app_30_car_service_app/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
//Models
import '../../models/service_shop.dart';
import '../../models/booking_history.dart';
import '../custom_utils/function_response.dart';
import '../models/app_user.dart';
import '../service_locator.dart';
import 'user_profile_screen_store.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStore with _$HomeScreenStore;

abstract class _HomeScreenStore with Store {
  _HomeScreenStore(this._userProfileScreenStore);

  final UserProfileScreenStore _userProfileScreenStore;

  @observable
  int bookings = 2;
  @observable
  int messages = 15;
  @observable
  int totalUserVehicles = 1;
  @observable
  bool isLoadingHomeScreenData = false;

  @observable
  AppUser currentUser = AppUser(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    address: '',
    userImage: '',
    userBio: '',
    userLatLng: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  @observable
  ObservableList<ServiceShop> serviceShopList = ObservableList<ServiceShop>.of([
    ServiceShop(
        id: '1',
        name: 'Faiq Car Service',
        address: 'Mujahid Colony, Burewala',
        coverImage: fullCarWashServiceImage,
        rating: 3.3,
        shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
        openingTime: TimeOfDay.now(),
        closingTime: TimeOfDay.now()),
    ServiceShop(
        id: '2',
        name: 'Bilal Car Service',
        address: 'Satellite Town, Burewala',
        coverImage: carTyreChangeServiceImage,
        rating: 3.3,
        shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
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

  @action
  Future<void> loadAllData() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    isLoadingHomeScreenData = true;
    fResponse = await _userProfileScreenStore.loadProfile();
    fResponse.printResponse();
    if (fResponse.success) {
      currentUser = _userProfileScreenStore.currentUser;
      print('name : ${currentUser.firstName}');
      print('location : ${currentUser.userLatLng.toString()}');
    }

    isLoadingHomeScreenData = false;
  }
}
