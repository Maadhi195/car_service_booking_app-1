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
import 'profile_store.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStore with _$HomeScreenStore;

abstract class _HomeScreenStore with Store {
  _HomeScreenStore(this._profileStore);

  final ProfileStore _profileStore;

  @observable
  int bookings = 2;
  @observable
  int messages = 15;
  @observable
  int totalUserVehicles = 1;
  @observable
  bool isLoadingHomeScreenData = false;
}
