import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../custom_utils/function_response.dart';
import '../custom_utils/google_maps_helper.dart';
import '../models/service_shop.dart';
import '../models/user.dart';
import '../service_locator.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  //
  @observable
  User newUser = User(
    id: '',
    email: '',
    address: '',
    firstName: '',
    lastName: '',
    password: '',
    userBio: '',
    userImage: '',
    userLatLng: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  @observable
  ServiceShop? currentUser;
  @observable
  ObservableList<ServiceShop> serviceShopeList =
      ObservableList<ServiceShop>.of([]);

  @action
  void updateCoverImage(String image) {
    newUser = User(
      id: newUser.id,
      firstName: newUser.firstName,
      lastName: newUser.lastName,
      email: newUser.email,
      password: newUser.password,
      address: newUser.address,
      userBio: newUser.userBio,
      userImage: image,
      userLatLng: newUser.userLatLng,
    );
  }
}
